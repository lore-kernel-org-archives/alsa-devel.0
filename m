From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Store DC offset correction for wm_hubs
	devices in class W mode
Date: Wed, 27 Oct 2010 20:34:41 -0700
Message-ID: <1288236881-7751-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 322841037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 05:34:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Providing the analogue configuration of the output path remains the same
the DC offset corrected by the DC servo will remain identical so we can
skip the callibration, reducing the startup time for the headphone output.
Implement this for the wm_hubs devices as has been done for several other
CODECs.

Don't do this if we have any analogue paths enabled since offsets may be
being introduced by the analogue paths which could vary outside the
control of the driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This change has not been tested yet but I'm sending it out for review
now to accelerate the process.

 sound/soc/codecs/wm8993.c  |    2 +
 sound/soc/codecs/wm8994.c  |    3 ++
 sound/soc/codecs/wm_hubs.c |   69 +++++++++++++++++++++++++++++--------------
 sound/soc/codecs/wm_hubs.h |    3 ++
 4 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 589e3fa..67fe5cc 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -735,6 +735,7 @@ static int class_w_put(struct snd_kcontrol *kcontrol,
 					    0);
 		}
 		wm8993->class_w_users++;
+		wm8993->hubs_data.class_w = true;
 	}
 
 	/* Implement the change */
@@ -751,6 +752,7 @@ static int class_w_put(struct snd_kcontrol *kcontrol,
 					    WM8993_CP_DYN_V);
 		}
 		wm8993->class_w_users--;
+		wm8993->hubs_data.class_w = false;
 	}
 
 	dev_dbg(codec->dev, "Indirect DAC use count now %d\n",
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 0db59c3..3f70dee 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2228,6 +2228,7 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 
 static void wm8994_update_class_w(struct snd_soc_codec *codec)
 {
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int enable = 1;
 	int source = 0;  /* GCC flow analysis can't track enable */
 	int reg, reg_r;
@@ -2278,11 +2279,13 @@ static void wm8994_update_class_w(struct snd_soc_codec *codec)
 				    WM8994_CP_DYN_PWR |
 				    WM8994_CP_DYN_SRC_SEL_MASK,
 				    source | WM8994_CP_DYN_PWR);
+		wm8994->hubs.class_w = true;
 		
 	} else {
 		dev_dbg(codec->dev, "Class W disabled\n");
 		snd_soc_update_bits(codec, WM8994_CLASS_W_1,
 				    WM8994_CP_DYN_PWR, 0);
+		wm8994->hubs.class_w = false;
 	}
 }
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 2cb8153..31c2a57 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -94,6 +94,18 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	u16 reg, reg_l, reg_r, dcs_cfg;
 
+	/* If we're using a digital only path and have a previously
+	 * callibrated DC servo offset stored then use that. */
+	if (hubs->class_w && hubs->class_w_dcs) {
+		dev_dbg(codec->dev, "Using cached DC servo offset %x\n",
+			hubs->class_w_dcs);
+		snd_soc_write(codec, WM8993_DC_SERVO_3, hubs->class_w_dcs);
+		wait_for_dc_servo(codec,
+				  WM8993_DCS_TRIG_DAC_WR_0 |
+				  WM8993_DCS_TRIG_DAC_WR_1);
+		return;
+	}
+
 	/* Set for 32 series updates */
 	snd_soc_update_bits(codec, WM8993_DC_SERVO_1,
 			    WM8993_DCS_SERIES_NO_01_MASK,
@@ -101,34 +113,34 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 	wait_for_dc_servo(codec,
 			  WM8993_DCS_TRIG_SERIES_0 | WM8993_DCS_TRIG_SERIES_1);
 
+	/* Different chips in the family support different readback
+	 * methods.
+	 */
+	switch (hubs->dcs_readback_mode) {
+	case 0:
+		reg_l = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_1)
+			& WM8993_DCS_INTEG_CHAN_0_MASK;;
+		reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
+			& WM8993_DCS_INTEG_CHAN_1_MASK;
+		break;
+	case 1:
+		reg = snd_soc_read(codec, WM8993_DC_SERVO_3);
+		reg_l = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
+			>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
+		reg_r = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
+		break;
+	default:
+		WARN(1, "Unknown DCS readback method");
+		break;
+	}
+
+	dev_dbg(codec->dev, "DCS input: %x %x\n", reg_l, reg_r);
+
 	/* Apply correction to DC servo result */
 	if (hubs->dcs_codes) {
 		dev_dbg(codec->dev, "Applying %d code DC servo correction\n",
 			hubs->dcs_codes);
 
-		/* Different chips in the family support different
-		 * readback methods.
-		 */
-		switch (hubs->dcs_readback_mode) {
-		case 0:
-			reg_l = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_1)
-				& WM8993_DCS_INTEG_CHAN_0_MASK;;
-			reg_r = snd_soc_read(codec, WM8993_DC_SERVO_READBACK_2)
-				& WM8993_DCS_INTEG_CHAN_1_MASK;
-			break;
-		case 1:
-			reg = snd_soc_read(codec, WM8993_DC_SERVO_3);
-			reg_l = (reg & WM8993_DCS_DAC_WR_VAL_1_MASK)
-				>> WM8993_DCS_DAC_WR_VAL_1_SHIFT;
-			reg_r = reg & WM8993_DCS_DAC_WR_VAL_0_MASK;
-			break;
-		default:
-			WARN(1, "Unknown DCS readback method");
-			break;
-		}
-
-		dev_dbg(codec->dev, "DCS input: %x %x\n", reg_l, reg_r);
-
 		/* HPOUT1L */
 		if (reg_l + hubs->dcs_codes > 0 &&
 		    reg_l + hubs->dcs_codes < 0xff)
@@ -148,7 +160,15 @@ static void calibrate_dc_servo(struct snd_soc_codec *codec)
 		wait_for_dc_servo(codec,
 				  WM8993_DCS_TRIG_DAC_WR_0 |
 				  WM8993_DCS_TRIG_DAC_WR_1);
+	} else {
+		dcs_cfg = reg_l << WM8993_DCS_DAC_WR_VAL_1_SHIFT;
+		dcs_cfg |= reg_r;
 	}
+
+	/* Save the callibrated offset if we're in class W mode and
+	 * therefore don't have any analogue signal mixed in. */
+	if (hubs->class_w)
+		hubs->class_w_dcs = dcs_cfg;
 }
 
 /*
@@ -163,6 +183,9 @@ static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 
 	ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
 
+	/* Updating the analogue gains invalidates the DC servo cache */
+	hubs->class_w_dcs = 0;
+
 	/* If we're applying an offset correction then updating the
 	 * callibration would be likely to introduce further offsets. */
 	if (hubs->dcs_codes)
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index e51c166..f8a5e97 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -23,6 +23,9 @@ struct wm_hubs_data {
 	int dcs_codes;
 	int dcs_readback_mode;
 	int hp_startup_mode;
+
+	bool class_w;
+	u16 class_w_dcs;
 };
 
 extern int wm_hubs_add_analogue_controls(struct snd_soc_codec *);
-- 
1.7.1
