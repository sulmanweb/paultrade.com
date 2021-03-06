class MyMailer < ApplicationMailer
  #default from: "from@example.com"
  #layout 'mailer'
  def mandrill_client
    @mandrill_client ||= Mandrill::API.new ENV['MANDRILL_KEY']
  end

  def new_user(user)
    template_name = "new-user"
    template_content = []
    message = {
        to: [{email: "#{user.email}"}],
        subject: "Welcome to Paul Trade",
        merge_vars: [
            {
                rcpt: user.email,
                vars: [{name: "USER_NAME", content: user.name}]
            }
        ]
    }

    mandrill_client.messages.send_template template_name, template_content, message
  end

  def contact_email(email, body)
    @email = email
    @body = body

    mail(from: email, subject: 'Contact Us', to: "paultraders@outlook.com")
  end
end
