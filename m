From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Tune performance of WM8958 revision A
Date: Tue, 30 Nov 2010 14:33:09 +0000
Message-ID: <1291127589-32082-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 544D8103995
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:33:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmciro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Update some of the default configuration for the device to improve
the performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |    9 ++++++++
 sound/soc/codecs/wm8994.c            |   35 +++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index a610c87..4d5a561 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -64,6 +64,7 @@
 #define WM8994_LDO_1                            0x3B
 #define WM8994_LDO_2                            0x3C
 #define WM8994_CHARGE_PUMP_1                    0x4C
+#define WM8958_CHARGE_PUMP_2                    0x4D
 #define WM8994_CLASS_W_1                        0x51
 #define WM8994_DC_SERVO_1                       0x54
 #define WM8994_DC_SERVO_2                       0x55
@@ -1858,6 +1859,14 @@
 #define WM8994_CP_ENA_WIDTH                          1  /* CP_ENA */
 
 /*
+ * R77 (0x4D) - Charge Pump (2)
+ */
+#define WM8958_CP_DISCH                         0x8000  /* CP_DISCH */
+#define WM8958_CP_DISCH_MASK                    0x8000  /* CP_DISCH */
+#define WM8958_CP_DISCH_SHIFT                       15  /* CP_DISCH */
+#define WM8958_CP_DISCH_WIDTH                        1  /* CP_DISCH */
+
+/*
  * R81 (0x51) - Class W (1)
  */
 #define WM8994_CP_DYN_SRC_SEL_MASK              0x0300  /* CP_DYN_SRC_SEL - [9:8] */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index bfd4cf4..b4c3cca 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1806,15 +1806,32 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			pm_runtime_get_sync(codec->dev);
 
-			/* Tweak DC servo and DSP configuration for
-			 * improved performance. */
-			if (control->type == WM8994 && wm8994->revision < 4) {
-				/* Tweak DC servo and DSP configuration for
-				 * improved performance. */
-				snd_soc_write(codec, 0x102, 0x3);
-				snd_soc_write(codec, 0x56, 0x3);
-				snd_soc_write(codec, 0x817, 0);
-				snd_soc_write(codec, 0x102, 0);
+			switch (control->type) {
+			case WM8994:
+				if (wm8994->revision < 4) {
+					/* Tweak DC servo and DSP
+					 * configuration for improved
+					 * performance. */
+					snd_soc_write(codec, 0x102, 0x3);
+					snd_soc_write(codec, 0x56, 0x3);
+					snd_soc_write(codec, 0x817, 0);
+					snd_soc_write(codec, 0x102, 0);
+				}
+				break;
+
+			case WM8958:
+				if (wm8994->revision == 0) {
+					/* Optimise performance for rev A */
+					snd_soc_write(codec, 0x102, 0x3);
+					snd_soc_write(codec, 0xcb, 0x81);
+					snd_soc_write(codec, 0x817, 0);
+					snd_soc_write(codec, 0x102, 0);
+
+					snd_soc_update_bits(codec,
+							    WM8958_CHARGE_PUMP_2,
+							    WM8958_CP_DISCH,
+							    WM8958_CP_DISCH);
+				}
 			}
 
 			/* Discharge LINEOUT1 & 2 */
-- 
1.7.1
