From: =?UTF-8?q?Daniel=20Sch=C3=BCrmann?= <daschuer@mixxx.org>
Subject: [PATCH v3] ALSA: snd-usb-audio: set the timeout for
	usb control set messages to 5000 ms
Date: Sat, 20 Apr 2013 23:06:17 +0200
Message-ID: <1366491977-12348-1-git-send-email-daschuer@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 084BC265215
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 23:06:59 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id j4so204901bkw.18
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 14:06:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, =?UTF-8?q?Daniel=20Sch=C3=BCrmann?= <daschuer@mixxx.org>, clemens@ladisch.de, zonque@gmail.com, hegge@resisty.net, gabrbedd@gmail.com
List-Id: alsa-devel@alsa-project.org

VGhpcyBpcyBhbiBvdGhlciB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBzZW5kIHZpYSBnaXQgc2VuZC1l
bWFpbC4gSSBzdGlsbCAKZGlzdGluZ3Vpc2ggYmV0d2VlbiBzZXQgYW5kIGdldCBidXQgYXMgbG9u
ZyBib3RoIGFyZSA1MDAwIG1zIEdDQyB3aWxsIApyZW1vdmUgaXQgYW55d2F5LiBJTUhPIHRoaXMg
aXMgbW9yZSBlYXN5IHJlYWQgYW5kIHRoZXJlIGlzIG5vIG5lZWQgdG8gCmV4cGxhaW4gd2h5IHdl
IHVzZSBhIGdldCB0aW1lb3V0IGZvciBzZXQgbWVzc2FnZXMuCgpDb21taXQgbWVzc2FnZToKU2V0
IHRoZSB0aW1lb3V0IGZvciBVU0IgY29udHJvbCBzZXQgbWVzc2FnZXMgYWNjb3JkaW5nIHRvIHRo
ZSBVU0IgMgpzcGVjLCB1c2luZyB0aGUgbWFjcm9zIGZyb20gaW5jbHVkZS9saW51eC91c2IuaC4g
ICAgIApUaGUgZ2V0IHRpbW91dCBiZWNvbWVzIDUwMDAgbXMgZXZlbiB0aG91Z2ggaXQgaXMgNTAw
IG1zIGluIHRoZSAgICAKc3BlYy4gVGhpcyBwYXRjaCBpcyByZXF1aXJlZCB0byBydW4gdGhlIEhl
cmN1bGVzIFJNWDIgd2hpY2ggbmVlZHMgYQp0aW1lb3V0IG9mIDEyNDAgbXMuCgpTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgU2Now7xybWFubiA8ZGFzY2h1ZXJAbWl4eHgub3JnPgotLS0KIHNvdW5kL3Vz
Yi9oZWxwZXIuYyB8ICAgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9oZWxwZXIuYyBiL3Nv
dW5kL3VzYi9oZWxwZXIuYwppbmRleCBjMWRiMjhmLi42MjA5MDI0IDEwMDY0NAotLS0gYS9zb3Vu
ZC91c2IvaGVscGVyLmMKKysrIGIvc291bmQvdXNiL2hlbHBlci5jCkBAIC04NiwxNCArODYsMjIg
QEAgaW50IHNuZF91c2JfY3RsX21zZyhzdHJ1Y3QgdXNiX2RldmljZSAqZGV2LCB1bnNpZ25lZCBp
bnQgcGlwZSwgX191OCByZXF1ZXN0LAogewogCWludCBlcnI7CiAJdm9pZCAqYnVmID0gTlVMTDsK
KwlpbnQgdGltZW91dDsKIAogCWlmIChzaXplID4gMCkgewogCQlidWYgPSBrbWVtZHVwKGRhdGEs
IHNpemUsIEdGUF9LRVJORUwpOwogCQlpZiAoIWJ1ZikKIAkJCXJldHVybiAtRU5PTUVNOwogCX0K
KworCWlmIChyZXF1ZXN0dHlwZSAmIFVTQl9ESVJfSU4pCisJCXRpbWVvdXQgPSBVU0JfQ1RSTF9H
RVRfVElNRU9VVDsKKwllbHNlCisJCXRpbWVvdXQgPSBVU0JfQ1RSTF9TRVRfVElNRU9VVDsKKwog
CWVyciA9IHVzYl9jb250cm9sX21zZyhkZXYsIHBpcGUsIHJlcXVlc3QsIHJlcXVlc3R0eXBlLAot
CQkJICAgICAgdmFsdWUsIGluZGV4LCBidWYsIHNpemUsIDEwMDApOworCQkJICAgICAgdmFsdWUs
IGluZGV4LCBidWYsIHNpemUsIHRpbWVvdXQpOworCiAJaWYgKHNpemUgPiAwKSB7CiAJCW1lbWNw
eShkYXRhLCBidWYsIHNpemUpOwogCQlrZnJlZShidWYpOwotLSAKMS43LjkuNQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
