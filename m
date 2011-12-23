From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/8] ASoC: jz4740: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:48:19 +0800
Message-ID: <1324622899.2295.1.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 16F0F103E90
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:48:26 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1332685ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:48:26 -0800 (PST)
In-Reply-To: <1324622828.2295.0.camel@phoenix>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L2p6NDc0MC9xaV9sYjYwLmMgfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9qejQ3NDAvcWlfbGI2
MC5jIGIvc291bmQvc29jL2p6NDc0MC9xaV9sYjYwLmMKaW5kZXggYzVmYzMzOS4uMDA5N2MzYiAx
MDA2NDQKLS0tIGEvc291bmQvc29jL2p6NDc0MC9xaV9sYjYwLmMKKysrIGIvc291bmQvc29jL2p6
NDc0MC9xaV9sYjYwLmMKQEAgLTgxLDYgKzgxLDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2Rh
aV9saW5rIHFpX2xiNjBfZGFpID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBxaV9s
YjYwID0gewogCS5uYW1lID0gIlFJIExCNjAiLAorCS5vd25lciA9IFRISVNfTU9EVUxFLAogCS5k
YWlfbGluayA9ICZxaV9sYjYwX2RhaSwKIAkubnVtX2xpbmtzID0gMSwKIAotLSAKMS43LjUuNAoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
