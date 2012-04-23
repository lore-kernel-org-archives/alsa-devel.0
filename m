From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Improve sequencing of AIF
	channel enables
Date: Mon, 23 Apr 2012 13:14:05 +0100
Message-ID: <1335183245-25536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1BFA924529
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 14:14:08 +0200 (CEST)
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

This ensures a clean startup of the channels, without this change some
use cases could result in issues in a small proportion of cases.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  276 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 222 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 7c49642..6c1fe3a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1000,61 +1000,170 @@ static void wm8994_update_class_w(struct snd_soc_codec *codec)
 	}
 }
 
-static int late_enable_ev(struct snd_soc_dapm_widget *w,
-			  struct snd_kcontrol *kcontrol, int event)
+static int aif1clk_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = codec->control_data;
+	int mask = WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA;
+	int dac;
+	int adc;
+	int val;
+
+	switch (control->type) {
+	case WM8994:
+	case WM8958:
+		mask |= WM8994_AIF1DAC2L_ENA | WM8994_AIF1DAC2R_ENA;
+		break;
+	default:
+		break;
+	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (wm8994->aif1clk_enable) {
-			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
-					    WM8994_AIF1CLK_ENA_MASK,
-					    WM8994_AIF1CLK_ENA);
-			wm8994->aif1clk_enable = 0;
-		}
-		if (wm8994->aif2clk_enable) {
-			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
-					    WM8994_AIF2CLK_ENA_MASK,
-					    WM8994_AIF2CLK_ENA);
-			wm8994->aif2clk_enable = 0;
-		}
+		val = snd_soc_read(codec, WM8994_AIF1_CONTROL_1);
+		if ((val & WM8994_AIF1ADCL_SRC) &&
+		    (val & WM8994_AIF1ADCR_SRC))
+			adc = WM8994_AIF1ADC1R_ENA | WM8994_AIF1ADC2R_ENA;
+		else if (!(val & WM8994_AIF1ADCL_SRC) &&
+			 !(val & WM8994_AIF1ADCR_SRC))
+			adc = WM8994_AIF1ADC1L_ENA | WM8994_AIF1ADC2L_ENA;
+		else
+			adc = WM8994_AIF1ADC1R_ENA | WM8994_AIF1ADC2R_ENA |
+				WM8994_AIF1ADC1L_ENA | WM8994_AIF1ADC2L_ENA;
+
+		val = snd_soc_read(codec, WM8994_AIF1_CONTROL_2);
+		if ((val & WM8994_AIF1DACL_SRC) &&
+		    (val & WM8994_AIF1DACR_SRC))
+			dac = WM8994_AIF1DAC1R_ENA | WM8994_AIF1DAC2R_ENA;
+		else if (!(val & WM8994_AIF1DACL_SRC) &&
+			 !(val & WM8994_AIF1DACR_SRC))
+			dac = WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC2L_ENA;
+		else
+			dac = WM8994_AIF1DAC1R_ENA | WM8994_AIF1DAC2R_ENA |
+				WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC2L_ENA;
+
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+				    mask, adc);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    mask, dac);
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8994_AIF1DSPCLK_ENA |
+				    WM8994_SYSDSPCLK_ENA,
+				    WM8994_AIF1DSPCLK_ENA |
+				    WM8994_SYSDSPCLK_ENA);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4, mask,
+				    WM8994_AIF1ADC1R_ENA |
+				    WM8994_AIF1ADC1L_ENA |
+				    WM8994_AIF1ADC2R_ENA |
+				    WM8994_AIF1ADC2L_ENA);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5, mask,
+				    WM8994_AIF1DAC1R_ENA |
+				    WM8994_AIF1DAC1L_ENA |
+				    WM8994_AIF1DAC2R_ENA |
+				    WM8994_AIF1DAC2L_ENA);
 		break;
-	}
 
-	/* We may also have postponed startup of DSP, handle that. */
-	wm8958_aif_ev(w, kcontrol, event);
+	case SND_SOC_DAPM_PRE_PMD:
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    mask, 0);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+				    mask, 0);
+
+		val = snd_soc_read(codec, WM8994_CLOCKING_1);
+		if (val & WM8994_AIF2DSPCLK_ENA)
+			val = WM8994_SYSDSPCLK_ENA;
+		else
+			val = 0;
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8994_SYSDSPCLK_ENA |
+				    WM8994_AIF1DSPCLK_ENA, val);
+		break;
+	}
 
 	return 0;
 }
 
-static int late_disable_ev(struct snd_soc_dapm_widget *w,
-			   struct snd_kcontrol *kcontrol, int event)
+static int aif2clk_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	int dac;
+	int adc;
+	int val;
 
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		val = snd_soc_read(codec, WM8994_AIF2_CONTROL_1);
+		if ((val & WM8994_AIF2ADCL_SRC) &&
+		    (val & WM8994_AIF2ADCR_SRC))
+			adc = WM8994_AIF2ADCR_ENA;
+		else if (!(val & WM8994_AIF2ADCL_SRC) &&
+			 !(val & WM8994_AIF2ADCR_SRC))
+			adc = WM8994_AIF2ADCL_ENA;
+		else
+			adc = WM8994_AIF2ADCL_ENA | WM8994_AIF2ADCR_ENA;
+
+
+		val = snd_soc_read(codec, WM8994_AIF2_CONTROL_2);
+		if ((val & WM8994_AIF2DACL_SRC) &&
+		    (val & WM8994_AIF2DACR_SRC))
+			dac = WM8994_AIF2DACR_ENA;
+		else if (!(val & WM8994_AIF2DACL_SRC) &&
+			 !(val & WM8994_AIF2DACR_SRC))
+			dac = WM8994_AIF2DACL_ENA;
+		else
+			dac = WM8994_AIF2DACL_ENA | WM8994_AIF2DACR_ENA;
+
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+				    WM8994_AIF2ADCL_ENA |
+				    WM8994_AIF2ADCR_ENA, adc);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    WM8994_AIF2DACL_ENA |
+				    WM8994_AIF2DACR_ENA, dac);
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8994_AIF2DSPCLK_ENA |
+				    WM8994_SYSDSPCLK_ENA,
+				    WM8994_AIF2DSPCLK_ENA |
+				    WM8994_SYSDSPCLK_ENA);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_4,
+				    WM8994_AIF2ADCL_ENA |
+				    WM8994_AIF2ADCR_ENA,
+				    WM8994_AIF2ADCL_ENA |
+				    WM8994_AIF2ADCR_ENA);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    WM8994_AIF2DACL_ENA |
+				    WM8994_AIF2DACR_ENA,
+				    WM8994_AIF2DACL_ENA |
+				    WM8994_AIF2DACR_ENA);
+		break;
+
+	case SND_SOC_DAPM_PRE_PMD:
 	case SND_SOC_DAPM_POST_PMD:
-		if (wm8994->aif1clk_disable) {
-			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
-					    WM8994_AIF1CLK_ENA_MASK, 0);
-			wm8994->aif1clk_disable = 0;
-		}
-		if (wm8994->aif2clk_disable) {
-			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
-					    WM8994_AIF2CLK_ENA_MASK, 0);
-			wm8994->aif2clk_disable = 0;
-		}
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    WM8994_AIF2DACL_ENA |
+				    WM8994_AIF2DACR_ENA, 0);
+		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
+				    WM8994_AIF2ADCL_ENA |
+				    WM8994_AIF2ADCR_ENA, 0);
+
+		val = snd_soc_read(codec, WM8994_CLOCKING_1);
+		if (val & WM8994_AIF1DSPCLK_ENA)
+			val = WM8994_SYSDSPCLK_ENA;
+		else
+			val = 0;
+		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				    WM8994_SYSDSPCLK_ENA |
+				    WM8994_AIF2DSPCLK_ENA, val);
 		break;
 	}
 
 	return 0;
 }
 
-static int aif1clk_ev(struct snd_soc_dapm_widget *w,
-		      struct snd_kcontrol *kcontrol, int event)
+static int aif1clk_late_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -1071,8 +1180,8 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int aif2clk_ev(struct snd_soc_dapm_widget *w,
-		      struct snd_kcontrol *kcontrol, int event)
+static int aif2clk_late_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -1089,6 +1198,63 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int late_enable_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (wm8994->aif1clk_enable) {
+			aif1clk_ev(w, kcontrol, event);
+			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+					    WM8994_AIF1CLK_ENA_MASK,
+					    WM8994_AIF1CLK_ENA);
+			wm8994->aif1clk_enable = 0;
+		}
+		if (wm8994->aif2clk_enable) {
+			aif2clk_ev(w, kcontrol, event);
+			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+					    WM8994_AIF2CLK_ENA_MASK,
+					    WM8994_AIF2CLK_ENA);
+			wm8994->aif2clk_enable = 0;
+		}
+		break;
+	}
+
+	/* We may also have postponed startup of DSP, handle that. */
+	wm8958_aif_ev(w, kcontrol, event);
+
+	return 0;
+}
+
+static int late_disable_ev(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMD:
+		if (wm8994->aif1clk_disable) {
+			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+					    WM8994_AIF1CLK_ENA_MASK, 0);
+			aif1clk_ev(w, kcontrol, event);
+			wm8994->aif1clk_disable = 0;
+		}
+		if (wm8994->aif2clk_disable) {
+			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+					    WM8994_AIF2CLK_ENA_MASK, 0);
+			aif2clk_ev(w, kcontrol, event);
+			wm8994->aif2clk_disable = 0;
+		}
+		break;
+	}
+
+	return 0;
+}
+
 static int adc_mux_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
@@ -1385,9 +1551,9 @@ static const struct snd_kcontrol_new aif2dacr_src_mux =
 	SOC_DAPM_ENUM("AIF2DACR Mux", aif2dacr_src_enum);
 
 static const struct snd_soc_dapm_widget wm8994_lateclk_revd_widgets[] = {
-SND_SOC_DAPM_SUPPLY("AIF1CLK", SND_SOC_NOPM, 0, 0, aif1clk_ev,
+SND_SOC_DAPM_SUPPLY("AIF1CLK", SND_SOC_NOPM, 0, 0, aif1clk_late_ev,
 	SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
-SND_SOC_DAPM_SUPPLY("AIF2CLK", SND_SOC_NOPM, 0, 0, aif2clk_ev,
+SND_SOC_DAPM_SUPPLY("AIF2CLK", SND_SOC_NOPM, 0, 0, aif2clk_late_ev,
 	SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_PGA_E("Late DAC1L Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
@@ -1416,8 +1582,10 @@ SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
 };
 
 static const struct snd_soc_dapm_widget wm8994_lateclk_widgets[] = {
-SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, aif1clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, aif2clk_ev,
+		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA("Direct Voice", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MIXER("SPKL", WM8994_POWER_MANAGEMENT_3, 8, 0,
 		   left_speaker_mixer, ARRAY_SIZE(left_speaker_mixer)),
@@ -1470,30 +1638,30 @@ SND_SOC_DAPM_SUPPLY("VMID", SND_SOC_NOPM, 0, 0, vmid_event,
 SND_SOC_DAPM_SUPPLY("CLK_SYS", SND_SOC_NOPM, 0, 0, clk_sys_event,
 		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
-SND_SOC_DAPM_SUPPLY("DSP1CLK", WM8994_CLOCKING_1, 3, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("DSP2CLK", WM8994_CLOCKING_1, 2, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("DSPINTCLK", WM8994_CLOCKING_1, 1, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("DSP1CLK", SND_SOC_NOPM, 3, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("DSP2CLK", SND_SOC_NOPM, 2, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("DSPINTCLK", SND_SOC_NOPM, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_AIF_OUT("AIF1ADC1L", NULL,
-		     0, WM8994_POWER_MANAGEMENT_4, 9, 0),
+		     0, SND_SOC_NOPM, 9, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", NULL,
-		     0, WM8994_POWER_MANAGEMENT_4, 8, 0),
+		     0, SND_SOC_NOPM, 8, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC1L", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 9, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 9, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC1R", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 8, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 8, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_AIF_OUT("AIF1ADC2L", NULL,
-		     0, WM8994_POWER_MANAGEMENT_4, 11, 0),
+		     0, SND_SOC_NOPM, 11, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1ADC2R", NULL,
-		     0, WM8994_POWER_MANAGEMENT_4, 10, 0),
+		     0, SND_SOC_NOPM, 10, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC2L", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 11, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 11, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 SND_SOC_DAPM_AIF_IN_E("AIF1DAC2R", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 10, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 10, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 SND_SOC_DAPM_MIXER("AIF1ADC1L Mixer", SND_SOC_NOPM, 0, 0,
@@ -1520,14 +1688,14 @@ SND_SOC_DAPM_MIXER("DAC1R Mixer", SND_SOC_NOPM, 0, 0,
 		   dac1r_mix, ARRAY_SIZE(dac1r_mix)),
 
 SND_SOC_DAPM_AIF_OUT("AIF2ADCL", NULL, 0,
-		     WM8994_POWER_MANAGEMENT_4, 13, 0),
+		     SND_SOC_NOPM, 13, 0),
 SND_SOC_DAPM_AIF_OUT("AIF2ADCR", NULL, 0,
-		     WM8994_POWER_MANAGEMENT_4, 12, 0),
+		     SND_SOC_NOPM, 12, 0),
 SND_SOC_DAPM_AIF_IN_E("AIF2DACL", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 13, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 13, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_AIF_IN_E("AIF2DACR", NULL, 0,
-		      WM8994_POWER_MANAGEMENT_5, 12, 0, wm8958_aif_ev,
+		      SND_SOC_NOPM, 12, 0, wm8958_aif_ev,
 		      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_AIF_IN("AIF1DACDAT", NULL, 0, SND_SOC_NOPM, 0, 0),
-- 
1.7.10
