From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/6] ASoC: atmel: Add .owner to struct
	snd_soc_card
Date: Thu, 22 Dec 2011 21:14:58 +0800
Message-ID: <1324559698.10821.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DF44103D20
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 14:15:05 +0100 (CET)
Received: by yhjj56 with SMTP id j56so5814570yhj.38
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 05:15:04 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lrg@ti.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

TWlzc2VkIC5vd25lciBvZiBzdHJ1Y3Qgc25kX3NvY19jYXJkIHdpbGwgcHJldmVudCB0aGUgbW9k
dWxlIGZyb20gYmVpbmcKcmVtb3ZlZCBmcm9tIHVuZGVybmVhdGggaXRzIHVzZXJzLgoKUmVwb3J0
ZWQtYnk6IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4KU2lnbmVkLW9m
Zi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNvbT4KLS0tCiBzb3VuZC9zb2MvYXRtZWwv
c2FtOWcyMF93bTg3MzEuYyAgIHwgICAgMSArCiBzb3VuZC9zb2MvYXRtZWwvc25kLXNvYy1hZmVi
OTI2MC5jIHwgICAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYXRtZWwvc2FtOWcyMF93bTg3MzEuYyBi
L3NvdW5kL3NvYy9hdG1lbC9zYW05ZzIwX3dtODczMS5jCmluZGV4IDAzNzdjNTQuLmM4ODM1MTQg
MTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9hdG1lbC9zYW05ZzIwX3dtODczMS5jCisrKyBiL3NvdW5k
L3NvYy9hdG1lbC9zYW05ZzIwX3dtODczMS5jCkBAIC0xODksNiArMTg5LDcgQEAgc3RhdGljIHN0
cnVjdCBzbmRfc29jX2RhaV9saW5rIGF0OTFzYW05ZzIwZWtfZGFpID0gewogCiBzdGF0aWMgc3Ry
dWN0IHNuZF9zb2NfY2FyZCBzbmRfc29jX2F0OTFzYW05ZzIwZWsgPSB7CiAJLm5hbWUgPSAiQVQ5
MVNBTUcyMC1FSyIsCisJLm93bmVyID0gVEhJU19NT0RVTEUsCiAJLmRhaV9saW5rID0gJmF0OTFz
YW05ZzIwZWtfZGFpLAogCS5udW1fbGlua3MgPSAxLAogCS5zZXRfYmlhc19sZXZlbCA9IGF0OTFz
YW05ZzIwZWtfc2V0X2JpYXNfbGV2ZWwsCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYXRtZWwvc25k
LXNvYy1hZmViOTI2MC5jIGIvc291bmQvc29jL2F0bWVsL3NuZC1zb2MtYWZlYjkyNjAuYwppbmRl
eCBkNDI3ZTkyLi40Y2E2NjdkIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvYXRtZWwvc25kLXNvYy1h
ZmViOTI2MC5jCisrKyBiL3NvdW5kL3NvYy9hdG1lbC9zbmQtc29jLWFmZWI5MjYwLmMKQEAgLTEz
NSw2ICsxMzUsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgYWZlYjkyNjBfZGFp
ID0gewogLyogQXVkaW8gbWFjaGluZSBkcml2ZXIgKi8KIHN0YXRpYyBzdHJ1Y3Qgc25kX3NvY19j
YXJkIHNuZF9zb2NfbWFjaGluZV9hZmViOTI2MCA9IHsKIAkubmFtZSA9ICJBRkVCOTI2MCIsCisJ
Lm93bmVyID0gVEhJU19NT0RVTEUsCiAJLmRhaV9saW5rID0gJmFmZWI5MjYwX2RhaSwKIAkubnVt
X2xpbmtzID0gMSwKIH07Ci0tIAoxLjcuNS40CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
