From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] sound/usb/mixer.c: fix dmesg source grepability
Date: Sun, 20 Jul 2014 16:05:25 +0200 (CEST)
Message-ID: <04a9938055f532572d1852b8c856d45b37ac9cde.1405864895.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [89.167.52.164])
 by alsa0.perex.cz (Postfix) with ESMTP id C3CCD264FBA
 for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2014 16:05:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "moderated list:SOUND" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

VGhpcyBmaXhlcyBtZXNzYWdlcyBmcm9tIGNvbW1pdCA4MGFjZWZmZjNiYzdiZDUzZDQ2YzE2YzY4
M2FiNjZjMGVjZTIwODEwLgoKU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc2xhdyA8bWlycS1s
aW51eEByZXJlLnFtcW0ucGw+CgotLS0KIHNvdW5kL3VzYi9taXhlci5jIHwgMTQgKysrKysrKy0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvc291bmQvdXNiL21peGVyLmMgYi9zb3VuZC91c2IvbWl4ZXIuYwppbmRleCBk
NDBhMjg1Li5hMjc4YjgyIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvbWl4ZXIuYworKysgYi9zb3Vu
ZC91c2IvbWl4ZXIuYwpAQCAtMTMwNSwxMyArMTMwNSwxMyBAQCBzdGF0aWMgdm9pZCBidWlsZF9m
ZWF0dXJlX2N0bChzdHJ1Y3QgbWl4ZXJfYnVpbGQgKnN0YXRlLCB2b2lkICpyYXdfZGVzYywKIAkg
KiBkZXZpY2VzLiBJdCB3aWxsIGRlZmluaXRpdmVseSBjYXRjaCBhbGwgYnVnZ3kgTG9naXRlY2gg
ZGV2aWNlcy4KIAkgKi8KIAlpZiAocmFuZ2UgPiAzODQpIHsKLQkJdXNiX2F1ZGlvX3dhcm4oc3Rh
dGUtPmNoaXAsICJXYXJuaW5nISBVbmxpa2VseSBiaWcgIgotCQkJICAgInZvbHVtZSByYW5nZSAo
PSV1KSwgY3ZhbC0+cmVzIGlzIHByb2JhYmx5IHdyb25nLiIsCi0JCQkgICByYW5nZSk7Ci0JCXVz
Yl9hdWRpb193YXJuKHN0YXRlLT5jaGlwLCAiWyVkXSBGVSBbJXNdIGNoID0gJWQsICIKLQkJCSAg
ICJ2YWwgPSAlZC8lZC8lZCIsIGN2YWwtPmlkLAotCQkJICAga2N0bC0+aWQubmFtZSwgY3ZhbC0+
Y2hhbm5lbHMsCi0JCQkgICBjdmFsLT5taW4sIGN2YWwtPm1heCwgY3ZhbC0+cmVzKTsKKwkJdXNi
X2F1ZGlvX3dhcm4oc3RhdGUtPmNoaXAsCisJCQkgICAgICAgIldhcm5pbmchIFVubGlrZWx5IGJp
ZyB2b2x1bWUgcmFuZ2UgKD0ldSksIGN2YWwtPnJlcyBpcyBwcm9iYWJseSB3cm9uZy4iLAorCQkJ
ICAgICAgIHJhbmdlKTsKKwkJdXNiX2F1ZGlvX3dhcm4oc3RhdGUtPmNoaXAsCisJCQkgICAgICAg
IlslZF0gRlUgWyVzXSBjaCA9ICVkLCB2YWwgPSAlZC8lZC8lZCIsCisJCQkgICAgICAgY3ZhbC0+
aWQsIGtjdGwtPmlkLm5hbWUsIGN2YWwtPmNoYW5uZWxzLAorCQkJICAgICAgIGN2YWwtPm1pbiwg
Y3ZhbC0+bWF4LCBjdmFsLT5yZXMpOwogCX0KIAogCXVzYl9hdWRpb19kYmcoc3RhdGUtPmNoaXAs
ICJbJWRdIEZVIFslc10gY2ggPSAlZCwgdmFsID0gJWQvJWQvJWRcbiIsCi0tIAoyLjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBt
YWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
