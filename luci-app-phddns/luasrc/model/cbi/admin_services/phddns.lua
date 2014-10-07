local sys = require "luci.sys"
local datatypes = require "luci."
local uci    = require "luci.model.uci"
local cur = uci.cursor();
local http = require "luci.http";
local _ = luci.i18n.translate

m = Map("phddns", "Oray DDNS.",
		_("This page allows you to set Oray DDNS."))

m.on_after_commit = function(self)
	luci.sys.call("/etc/init.d/phddns restart >/dev/null") 
end

s = m:section(TypedSection, "phddns", translate("Oray Account"))
s.anonymous = true
s.addremove = false

o = s:option(Flag , "enabled", translate("Enable"))

o = s:option(Value, "username", translate("Username"))
o.datatype="string"
o:depends("enabled", "1")

o = s:option(Value, "password", translate("Password"))
o.datatype="string"
o:depends("enabled", "1")

o = s:option(Value, "stat", "")
o.template="admin_services/phddns_stat"

return m
