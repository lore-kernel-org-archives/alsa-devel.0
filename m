From: Milan Nikolic <gen2brain@gmail.com>
Subject: [PATCH] alsa-python mixer: add poll_fds property
Date: Mon, 20 Dec 2010 21:53:32 +0100
Message-ID: <AANLkTinG30KekgVAFLdrk=1f=-psvv8QfEXViQ-JQEeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016361e7dc68b451b0497ddb635
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 387EC103801
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 21:53:39 +0100 (CET)
Received: by qwj8 with SMTP id 8so3185141qwj.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 12:53:33 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

--0016361e7dc68b451b0497ddb635
Content-Type: text/plain; charset=UTF-8

Hi,
this patch adds poll_fds property to pyalsa alsamixer. register_poll works
with Python's select.poll but not with main loop of GUI toolkits. This is
already done for hcontrol by Clemens Ladisch, patch is based on his patch.
Other patch fixes memory leak as reported by him.

--0016361e7dc68b451b0497ddb635
Content-Type: application/octet-stream;
	name="alsamixer_poll_fds_property.patch"
Content-Disposition: attachment;
	filename="alsamixer_poll_fds_property.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghxu63bd0

LS0tIGEvcHlhbHNhLTEuMC4yMi9weWFsc2EvYWxzYW1peGVyLmMJMjAwOS0xMi0xNiAxNjoxODo1
Ni4wMDAwMDAwMDAgKzAxMDAKKysrIGIvcHlhbHNhLTEuMC4yMi9weWFsc2EvYWxzYW1peGVyLmMJ
MjAxMC0xMi0yMCAyMDo1Njo1MS41NTMwMDAwMDEgKzAxMDAKQEAgLTE4OCw2ICsxODYsMzggQEAK
IAlQeV9SRVRVUk5fTk9ORTsKIH0KIAorc3RhdGljIFB5T2JqZWN0ICoKK3B5YWxzYW1peGVyX2dl
dHBvbGxmZHMoc3RydWN0IHB5YWxzYW1peGVyICpzZWxmLCB2b2lkICpwcml2KQoreworCVB5T2Jq
ZWN0ICpsLCAqdDsKKwlzdHJ1Y3QgcG9sbGZkICpwZmRzOworCWludCBpLCBjb3VudDsKKworCWNv
dW50ID0gc25kX21peGVyX3BvbGxfZGVzY3JpcHRvcnNfY291bnQoc2VsZi0+aGFuZGxlKTsKKwlp
ZiAoY291bnQgPCAwKSB7CitwZmRzX2Vycm9yOgorCQlQeUVycl9Gb3JtYXQoUHlFeGNfSU9FcnJv
ciwgInBvbGwgZGVzY3JpcHRvcnMgZXJyb3I6ICVzIiwgc25kX3N0cmVycm9yKGNvdW50KSk7CisJ
CXJldHVybiBOVUxMOworCX0KKwlwZmRzID0gYWxsb2NhKHNpemVvZihzdHJ1Y3QgcG9sbGZkKSAq
IGNvdW50KTsKKwljb3VudCA9IHNuZF9taXhlcl9wb2xsX2Rlc2NyaXB0b3JzKHNlbGYtPmhhbmRs
ZSwgcGZkcywgY291bnQpOworCWlmIChjb3VudCA8IDApCisJCWdvdG8gcGZkc19lcnJvcjsKKwor
CWwgPSBQeUxpc3RfTmV3KGNvdW50KTsKKwlpZiAoIWwpCisJCXJldHVybiBOVUxMOworCWZvciAo
aSA9IDA7IGkgPCBjb3VudDsgKytpKSB7CisJCXQgPSBQeVR1cGxlX05ldygyKTsKKwkJaWYgKHQp
IHsKKwkJCVB5VHVwbGVfU0VUX0lURU0odCwgMCwgUHlJbnRfRnJvbUxvbmcocGZkc1tpXS5mZCkp
OworCQkJUHlUdXBsZV9TRVRfSVRFTSh0LCAxLCBQeUludF9Gcm9tTG9uZyhwZmRzW2ldLmV2ZW50
cykpOworCQkJUHlMaXN0X1NldEl0ZW0obCwgaSwgdCk7CisJCX0KKwl9CisJcmV0dXJuIGw7Cit9
CisKIFB5RG9jX1NUUlZBUihsaXN0X19kb2NfXywKICJsaXN0KCkgLS0gUmV0dXJuIGEgbGlzdCAo
dHVwbGUpIG9mIGVsZW1lbnQgSURzIGluIChuYW1lLGluZGV4KSB0dXBsZS4iKTsKIApAQCAtMjU3
LDcgKzI4Nyw4IEBACiAKIHN0YXRpYyBQeUdldFNldERlZiBweWFsc2FtaXhlcl9nZXRzZXRlcnNb
XSA9IHsKIAotCXsiY291bnQiLAkoZ2V0dGVyKXB5YWxzYW1peGVyX2dldGNvdW50LAlOVUxMLAki
bWl4ZXIgZWxlbWVudCBjb3VudCIsCQlOVUxMfSwKKwl7ImNvdW50IiwJKGdldHRlcilweWFsc2Ft
aXhlcl9nZXRjb3VudCwgICBOVUxMLAkibWl4ZXIgZWxlbWVudCBjb3VudCIsCQlOVUxMfSwKKwl7
InBvbGxfZmRzIiwgICAgKGdldHRlcilweWFsc2FtaXhlcl9nZXRwb2xsZmRzLCAgICAgTlVMTCwJ
Imxpc3Qgb2YgKGZkLCBldmVudGJpdHMpIHR1cGxlcyIsCU5VTEx9LAogCiAJe05VTEx9CiB9Owo=
--0016361e7dc68b451b0497ddb635
Content-Type: application/octet-stream; name="alsamixer_memory_leak.patch"
Content-Disposition: attachment; filename="alsamixer_memory_leak.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghxu6a2s1

LS0tIGEvcHlhbHNhLTEuMC4yMi9weWFsc2EvYWxzYW1peGVyLmMJMjAwOS0xMi0xNiAxNjoxODo1
Ni4wMDAwMDAwMDAgKzAxMDAKKysrIGIvcHlhbHNhLTEuMC4yMi9weWFsc2EvYWxzYW1peGVyLmMJ
MjAxMC0xMi0yMCAyMDo0OTowOC4wMDIwMDAwMDEgKzAxMDAKQEAgLTE2NCw5ICsxNjQsNyBAQAog
CWNvdW50ID0gc25kX21peGVyX3BvbGxfZGVzY3JpcHRvcnNfY291bnQoc2VsZi0+aGFuZGxlKTsK
IAlpZiAoY291bnQgPD0gMCkKIAkJUHlfUkVUVVJOX05PTkU7Ci0JcGZkID0gbWFsbG9jKHNpemVv
ZihzdHJ1Y3QgcG9sbGZkKSAqIGNvdW50KTsKLQlpZiAocGZkID09IE5VTEwpCi0JCVB5X1JFVFVS
Tl9OT05FOworCXBmZCA9IGFsbG9jYShzaXplb2Yoc3RydWN0IHBvbGxmZCkgKiBjb3VudCk7CiAJ
Y291bnQgPSBzbmRfbWl4ZXJfcG9sbF9kZXNjcmlwdG9ycyhzZWxmLT5oYW5kbGUsIHBmZCwgY291
bnQpOwogCWlmIChjb3VudCA8PSAwKQogCQlQeV9SRVRVUk5fTk9ORTsK
--0016361e7dc68b451b0497ddb635
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016361e7dc68b451b0497ddb635--
