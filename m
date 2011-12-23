From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: au1x: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 09:53:55 +0800
Message-ID: <1324605235.3108.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B7AE5103F45
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 02:54:07 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1276550ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 17:54:07 -0800 (PST)
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQp2MjogcmVnZW5l
cmF0ZSB0aGUgcGF0Y2ggYWdhaW5zdCBhc29jIHRyZWUuCgogc291bmQvc29jL2F1MXgvZGIxMDAw
LmMgfCAgICAxICsKIHNvdW5kL3NvYy9hdTF4L2RiMTIwMC5jIHwgICAgMiArKwogMiBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2F1MXgvZGIxMDAwLmMgYi9zb3VuZC9zb2MvYXUxeC9kYjEwMDAuYwppbmRleCAxMjc0
NzdhLi44Mzg3ZDQyIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvYXUxeC9kYjEwMDAuYworKysgYi9z
b3VuZC9zb2MvYXUxeC9kYjEwMDAuYwpAQCAtMjksNiArMjksNyBAQCBzdGF0aWMgc3RydWN0IHNu
ZF9zb2NfZGFpX2xpbmsgZGIxMDAwX2FjOTdfZGFpID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9z
b2NfY2FyZCBkYjEwMDBfYWM5NyA9IHsKIAkubmFtZQkJPSAiREIxMDAwX0FDOTciLAorCS5vd25l
cgkJPSBUSElTX01PRFVMRSwKIAkuZGFpX2xpbmsJPSAmZGIxMDAwX2FjOTdfZGFpLAogCS5udW1f
bGlua3MJPSAxLAogfTsKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hdTF4L2RiMTIwMC5jIGIvc291
bmQvc29jL2F1MXgvZGIxMjAwLmMKaW5kZXggMjg5MzEyYy4uMTVlNTEzOCAxMDA2NDQKLS0tIGEv
c291bmQvc29jL2F1MXgvZGIxMjAwLmMKKysrIGIvc291bmQvc29jL2F1MXgvZGIxMjAwLmMKQEAg
LTQ1LDYgKzQ1LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGRiMTIwMF9hYzk3
X2RhaSA9IHsKIAogc3RhdGljIHN0cnVjdCBzbmRfc29jX2NhcmQgZGIxMjAwX2FjOTdfbWFjaGlu
ZSA9IHsKIAkubmFtZQkJPSAiREIxMjAwX0FDOTciLAorCS5vd25lcgkJPSBUSElTX01PRFVMRSwK
IAkuZGFpX2xpbmsJPSAmZGIxMjAwX2FjOTdfZGFpLAogCS5udW1fbGlua3MJPSAxLAogfTsKQEAg
LTk0LDYgKzk1LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9saW5rIGRiMTIwMF9pMnNf
ZGFpID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBkYjEyMDBfaTJzX21hY2hpbmUg
PSB7CiAJLm5hbWUJCT0gIkRCMTIwMF9JMlMiLAorCS5vd25lcgkJPSBUSElTX01PRFVMRSwKIAku
ZGFpX2xpbmsJPSAmZGIxMjAwX2kyc19kYWksCiAJLm51bV9saW5rcwk9IDEsCiB9OwotLSAKMS43
LjUuNAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
