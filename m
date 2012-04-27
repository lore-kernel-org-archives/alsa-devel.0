From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm_hubs: Factor out class W
	management
Date: Fri, 27 Apr 2012 18:35:00 +0100
Message-ID: <1335548101-22693-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335548101-22693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED6232455E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 19:35:05 +0200 (CEST)
In-Reply-To: <1335548101-22693-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Since the analogue portions of the checks for class W are the same over
all the devices factor out these checks into wm_hubs and while we're at
it also use wm_hubs_dac_hp_direct() to enable class W optimisations on
more paths.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c  |   84 +---------------------------------------
 sound/soc/codecs/wm8994.c  |   91 ++++++++------------------------------------
 sound/soc/codecs/wm_hubs.c |   59 ++++++++++++++++++++++++++++
 sound/soc/codecs/wm_hubs.h |    6 +++
 4 files changed, 82 insertions(+), 158 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 8bb0059..36acfcc 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -218,7 +218,6 @@ struct wm8993_priv {
 	unsigned int sysclk_rate;
 	unsigned int fs;
 	unsigned int bclk;
-	int class_w_users;
 	unsigned int fll_fref;
 	unsigned int fll_fout;
 	int fll_src;
@@ -824,82 +823,6 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-/*
- * When used with DAC outputs only the WM8993 charge pump supports
- * operation in class W mode, providing very low power consumption
- * when used with digital sources.  Enable and disable this mode
- * automatically depending on the mixer configuration.
- *
- * Currently the only supported paths are the direct DAC->headphone
- * paths (which provide minimum power consumption anyway).
- */
-static int class_w_put(struct snd_kcontrol *kcontrol,
-		       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
-	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	/* Turn it off if we're using the main output mixer */
-	if (ucontrol->value.integer.value[0] == 0) {
-		if (wm8993->class_w_users == 0) {
-			dev_dbg(codec->dev, "Disabling Class W\n");
-			snd_soc_update_bits(codec, WM8993_CLASS_W_0,
-					    WM8993_CP_DYN_FREQ |
-					    WM8993_CP_DYN_V,
-					    0);
-		}
-		wm8993->class_w_users++;
-	}
-
-	/* Implement the change */
-	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
-
-	/* Enable it if we're using the direct DAC path */
-	if (ucontrol->value.integer.value[0] == 1) {
-		if (wm8993->class_w_users == 1) {
-			dev_dbg(codec->dev, "Enabling Class W\n");
-			snd_soc_update_bits(codec, WM8993_CLASS_W_0,
-					    WM8993_CP_DYN_FREQ |
-					    WM8993_CP_DYN_V,
-					    WM8993_CP_DYN_FREQ |
-					    WM8993_CP_DYN_V);
-		}
-		wm8993->class_w_users--;
-	}
-
-	dev_dbg(codec->dev, "Indirect DAC use count now %d\n",
-		wm8993->class_w_users);
-
-	return ret;
-}
-
-#define SOC_DAPM_ENUM_W(xname, xenum) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
-	.get = snd_soc_dapm_get_enum_double, \
-	.put = class_w_put, \
-	.private_value = (unsigned long)&xenum }
-
-static const char *hp_mux_text[] = {
-	"Mixer",
-	"DAC",
-};
-
-static const struct soc_enum hpl_enum =
-	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER1, 8, 2, hp_mux_text);
-
-static const struct snd_kcontrol_new hpl_mux =
-	SOC_DAPM_ENUM_W("Left Headphone Mux", hpl_enum);
-
-static const struct soc_enum hpr_enum =
-	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER2, 8, 2, hp_mux_text);
-
-static const struct snd_kcontrol_new hpr_mux =
-	SOC_DAPM_ENUM_W("Right Headphone Mux", hpr_enum);
-
 static const struct snd_kcontrol_new left_speaker_mixer[] = {
 SOC_DAPM_SINGLE("Input Switch", WM8993_SPEAKER_MIXER, 7, 1, 0),
 SOC_DAPM_SINGLE("IN1LP Switch", WM8993_SPEAKER_MIXER, 5, 1, 0),
@@ -986,8 +909,8 @@ SND_SOC_DAPM_MUX("DACR Sidetone", SND_SOC_NOPM, 0, 0, &sidetoner_mux),
 SND_SOC_DAPM_DAC("DACL", NULL, WM8993_POWER_MANAGEMENT_3, 1, 0),
 SND_SOC_DAPM_DAC("DACR", NULL, WM8993_POWER_MANAGEMENT_3, 0, 0),
 
-SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
-SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
+SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpl_mux),
+SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpr_mux),
 
 SND_SOC_DAPM_MIXER("SPKL", WM8993_POWER_MANAGEMENT_3, 8, 0,
 		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
@@ -1577,9 +1500,6 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* By default we're using the output mixers */
-	wm8993->class_w_users = 2;
-
 	/* Latch volume update bits and default ZC on */
 	snd_soc_update_bits(codec, WM8993_RIGHT_DAC_DIGITAL_VOLUME,
 			    WM8993_DAC_VU, WM8993_DAC_VU);
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5b7bb10..b3b2d5f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -945,27 +945,12 @@ static int vmid_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static void wm8994_update_class_w(struct snd_soc_codec *codec)
+static bool wm8994_check_class_w_digital(struct snd_soc_codec *codec)
 {
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	int enable = 1;
 	int source = 0;  /* GCC flow analysis can't track enable */
 	int reg, reg_r;
 
-	/* Only support direct DAC->headphone paths */
-	reg = snd_soc_read(codec, WM8994_OUTPUT_MIXER_1);
-	if (!(reg & WM8994_DAC1L_TO_HPOUT1L)) {
-		dev_vdbg(codec->dev, "HPL connected to output mixer\n");
-		enable = 0;
-	}
-
-	reg = snd_soc_read(codec, WM8994_OUTPUT_MIXER_2);
-	if (!(reg & WM8994_DAC1R_TO_HPOUT1R)) {
-		dev_vdbg(codec->dev, "HPR connected to output mixer\n");
-		enable = 0;
-	}
-
-	/* We also need the same setting for L/R and only one path */
+	/* We also need the same AIF source for L/R and only one path */
 	reg = snd_soc_read(codec, WM8994_DAC1_LEFT_MIXER_ROUTING);
 	switch (reg) {
 	case WM8994_AIF2DACL_TO_DAC1L:
@@ -982,28 +967,20 @@ static void wm8994_update_class_w(struct snd_soc_codec *codec)
 		break;
 	default:
 		dev_vdbg(codec->dev, "DAC mixer setting: %x\n", reg);
-		enable = 0;
-		break;
+		return false;
 	}
 
 	reg_r = snd_soc_read(codec, WM8994_DAC1_RIGHT_MIXER_ROUTING);
 	if (reg_r != reg) {
 		dev_vdbg(codec->dev, "Left and right DAC mixers different\n");
-		enable = 0;
+		return false;
 	}
 
-	if (enable) {
-		dev_dbg(codec->dev, "Class W enabled\n");
-		snd_soc_update_bits(codec, WM8994_CLASS_W_1,
-				    WM8994_CP_DYN_PWR |
-				    WM8994_CP_DYN_SRC_SEL_MASK,
-				    source | WM8994_CP_DYN_PWR);
+	/* Set the source up */
+	snd_soc_update_bits(codec, WM8994_CLASS_W_1,
+			    WM8994_CP_DYN_SRC_SEL_MASK, source);
 
-	} else {
-		dev_dbg(codec->dev, "Class W disabled\n");
-		snd_soc_update_bits(codec, WM8994_CLASS_W_1,
-				    WM8994_CP_DYN_PWR, 0);
-	}
+	return true;
 }
 
 static int aif1clk_ev(struct snd_soc_dapm_widget *w,
@@ -1286,45 +1263,6 @@ static int dac_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const char *hp_mux_text[] = {
-	"Mixer",
-	"DAC",
-};
-
-#define WM8994_HP_ENUM(xname, xenum) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_enum_double, \
- 	.get = snd_soc_dapm_get_enum_double, \
- 	.put = wm8994_put_hp_enum, \
-  	.private_value = (unsigned long)&xenum }
-
-static int wm8994_put_hp_enum(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *w = wlist->widgets[0];
-	struct snd_soc_codec *codec = w->codec;
-	int ret;
-
-	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
-
-	wm8994_update_class_w(codec);
-
-	return ret;
-}
-
-static const struct soc_enum hpl_enum =
-	SOC_ENUM_SINGLE(WM8994_OUTPUT_MIXER_1, 8, 2, hp_mux_text);
-
-static const struct snd_kcontrol_new hpl_mux =
-	WM8994_HP_ENUM("Left Headphone Mux", hpl_enum);
-
-static const struct soc_enum hpr_enum =
-	SOC_ENUM_SINGLE(WM8994_OUTPUT_MIXER_2, 8, 2, hp_mux_text);
-
-static const struct snd_kcontrol_new hpr_mux =
-	WM8994_HP_ENUM("Right Headphone Mux", hpr_enum);
-
 static const char *adc_mux_text[] = {
 	"ADC",
 	"DMIC",
@@ -1436,7 +1374,7 @@ static int wm8994_put_class_w(struct snd_kcontrol *kcontrol,
 
 	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
 
-	wm8994_update_class_w(codec);
+	wm_hubs_update_class_w(codec);
 
 	return ret;
 }
@@ -1579,9 +1517,9 @@ SND_SOC_DAPM_MIXER_E("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
 SND_SOC_DAPM_MIXER_E("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
 		     right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer),
 		     late_enable_ev, SND_SOC_DAPM_PRE_PMU),
-SND_SOC_DAPM_MUX_E("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux,
+SND_SOC_DAPM_MUX_E("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpl_mux,
 		   late_enable_ev, SND_SOC_DAPM_PRE_PMU),
-SND_SOC_DAPM_MUX_E("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux,
+SND_SOC_DAPM_MUX_E("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpr_mux,
 		   late_enable_ev, SND_SOC_DAPM_PRE_PMU),
 
 SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
@@ -1597,8 +1535,8 @@ SND_SOC_DAPM_MIXER("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
 		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
 SND_SOC_DAPM_MIXER("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
 		   right_speaker_mixer, ARRAY_SIZE(right_speaker_mixer)),
-SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &hpl_mux),
-SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &hpr_mux),
+SND_SOC_DAPM_MUX("Left Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpl_mux),
+SND_SOC_DAPM_MUX("Right Headphone Mux", SND_SOC_NOPM, 0, 0, &wm_hubs_hpr_mux),
 };
 
 static const struct snd_soc_dapm_widget wm8994_dac_revd_widgets[] = {
@@ -3997,7 +3935,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	wm8994_update_class_w(codec);
+	wm8994->hubs.check_class_w_digital = wm8994_check_class_w_digital;
+	wm_hubs_update_class_w(codec);
 
 	wm8994_handle_pdata(wm8994);
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index df44083..803b3b6 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -566,6 +566,65 @@ static int lineout_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+void wm_hubs_update_class_w(struct snd_soc_codec *codec)
+{
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
+	int enable = WM8993_CP_DYN_V | WM8993_CP_DYN_FREQ;
+
+	if (!wm_hubs_dac_hp_direct(codec))
+		enable = false;
+
+	if (hubs->check_class_w_digital && !hubs->check_class_w_digital(codec))
+		enable = false;
+
+	dev_vdbg(codec->dev, "Class W %s\n", enable ? "enabled" : "disabled");
+
+	snd_soc_update_bits(codec, WM8993_CLASS_W_0,
+			    WM8993_CP_DYN_V | WM8993_CP_DYN_FREQ, enable);
+}
+EXPORT_SYMBOL_GPL(wm_hubs_update_class_w);
+
+#define WM_HUBS_ENUM_W(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_enum_double, \
+	.get = snd_soc_dapm_get_enum_double, \
+	.put = class_w_put, \
+	.private_value = (unsigned long)&xenum }
+
+static int class_w_put(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
+	struct snd_soc_codec *codec = widget->codec;
+	int ret;
+
+	ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+
+	wm_hubs_update_class_w(codec);
+
+	return ret;
+}
+
+static const char *hp_mux_text[] = {
+	"Mixer",
+	"DAC",
+};
+
+static const struct soc_enum hpl_enum =
+	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER1, 8, 2, hp_mux_text);
+
+const struct snd_kcontrol_new wm_hubs_hpl_mux =
+	WM_HUBS_ENUM_W("Left Headphone Mux", hpl_enum);
+EXPORT_SYMBOL_GPL(wm_hubs_hpl_mux);
+
+static const struct soc_enum hpr_enum =
+	SOC_ENUM_SINGLE(WM8993_OUTPUT_MIXER2, 8, 2, hp_mux_text);
+
+const struct snd_kcontrol_new wm_hubs_hpr_mux =
+	WM_HUBS_ENUM_W("Right Headphone Mux", hpr_enum);
+EXPORT_SYMBOL_GPL(wm_hubs_hpr_mux);
+
 static const struct snd_kcontrol_new in1l_pga[] = {
 SOC_DAPM_SINGLE("IN1LP Switch", WM8993_INPUT_MIXER2, 5, 1, 0),
 SOC_DAPM_SINGLE("IN1LN Switch", WM8993_INPUT_MIXER2, 4, 1, 0),
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 8bb9f1b..71861fc 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -16,6 +16,7 @@
 
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <sound/control.h>
 
 struct snd_soc_codec;
 
@@ -32,6 +33,7 @@ struct wm_hubs_data {
 
 	bool no_cache_dac_hp_direct;
 	u16 dac_hp_direct_dcs;
+	bool (*check_class_w_digital)(struct snd_soc_codec *);
 
 	bool lineout1_se;
 	bool lineout1n_ena;
@@ -57,5 +59,9 @@ extern irqreturn_t wm_hubs_dcs_done(int irq, void *data);
 extern void wm_hubs_vmid_ena(struct snd_soc_codec *codec);
 extern void wm_hubs_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level);
+extern void wm_hubs_update_class_w(struct snd_soc_codec *codec);
+
+extern const struct snd_kcontrol_new wm_hubs_hpl_mux;
+extern const struct snd_kcontrol_new wm_hubs_hpr_mux;
 
 #endif
-- 
1.7.10
