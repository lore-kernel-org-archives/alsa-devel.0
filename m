From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/6] ASoC: ep93xx: Add .owner to struct
	snd_soc_card
Date: Thu, 22 Dec 2011 21:21:37 +0800
Message-ID: <1324560097.10821.8.camel@phoenix>
References: <1324559698.10821.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 56496103DC3
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 14:21:44 +0100 (CET)
Received: by ghbz2 with SMTP id z2so885735ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 05:21:43 -0800 (PST)
In-Reply-To: <1324559698.10821.2.camel@phoenix>
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
Cc: Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Lothar@alsa-project.org, Liam Girdwood <lrg@ti.com>, =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

TWlzc2VkIC5vd25lciBvZiBzdHJ1Y3Qgc25kX3NvY19jYXJkIHdpbGwgcHJldmVudCB0aGUgbW9k
dWxlIGZyb20gYmVpbmcKcmVtb3ZlZCBmcm9tIHVuZGVybmVhdGggaXRzIHVzZXJzLgoKUmVwb3J0
ZWQtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4KU2lnbmVkLW9m
Zi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9zb2MvZXA5M3h4
L2VkYjkzeHguYyAgICAgfCAgICAxICsKIHNvdW5kL3NvYy9lcDkzeHgvc2ltb25lLmMgICAgICB8
ICAgIDEgKwogc291bmQvc29jL2VwOTN4eC9zbmFwcGVyY2wxNS5jIHwgICAgMSArCiAzIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9z
b3VuZC9zb2MvZXA5M3h4L2VkYjkzeHguYyBiL3NvdW5kL3NvYy9lcDkzeHgvZWRiOTN4eC5jCmlu
ZGV4IDlmNmZlY2QuLmJhZTVjYmIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9lcDkzeHgvZWRiOTN4
eC5jCisrKyBiL3NvdW5kL3NvYy9lcDkzeHgvZWRiOTN4eC5jCkBAIC03NSw2ICs3NSw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc25kX3NvY19kYWlfbGluayBlZGI5M3h4X2RhaSA9IHsKIAogc3RhdGljIHN0
cnVjdCBzbmRfc29jX2NhcmQgc25kX3NvY19lZGI5M3h4ID0gewogCS5uYW1lCQk9ICJFREI5M1hY
IiwKKwkub3duZXIJCT0gVEhJU19NT0RVTEUsCiAJLmRhaV9saW5rCT0gJmVkYjkzeHhfZGFpLAog
CS5udW1fbGlua3MJPSAxLAogfTsKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9lcDkzeHgvc2ltb25l
LmMgYi9zb3VuZC9zb2MvZXA5M3h4L3NpbW9uZS5jCmluZGV4IDFlMDBiMzMuLmRkOTk3MDkgMTAw
NjQ0Ci0tLSBhL3NvdW5kL3NvYy9lcDkzeHgvc2ltb25lLmMKKysrIGIvc291bmQvc29jL2VwOTN4
eC9zaW1vbmUuYwpAQCAtMzQsNiArMzQsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xp
bmsgc2ltb25lX2RhaSA9IHsKIAogc3RhdGljIHN0cnVjdCBzbmRfc29jX2NhcmQgc25kX3NvY19z
aW1vbmUgPSB7CiAJLm5hbWUJCT0gIlNpbS5PbmUiLAorCS5vd25lcgkJPSBUSElTX01PRFVMRSwK
IAkuZGFpX2xpbmsJPSAmc2ltb25lX2RhaSwKIAkubnVtX2xpbmtzCT0gMSwKIH07CmRpZmYgLS1n
aXQgYS9zb3VuZC9zb2MvZXA5M3h4L3NuYXBwZXJjbDE1LmMgYi9zb3VuZC9zb2MvZXA5M3h4L3Nu
YXBwZXJjbDE1LmMKaW5kZXggZTk3Y2Q1Ny4uY2NhZTM0YSAxMDA2NDQKLS0tIGEvc291bmQvc29j
L2VwOTN4eC9zbmFwcGVyY2wxNS5jCisrKyBiL3NvdW5kL3NvYy9lcDkzeHgvc25hcHBlcmNsMTUu
YwpAQCAtOTMsNiArOTMsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgc25hcHBl
cmNsMTVfZGFpID0gewogCiBzdGF0aWMgc3RydWN0IHNuZF9zb2NfY2FyZCBzbmRfc29jX3NuYXBw
ZXJjbDE1ID0gewogCS5uYW1lCQk9ICJTbmFwcGVyIENMMTUiLAorCS5vd25lcgkJPSBUSElTX01P
RFVMRSwKIAkuZGFpX2xpbmsJPSAmc25hcHBlcmNsMTVfZGFpLAogCS5udW1fbGlua3MJPSAxLAog
fTsKLS0gCjEuNy41LjQKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
