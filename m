From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Kcontrols for ASoC TWL4030 CODEC
Date: Thu, 20 Nov 2008 18:12:56 +0530
Message-ID: <ef0d8a250811200442j3146441cgc4650153974e62d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_104608_4345427.1227184976448"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id C4DD524355
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 13:42:57 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so427231rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 04:42:56 -0800 (PST)
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
Cc: Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

------=_Part_104608_4345427.1227184976448
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here i submit the patch for the kcontrols for ASoC TWL4030 CODEC.

This patch comes next to my first patch.

There seems some MUA issue so i attached the patch.

>From 228b912bef74c4f22f4afaa031ac0ce0fef652f1 Mon Sep 17 00:00:00 2001
From: chnaveenkrishna <chnaveen@chnaveen.mistral.in>
Date: Thu, 20 Nov 2008 18:11:45 +0530
Subject: [PATCH] Kcontrols for gain selection and enabling, disabling the
ADC, DAC-2

---
 sound/soc/codecs/twl4030.c |   61
+++++++++++++++++++++++++++++++++++++++----
 1 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3bc42b3..f258ea2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -190,12 +190,61 @@ static void twl4030_init_chip(struct snd_soc_codec
*codec)
 }

 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
-    SOC_DOUBLE_R("Master Playback Volume",
-         TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
-        0, 127, 0),
-    SOC_DOUBLE_R("Capture Volume",
-         TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
-        0, 127, 0),
+
+    /* Master Playback Volume Controls */
+        SOC_DOUBLE_R("Master PLayback Course Gain",
+                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
+                6, 3, 0),
+
+        SOC_DOUBLE_R("Master Playback Fine Gain",
+                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
+                0, 63, 0),
+
+        /* Master Capture Gain controls */
+        SOC_DOUBLE_R("Master Capture Gain",
+                TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
+                0, 31, 0),
+
+        /* Headset volume controls */
+        SOC_DOUBLE("Headset Volume",
+                TWL4030_REG_HS_GAIN_SET, 2, 0, 3, 0),
+
+        /* Ear Piece volume controls */
+        SOC_SINGLE("Earpiece Volume",
+                TWL4030_REG_EAR_CTL, 4, 3, 0),
+
+        /* Internal Class D Speaker volume controls */
+        SOC_DOUBLE_R("Internal Speaker Volume",
+                TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
+                 3, 17, 0),
+
+        /* External Class D Speaker volume controls */
+        SOC_DOUBLE_R("External Speaker Volume",
+                TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
+                4, 3, 0),
+
+    /* Predriver Carkit volume controls */
+        SOC_DOUBLE_R("Pre Car-Kit Volume",
+                TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
+                4, 3, 0),
+
+        SOC_DOUBLE("Main + Sub Mic Capture Gain",
+                TWL4030_REG_ANAMIC_GAIN, 3 , 0, 5, 0),
+
+        /* Loop gain controls*/
+        SOC_DOUBLE("Loop Gain", TWL4030_REG_ATX2ARXPGA,
+                3 , 0, 7, 0),
+
+        /* Left and Right ADC Switches */
+        SOC_SINGLE("ADCL", TWL4030_REG_AVADC_CTL, 3, 1, 0),
+
+        SOC_SINGLE("ADCR", TWL4030_REG_AVADC_CTL, 1, 1, 0),
+
+        /* Left and Right DAC-2 Switches */
+        SOC_SINGLE("DACL2", TWL4030_REG_AVDAC_CTL, 3, 1, 0),
+
+        SOC_SINGLE("DACR2", TWL4030_REG_AVDAC_CTL, 2, 1, 0),
+
 };

 /* add non dapm controls */
-- 
1.5.3.4

-- 
Thanks,

(: Naveen Krishna Ch :)

------=_Part_104608_4345427.1227184976448
Content-Type: application/octet-stream; name=kcontrols-patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnrem0fl0
Content-Disposition: attachment; filename=kcontrols-patch

RnJvbSAyMjhiOTEyYmVmNzRjNGYyMmY0YWZhYTAzMWFjMGNlMGZlZjY1MmYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBjaG5hdmVlbmtyaXNobmEgPGNobmF2ZWVuQGNobmF2ZWVuLm1p
c3RyYWwuaW4+CkRhdGU6IFRodSwgMjAgTm92IDIwMDggMTg6MTE6NDUgKzA1MzAKU3ViamVjdDog
W1BBVENIXSBLY29udHJvbHMgZm9yIGdhaW4gc2VsZWN0aW9uIGFuZCBlbmFibGluZywgZGlzYWJs
aW5nIHRoZSBBREMsIERBQy0yCgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvdHdsNDAzMC5jIHwgICA2
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGVzIGNo
YW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2NvZGVjcy90d2w0MDMwLmMgYi9zb3VuZC9zb2MvY29kZWNzL3R3bDQwMzAuYwppbmRl
eCAzYmM0MmIzLi5mMjU4ZWEyIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL3R3bDQwMzAu
YworKysgYi9zb3VuZC9zb2MvY29kZWNzL3R3bDQwMzAuYwpAQCAtMTkwLDEyICsxOTAsNjEgQEAg
c3RhdGljIHZvaWQgdHdsNDAzMF9pbml0X2NoaXAoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVj
KQogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgdHdsNDAzMF9zbmRf
Y29udHJvbHNbXSA9IHsKLQlTT0NfRE9VQkxFX1IoIk1hc3RlciBQbGF5YmFjayBWb2x1bWUiLAot
CQkgVFdMNDAzMF9SRUdfQVJYTDJQR0EsIFRXTDQwMzBfUkVHX0FSWFIyUEdBLAotCQkwLCAxMjcs
IDApLAotCVNPQ19ET1VCTEVfUigiQ2FwdHVyZSBWb2x1bWUiLAotCQkgVFdMNDAzMF9SRUdfQVRY
TDFQR0EsIFRXTDQwMzBfUkVHX0FUWFIxUEdBLAotCQkwLCAxMjcsIDApLAorCQorCS8qIE1hc3Rl
ciBQbGF5YmFjayBWb2x1bWUgQ29udHJvbHMgKi8KKyAgICAgICAgU09DX0RPVUJMRV9SKCJNYXN0
ZXIgUExheWJhY2sgQ291cnNlIEdhaW4iLAorICAgICAgICAgICAgICAgIFRXTDQwMzBfUkVHX0FS
WEwyUEdBLCBUV0w0MDMwX1JFR19BUlhSMlBHQSwKKyAgICAgICAgICAgICAgICA2LCAzLCAwKSwK
KworICAgICAgICBTT0NfRE9VQkxFX1IoIk1hc3RlciBQbGF5YmFjayBGaW5lIEdhaW4iLAorICAg
ICAgICAgICAgICAgIFRXTDQwMzBfUkVHX0FSWEwyUEdBLCBUV0w0MDMwX1JFR19BUlhSMlBHQSwK
KyAgICAgICAgICAgICAgICAwLCA2MywgMCksCisKKyAgICAgICAgLyogTWFzdGVyIENhcHR1cmUg
R2FpbiBjb250cm9scyAqLworICAgICAgICBTT0NfRE9VQkxFX1IoIk1hc3RlciBDYXB0dXJlIEdh
aW4iLAorICAgICAgICAgICAgICAgIFRXTDQwMzBfUkVHX0FUWEwxUEdBLCBUV0w0MDMwX1JFR19B
VFhSMVBHQSwKKyAgICAgICAgICAgICAgICAwLCAzMSwgMCksCisKKyAgICAgICAgLyogSGVhZHNl
dCB2b2x1bWUgY29udHJvbHMgKi8KKyAgICAgICAgU09DX0RPVUJMRSgiSGVhZHNldCBWb2x1bWUi
LAorICAgICAgICAgICAgICAgIFRXTDQwMzBfUkVHX0hTX0dBSU5fU0VULCAyLCAwLCAzLCAwKSwK
KworICAgICAgICAvKiBFYXIgUGllY2Ugdm9sdW1lIGNvbnRyb2xzICovCisgICAgICAgIFNPQ19T
SU5HTEUoIkVhcnBpZWNlIFZvbHVtZSIsCisgICAgICAgICAgICAgICAgVFdMNDAzMF9SRUdfRUFS
X0NUTCwgNCwgMywgMCksCisKKyAgICAgICAgLyogSW50ZXJuYWwgQ2xhc3MgRCBTcGVha2VyIHZv
bHVtZSBjb250cm9scyAqLworICAgICAgICBTT0NfRE9VQkxFX1IoIkludGVybmFsIFNwZWFrZXIg
Vm9sdW1lIiwKKyAgICAgICAgICAgICAgICBUV0w0MDMwX1JFR19BUlhMMl9BUEdBX0NUTCwgVFdM
NDAzMF9SRUdfQVJYUjJfQVBHQV9DVEwsCisgICAgICAgICAgICAgICAgIDMsIDE3LCAwKSwKKwor
ICAgICAgICAvKiBFeHRlcm5hbCBDbGFzcyBEIFNwZWFrZXIgdm9sdW1lIGNvbnRyb2xzICovCisg
ICAgICAgIFNPQ19ET1VCTEVfUigiRXh0ZXJuYWwgU3BlYWtlciBWb2x1bWUiLAorICAgICAgICAg
ICAgICAgIFRXTDQwMzBfUkVHX1BSRURMX0NUTCwgVFdMNDAzMF9SRUdfUFJFRFJfQ1RMLAorICAg
ICAgICAgICAgICAgIDQsIDMsIDApLAorCQorCS8qIFByZWRyaXZlciBDYXJraXQgdm9sdW1lIGNv
bnRyb2xzICovCisgICAgICAgIFNPQ19ET1VCTEVfUigiUHJlIENhci1LaXQgVm9sdW1lIiwKKyAg
ICAgICAgICAgICAgICBUV0w0MDMwX1JFR19QUkVDS0xfQ1RMLCBUV0w0MDMwX1JFR19QUkVDS1Jf
Q1RMLAorICAgICAgICAgICAgICAgIDQsIDMsIDApLAorCisgICAgICAgIFNPQ19ET1VCTEUoIk1h
aW4gKyBTdWIgTWljIENhcHR1cmUgR2FpbiIsCisgICAgICAgICAgICAgICAgVFdMNDAzMF9SRUdf
QU5BTUlDX0dBSU4sIDMgLCAwLCA1LCAwKSwKKworICAgICAgICAvKiBMb29wIGdhaW4gY29udHJv
bHMqLworICAgICAgICBTT0NfRE9VQkxFKCJMb29wIEdhaW4iLCBUV0w0MDMwX1JFR19BVFgyQVJY
UEdBLAorICAgICAgICAgICAgICAgIDMgLCAwLCA3LCAwKSwKKworICAgICAgICAvKiBMZWZ0IGFu
ZCBSaWdodCBBREMgU3dpdGNoZXMgKi8KKyAgICAgICAgU09DX1NJTkdMRSgiQURDTCIsIFRXTDQw
MzBfUkVHX0FWQURDX0NUTCwgMywgMSwgMCksCisKKyAgICAgICAgU09DX1NJTkdMRSgiQURDUiIs
IFRXTDQwMzBfUkVHX0FWQURDX0NUTCwgMSwgMSwgMCksCisKKyAgICAgICAgLyogTGVmdCBhbmQg
UmlnaHQgREFDLTIgU3dpdGNoZXMgKi8KKyAgICAgICAgU09DX1NJTkdMRSgiREFDTDIiLCBUV0w0
MDMwX1JFR19BVkRBQ19DVEwsIDMsIDEsIDApLAorCisgICAgICAgIFNPQ19TSU5HTEUoIkRBQ1Iy
IiwgVFdMNDAzMF9SRUdfQVZEQUNfQ1RMLCAyLCAxLCAwKSwKKwogfTsKIAogLyogYWRkIG5vbiBk
YXBtIGNvbnRyb2xzICovCi0tIAoxLjUuMy40Cgo=
------=_Part_104608_4345427.1227184976448
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_104608_4345427.1227184976448--
