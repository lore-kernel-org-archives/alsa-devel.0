From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 2.6.38] ASoC: WM8994: Improve robustness in
	some use cases
Date: Fri, 11 Feb 2011 12:17:09 +0000
Message-ID: <1297426630-8864-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC64E24542
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 13:17:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Ensure that on disabling certain registers such as AIF1DAC1L,
AIF1DAC1R etc. the AIF1CLK and AIF2CLK remain enabled.  Similarly
when enabling those registers, AIF1CLK and AIF2CLK will remain
disabled.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  142 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 37b8aa8..bd0cfdd 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -107,6 +107,9 @@ struct wm8994_priv {
 
 	int revision;
 	struct wm8994_pdata *pdata;
+
+	unsigned int aif1clk_enable:1;
+	unsigned int aif2clk_enable:1;
 };
 
 static int wm8994_readable(unsigned int reg)
@@ -1004,6 +1007,82 @@ static void wm8994_update_class_w(struct snd_soc_codec *codec)
 	}
 }
 
+static int late_enable_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (wm8994->aif1clk_enable)
+			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+					    WM8994_AIF1CLK_ENA_MASK,
+					    WM8994_AIF1CLK_ENA);
+		if (wm8994->aif2clk_enable)
+			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+					    WM8994_AIF2CLK_ENA_MASK,
+					    WM8994_AIF2CLK_ENA);
+		break;
+	}
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
+		if (wm8994->aif1clk_enable) {
+			snd_soc_update_bits(codec, WM8994_AIF1_CLOCKING_1,
+					    WM8994_AIF1CLK_ENA_MASK, 0);
+			wm8994->aif1clk_enable = 0;
+		}
+		if (wm8994->aif2clk_enable) {
+			snd_soc_update_bits(codec, WM8994_AIF2_CLOCKING_1,
+					    WM8994_AIF2CLK_ENA_MASK, 0);
+			wm8994->aif2clk_enable = 0;
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int aif1clk_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		wm8994->aif1clk_enable = 1;
+		break;
+	}
+
+	return 0;
+}
+
+static int aif2clk_ev(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		wm8994->aif2clk_enable = 1;
+		break;
+	}
+
+	return 0;
+}
+
 static const char *hp_mux_text[] = {
 	"Mixer",
 	"DAC",
@@ -1272,6 +1351,29 @@ static const struct soc_enum aif2dacr_src_enum =
 static const struct snd_kcontrol_new aif2dacr_src_mux =
 	SOC_DAPM_ENUM("AIF2DACR Mux", aif2dacr_src_enum);
 
+static const struct snd_soc_dapm_widget wm8994_lateclk_revd_widgets[] = {
+SND_SOC_DAPM_SUPPLY("AIF1CLK", SND_SOC_NOPM, 0, 0, aif1clk_ev,
+	SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("AIF2CLK", SND_SOC_NOPM, 0, 0, aif2clk_ev,
+	SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+SND_SOC_DAPM_PGA_E("Late DAC1L Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
+	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("Late DAC1R Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
+	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("Late DAC2L Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
+	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("Late DAC2R Enable PGA", SND_SOC_NOPM, 0, 0, NULL, 0,
+	late_enable_ev, SND_SOC_DAPM_PRE_PMU),
+
+SND_SOC_DAPM_POST("Late Disable PGA", late_disable_ev)
+};
+
+static const struct snd_soc_dapm_widget wm8994_lateclk_widgets[] = {
+SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0)
+};
+
 static const struct snd_soc_dapm_widget wm8994_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
 SND_SOC_DAPM_INPUT("DMIC2DAT"),
@@ -1284,9 +1386,6 @@ SND_SOC_DAPM_SUPPLY("DSP1CLK", WM8994_CLOCKING_1, 3, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("DSP2CLK", WM8994_CLOCKING_1, 2, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("DSPINTCLK", WM8994_CLOCKING_1, 1, 0, NULL, 0),
 
-SND_SOC_DAPM_SUPPLY("AIF1CLK", WM8994_AIF1_CLOCKING_1, 0, 0, NULL, 0),
-SND_SOC_DAPM_SUPPLY("AIF2CLK", WM8994_AIF2_CLOCKING_1, 0, 0, NULL, 0),
-
 SND_SOC_DAPM_AIF_OUT("AIF1ADC1L", NULL,
 		     0, WM8994_POWER_MANAGEMENT_4, 9, 0),
 SND_SOC_DAPM_AIF_OUT("AIF1ADC1R", NULL,
@@ -1516,14 +1615,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF2ADC Mux", "AIF3DACDAT", "AIF3ADCDAT" },
 
 	/* DAC1 inputs */
-	{ "DAC1L", NULL, "DAC1L Mixer" },
 	{ "DAC1L Mixer", "AIF2 Switch", "AIF2DACL" },
 	{ "DAC1L Mixer", "AIF1.2 Switch", "AIF1DAC2L" },
 	{ "DAC1L Mixer", "AIF1.1 Switch", "AIF1DAC1L" },
 	{ "DAC1L Mixer", "Left Sidetone Switch", "Left Sidetone" },
 	{ "DAC1L Mixer", "Right Sidetone Switch", "Right Sidetone" },
 
-	{ "DAC1R", NULL, "DAC1R Mixer" },
 	{ "DAC1R Mixer", "AIF2 Switch", "AIF2DACR" },
 	{ "DAC1R Mixer", "AIF1.2 Switch", "AIF1DAC2R" },
 	{ "DAC1R Mixer", "AIF1.1 Switch", "AIF1DAC1R" },
@@ -1532,7 +1629,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	/* DAC2/AIF2 outputs  */
 	{ "AIF2ADCL", NULL, "AIF2DAC2L Mixer" },
-	{ "DAC2L", NULL, "AIF2DAC2L Mixer" },
 	{ "AIF2DAC2L Mixer", "AIF2 Switch", "AIF2DACL" },
 	{ "AIF2DAC2L Mixer", "AIF1.2 Switch", "AIF1DAC2L" },
 	{ "AIF2DAC2L Mixer", "AIF1.1 Switch", "AIF1DAC1L" },
@@ -1540,7 +1636,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF2DAC2L Mixer", "Right Sidetone Switch", "Right Sidetone" },
 
 	{ "AIF2ADCR", NULL, "AIF2DAC2R Mixer" },
-	{ "DAC2R", NULL, "AIF2DAC2R Mixer" },
 	{ "AIF2DAC2R Mixer", "AIF2 Switch", "AIF2DACR" },
 	{ "AIF2DAC2R Mixer", "AIF1.2 Switch", "AIF1DAC2R" },
 	{ "AIF2DAC2R Mixer", "AIF1.1 Switch", "AIF1DAC1R" },
@@ -1584,6 +1679,24 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Right Headphone Mux", "DAC", "DAC1R" },
 };
 
+static const struct snd_soc_dapm_route wm8994_lateclk_revd_intercon[] = {
+	{ "DAC1L", NULL, "Late DAC1L Enable PGA" },
+	{ "Late DAC1L Enable PGA", NULL, "DAC1L Mixer" },
+	{ "DAC1R", NULL, "Late DAC1R Enable PGA" },
+	{ "Late DAC1R Enable PGA", NULL, "DAC1R Mixer" },
+	{ "DAC2L", NULL, "Late DAC2L Enable PGA" },
+	{ "Late DAC2L Enable PGA", NULL, "AIF2DAC2L Mixer" },
+	{ "DAC2R", NULL, "Late DAC2R Enable PGA" },
+	{ "Late DAC2R Enable PGA", NULL, "AIF2DAC2R Mixer" }
+};
+
+static const struct snd_soc_dapm_route wm8994_lateclk_intercon[] = {
+	{ "DAC1L", NULL, "DAC1L Mixer" },
+	{ "DAC1R", NULL, "DAC1R Mixer" },
+	{ "DAC2L", NULL, "AIF2DAC2L Mixer" },
+	{ "DAC2R", NULL, "AIF2DAC2R Mixer" },
+};
+
 static const struct snd_soc_dapm_route wm8994_revd_intercon[] = {
 	{ "AIF1DACDAT", NULL, "AIF2DACDAT" },
 	{ "AIF2DACDAT", NULL, "AIF1DACDAT" },
@@ -3125,6 +3238,12 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	case WM8994:
 		snd_soc_dapm_new_controls(dapm, wm8994_specific_dapm_widgets,
 					  ARRAY_SIZE(wm8994_specific_dapm_widgets));
+		if (wm8994->revision < 4)
+			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_revd_widgets,
+						  ARRAY_SIZE(wm8994_lateclk_revd_widgets));
+		else
+			snd_soc_dapm_new_controls(dapm, wm8994_lateclk_widgets,
+						  ARRAY_SIZE(wm8994_lateclk_widgets));
 		break;
 	case WM8958:
 		snd_soc_add_controls(codec, wm8958_snd_controls,
@@ -3143,10 +3262,15 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_add_routes(dapm, wm8994_intercon,
 					ARRAY_SIZE(wm8994_intercon));
 
-		if (wm8994->revision < 4)
+		if (wm8994->revision < 4) {
 			snd_soc_dapm_add_routes(dapm, wm8994_revd_intercon,
 						ARRAY_SIZE(wm8994_revd_intercon));
-			
+			snd_soc_dapm_add_routes(dapm, wm8994_lateclk_revd_intercon,
+						ARRAY_SIZE(wm8994_lateclk_revd_intercon));
+		} else {
+			snd_soc_dapm_add_routes(dapm, wm8994_lateclk_intercon,
+						ARRAY_SIZE(wm8994_lateclk_intercon));
+		}
 		break;
 	case WM8958:
 		snd_soc_dapm_add_routes(dapm, wm8958_intercon,
-- 
1.7.4
