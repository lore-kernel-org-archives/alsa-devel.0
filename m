From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] wm8990: Implement speaker volume PGA
Date: Fri, 15 Aug 2008 16:22:33 +0100
Message-ID: <1218813753-24344-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1218813753-24344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14441246ED
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 17:22:35 +0200 (CEST)
In-Reply-To: <1218813753-24344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The latest revisions of the WM8990 provide a programmable gain amplifier
for the speaker - configure the register cache and implement controls
for this. Older revisions of the device ignore writes to these controls.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8990.c |    8 ++++++--
 sound/soc/codecs/wm8990.h |   14 ++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

This ought to go into 2.6.27 - without this current revisions will have
problems with the speaker on resume due to the register cache default.

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 9505a18..e44153f 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -82,7 +82,7 @@ static const u16 wm8990_reg[] = {
 	0x0003,     /* R35 - ClassD1 */
 	0x0000,     /* R36 */
 	0x0100,     /* R37 - ClassD3 */
-	0x0000,     /* R38 */
+	0x0079,     /* R38 - ClassD4 */
 	0x0000,     /* R39 - Input Mixer1 */
 	0x0000,     /* R40 - Input Mixer2 */
 	0x0000,     /* R41 - Input Mixer3 */
@@ -311,11 +311,15 @@ SOC_SINGLE("Speaker Mode Switch", WM8990_CLASSD1,
 	WM8990_CDMODE_BIT, 1, 0),
 
 SOC_SINGLE("Speaker Output Attenuation Volume", WM8990_SPEAKER_VOLUME,
-	WM8990_SPKVOL_SHIFT, WM8990_SPKVOL_MASK, 0),
+	WM8990_SPKATTN_SHIFT, WM8990_SPKATTN_MASK, 0),
 SOC_SINGLE("Speaker DC Boost Volume", WM8990_CLASSD3,
 	WM8990_DCGAIN_SHIFT, WM8990_DCGAIN_MASK, 0),
 SOC_SINGLE("Speaker AC Boost Volume", WM8990_CLASSD3,
 	WM8990_ACGAIN_SHIFT, WM8990_ACGAIN_MASK, 0),
+SOC_SINGLE_TLV("Speaker Volume", WM8990_CLASSD4,
+	WM8990_SPKVOL_SHIFT, WM8990_SPKVOL_MASK, 0, out_pga_tlv),
+SOC_SINGLE("Speaker ZC Switch", WM8990_CLASSD4,
+	WM8990_SPKZC_SHIFT, WM8990_SPKZC_MASK, 0),
 
 SOC_WM899X_OUTPGA_SINGLE_R_TLV("Left DAC Digital Volume",
 	WM8990_LEFT_DAC_DIGITAL_VOLUME,
diff --git a/sound/soc/codecs/wm8990.h b/sound/soc/codecs/wm8990.h
index 6bea574..0a08325 100644
--- a/sound/soc/codecs/wm8990.h
+++ b/sound/soc/codecs/wm8990.h
@@ -54,6 +54,7 @@
 #define WM8990_SPEAKER_VOLUME                   0x22
 #define WM8990_CLASSD1                          0x23
 #define WM8990_CLASSD3                          0x25
+#define WM8990_CLASSD4                          0x26
 #define WM8990_INPUT_MIXER1                     0x27
 #define WM8990_INPUT_MIXER2                     0x28
 #define WM8990_INPUT_MIXER3                     0x29
@@ -528,8 +529,8 @@
 /*
  * R34 (0x22) - Speaker Volume
  */
-#define WM8990_SPKVOL_MASK                      0x0003  /* SPKVOL - [1:0] */
-#define WM8990_SPKVOL_SHIFT			0
+#define WM8990_SPKATTN_MASK                      0x0003  /* SPKATTN - [1:0] */
+#define WM8990_SPKATTN_SHIFT			 0
 
 /*
  * R35 (0x23) - ClassD1
@@ -544,6 +545,15 @@
 #define WM8990_DCGAIN_SHIFT			3
 #define WM8990_ACGAIN_MASK                      0x0007  /* ACGAIN - [2:0] */
 #define WM8990_ACGAIN_SHIFT			0
+
+/*
+ * R38 (0x26) - ClassD4
+ */
+#define WM8990_SPKZC_MASK                       0x0001  /* SPKZC */
+#define WM8990_SPKZC_SHIFT                           7  /* SPKZC */
+#define WM8990_SPKVOL_MASK                      0x007F  /* SPKVOL - [6:0] */
+#define WM8990_SPKVOL_SHIFT                          0  /* SPKVOL - [6:0] */
+
 /*
  * R39 (0x27) - Input Mixer1
  */
-- 
1.5.6.3
