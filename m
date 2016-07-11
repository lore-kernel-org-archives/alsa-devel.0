From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/7] topology: initialize variable for error
	output
Date: Mon, 11 Jul 2016 21:06:00 +0900
Message-ID: <1468238763-15547-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D9B3A265A45
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:08 +0200 (CEST)
In-Reply-To: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gLi4vLi4vaW5jbHVkZS9sb2NhbC5oOjE2NTowLAogICAgICAgICAgICAgICAgIGZy
b20gdHBsZ19sb2NhbC5oOjE3LAogICAgICAgICAgICAgICAgIGZyb20gZGF0YS5jOjIwOgpkYXRh
LmM6IEluIGZ1bmN0aW9uIOKAmHRwbGdfcGFyc2VfdHVwbGVz4oCZOgouLi8uLi9pbmNsdWRlL2Vy
cm9yLmg6NjQ6MjE6IHdhcm5pbmc6IOKAmGlk4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQg
aW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQogI2RlZmluZSBTTkRFUlIo
Li4uKSBzbmRfbGliX2Vycm9yKF9fRklMRV9fLCBfX0xJTkVfXywgX19GVU5DVElPTl9fLCAwLCBf
X1ZBX0FSR1NfXykgLyoqPCBTaG93cyBhIHNvdW5kIGVycm9yIG1lc3NhZ2UuICovCiAgICAgICAg
ICAgICAgICAgICAgIF4KZGF0YS5jOjU3NjoxNDogbm90ZTog4oCYaWTigJkgd2FzIGRlY2xhcmVk
IGhlcmUKICBjb25zdCBjaGFyICppZDsKICAgICAgICAgICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBU
YWthc2hpIFNha2Ftb3RvIDxvLXRha2FzaGlAc2FrYW1vY2NoaS5qcD4KLS0tCiBzcmMvdG9wb2xv
Z3kvZGF0YS5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1n
aXQgYS9zcmMvdG9wb2xvZ3kvZGF0YS5jIGIvc3JjL3RvcG9sb2d5L2RhdGEuYwppbmRleCA5M2Vh
ZjkxLi5jMGEwOThjIDEwMDY0NAotLS0gYS9zcmMvdG9wb2xvZ3kvZGF0YS5jCisrKyBiL3NyYy90
b3BvbG9neS9kYXRhLmMKQEAgLTU3OCw2ICs1NzgsNyBAQCBzdGF0aWMgaW50IHBhcnNlX3R1cGxl
X3NldHMoc25kX3RwbGdfdCAqdHBsZywgc25kX2NvbmZpZ190ICpjZmcsCiAJaW50IGVycjsKIAog
CWlmIChzbmRfY29uZmlnX2dldF90eXBlKGNmZykgIT0gU05EX0NPTkZJR19UWVBFX0NPTVBPVU5E
KSB7CisJCXNuZF9jb25maWdfZ2V0X2lkKGNmZywgJmlkKTsKIAkJU05ERVJSKCJlcnJvcjogY29t
cG91bmQgdHlwZSBleHBlY3RlZCBmb3IgJXMiLCBpZCk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0K
LS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
