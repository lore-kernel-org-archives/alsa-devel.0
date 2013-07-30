From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: bf5xx-ac97: Fix compile error
Date: Tue, 30 Jul 2013 13:34:09 +0200
Message-ID: <1375184050-21514-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-226.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id AD127261981
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:33:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

SWYgQ09ORklHX1NORF9CRjVYWF9IQVZFX0NPTERfUkVTRVQgaXMgZW5hYmxlZCBidWlsZGluZyB0
aGUgYmxhY2tmaW4gYWM5NyBkcml2ZXIKZmFpbHMgd2l0aCB0aGUgZm9sbG93aW5nIGNvbXBpbGUg
ZXJyb3I6Cglzb3VuZC9zb2MvYmxhY2tmaW4vYmY1eHgtYWM5Ny5jOiBJbiBmdW5jdGlvbiDigJhh
c29jX2JmaW5fYWM5N19wcm9iZeKAmToKCXNvdW5kL3NvYy9ibGFja2Zpbi9iZjV4eC1hYzk3LmM6
Mjk3OiBlcnJvcjogZXhwZWN0ZWQg4oCYO+KAmSBiZWZvcmUg4oCYe+KAmSB0b2tlbgoJc291bmQv
c29jL2JsYWNrZmluL2JmNXh4LWFjOTcuYzozMDI6IGVycm9yOiBsYWJlbCDigJhncGlvX2VycuKA
mSB1c2VkIGJ1dCBub3QgZGVmaW5lZAoKVGhlIGlzc3VlIHdhcyBpbnRyb2R1Y2VkIGluIGNvbW1p
dCA2ZGFiMmZkNyAoIkFTb0M6IGJmNXh4LWFjOTc6IENvbnZlcnQgdG8KZGV2bV9ncGlvX3JlcXVl
c3Rfb25lKCkiKS4KClNpZ25lZC1vZmYtYnk6IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRh
Zm9vLmRlPgotLS0KIHNvdW5kL3NvYy9ibGFja2Zpbi9iZjV4eC1hYzk3LmMgfCA1ICsrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9ibGFja2Zpbi9iZjV4eC1hYzk3LmMgYi9zb3VuZC9zb2MvYmxhY2tmaW4v
YmY1eHgtYWM5Ny5jCmluZGV4IGVmYjFkYWUuLmU4MmViMzcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3Nv
Yy9ibGFja2Zpbi9iZjV4eC1hYzk3LmMKKysrIGIvc291bmQvc29jL2JsYWNrZmluL2JmNXh4LWFj
OTcuYwpAQCAtMjk0LDExICsyOTQsMTIgQEAgc3RhdGljIGludCBhc29jX2JmaW5fYWM5N19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCS8qIFJlcXVlc3QgUEIzIGFzIHJlc2V0
IHBpbiAqLwogCXJldCA9IGRldm1fZ3Bpb19yZXF1ZXN0X29uZSgmcGRldi0+ZGV2LAogCQkJCSAg
ICBDT05GSUdfU05EX0JGNVhYX1JFU0VUX0dQSU9fTlVNLAotCQkJCSAgICBHUElPRl9PVVRfSU5J
VF9ISUdILCAiU05EX0FEMTk4eCBSRVNFVCIpIHsKKwkJCQkgICAgR1BJT0ZfT1VUX0lOSVRfSElH
SCwgIlNORF9BRDE5OHggUkVTRVQiKTsKKwlpZiAocmV0KSB7CiAJCWRldl9lcnIoJnBkZXYtPmRl
diwKIAkJCSJGYWlsZWQgdG8gcmVxdWVzdCBHUElPXyVkIGZvciByZXNldDogJWRcbiIsCiAJCQlD
T05GSUdfU05EX0JGNVhYX1JFU0VUX0dQSU9fTlVNLCByZXQpOwotCQlnb3RvIGdwaW9fZXJyOwor
CQlyZXR1cm4gcmV0OwogCX0KICNlbmRpZgogCi0tIAoxLjguMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
