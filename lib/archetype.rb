require 'compass'

#
# Initialize Archetype and register it as a Compass extension
#
module Archetype
  # extension info
  @archetype = {}
  @archetype[:name] = 'archetype'
  @archetype[:path] = File.expand_path(File.join(File.dirname(__FILE__), ".."))
  # register the extension
  def self.register
    Compass::Frameworks.register(@archetype[:name], :path => @archetype[:path])
  end
  # initialize Archetype
  def self.init
    # register it
    self.register
    # setup configs
    # locale
    Compass::Configuration.add_configuration_property(:locale, "the user locale") do
      'en_US'
    end
    # reading direction (ltr|rtl)
    Compass::Configuration.add_configuration_property(:reading, "the user interface reading direction") do
      'ltr'
    end
    # environment
    Compass::Configuration.add_configuration_property(:environment, "current environment") do
      :development
    end
    # memoize
    Compass::Configuration.add_configuration_property(:memoize, "should the memoizer be used to improve compilation speed") do
      not (Compass.configuration.environment || :development).to_s.include?('dev')
    end
    # testing (for running unit tests)
    Compass::Configuration.add_configuration_property(:testing, "is this a testing environment") do
      ENV['CI']
    end
  end
end

# init
Archetype.init

# load dependencies
%w(functions sass_extensions).each do |lib|
  require "archetype/#{lib}"
end
