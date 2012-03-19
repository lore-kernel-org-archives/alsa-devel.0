From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8994: Provide VMID mode control
	and fix default sequence
Date: Mon, 19 Mar 2012 18:59:41 +0000
Message-ID: <1332183581-14591-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1332183581-14591-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B42424358
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 19:59:44 +0100 (CET)
In-Reply-To: <1332183581-14591-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The optimal management of VMID depends on a number of factors which vary
dynamically at runtime, for example the connection to a system docking
station. In some circumstances it is desirable to keep VMID enabled all
the time, in others it is desirable to aggressively power it up and down.

Provide a callback allowing machine driver to configure either the normal
power up/down mode (WM8994_VMID_MODE_NORMAL) or to maintain VMID even
when idle (WM8994_VMID_MODE_FORCE). This callback, wm8994_vmid_mode(),
should be called with the CODEC lock.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  186 +++++++++++++++++++++++++++++++++++----------
 sound/soc/codecs/wm8994.h |    8 ++
 2 files changed, 155 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6ffb1d2..8efc42b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -780,36 +780,68 @@ static void vmid_reference(struct snd_soc_codec *codec)
 
 	if (wm8994->vmid_refcount == 1) {
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
-				    WM8994_LINEOUT_VMID_BUF_ENA |
 				    WM8994_LINEOUT1_DISCH |
-				    WM8994_LINEOUT2_DISCH,
-				    WM8994_LINEOUT_VMID_BUF_ENA);
+				    WM8994_LINEOUT2_DISCH, 0);
 
 		wm_hubs_vmid_ena(codec);
 
-		/* Startup bias, VMID ramp & buffer */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-				    WM8994_BIAS_SRC |
-				    WM8994_VMID_DISCH |
-				    WM8994_STARTUP_BIAS_ENA |
-				    WM8994_VMID_BUF_ENA |
-				    WM8994_VMID_RAMP_MASK,
-				    WM8994_BIAS_SRC |
-				    WM8994_STARTUP_BIAS_ENA |
-				    WM8994_VMID_BUF_ENA |
-				    (0x2 << WM8994_VMID_RAMP_SHIFT));
+		switch (wm8994->vmid_mode) {
+		default:
+			WARN_ON(0 == "Invalid VMID mode");
+		case WM8994_VMID_NORMAL:
+			/* Startup bias, VMID ramp & buffer */
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM8994_BIAS_SRC |
+					    WM8994_VMID_DISCH |
+					    WM8994_STARTUP_BIAS_ENA |
+					    WM8994_VMID_BUF_ENA |
+					    WM8994_VMID_RAMP_MASK,
+					    WM8994_BIAS_SRC |
+					    WM8994_STARTUP_BIAS_ENA |
+					    WM8994_VMID_BUF_ENA |
+					    (0x3 << WM8994_VMID_RAMP_SHIFT));
+
+			/* Main bias enable, VMID=2x40k */
+			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+					    WM8994_BIAS_ENA |
+					    WM8994_VMID_SEL_MASK,
+					    WM8994_BIAS_ENA | 0x2);
+
+			msleep(50);
 
-		/* Main bias enable, VMID=2x40k */
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-				    WM8994_BIAS_ENA |
-				    WM8994_VMID_SEL_MASK,
-				    WM8994_BIAS_ENA | 0x2);
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM8994_VMID_RAMP_MASK |
+					    WM8994_BIAS_SRC,
+					    0);
+			break;
 
-		msleep(50);
+		case WM8994_VMID_FORCE:
+			/* Startup bias, slow VMID ramp & buffer */
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM8994_BIAS_SRC |
+					    WM8994_VMID_DISCH |
+					    WM8994_STARTUP_BIAS_ENA |
+					    WM8994_VMID_BUF_ENA |
+					    WM8994_VMID_RAMP_MASK,
+					    WM8994_BIAS_SRC |
+					    WM8994_STARTUP_BIAS_ENA |
+					    WM8994_VMID_BUF_ENA |
+					    (0x2 << WM8994_VMID_RAMP_SHIFT));
+
+			/* Main bias enable, VMID=2x40k */
+			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+					    WM8994_BIAS_ENA |
+					    WM8994_VMID_SEL_MASK,
+					    WM8994_BIAS_ENA | 0x2);
+
+			msleep(400);
 
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-				    WM8994_VMID_RAMP_MASK | WM8994_BIAS_SRC,
-				    0);
+			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+					    WM8994_VMID_RAMP_MASK |
+					    WM8994_BIAS_SRC,
+					    0);
+			break;
+		}
 	}
 }
 
@@ -823,34 +855,55 @@ static void vmid_dereference(struct snd_soc_codec *codec)
 		wm8994->vmid_refcount);
 
 	if (wm8994->vmid_refcount == 0) {
-		/* Switch over to startup biases */
+		if (wm8994->hubs.lineout1_se)
+			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+					    WM8994_LINEOUT1N_ENA |
+					    WM8994_LINEOUT1P_ENA,
+					    WM8994_LINEOUT1N_ENA |
+					    WM8994_LINEOUT1P_ENA);
+
+		if (wm8994->hubs.lineout2_se)
+			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+					    WM8994_LINEOUT2N_ENA |
+					    WM8994_LINEOUT2P_ENA,
+					    WM8994_LINEOUT2N_ENA |
+					    WM8994_LINEOUT2P_ENA);
+
+		/* Start discharging VMID */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
 				    WM8994_BIAS_SRC |
-				    WM8994_STARTUP_BIAS_ENA |
-				    WM8994_VMID_BUF_ENA |
-				    WM8994_VMID_RAMP_MASK,
+				    WM8994_VMID_DISCH,
 				    WM8994_BIAS_SRC |
-				    WM8994_STARTUP_BIAS_ENA |
-				    WM8994_VMID_BUF_ENA |
-				    (1 << WM8994_VMID_RAMP_SHIFT));
+				    WM8994_VMID_DISCH);
 
-		/* Disable main biases */
-		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-				    WM8994_BIAS_ENA |
-				    WM8994_VMID_SEL_MASK, 0);
+		switch (wm8994->vmid_mode) {
+		case WM8994_VMID_FORCE:
+			msleep(350);
+			break;
+		default:
+			break;
+		}
 
-		/* Discharge VMID */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-				    WM8994_VMID_DISCH, WM8994_VMID_DISCH);
+		snd_soc_update_bits(codec, WM8994_ADDITIONAL_CONTROL,
+				    WM8994_VROI, WM8994_VROI);
 
-		/* Discharge line */
+		/* Active discharge */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
 				    WM8994_LINEOUT1_DISCH |
 				    WM8994_LINEOUT2_DISCH,
 				    WM8994_LINEOUT1_DISCH |
 				    WM8994_LINEOUT2_DISCH);
 
-		msleep(5);
+		msleep(150);
+
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_3,
+				    WM8994_LINEOUT1N_ENA |
+				    WM8994_LINEOUT1P_ENA |
+				    WM8994_LINEOUT2N_ENA |
+				    WM8994_LINEOUT2P_ENA, 0);
+
+		snd_soc_update_bits(codec, WM8994_ADDITIONAL_CONTROL,
+				    WM8994_VROI, 0);
 
 		/* Switch off startup biases */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
@@ -858,6 +911,12 @@ static void vmid_dereference(struct snd_soc_codec *codec)
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
 				    WM8994_VMID_RAMP_MASK, 0);
+
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
+				    WM8994_BIAS_ENA | WM8994_VMID_SEL_MASK, 0);
+
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_VMID_RAMP_MASK, 0);
 	}
 
 	pm_runtime_put(codec->dev);
@@ -2177,6 +2236,55 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (mode) {
+	case WM8994_VMID_NORMAL:
+		if (wm8994->hubs.lineout1_se) {
+			snd_soc_dapm_disable_pin(&codec->dapm,
+						 "LINEOUT1N Driver");
+			snd_soc_dapm_disable_pin(&codec->dapm,
+						 "LINEOUT1P Driver");
+		}
+		if (wm8994->hubs.lineout2_se) {
+			snd_soc_dapm_disable_pin(&codec->dapm,
+						 "LINEOUT2N Driver");
+			snd_soc_dapm_disable_pin(&codec->dapm,
+						 "LINEOUT2P Driver");
+		}
+
+		/* Do the sync with the old mode to allow it to clean up */
+		snd_soc_dapm_sync(&codec->dapm);
+		wm8994->vmid_mode = mode;
+		break;
+
+	case WM8994_VMID_FORCE:
+		if (wm8994->hubs.lineout1_se) {
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "LINEOUT1N Driver");
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "LINEOUT1P Driver");
+		}
+		if (wm8994->hubs.lineout2_se) {
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "LINEOUT2N Driver");
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "LINEOUT2P Driver");
+		}
+
+		wm8994->vmid_mode = mode;
+		snd_soc_dapm_sync(&codec->dapm);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 2f4d2d1..c724112 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -32,6 +32,11 @@
 #define WM8994_FLL_SRC_LRCLK  3
 #define WM8994_FLL_SRC_BCLK   4
 
+enum wm8994_vmid_mode {
+	WM8994_VMID_NORMAL,
+	WM8994_VMID_FORCE,
+};
+
 typedef void (*wm8958_micdet_cb)(u16 status, void *data);
 
 int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
@@ -39,6 +44,8 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      wm8958_micdet_cb cb, void *cb_data);
 
+int wm8994_vmid_mode(struct snd_soc_codec *codec, enum wm8994_vmid_mode mode);
+
 int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
 
@@ -75,6 +82,7 @@ struct wm8994_priv {
 
 	int vmid_refcount;
 	int active_refcount;
+	enum wm8994_vmid_mode vmid_mode;
 
 	int dac_rates[2];
 	int lrclk_shared[2];
-- 
1.7.9.1
