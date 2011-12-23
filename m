From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/8] ASoC: nuc900: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:51:17 +0800
Message-ID: <1324623077.2295.4.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A19F8103F3F
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:51:24 +0100 (CET)
Received: by yenr11 with SMTP id r11so2295069yen.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:51:24 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wan ZongShun <mcuos.com@gmail.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L251YzkwMC9udWM5MDAtYXVkaW8uYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvc29jL251YzkwMC9u
dWM5MDAtYXVkaW8uYyBiL3NvdW5kL3NvYy9udWM5MDAvbnVjOTAwLWF1ZGlvLmMKaW5kZXggMzhh
MmQwZC4uMmY2ZTZmZCAxMDA2NDQKLS0tIGEvc291bmQvc29jL251YzkwMC9udWM5MDAtYXVkaW8u
YworKysgYi9zb3VuZC9zb2MvbnVjOTAwL251YzkwMC1hdWRpby5jCkBAIC0zMiw2ICszMiw3IEBA
IHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBudWM5MDBldmJfYWM5N19kYWkgPSB7CiAK
IHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIG51YzkwMGV2Yl9hdWRpb19tYWNoaW5lID0gewog
CS5uYW1lCQk9ICJOVUM5MDBFVkJfQUM5NyIsCisJLm93bmVyCQk9IFRISVNfTU9EVUxFLAogCS5k
YWlfbGluawk9ICZudWM5MDBldmJfYWM5N19kYWksCiAJLm51bV9saW5rcwk9IDEsCiB9OwotLSAK
MS43LjUuNAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
