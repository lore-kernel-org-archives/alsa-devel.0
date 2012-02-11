From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: wm_hubs: Improve single ended line
	output enable performance
Date: Sat, 11 Feb 2012 23:13:27 +0000
Message-ID: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 875C5103AC7
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 00:13:34 +0100 (CET)
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

The enable of the single ended line outputs on wm_hubs devices performs
better if the output is enabled prior to starting VMID. Since inactive
outputs are held at VMID anyway there is little cost to doing this for
unused outputs. Add callbacks into wm_hubs and keep track of which outputs
are really active so we can disable them once we're active.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |    4 ++
 sound/soc/codecs/wm8994.c  |    5 ++
 sound/soc/codecs/wm_hubs.c |  113 ++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/wm_hubs.h |   11 ++++
 4 files changed, 125 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index ab4685a..1e69f63 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1058,6 +1058,8 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	wm_hubs_set_bias_level(codec, level);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
@@ -1078,6 +1080,8 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			regcache_cache_only(wm8993->regmap, false);
 			regcache_sync(wm8993->regmap);
 
+			wm_hubs_vmid_ena(codec);
+
 			/* Bring up VMID with fast soft start */
 			snd_soc_update_bits(codec, WM8993_ANTIPOP2,
 					    WM8993_STARTUP_BIAS_ENA |
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e6eebf7..21931a0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -787,6 +787,8 @@ static void vmid_reference(struct snd_soc_codec *codec)
 				    WM8994_VMID_BUF_ENA |
 				    (0x3 << WM8994_VMID_RAMP_SHIFT));
 
+		wm_hubs_vmid_ena(codec);
+
 		/* Remove discharge for line out */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
 				    WM8994_LINEOUT1_DISCH |
@@ -2074,6 +2076,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 
+	wm_hubs_set_bias_level(codec, level);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
@@ -2168,6 +2172,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 			wm8994->cur_fw = NULL;
 		break;
 	}
+
 	codec->dapm.bias_level = level;
 
 	return 0;
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index a53daf6..f7650c5 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -500,6 +500,36 @@ static int earpiece_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int lineout_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *control, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	bool *flag;
+
+	switch (w->shift) {
+	case WM8993_LINEOUT1N_ENA_SHIFT:
+		flag = &hubs->lineout1n_ena;
+		break;
+	case WM8993_LINEOUT1P_ENA_SHIFT:
+		flag = &hubs->lineout1p_ena;
+		break;
+	case WM8993_LINEOUT2N_ENA_SHIFT:
+		flag = &hubs->lineout2n_ena;
+		break;
+	case WM8993_LINEOUT2P_ENA_SHIFT:
+		flag = &hubs->lineout2p_ena;
+		break;
+	default:
+		WARN(1, "Unknown line output");
+		return -EINVAL;
+	}
+
+	*flag = SND_SOC_DAPM_EVENT_ON(event);
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new in1l_pga[] = {
 SOC_DAPM_SINGLE("IN1LP Switch", WM8993_INPUT_MIXER2, 5, 1, 0),
 SOC_DAPM_SINGLE("IN1LN Switch", WM8993_INPUT_MIXER2, 4, 1, 0),
@@ -675,14 +705,18 @@ SND_SOC_DAPM_MIXER("LINEOUT2N Mixer", SND_SOC_NOPM, 0, 0,
 SND_SOC_DAPM_MIXER("LINEOUT2P Mixer", SND_SOC_NOPM, 0, 0,
 		   line2p_mix, ARRAY_SIZE(line2p_mix)),
 
-SND_SOC_DAPM_OUT_DRV("LINEOUT1N Driver", WM8993_POWER_MANAGEMENT_3, 13, 0,
-		     NULL, 0),
-SND_SOC_DAPM_OUT_DRV("LINEOUT1P Driver", WM8993_POWER_MANAGEMENT_3, 12, 0,
-		     NULL, 0),
-SND_SOC_DAPM_OUT_DRV("LINEOUT2N Driver", WM8993_POWER_MANAGEMENT_3, 11, 0,
-		     NULL, 0),
-SND_SOC_DAPM_OUT_DRV("LINEOUT2P Driver", WM8993_POWER_MANAGEMENT_3, 10, 0,
-		     NULL, 0),
+SND_SOC_DAPM_OUT_DRV_E("LINEOUT1N Driver", WM8993_POWER_MANAGEMENT_3, 13, 0,
+		       NULL, 0, lineout_event,
+		     SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_OUT_DRV_E("LINEOUT1P Driver", WM8993_POWER_MANAGEMENT_3, 12, 0,
+		       NULL, 0, lineout_event,
+		       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_OUT_DRV_E("LINEOUT2N Driver", WM8993_POWER_MANAGEMENT_3, 11, 0,
+		       NULL, 0, lineout_event,
+		       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_OUT_DRV_E("LINEOUT2P Driver", WM8993_POWER_MANAGEMENT_3, 10, 0,
+		       NULL, 0, lineout_event,
+		       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_OUTPUT("SPKOUTLP"),
 SND_SOC_DAPM_OUTPUT("SPKOUTLN"),
@@ -949,6 +983,11 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 				  int jd_scthr, int jd_thr, int micbias1_lvl,
 				  int micbias2_lvl)
 {
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+
+	hubs->lineout1_se = !lineout1_diff;
+	hubs->lineout2_se = !lineout2_diff;
+
 	if (!lineout1_diff)
 		snd_soc_update_bits(codec, WM8993_LINE_MIXER1,
 				    WM8993_LINEOUT1_MODE,
@@ -978,6 +1017,64 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(wm_hubs_handle_analogue_pdata);
 
+void wm_hubs_vmid_ena(struct snd_soc_codec *codec)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	int val = 0;
+
+	if (hubs->lineout1_se)
+		val |= WM8993_LINEOUT1N_ENA | WM8993_LINEOUT1P_ENA;
+
+	if (hubs->lineout2_se)
+		val |= WM8993_LINEOUT2N_ENA | WM8993_LINEOUT2P_ENA;
+
+	/* Enable the line outputs while we power up */
+	snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_3, val, val);
+}
+EXPORT_SYMBOL_GPL(wm_hubs_vmid_ena);
+
+void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
+			    enum snd_soc_bias_level level)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	int val;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* Turn off any unneded single ended outputs */
+		val = 0;
+
+		if (hubs->lineout1_se && hubs->lineout1n_ena)
+			val |= WM8993_LINEOUT1N_ENA;
+
+		if (hubs->lineout1_se && hubs->lineout1p_ena)
+			val |= WM8993_LINEOUT1P_ENA;
+
+		if (hubs->lineout2_se && hubs->lineout2n_ena)
+			val |= WM8993_LINEOUT2N_ENA;
+
+		if (hubs->lineout2_se && hubs->lineout2p_ena)
+			val |= WM8993_LINEOUT2P_ENA;
+
+		snd_soc_update_bits(codec, WM8993_POWER_MANAGEMENT_3,
+				    WM8993_LINEOUT1N_ENA |
+				    WM8993_LINEOUT1P_ENA |
+				    WM8993_LINEOUT2N_ENA |
+				    WM8993_LINEOUT2P_ENA,
+				    val);
+
+		if (!hubs->lineout1n_ena && !hubs->lineout1p_ena &&
+		    !hubs->lineout2n_ena && !hubs->lineout2p_ena)
+			snd_soc_update_bits(codec, WM8993_ANTIPOP1,
+					    WM8993_LINEOUT_VMID_BUF_ENA, 0);
+		break;
+
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(wm_hubs_set_bias_level);
+
 MODULE_DESCRIPTION("Shared support for Wolfson hubs products");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index c674c7a..4140905 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -33,6 +33,14 @@ struct wm_hubs_data {
 	bool class_w;
 	u16 class_w_dcs;
 
+	bool lineout1_se;
+	bool lineout1n_ena;
+	bool lineout1p_ena;
+
+	bool lineout2_se;
+	bool lineout2n_ena;
+	bool lineout2p_ena;
+
 	bool dcs_done_irq;
 	struct completion dcs_done;
 };
@@ -46,5 +54,8 @@ extern int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *,
 					 int micbias1_lvl, int micbias2_lvl);
 
 extern irqreturn_t wm_hubs_dcs_done(int irq, void *data);
+extern void wm_hubs_vmid_ena(struct snd_soc_codec *codec);
+extern void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
+				   enum snd_soc_bias_level level);
 
 #endif
-- 
1.7.9.rc1
