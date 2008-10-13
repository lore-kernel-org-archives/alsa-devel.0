From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: fix nid variable warning
Date: Mon, 13 Oct 2008 13:22:45 -0400
Message-ID: <48F383E5.9080200@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id DE75E24579
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 19:23:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Rml4ZWQgY29tcGlsZXIgd2FybmluZyB3aXRoIHBvc3NpYmxlIHVuaW5pdGlhbGl6ZWQgdmFyaWFi
bGUgJ25pZCcuCgogIENDIFtNXSAgL2hvbWUvbXJhbm9zdGF5L2dpdC9hbHNhLWRyaXZlci9wY2kv
aGRhL3BhdGNoX3NpZ21hdGVsLm8KL2hvbWUvbXJhbm9zdGF5L2dpdC9hbHNhLWRyaXZlci9wY2kv
aGRhLy4uLy4uL2Fsc2Eta2VybmVsL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYzogSW4gZnVuY3Rp
b24K4oCYc3RhYzkyeHhfcGFyc2VfYXV0b19jb25maWfigJk6Ci9ob21lL21yYW5vc3RheS9naXQv
YWxzYS1kcml2ZXIvcGNpL2hkYS8uLi8uLi9hbHNhLWtlcm5lbC9wY2kvaGRhL3BhdGNoX3NpZ21h
dGVsLmM6MjgxNTogd2FybmluZzog4oCYbmlk4oCZIG1heSBiZSB1c2VkCnVuaW5pdGlhbGl6ZWQg
aW4gdGhpcyBmdW5jdGlvbgoKU2lnbmVkLW9mZi1ieTogTWF0dGhldyBSYW5vc3RheSA8bXJhbm9z
dGF5QGVtYmVkZGVkYWxsZXkuY29tPgotLS0KCmRpZmYgLS1naXQgYS9wY2kvaGRhL3BhdGNoX3Np
Z21hdGVsLmMgYi9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKaW5kZXggYzQ2MWJhYS4uZjhiZmI0
YyAxMDA2NDQKLS0tIGEvcGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCisrKyBiL3BjaS9oZGEvcGF0
Y2hfc2lnbWF0ZWwuYwpAQCAtMjgxMiw3ICsyODEyLDcgQEAgc3RhdGljIGludCBzdGFjOTJ4eF9h
dXRvX2NyZWF0ZV9tdWx0aV9vdXRfY3RscyhzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYywKIAlzdGF0
aWMgY29uc3QgY2hhciAqY2huYW1lWzRdID0gewogCQkiRnJvbnQiLCAiU3Vycm91bmQiLCBOVUxM
IC8qQ0xGRSovLCAiU2lkZSIKIAl9OwotCWhkYV9uaWRfdCBuaWQ7CisJaGRhX25pZF90IG5pZCA9
IDA7CiAJaW50IGksIGVycjsKCiAJc3RydWN0IHNpZ21hdGVsX3NwZWMgKnNwZWMgPSBjb2RlYy0+
c3BlYzsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
