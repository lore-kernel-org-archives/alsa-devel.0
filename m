From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 8/8] ASoC: txx9: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 14:54:30 +0800
Message-ID: <1324623270.2295.7.camel@phoenix>
References: <1324622828.2295.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 638FA103F4D
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 07:54:37 +0100 (CET)
Received: by ggnv5 with SMTP id v5so6772048ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 22:54:36 -0800 (PST)
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
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

QWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVudHMg
dGhlIG1vZHVsZSBmcm9tIGJlaW5nCnJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0cyB1c2Vycy4K
ClJlcG9ydGVkLWJ5OiBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxlY3Ryb25pY3MuZGU+ClNp
Z25lZC1vZmYtYnk6IEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ci0tLQogc291bmQvc29j
L3R4eDkvdHh4OWFjbGMtZ2VuZXJpYy5jIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvdHh4OS90
eHg5YWNsYy1nZW5lcmljLmMgYi9zb3VuZC9zb2MvdHh4OS90eHg5YWNsYy1nZW5lcmljLmMKaW5k
ZXggOWI1ZTI4My4uYjA1NmExNCAxMDA2NDQKLS0tIGEvc291bmQvc29jL3R4eDkvdHh4OWFjbGMt
Z2VuZXJpYy5jCisrKyBiL3NvdW5kL3NvYy90eHg5L3R4eDlhY2xjLWdlbmVyaWMuYwpAQCAtMzIs
NiArMzIsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgdHh4OWFjbGNfZ2VuZXJp
Y19kYWkgPSB7CiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19jYXJkIHR4eDlhY2xjX2dlbmVyaWNf
Y2FyZCA9IHsKIAkubmFtZQkJPSAiR2VuZXJpYyBUWHg5IEFDTEMgQXVkaW8iLAorCS5vd25lcgkJ
PSBUSElTX01PRFVMRSwKIAkuZGFpX2xpbmsJPSAmdHh4OWFjbGNfZ2VuZXJpY19kYWksCiAJLm51
bV9saW5rcwk9IDEsCiB9OwotLSAKMS43LjUuNAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
