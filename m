From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - alsa-lib/test/latency.c - print error
 message when playback/capture does not support two periods per buffer
Date: Wed, 20 Apr 2011 16:32:05 +0800
Message-ID: <BANLkTinPq0FVNb0N6a8CaBi5+OVwz5uNNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015173fe69ab1bc4804a1557560
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9A1C9243F2
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 10:32:08 +0200 (CEST)
Received: by fxm5 with SMTP id 5so341807fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2011 01:32:05 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0015173fe69ab1bc4804a1557560
Content-Type: text/plain; charset=ISO-8859-1

print error message when playback/capture device does not support two
periods per buffer

alsa-lib/test/latency does not perform real test when playback/capture
devices does not support two periods per buffer
and this confuse user that the sound card pass the test but in fact no test
has been performed

--0015173fe69ab1bc4804a1557560
Content-Type: application/octet-stream;
	name="0001-print-error-message-when-playback-capture-does-not-support_two_periods_per_buffer.patch"
Content-Disposition: attachment;
	filename="0001-print-error-message-when-playback-capture-does-not-support_two_periods_per_buffer.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmq05fhf0

RnJvbSBkOGY0Nzc4MjEzYjc5NTA0ZjNhZGQyMGEzYjg4NTE0ZDc0YjEwZmU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBXZWQsIDIwIEFwciAyMDExIDE2OjE4OjUwICswODAwClN1YmplY3Q6IFtbUEFU
Q0hdIGFsc2EtbGliL3Rlc3QvbGF0ZW5jeS5jIDEvMV0gcHJpbnQgZXJyb3IgbWVzc2FnZSB3aGVu
IHBsYXliYWNrL2NhcHR1cmUgZG9lcyBub3Qgc3VwcG9ydCAyIHBlcmlvZHMgcGVyIGJ1ZmZlcgoK
ClNpZ25lZC1vZmYtYnk6IFJheW1vbmQgWWF1IDxzdXBlcnF1YWQudm9ydGV4MkBnbWFpbC5jb20+
CgpkaWZmIC0tZ2l0IGEvdGVzdC9sYXRlbmN5LmMgYi90ZXN0L2xhdGVuY3kuYwppbmRleCAwM2Q2
NWEyLi5lZTg1OWNlIDEwMDY0NAotLS0gYS90ZXN0L2xhdGVuY3kuYworKysgYi90ZXN0L2xhdGVu
Y3kuYwpAQCAtMTc1LDYgKzE3NSw3IEBAIGludCBzZXRwYXJhbXMoc25kX3BjbV90ICpwaGFuZGxl
LCBzbmRfcGNtX3QgKmNoYW5kbGUsIGludCAqYnVmc2l6ZSkKIAlzbmRfcGNtX3N3X3BhcmFtc190
ICpwX3N3cGFyYW1zLCAqY19zd3BhcmFtczsKIAlzbmRfcGNtX3VmcmFtZXNfdCBwX3NpemUsIGNf
c2l6ZSwgcF9wc2l6ZSwgY19wc2l6ZTsKIAl1bnNpZ25lZCBpbnQgcF90aW1lLCBjX3RpbWU7CisJ
dW5zaWduZWQgaW50IHZhbDsKIAogCXNuZF9wY21faHdfcGFyYW1zX2FsbG9jYSgmcF9wYXJhbXMp
OwogCXNuZF9wY21faHdfcGFyYW1zX2FsbG9jYSgmY19wYXJhbXMpOwpAQCAtMjI2LDEyICsyMjcs
MjMgQEAgaW50IHNldHBhcmFtcyhzbmRfcGNtX3QgKnBoYW5kbGUsIHNuZF9wY21fdCAqY2hhbmRs
ZSwgaW50ICpidWZzaXplKQogCQlnb3RvIF9fYWdhaW47CiAKIAlzbmRfcGNtX2h3X3BhcmFtc19n
ZXRfYnVmZmVyX3NpemUocF9wYXJhbXMsICZwX3NpemUpOwotCWlmIChwX3BzaXplICogMiA8IHBf
c2l6ZSkKKwlpZiAocF9wc2l6ZSAqIDIgPCBwX3NpemUpIHsKKyAgICAgICAgICAgICAgICBzbmRf
cGNtX2h3X3BhcmFtc19nZXRfcGVyaW9kc19taW4ocF9wYXJhbXMsICZ2YWwsIE5VTEwpOworICAg
ICAgICAgICAgICAgIGlmICh2YWwgPiAyKSB7CisJCQlwcmludGYoInBsYXliYWNrIGRldmljZSBk
b2VzIG5vdCBzdXBwb3J0IDIgcGVyaW9kcyBwZXIgYnVmZmVyXG4iKTsKKwkJCWV4aXQoMCk7CisJ
CX0KIAkJZ290byBfX2FnYWluOworCX0KIAlzbmRfcGNtX2h3X3BhcmFtc19nZXRfYnVmZmVyX3Np
emUoY19wYXJhbXMsICZjX3NpemUpOwotCWlmIChjX3BzaXplICogMiA8IGNfc2l6ZSkKKwlpZiAo
Y19wc2l6ZSAqIDIgPCBjX3NpemUpIHsKKyAgICAgICAgICAgICAgICBzbmRfcGNtX2h3X3BhcmFt
c19nZXRfcGVyaW9kc19taW4oY19wYXJhbXMsICZ2YWwsIE5VTEwpOworCQlpZiAodmFsID4gMiAp
IHsKKwkJCXByaW50ZigiY2FwdHVyZSBkZXZpY2UgZG9lcyBub3Qgc3VwcG9ydCAyIHBlcmlvZHMg
cGVyIGJ1ZmZlclxuIik7CisJCQlleGl0KDApOworCQl9CiAJCWdvdG8gX19hZ2FpbjsKLQorCX0K
IAlpZiAoKGVyciA9IHNldHBhcmFtc19zZXQocGhhbmRsZSwgcF9wYXJhbXMsIHBfc3dwYXJhbXMs
ICJwbGF5YmFjayIpKSA8IDApIHsKIAkJcHJpbnRmKCJVbmFibGUgdG8gc2V0IHN3IHBhcmFtZXRl
cnMgZm9yIHBsYXliYWNrIHN0cmVhbTogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKIAkJZXhp
dCgwKTsKQEAgLTYwOSw3ICs2MjEsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQogCQlpZiAoKGVyciA9IHNuZF9wY21fbGluayhjaGFuZGxlLCBwaGFuZGxlKSkgPCAwKSB7CiAJ
CQlwcmludGYoIlN0cmVhbXMgbGluayBlcnJvcjogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsK
IAkJCWV4aXQoMCk7Ci0JCX0KKwkJfSAKIAkJaWYgKHNuZF9wY21fZm9ybWF0X3NldF9zaWxlbmNl
KGZvcm1hdCwgYnVmZmVyLCBsYXRlbmN5KmNoYW5uZWxzKSA8IDApIHsKIAkJCWZwcmludGYoc3Rk
ZXJyLCAic2lsZW5jZSBlcnJvclxuIik7CiAJCQlicmVhazsKLS0gCjEuNi4wLjYKCg==
--0015173fe69ab1bc4804a1557560
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015173fe69ab1bc4804a1557560--
