From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH ALSA HDA 1/2] Fix HP pin and Front pin of
	ad1988/ad1989 in ad198x_eapd_powerdown
Date: Wed, 1 Jun 2011 16:41:19 +0800
Message-ID: <BANLkTinr8UzKAxnYH4-t8g1VMBWZay8foQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c427810f77c04a4a27c45
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 40A3F103813
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 10:41:20 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4069230fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Jun 2011 01:41:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Daniel T Chen <crimsun@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

--0015174c427810f77c04a4a27c45
Content-Type: text/plain; charset=ISO-8859-1

Refer to commit ea52bf260ecbb175339af3178c15788df21b7516

1) Fix HP pin and Front pin of ad1988/ad1989 in ad198x_eapd_powerdown

According to ad1988a/ad1988b datasheet, Port A (0x11) is HP and Port D
(0x12) is Front

but both of these pins in ad1988a are not EAPD capable

2) Check pin support EAPD in ad198x_power_eapd_write

--0015174c427810f77c04a4a27c45
Content-Type: application/octet-stream;
	name="0001-Fix-HP-pin-and-Front-pin-of-ad1988-ad1989-in-ad198x_eapd_powerdown.patch"
Content-Disposition: attachment;
	filename="0001-Fix-HP-pin-and-Front-pin-of-ad1988-ad1989-in-ad198x_eapd_powerdown.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goe0tyz80

RnJvbSAyMTBjMjViNDEwMjhhZjIxOTI4MWQ2Y2Y4MTIwZTZlYjMwZWU5NGMwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTYXQsIDI4IE1heSAyMDExIDEyOjA0OjE1ICswODAwClN1YmplY3Q6IFtQQVRD
SCBBTFNBIEhEQSAxLzJdIEZpeCBIUCBwaW4gYW5kIEZyb250IHBpbiBvZiBhZDE5ODgvYWQxOTg5
IGluIGFkMTk4eF9lYXBkX3Bvd2VyZG93bgoKQWNjb3JkaW5nIHRvIGRhdGFzaGVldCwgUG9ydCBB
ICgweDExKSBpcyBIUCBhbmQgUG9ydCBEICgweDEyKSBpcyBGcm9udAoKYnV0IGJvdGggb2YgdGhl
c2UgcGlucyBpbiBhZDE5ODhhIGFyZSBub3QgRUFQRCBjYXBhYmxlCgpTaWduZWQtb2ZmLWJ5OiBS
YXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfYW5hbG9nLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5j
CmluZGV4IDY5NmFjMjUuLmI3NDM5ZTkgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
YW5hbG9nLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9hbmFsb2cuYwpAQCAtNTM3LDcgKzUz
Nyw3IEBAIHN0YXRpYyB2b2lkIGFkMTk4eF9wb3dlcl9lYXBkKHN0cnVjdCBoZGFfY29kZWMgKmNv
ZGVjKQogCWNhc2UgMHgxMWQ0MTk4YjoKIAljYXNlIDB4MTFkNDk4OWE6CiAJY2FzZSAweDExZDQ5
ODliOgotCQlhZDE5OHhfcG93ZXJfZWFwZF93cml0ZShjb2RlYywgMHgyOSwgMHgyMik7CisJCWFk
MTk4eF9wb3dlcl9lYXBkX3dyaXRlKGNvZGVjLCAweDEyLCAweDExKTsKIAkJYnJlYWs7CiAJfQog
fQotLSAKMS42LjAuNgoK
--0015174c427810f77c04a4a27c45
Content-Type: application/octet-stream;
	name="0002-Check-pin-support-EAPD-in-ad198x-eapd-power-write.patch"
Content-Disposition: attachment;
	filename="0002-Check-pin-support-EAPD-in-ad198x-eapd-power-write.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goe0xkz51

RnJvbSBlYTkwOTNjN2UxNDc0Y2EyNzNkNzZiYWE4MWEwYjg4ODQ4ZjVjZGNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDEgSnVuIDIwMTEgMTU6MDk6NDggKzA4MDAKU3ViamVjdDogW1BBVENI
IEFMU0EgSERBIDIvMl0gQ2hlY2sgcGluIHN1cHBvcnQgRUFQRCBpbiBhZDE5OHhfcG93ZXJfZWFw
ZF93cml0ZQoKQ2hlY2sgcGluIHN1cHBvcnQgRUFQRCBpbiBhZDE5OHhfcG93ZXJfZWFwZF93cml0
ZQoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWlsLmNv
bT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jIGIvc291bmQvcGNp
L2hkYS9wYXRjaF9hbmFsb2cuYwppbmRleCBiNzQzOWU5Li4xMmI3NTM5IDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kvaGRhL3BhdGNoX2FuYWxvZy5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfYW5h
bG9nLmMKQEAgLTUwNiw5ICs1MDYsMTEgQEAgc3RhdGljIHZvaWQgYWQxOTh4X3Bvd2VyX2VhcGRf
d3JpdGUoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsIGhkYV9uaWRfdCBmcm9udCwKIAkJCQloZGFf
bmlkX3QgaHApCiB7CiAJc3RydWN0IGFkMTk4eF9zcGVjICpzcGVjID0gY29kZWMtPnNwZWM7Ci0J
c25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgZnJvbnQsIDAsIEFDX1ZFUkJfU0VUX0VBUERfQlRM
RU5BQkxFLAorCWlmIChzbmRfaGRhX3F1ZXJ5X3Bpbl9jYXBzKGNvZGVjLCBmcm9udCkgJiBBQ19Q
SU5DQVBfRUFQRCkKKwkJc25kX2hkYV9jb2RlY193cml0ZShjb2RlYywgZnJvbnQsIDAsIEFDX1ZF
UkJfU0VUX0VBUERfQlRMRU5BQkxFLAogCQkJICAgICFzcGVjLT5pbnZfZWFwZCA/IDB4MDAgOiAw
eDAyKTsKLQlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVjLCBocCwgMCwgQUNfVkVSQl9TRVRfRUFQ
RF9CVExFTkFCTEUsCisJaWYgKHNuZF9oZGFfcXVlcnlfcGluX2NhcHMoY29kZWMsIGhwKSAmIEFD
X1BJTkNBUF9FQVBEKQorCQlzbmRfaGRhX2NvZGVjX3dyaXRlKGNvZGVjLCBocCwgMCwgQUNfVkVS
Ql9TRVRfRUFQRF9CVExFTkFCTEUsCiAJCQkgICAgIXNwZWMtPmludl9lYXBkID8gMHgwMCA6IDB4
MDIpOwogfQogCi0tIAoxLjYuMC42Cgo=
--0015174c427810f77c04a4a27c45
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174c427810f77c04a4a27c45--
