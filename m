From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Implement new DC servo readback mode
	for late WM8994 revisions
Date: Mon,  1 Aug 2011 14:12:51 +0900
Message-ID: <1312175572-13551-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B8A4243EF
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 08:04:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Later WM8994 devices implement a new DC servo readback mode with the
register used to access the offset moved to register 0x59. Implement
support for this and enable it on the appropriate devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |    1 +
 sound/soc/codecs/wm8994.c            |    3 ++-
 sound/soc/codecs/wm_hubs.c           |   19 +++++++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index f3ee842..6152914 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -72,6 +72,7 @@
 #define WM8994_DC_SERVO_2                       0x55
 #define WM8994_DC_SERVO_4                       0x57
 #define WM8994_DC_SERVO_READBACK                0x58
+#define WM8994_DC_SERVO_4E			0x59
 #define WM8994_ANALOGUE_HP_1                    0x60
 #define WM8958_MIC_DETECT_1                     0xD0
 #define WM8958_MIC_DETECT_2                     0xD1
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index cc8222c..e1e9aca 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -107,6 +107,7 @@ static int wm8994_volatile(struct snd_soc_codec *codec, unsigned int reg)
 	case WM8994_LDO_2:
 	case WM8958_DSP2_EXECCONTROL:
 	case WM8958_MIC_DETECT_3:
+	case WM8994_DC_SERVO_4E:
 		return 1;
 	default:
 		return 0;
@@ -2965,7 +2966,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			wm8994->hubs.series_startup = 1;
 			break;
 		default:
-			wm8994->hubs.dcs_readback_mode = 1;
+			wm8994->hubs.dcs_readback_mode = 2;
 			break;
 		}
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 4416a76..524bdc6 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/wm8994/registers.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -116,14 +117,23 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 {
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	s8 offset;
-	u16 reg, reg_l, reg_r, dcs_cfg;
+	u16 reg, reg_l, reg_r, dcs_cfg, dcs_reg;
+
+	switch (hubs->dcs_readback_mode) {
+	case 2:
+		dcs_reg = WM8994_DC_SERVO_4E;
+		break;
+	default:
+		dcs_reg = WM8993_DC_SERVO_3;
+		break;
+	}
 
 	/* If we're using a digital only path and have a previously
 	 * callibrated DC servo offset stored then use that. */
 	if (hubs->class_w && hubs->class_w_dcs) {
 		dev_dbg(codec->dev, "Using cached DC servo offset %x\n",
 			hubs->class_w_dcs);
-		snd_soc_write(codec, WM8993_DC_SERVO_3, hubs->class_w_dcs);
+		snd_soc_write(codec, dcs_reg, hubs->class_w_dcs);
 		wait_for_dc_servo(codec,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
@@ -154,8 +164,9 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
 			& WM8993_DCS_INTEG_CHAN_1_MASK;
 		break;
+	case 2:
 	case 1:
-		reg = snd_soc_read(codec, WM8993_DC_SERVO_3);
+		reg = snd_soc_read(codec, dcs_reg);
 		reg_r = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
 			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
 		reg_l = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
@@ -185,7 +196,7 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		dev_dbg(codec->dev, "DCS result: %x\n", dcs_cfg);
 
 		/* Do it */
-		snd_soc_write(codec, WM8993_DC_SERVO_3, dcs_cfg);
+		snd_soc_write(codec, dcs_reg, dcs_cfg);
 		wait_for_dc_servo(codec,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
-- 
1.7.5.4
