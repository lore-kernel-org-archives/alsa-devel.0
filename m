From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_hubs: Factor out DC servo
	readback code
Date: Thu, 26 Jul 2012 14:15:42 +0100
Message-ID: <1343308543-22455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19C4C264EFB
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 15:15:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's currently only used in one place but another user will be added
shortly and there's an argument it's clearer anyway.

Also add support for readback in mode 1, though it's not currently used.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   65 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 728a180..6ab69f3 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -199,6 +199,47 @@ static void wm_hubs_dcs_cache_set(struct snd_soc_codec *codec, u16 dcs_cfg)
 	list_add_tail(&cache->list, &hubs->dcs_cache);
 }
 
+static void wm_hubs_read_dc_servo(struct snd_soc_codec *codec,
+				  u16 *reg_l, u16 *reg_r)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	u16 dcs_reg, reg;
+
+	switch (hubs->dcs_readback_mode) {
+	case 2:
+		dcs_reg = WM8994_DC_SERVO_4E;
+		break;
+	case 1:
+		dcs_reg = WM8994_DC_SERVO_READBACK;
+		break;
+	default:
+		dcs_reg = WM8993_DC_SERVO_3;
+		break;
+	}
+
+	/* Different chips in the family support different readback
+	 * methods.
+	 */
+	switch (hubs->dcs_readback_mode) {
+	case 0:
+		*reg_l = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_1)
+			& WM8993_DCS_INTEG_CHAN_0_MASK;
+		*reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
+			& WM8993_DCS_INTEG_CHAN_1_MASK;
+		break;
+	case 2:
+	case 1:
+		reg = snd_soc_read(codec, dcs_reg);
+		*reg_r = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
+			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
+		*reg_l = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
+		break;
+	default:
+		WARN(1, "Unknown DCS readback method\n");
+		return;
+	}
+}
+
 /*
  * Startup calibration of the DC servo
  */
@@ -207,7 +248,7 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct wm_hubs_dcs_cache *cache;
 	s8 offset;
-	u16 reg, reg_l, reg_r, dcs_cfg, dcs_reg;
+	u16 reg_l, reg_r, dcs_cfg, dcs_reg;
 
 	switch (hubs->dcs_readback_mode) {
 	case 2:
@@ -245,27 +286,7 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 				  WM8993_DCS_TRIG_STARTUP_1);
 	}
 
-	/* Different chips in the family support different readback
-	 * methods.
-	 */
-	switch (hubs->dcs_readback_mode) {
-	case 0:
-		reg_l = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_1)
-			& WM8993_DCS_INTEG_CHAN_0_MASK;
-		reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
-			& WM8993_DCS_INTEG_CHAN_1_MASK;
-		break;
-	case 2:
-	case 1:
-		reg = snd_soc_read(codec, dcs_reg);
-		reg_r = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
-			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
-		reg_l = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
-		break;
-	default:
-		WARN(1, "Unknown DCS readback method\n");
-		return;
-	}
+	wm_hubs_read_dc_servo(codec, &reg_l, &reg_r);
 
 	dev_dbg(codec->dev, "DCS input: %x %x\n", reg_l, reg_r);
 
-- 
1.7.10.4
