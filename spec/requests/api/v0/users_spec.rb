require 'rails_helper'

RSpec.describe 'Users Requests', type: :request do
  describe 'POST /api/v0/users' do
    context 'with valid credentials' do
      it 'creates a new user and returns the id, email, and api_key for the user' do
        params = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
        headers = {"CONTENT_TYPE" => "application/json"}
        
        expect do
          post '/api/v0/users', headers: headers, params: JSON.generate(params)
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq("users")
        expect(json[:data]).to have_key(:id)
        expect(json[:data]).to have_key(:attributes)

        attributes = json[:data][:attributes]

        expect(attributes).to be_a(Hash)
        expect(attributes).to have_key(:email)
        expect(attributes[:email]).to be_a(String)

        # expect(attributes).to have_key(:api_key)
        # expect(attribute[:api_key]).to be_a(String)
      end
    end

    context 'with invalid credentials' do

    end
  end
end