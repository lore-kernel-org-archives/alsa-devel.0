From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/7] pcm: set error code at failure path
Date: Mon, 11 Jul 2016 21:06:01 +0900
Message-ID: <1468238763-15547-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 56AD9265ACA
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:10 +0200 (CEST)
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

VGhpcyBjb21taXQgZml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3MuCgpwY21faHcuYzogSW4g
ZnVuY3Rpb24g4oCYX3NuZF9wY21faHdfb3BlbuKAmToKcGNtX2h3LmM6MTgxNjoxNjogd2Fybmlu
Zzog4oCYZXJy4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBb
LVdtYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICByZXR1cm4gZXJyOwogICAgICAgICAgICAg
ICAgXgoKU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBTYWthbW90byA8by10YWthc2hpQHNha2Ftb2Nj
aGkuanA+Ci0tLQogc3JjL3BjbS9wY21faHcuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc3JjL3BjbS9wY21faHcuYyBiL3NyYy9wY20vcGNtX2h3
LmMKaW5kZXggNGY0Yjg0Yi4uMWZlMzA3ZiAxMDA2NDQKLS0tIGEvc3JjL3BjbS9wY21faHcuYwor
KysgYi9zcmMvcGNtL3BjbV9ody5jCkBAIC0xNzY5LDYgKzE3NjksNyBAQCBpbnQgX3NuZF9wY21f
aHdfb3BlbihzbmRfcGNtX3QgKipwY21wLCBjb25zdCBjaGFyICpuYW1lLAogCQkJY2htYXAgPSBf
c25kX3BjbV9wYXJzZV9jb25maWdfY2htYXBzKG4pOwogCQkJaWYgKCFjaG1hcCkgewogCQkJCVNO
REVSUigiSW52YWxpZCBjaGFubmVsIG1hcCBmb3IgJXMiLCBpZCk7CisJCQkJZXJyID0gLUVJTlZB
TDsKIAkJCQlnb3RvIGZhaWw7CiAJCQl9CiAJCQljb250aW51ZTsKLS0gCjIuNy40CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
