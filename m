From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb-caiaq: initialize card pointer
Date: Mon, 18 Jun 2012 21:16:31 +0200
Message-ID: <1340046991-23552-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B93572457E
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2012 21:16:53 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nOgoKICBDQyBbTV0gIHNvdW5kL3VzYi9jYWlhcS9k
ZXZpY2Uubwpzb3VuZC91c2IvY2FpYXEvZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmHNuZF9wcm9i
ZeKAmToKc291bmQvdXNiL2NhaWFxL2RldmljZS5jOjUwMDoxNjogd2FybmluZzog4oCYY2FyZOKA
mSBtYXkgYmUgdXNlZAp1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5p
bml0aWFsaXplZF0KClNpZ25lZC1vZmYtYnk6IERhbmllbCBNYWNrIDx6b25xdWVAZ21haWwuY29t
PgotLS0KIHNvdW5kL3VzYi9jYWlhcS9kZXZpY2UuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9j
YWlhcS9kZXZpY2UuYyBiL3NvdW5kL3VzYi9jYWlhcS9kZXZpY2UuYwppbmRleCA2NGFlZDQzLi43
ZGEwZDBhIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvY2FpYXEvZGV2aWNlLmMKKysrIGIvc291bmQv
dXNiL2NhaWFxL2RldmljZS5jCkBAIC00ODUsNyArNDg1LDcgQEAgc3RhdGljIGludCBfX2Rldmlu
aXQgc25kX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLAogCQkgICAgIGNvbnN0IHN0
cnVjdCB1c2JfZGV2aWNlX2lkICppZCkKIHsKIAlpbnQgcmV0OwotCXN0cnVjdCBzbmRfY2FyZCAq
Y2FyZDsKKwlzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQgPSBOVUxMOwogCXN0cnVjdCB1c2JfZGV2aWNl
ICpkZXZpY2UgPSBpbnRlcmZhY2VfdG9fdXNiZGV2KGludGYpOwogCiAJcmV0ID0gY3JlYXRlX2Nh
cmQoZGV2aWNlLCBpbnRmLCAmY2FyZCk7Ci0tIAoxLjcuMTAuMgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
