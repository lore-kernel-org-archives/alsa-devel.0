From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [ALSA] sound/usb/mixer.c: improve dmesg source
	grepability
Date: Sun,  3 Aug 2014 15:09:57 +0200 (CEST)
Message-ID: <89e02ed1efc1ceaab2f31096a4636e0495c7a863.1407071205.git.mirq-linux@rere.qmqm.pl>
References: <04a9938055f532572d1852b8c856d45b37ac9cde.1405864895.git.mirq-linux@rere.qmqm.pl>
 <s5hfvhuor2o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rere.qmqm.pl (rere.qmqm.pl [89.167.52.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 19FEF26525F
 for <alsa-devel@alsa-project.org>; Sun,  3 Aug 2014 15:09:58 +0200 (CEST)
In-Reply-To: <s5hfvhuor2o.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

VGhpcyBpbXByb3ZlcyBtZXNzYWdlcyBmcm9tIGNvbW1pdCA4MGFjZWZmZjNiYzdiZDUzZDQ2YzE2
YzY4M2FiNjZjMGVjZTIwODEwLgoKU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc2xhdyA8bWly
cS1saW51eEByZXJlLnFtcW0ucGw+CkNjOiBBbGV4ZXkgRmlzaGVyIDxidWctdHJhY2tAZmlzaGVy
LXByaXZhdC5uZXQ+ClNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PFgmF3IDxtaXJxLWxpbnV4
QHJlcmUucW1xbS5wbD4KLS0tCiBzb3VuZC91c2IvbWl4ZXIuYyB8IDkgKysrKy0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKcGF0Y2ggYWdhaW5z
dCBjdXJyZW50IExpbnVzJ3MgdHJlZS4KCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvbWl4ZXIuYyBi
L3NvdW5kL3VzYi9taXhlci5jCmluZGV4IDBiNzI4ZDguLjJlNGE5ZGIgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3VzYi9taXhlci5jCisrKyBiL3NvdW5kL3VzYi9taXhlci5jCkBAIC0xMzQwLDEyICsxMzQw
LDExIEBAIHN0YXRpYyB2b2lkIGJ1aWxkX2ZlYXR1cmVfY3RsKHN0cnVjdCBtaXhlcl9idWlsZCAq
c3RhdGUsIHZvaWQgKnJhd19kZXNjLAogCSAqLwogCWlmIChyYW5nZSA+IDM4NCkgewogCQl1c2Jf
YXVkaW9fd2FybihzdGF0ZS0+Y2hpcCwKLQkJCSAgICAgICAiV2FybmluZyEgVW5saWtlbHkgYmln
IHZvbHVtZSByYW5nZSAoPSV1KSwgIgotCQkJICAgICAgICJjdmFsLT5yZXMgaXMgcHJvYmFibHkg
d3JvbmcuIiwKKwkJCSAgICAgICAiV2FybmluZyEgVW5saWtlbHkgYmlnIHZvbHVtZSByYW5nZSAo
PSV1KSwgY3ZhbC0+cmVzIGlzIHByb2JhYmx5IHdyb25nLiIsCiAJCQkgICAgICAgcmFuZ2UpOwot
CQl1c2JfYXVkaW9fd2FybihzdGF0ZS0+Y2hpcCwgIlslZF0gRlUgWyVzXSBjaCA9ICVkLCAiCi0J
CQkgICAgICAgInZhbCA9ICVkLyVkLyVkIiwgY3ZhbC0+aWQsCi0JCQkgICAgICAga2N0bC0+aWQu
bmFtZSwgY3ZhbC0+Y2hhbm5lbHMsCisJCXVzYl9hdWRpb193YXJuKHN0YXRlLT5jaGlwLAorCQkJ
ICAgICAgICJbJWRdIEZVIFslc10gY2ggPSAlZCwgdmFsID0gJWQvJWQvJWQiLAorCQkJICAgICAg
IGN2YWwtPmlkLCBrY3RsLT5pZC5uYW1lLCBjdmFsLT5jaGFubmVscywKIAkJCSAgICAgICBjdmFs
LT5taW4sIGN2YWwtPm1heCwgY3ZhbC0+cmVzKTsKIAl9CiAKLS0gCjIuMC4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
