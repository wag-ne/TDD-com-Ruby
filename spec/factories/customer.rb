FactoryBot.define do
  factory :customer do

    transient do
      upcased false
      qtt_orders 3
    end

    name { Faker::Name.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }

    trait :vip do
      vip true
      days_to_pay 30
    end

    trait :default do
      vip false
      days_to_pay 15
    end

    trait :male do
      gender 'M'
    end

    trait :female do
      gender 'F'
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
    end

    factory :customer_with_orders, traits: [:with_orders]
    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_default, traits: [:default]
    factory :customer_vip, traits: [:vip]
    factory :customer_vip_male, traits: [:vip, :male]
    factory :customer_default_male, traits: [:default, :male]
    factory :customer_vip_female, traits: [:vip, :female]
    factory :customer_default_female, traits: [:default, :female]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end