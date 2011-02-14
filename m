From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA : au88x0 - modify pointer callback of
 au88x0 to give accurate playback position
Date: Mon, 14 Feb 2011 09:32:06 +0800
Message-ID: <AANLkTin4VX5xT_056dHnPH1owTi5_OhDFDTVRdfwMQ=S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba1819a0084b94049c340465
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 450681037F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 02:32:10 +0100 (CET)
Received: by ewy19 with SMTP id 19so1939398ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 17:32:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: manuel.jander@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--90e6ba1819a0084b94049c340465
Content-Type: text/plain; charset=ISO-8859-1

Modify pointer callback of au88x0 to give accurate playback position


Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

--90e6ba1819a0084b94049c340465
Content-Type: application/octet-stream;
	name="0001-Modify-pointer-callback-of-au88x0-to-give-accurate-playback-position.patch"
Content-Disposition: attachment;
	filename="0001-Modify-pointer-callback-of-au88x0-to-give-accurate-playback-position.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk4p903p0

RnJvbSBjOGQxMjEyYTE1ZDE2NGJlNjkzNmZkN2I5ZjA0ZDRiM2MzOGE0ZDY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDE0IEZlYiAyMDExIDA3OjMzOjI0ICswODAwClN1YmplY3Q6IFtQQVRD
SCBBTFNBIGF1ODh4MCAxLzFdIE1vZGlmeSBwb2ludGVyIGNhbGxiYWNrIG9mIGF1ODh4MCB0byBn
aXZlIGFjY3VyYXRlIHBsYXliYWNrIHBvc2l0aW9uCgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZ
YXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kv
YXU4OHgwL2F1ODh4MF9jb3JlLmMgYi9zb3VuZC9wY2kvYXU4OHgwL2F1ODh4MF9jb3JlLmMKaW5k
ZXggMjNmNDlmMy4uMzBmZjYwYiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2F1ODh4MC9hdTg4eDBf
Y29yZS5jCisrKyBiL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX2NvcmUuYwpAQCAtMTI1MiwxMSAr
MTI1MiwxOSBAQCBzdGF0aWMgdm9pZCB2b3J0ZXhfYWRiZG1hX3Jlc2V0dXAodm9ydGV4X3QgKnZv
cnRleCwgaW50IGFkYmRtYSkgewogc3RhdGljIGludCBpbmxpbmUgdm9ydGV4X2FkYmRtYV9nZXRs
aW5lYXJwb3Modm9ydGV4X3QgKiB2b3J0ZXgsIGludCBhZGJkbWEpCiB7CiAJc3RyZWFtX3QgKmRt
YSA9ICZ2b3J0ZXgtPmRtYV9hZGJbYWRiZG1hXTsKLQlpbnQgdGVtcDsKKwlpbnQgdGVtcCwgcGFn
ZSwgZGVsdGE7CiAKIAl0ZW1wID0gaHdyZWFkKHZvcnRleC0+bW1pbywgVk9SVEVYX0FEQkRNQV9T
VEFUICsgKGFkYmRtYSA8PCAyKSk7Ci0JdGVtcCA9IChkbWEtPnBlcmlvZF92aXJ0ICogZG1hLT5w
ZXJpb2RfYnl0ZXMpICsgKHRlbXAgJiAoZG1hLT5wZXJpb2RfYnl0ZXMgLSAxKSk7Ci0JcmV0dXJu
IHRlbXA7CisJcGFnZSA9ICh0ZW1wICYgQURCX1NVQkJVRl9NQVNLKSA+PiBBREJfU1VCQlVGX1NI
SUZUOworCWlmIChkbWEtPm5yX3BlcmlvZHMgPj0gNCkKKwkJZGVsdGEgPSAocGFnZSAtIGRtYS0+
cGVyaW9kX3JlYWwpICYgMzsKKwllbHNlIHsKKwkJZGVsdGEgPSAocGFnZSAtIGRtYS0+cGVyaW9k
X3JlYWwpOworCQlpZiAoZGVsdGEgPCAwKQorCQkJZGVsdGEgKz0gZG1hLT5ucl9wZXJpb2RzOwor
CX0KKwlyZXR1cm4gKGRtYS0+cGVyaW9kX3ZpcnQgKyBkZWx0YSkgKiBkbWEtPnBlcmlvZF9ieXRl
cworCQkrICh0ZW1wICYgKGRtYS0+cGVyaW9kX2J5dGVzIC0gMSkpOwogfQogCiBzdGF0aWMgdm9p
ZCB2b3J0ZXhfYWRiZG1hX3N0YXJ0Zmlmbyh2b3J0ZXhfdCAqIHZvcnRleCwgaW50IGFkYmRtYSkK
LS0gCjEuNi4wLjYKCg==
--90e6ba1819a0084b94049c340465
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--90e6ba1819a0084b94049c340465--
