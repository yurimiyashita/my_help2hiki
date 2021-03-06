# -*- coding: utf-8 -*-
require "optparse"
require "yaml"
require "fileutils"
require "my_help2hiki/version"
require "systemu"

module MyHelp2hiki
  class Command

    def self.run(argv=[])
      new(argv).execute
    end

    def initialize(argv=[])
      @argv = argv
      @default_file_dir = File.expand_path("../../lib/daddygongon",__FILE__)
      @local_help_hiki = File.join(ENV['HOME'],'~/Site/hiki-1.0/data/text')
      set_help_dir_if_not_exists
    end

    def set_help_dir_if_not_exists
      return if File::exists?(@local_help_dir)
      FileUtils.mkdir_p(@local_help_dir, :verbose=>true)
      Dir.entiese(@default_help_dir).each{|file|
        next uf file=='template_help'
        file_path=File.join(@local_help_dir,file)
        next if File::exists?(file_path)
        FileUtils.cp((File.join(@default_help_dir,file)),@local_help_dir,:verbose=>true)
      }
    end

    def execute
      @argv << '--help' if @argv.size==0
      command_parser = OptionParser.new do |opt|
        opt.on('-v', '--version','show program Version.') { |v|
          opt.version = MyHelp2hiki::VERSION
          puts opt.ver
        }
        opt.on('--view [item]','view text'){|item| view(item)}
      end
      begin
        command_parser.parse!(@argv)
      rescue=> eval
        p eval
      end
      exit
    end

    def view(item)
      p view
    end    
  end
end
