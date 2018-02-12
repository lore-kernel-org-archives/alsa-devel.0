From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98095: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:30 +0000
Message-ID: <E1elDQI-0004rI-UC@debutante>
References: <87po5tz4xq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 98024267C33
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:33 +0100 (CET)
In-Reply-To: <87po5tz4xq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98095: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2dd1637f5a7c602a2d32d95821b0cef13fff175a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:05:45 +0000
Subject: [PATCH] ASoC: max98095: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98095.c | 448 ++++++++++++++++++++++----------------------
 sound/soc/codecs/max98095.h |   2 +-
 2 files changed, 222 insertions(+), 228 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 5ead87d2ab1d..6bf2d0ba864f 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -251,7 +251,7 @@ static const struct regmap_config max98095_regmap = {
 /*
  * Load equalizer DSP coefficient configurations registers
  */
-static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
+static void m98095_eq_band(struct snd_soc_component *component, unsigned int dai,
 		    unsigned int band, u16 *coefs)
 {
 	unsigned int eq_reg;
@@ -269,15 +269,15 @@ static void m98095_eq_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		snd_soc_write(codec, eq_reg++, M98095_BYTE1(coefs[i]));
-		snd_soc_write(codec, eq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_component_write(component, eq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_component_write(component, eq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
 /*
  * Load biquad filter coefficient configurations registers
  */
-static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
+static void m98095_biquad_band(struct snd_soc_component *component, unsigned int dai,
 		    unsigned int band, u16 *coefs)
 {
 	unsigned int bq_reg;
@@ -295,8 +295,8 @@ static void m98095_biquad_band(struct snd_soc_codec *codec, unsigned int dai,
 
 	/* Step through the registers and coefs */
 	for (i = 0; i < M98095_COEFS_PER_BAND; i++) {
-		snd_soc_write(codec, bq_reg++, M98095_BYTE1(coefs[i]));
-		snd_soc_write(codec, bq_reg++, M98095_BYTE0(coefs[i]));
+		snd_soc_component_write(component, bq_reg++, M98095_BYTE1(coefs[i]));
+		snd_soc_component_write(component, bq_reg++, M98095_BYTE0(coefs[i]));
 	}
 }
 
@@ -353,12 +353,12 @@ static SOC_ENUM_SINGLE_DECL(max98095_dai3_dac_filter_enum,
 static int max98095_mic1pre_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
 	max98095->mic1pre = sel;
-	snd_soc_update_bits(codec, M98095_05F_LVL_MIC1, M98095_MICPRE_MASK,
+	snd_soc_component_update_bits(component, M98095_05F_LVL_MIC1, M98095_MICPRE_MASK,
 		(1+sel)<<M98095_MICPRE_SHIFT);
 
 	return 0;
@@ -367,8 +367,8 @@ static int max98095_mic1pre_set(struct snd_kcontrol *kcontrol,
 static int max98095_mic1pre_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = max98095->mic1pre;
 	return 0;
@@ -377,12 +377,12 @@ static int max98095_mic1pre_get(struct snd_kcontrol *kcontrol,
 static int max98095_mic2pre_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
 	max98095->mic2pre = sel;
-	snd_soc_update_bits(codec, M98095_060_LVL_MIC2, M98095_MICPRE_MASK,
+	snd_soc_component_update_bits(component, M98095_060_LVL_MIC2, M98095_MICPRE_MASK,
 		(1+sel)<<M98095_MICPRE_SHIFT);
 
 	return 0;
@@ -391,8 +391,8 @@ static int max98095_mic2pre_set(struct snd_kcontrol *kcontrol,
 static int max98095_mic2pre_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = max98095->mic2pre;
 	return 0;
@@ -598,21 +598,21 @@ static const struct snd_kcontrol_new max98095_right_ADC_mixer_controls[] = {
 static int max98095_mic_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (w->reg == M98095_05F_LVL_MIC1) {
-			snd_soc_update_bits(codec, w->reg, M98095_MICPRE_MASK,
+			snd_soc_component_update_bits(component, w->reg, M98095_MICPRE_MASK,
 				(1+max98095->mic1pre)<<M98095_MICPRE_SHIFT);
 		} else {
-			snd_soc_update_bits(codec, w->reg, M98095_MICPRE_MASK,
+			snd_soc_component_update_bits(component, w->reg, M98095_MICPRE_MASK,
 				(1+max98095->mic2pre)<<M98095_MICPRE_SHIFT);
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, w->reg, M98095_MICPRE_MASK, 0);
+		snd_soc_component_update_bits(component, w->reg, M98095_MICPRE_MASK, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -628,8 +628,8 @@ static int max98095_mic_event(struct snd_soc_dapm_widget *w,
 static int max98095_line_pga(struct snd_soc_dapm_widget *w,
 			     int event, u8 channel)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	u8 *state;
 
 	if (WARN_ON(!(channel == 1 || channel == 2)))
@@ -640,13 +640,13 @@ static int max98095_line_pga(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		*state |= channel;
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 			(1 << w->shift), (1 << w->shift));
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		*state &= ~channel;
 		if (*state == 0) {
-			snd_soc_update_bits(codec, w->reg,
+			snd_soc_component_update_bits(component, w->reg,
 				(1 << w->shift), 0);
 		}
 		break;
@@ -676,15 +676,15 @@ static int max98095_pga_in2_event(struct snd_soc_dapm_widget *w,
 static int max98095_lineout_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 			(1 << (w->shift+2)), (1 << (w->shift+2)));
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 			(1 << (w->shift+2)), 0);
 		break;
 	default:
@@ -942,8 +942,8 @@ static int max98095_dai1_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	unsigned long long ni;
 	unsigned int rate;
@@ -955,11 +955,11 @@ static int max98095_dai1_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_width(params)) {
 	case 16:
-		snd_soc_update_bits(codec, M98095_02A_DAI1_FORMAT,
+		snd_soc_component_update_bits(component, M98095_02A_DAI1_FORMAT,
 			M98095_DAI_WS, 0);
 		break;
 	case 24:
-		snd_soc_update_bits(codec, M98095_02A_DAI1_FORMAT,
+		snd_soc_component_update_bits(component, M98095_02A_DAI1_FORMAT,
 			M98095_DAI_WS, M98095_DAI_WS);
 		break;
 	default:
@@ -969,31 +969,31 @@ static int max98095_dai1_hw_params(struct snd_pcm_substream *substream,
 	if (rate_value(rate, &regval))
 		return -EINVAL;
 
-	snd_soc_update_bits(codec, M98095_027_DAI1_CLKMODE,
+	snd_soc_component_update_bits(component, M98095_027_DAI1_CLKMODE,
 		M98095_CLKMODE_MASK, regval);
 	cdata->rate = rate;
 
 	/* Configure NI when operating as master */
-	if (snd_soc_read(codec, M98095_02A_DAI1_FORMAT) & M98095_DAI_MAS) {
+	if (snd_soc_component_read32(component, M98095_02A_DAI1_FORMAT) & M98095_DAI_MAS) {
 		if (max98095->sysclk == 0) {
-			dev_err(codec->dev, "Invalid system clock frequency\n");
+			dev_err(component->dev, "Invalid system clock frequency\n");
 			return -EINVAL;
 		}
 		ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
 				* (unsigned long long int)rate;
 		do_div(ni, (unsigned long long int)max98095->sysclk);
-		snd_soc_write(codec, M98095_028_DAI1_CLKCFG_HI,
+		snd_soc_component_write(component, M98095_028_DAI1_CLKCFG_HI,
 			(ni >> 8) & 0x7F);
-		snd_soc_write(codec, M98095_029_DAI1_CLKCFG_LO,
+		snd_soc_component_write(component, M98095_029_DAI1_CLKCFG_LO,
 			ni & 0xFF);
 	}
 
 	/* Update sample rate mode */
 	if (rate < 50000)
-		snd_soc_update_bits(codec, M98095_02E_DAI1_FILTERS,
+		snd_soc_component_update_bits(component, M98095_02E_DAI1_FILTERS,
 			M98095_DAI_DHF, 0);
 	else
-		snd_soc_update_bits(codec, M98095_02E_DAI1_FILTERS,
+		snd_soc_component_update_bits(component, M98095_02E_DAI1_FILTERS,
 			M98095_DAI_DHF, M98095_DAI_DHF);
 
 	return 0;
@@ -1003,8 +1003,8 @@ static int max98095_dai2_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	unsigned long long ni;
 	unsigned int rate;
@@ -1016,11 +1016,11 @@ static int max98095_dai2_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_width(params)) {
 	case 16:
-		snd_soc_update_bits(codec, M98095_034_DAI2_FORMAT,
+		snd_soc_component_update_bits(component, M98095_034_DAI2_FORMAT,
 			M98095_DAI_WS, 0);
 		break;
 	case 24:
-		snd_soc_update_bits(codec, M98095_034_DAI2_FORMAT,
+		snd_soc_component_update_bits(component, M98095_034_DAI2_FORMAT,
 			M98095_DAI_WS, M98095_DAI_WS);
 		break;
 	default:
@@ -1030,31 +1030,31 @@ static int max98095_dai2_hw_params(struct snd_pcm_substream *substream,
 	if (rate_value(rate, &regval))
 		return -EINVAL;
 
-	snd_soc_update_bits(codec, M98095_031_DAI2_CLKMODE,
+	snd_soc_component_update_bits(component, M98095_031_DAI2_CLKMODE,
 		M98095_CLKMODE_MASK, regval);
 	cdata->rate = rate;
 
 	/* Configure NI when operating as master */
-	if (snd_soc_read(codec, M98095_034_DAI2_FORMAT) & M98095_DAI_MAS) {
+	if (snd_soc_component_read32(component, M98095_034_DAI2_FORMAT) & M98095_DAI_MAS) {
 		if (max98095->sysclk == 0) {
-			dev_err(codec->dev, "Invalid system clock frequency\n");
+			dev_err(component->dev, "Invalid system clock frequency\n");
 			return -EINVAL;
 		}
 		ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
 				* (unsigned long long int)rate;
 		do_div(ni, (unsigned long long int)max98095->sysclk);
-		snd_soc_write(codec, M98095_032_DAI2_CLKCFG_HI,
+		snd_soc_component_write(component, M98095_032_DAI2_CLKCFG_HI,
 			(ni >> 8) & 0x7F);
-		snd_soc_write(codec, M98095_033_DAI2_CLKCFG_LO,
+		snd_soc_component_write(component, M98095_033_DAI2_CLKCFG_LO,
 			ni & 0xFF);
 	}
 
 	/* Update sample rate mode */
 	if (rate < 50000)
-		snd_soc_update_bits(codec, M98095_038_DAI2_FILTERS,
+		snd_soc_component_update_bits(component, M98095_038_DAI2_FILTERS,
 			M98095_DAI_DHF, 0);
 	else
-		snd_soc_update_bits(codec, M98095_038_DAI2_FILTERS,
+		snd_soc_component_update_bits(component, M98095_038_DAI2_FILTERS,
 			M98095_DAI_DHF, M98095_DAI_DHF);
 
 	return 0;
@@ -1064,8 +1064,8 @@ static int max98095_dai3_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params,
 				   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	unsigned long long ni;
 	unsigned int rate;
@@ -1077,11 +1077,11 @@ static int max98095_dai3_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_width(params)) {
 	case 16:
-		snd_soc_update_bits(codec, M98095_03E_DAI3_FORMAT,
+		snd_soc_component_update_bits(component, M98095_03E_DAI3_FORMAT,
 			M98095_DAI_WS, 0);
 		break;
 	case 24:
-		snd_soc_update_bits(codec, M98095_03E_DAI3_FORMAT,
+		snd_soc_component_update_bits(component, M98095_03E_DAI3_FORMAT,
 			M98095_DAI_WS, M98095_DAI_WS);
 		break;
 	default:
@@ -1091,31 +1091,31 @@ static int max98095_dai3_hw_params(struct snd_pcm_substream *substream,
 	if (rate_value(rate, &regval))
 		return -EINVAL;
 
-	snd_soc_update_bits(codec, M98095_03B_DAI3_CLKMODE,
+	snd_soc_component_update_bits(component, M98095_03B_DAI3_CLKMODE,
 		M98095_CLKMODE_MASK, regval);
 	cdata->rate = rate;
 
 	/* Configure NI when operating as master */
-	if (snd_soc_read(codec, M98095_03E_DAI3_FORMAT) & M98095_DAI_MAS) {
+	if (snd_soc_component_read32(component, M98095_03E_DAI3_FORMAT) & M98095_DAI_MAS) {
 		if (max98095->sysclk == 0) {
-			dev_err(codec->dev, "Invalid system clock frequency\n");
+			dev_err(component->dev, "Invalid system clock frequency\n");
 			return -EINVAL;
 		}
 		ni = 65536ULL * (rate < 50000 ? 96ULL : 48ULL)
 				* (unsigned long long int)rate;
 		do_div(ni, (unsigned long long int)max98095->sysclk);
-		snd_soc_write(codec, M98095_03C_DAI3_CLKCFG_HI,
+		snd_soc_component_write(component, M98095_03C_DAI3_CLKCFG_HI,
 			(ni >> 8) & 0x7F);
-		snd_soc_write(codec, M98095_03D_DAI3_CLKCFG_LO,
+		snd_soc_component_write(component, M98095_03D_DAI3_CLKCFG_LO,
 			ni & 0xFF);
 	}
 
 	/* Update sample rate mode */
 	if (rate < 50000)
-		snd_soc_update_bits(codec, M98095_042_DAI3_FILTERS,
+		snd_soc_component_update_bits(component, M98095_042_DAI3_FILTERS,
 			M98095_DAI_DHF, 0);
 	else
-		snd_soc_update_bits(codec, M98095_042_DAI3_FILTERS,
+		snd_soc_component_update_bits(component, M98095_042_DAI3_FILTERS,
 			M98095_DAI_DHF, M98095_DAI_DHF);
 
 	return 0;
@@ -1124,8 +1124,8 @@ static int max98095_dai3_hw_params(struct snd_pcm_substream *substream,
 static int max98095_dai_set_sysclk(struct snd_soc_dai *dai,
 				   int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 
 	/* Requested clock frequency is already setup */
 	if (freq == max98095->sysclk)
@@ -1142,13 +1142,13 @@ static int max98095_dai_set_sysclk(struct snd_soc_dai *dai,
 	 *         0x03 (when master clk is 40MHz to 60MHz)..
 	 */
 	if ((freq >= 10000000) && (freq < 20000000)) {
-		snd_soc_write(codec, M98095_026_SYS_CLK, 0x10);
+		snd_soc_component_write(component, M98095_026_SYS_CLK, 0x10);
 	} else if ((freq >= 20000000) && (freq < 40000000)) {
-		snd_soc_write(codec, M98095_026_SYS_CLK, 0x20);
+		snd_soc_component_write(component, M98095_026_SYS_CLK, 0x20);
 	} else if ((freq >= 40000000) && (freq < 60000000)) {
-		snd_soc_write(codec, M98095_026_SYS_CLK, 0x30);
+		snd_soc_component_write(component, M98095_026_SYS_CLK, 0x30);
 	} else {
-		dev_err(codec->dev, "Invalid master clock frequency\n");
+		dev_err(component->dev, "Invalid master clock frequency\n");
 		return -EINVAL;
 	}
 
@@ -1161,8 +1161,8 @@ static int max98095_dai_set_sysclk(struct snd_soc_dai *dai,
 static int max98095_dai1_set_fmt(struct snd_soc_dai *codec_dai,
 				 unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	u8 regval = 0;
 
@@ -1174,9 +1174,9 @@ static int max98095_dai1_set_fmt(struct snd_soc_dai *codec_dai,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* Slave mode PLL */
-			snd_soc_write(codec, M98095_028_DAI1_CLKCFG_HI,
+			snd_soc_component_write(component, M98095_028_DAI1_CLKCFG_HI,
 				0x80);
-			snd_soc_write(codec, M98095_029_DAI1_CLKCFG_LO,
+			snd_soc_component_write(component, M98095_029_DAI1_CLKCFG_LO,
 				0x00);
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
@@ -1186,7 +1186,7 @@ static int max98095_dai1_set_fmt(struct snd_soc_dai *codec_dai,
 		case SND_SOC_DAIFMT_CBS_CFM:
 		case SND_SOC_DAIFMT_CBM_CFS:
 		default:
-			dev_err(codec->dev, "Clock mode unsupported");
+			dev_err(component->dev, "Clock mode unsupported");
 			return -EINVAL;
 		}
 
@@ -1216,11 +1216,11 @@ static int max98095_dai1_set_fmt(struct snd_soc_dai *codec_dai,
 			return -EINVAL;
 		}
 
-		snd_soc_update_bits(codec, M98095_02A_DAI1_FORMAT,
+		snd_soc_component_update_bits(component, M98095_02A_DAI1_FORMAT,
 			M98095_DAI_MAS | M98095_DAI_DLY | M98095_DAI_BCI |
 			M98095_DAI_WCI, regval);
 
-		snd_soc_write(codec, M98095_02B_DAI1_CLOCK, M98095_DAI_BSEL64);
+		snd_soc_component_write(component, M98095_02B_DAI1_CLOCK, M98095_DAI_BSEL64);
 	}
 
 	return 0;
@@ -1229,8 +1229,8 @@ static int max98095_dai1_set_fmt(struct snd_soc_dai *codec_dai,
 static int max98095_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 				 unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	u8 regval = 0;
 
@@ -1242,9 +1242,9 @@ static int max98095_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* Slave mode PLL */
-			snd_soc_write(codec, M98095_032_DAI2_CLKCFG_HI,
+			snd_soc_component_write(component, M98095_032_DAI2_CLKCFG_HI,
 				0x80);
-			snd_soc_write(codec, M98095_033_DAI2_CLKCFG_LO,
+			snd_soc_component_write(component, M98095_033_DAI2_CLKCFG_LO,
 				0x00);
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
@@ -1254,7 +1254,7 @@ static int max98095_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 		case SND_SOC_DAIFMT_CBS_CFM:
 		case SND_SOC_DAIFMT_CBM_CFS:
 		default:
-			dev_err(codec->dev, "Clock mode unsupported");
+			dev_err(component->dev, "Clock mode unsupported");
 			return -EINVAL;
 		}
 
@@ -1284,11 +1284,11 @@ static int max98095_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 			return -EINVAL;
 		}
 
-		snd_soc_update_bits(codec, M98095_034_DAI2_FORMAT,
+		snd_soc_component_update_bits(component, M98095_034_DAI2_FORMAT,
 			M98095_DAI_MAS | M98095_DAI_DLY | M98095_DAI_BCI |
 			M98095_DAI_WCI, regval);
 
-		snd_soc_write(codec, M98095_035_DAI2_CLOCK,
+		snd_soc_component_write(component, M98095_035_DAI2_CLOCK,
 			M98095_DAI_BSEL64);
 	}
 
@@ -1298,8 +1298,8 @@ static int max98095_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 static int max98095_dai3_set_fmt(struct snd_soc_dai *codec_dai,
 				 unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	u8 regval = 0;
 
@@ -1311,9 +1311,9 @@ static int max98095_dai3_set_fmt(struct snd_soc_dai *codec_dai,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
 			/* Slave mode PLL */
-			snd_soc_write(codec, M98095_03C_DAI3_CLKCFG_HI,
+			snd_soc_component_write(component, M98095_03C_DAI3_CLKCFG_HI,
 				0x80);
-			snd_soc_write(codec, M98095_03D_DAI3_CLKCFG_LO,
+			snd_soc_component_write(component, M98095_03D_DAI3_CLKCFG_LO,
 				0x00);
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
@@ -1323,7 +1323,7 @@ static int max98095_dai3_set_fmt(struct snd_soc_dai *codec_dai,
 		case SND_SOC_DAIFMT_CBS_CFM:
 		case SND_SOC_DAIFMT_CBM_CFS:
 		default:
-			dev_err(codec->dev, "Clock mode unsupported");
+			dev_err(component->dev, "Clock mode unsupported");
 			return -EINVAL;
 		}
 
@@ -1353,21 +1353,21 @@ static int max98095_dai3_set_fmt(struct snd_soc_dai *codec_dai,
 			return -EINVAL;
 		}
 
-		snd_soc_update_bits(codec, M98095_03E_DAI3_FORMAT,
+		snd_soc_component_update_bits(component, M98095_03E_DAI3_FORMAT,
 			M98095_DAI_MAS | M98095_DAI_DLY | M98095_DAI_BCI |
 			M98095_DAI_WCI, regval);
 
-		snd_soc_write(codec, M98095_03F_DAI3_CLOCK,
+		snd_soc_component_write(component, M98095_03F_DAI3_CLOCK,
 			M98095_DAI_BSEL64);
 	}
 
 	return 0;
 }
 
-static int max98095_set_bias_level(struct snd_soc_codec *codec,
+static int max98095_set_bias_level(struct snd_soc_component *component,
 				   enum snd_soc_bias_level level)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -1385,7 +1385,7 @@ static int max98095_set_bias_level(struct snd_soc_codec *codec,
 		if (IS_ERR(max98095->mclk))
 			break;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_ON) {
 			clk_disable_unprepare(max98095->mclk);
 		} else {
 			ret = clk_prepare_enable(max98095->mclk);
@@ -1395,21 +1395,21 @@ static int max98095_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regcache_sync(max98095->regmap);
 
 			if (ret != 0) {
-				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
+				dev_err(component->dev, "Failed to sync cache: %d\n", ret);
 				return ret;
 			}
 		}
 
-		snd_soc_update_bits(codec, M98095_090_PWR_EN_IN,
+		snd_soc_component_update_bits(component, M98095_090_PWR_EN_IN,
 				M98095_MBEN, M98095_MBEN);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, M98095_090_PWR_EN_IN,
+		snd_soc_component_update_bits(component, M98095_090_PWR_EN_IN,
 				M98095_MBEN, 0);
 		regcache_mark_dirty(max98095->regmap);
 		break;
@@ -1494,8 +1494,8 @@ static int max98095_get_eq_channel(const char *name)
 static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_pdata *pdata = max98095->pdata;
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
 	struct max98095_cdata *cdata;
@@ -1528,7 +1528,7 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	dev_dbg(codec->dev, "Selected %s/%dHz for %dHz sample rate\n",
+	dev_dbg(component->dev, "Selected %s/%dHz for %dHz sample rate\n",
 		pdata->eq_cfg[best].name,
 		pdata->eq_cfg[best].rate, fs);
 
@@ -1537,29 +1537,29 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 	regmask = (channel == 0) ? M98095_EQ1EN : M98095_EQ2EN;
 
 	/* Disable filter while configuring, and save current on/off state */
-	regsave = snd_soc_read(codec, M98095_088_CFG_LEVEL);
-	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, 0);
+	regsave = snd_soc_component_read32(component, M98095_088_CFG_LEVEL);
+	snd_soc_component_update_bits(component, M98095_088_CFG_LEVEL, regmask, 0);
 
 	mutex_lock(&max98095->lock);
-	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
-	m98095_eq_band(codec, channel, 0, coef_set->band1);
-	m98095_eq_band(codec, channel, 1, coef_set->band2);
-	m98095_eq_band(codec, channel, 2, coef_set->band3);
-	m98095_eq_band(codec, channel, 3, coef_set->band4);
-	m98095_eq_band(codec, channel, 4, coef_set->band5);
-	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, 0);
+	snd_soc_component_update_bits(component, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
+	m98095_eq_band(component, channel, 0, coef_set->band1);
+	m98095_eq_band(component, channel, 1, coef_set->band2);
+	m98095_eq_band(component, channel, 2, coef_set->band3);
+	m98095_eq_band(component, channel, 3, coef_set->band4);
+	m98095_eq_band(component, channel, 4, coef_set->band5);
+	snd_soc_component_update_bits(component, M98095_00F_HOST_CFG, M98095_SEG, 0);
 	mutex_unlock(&max98095->lock);
 
 	/* Restore the original on/off state */
-	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, regsave);
+	snd_soc_component_update_bits(component, M98095_088_CFG_LEVEL, regmask, regsave);
 	return 0;
 }
 
 static int max98095_get_eq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
 	struct max98095_cdata *cdata;
 
@@ -1569,9 +1569,9 @@ static int max98095_get_eq_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void max98095_handle_eq_pdata(struct snd_soc_codec *codec)
+static void max98095_handle_eq_pdata(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_pdata *pdata = max98095->pdata;
 	struct max98095_eq_cfg *cfg;
 	unsigned int cfgcnt;
@@ -1624,14 +1624,14 @@ static void max98095_handle_eq_pdata(struct snd_soc_codec *codec)
 	max98095->eq_enum.texts = max98095->eq_texts;
 	max98095->eq_enum.items = max98095->eq_textcnt;
 
-	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_component_controls(component, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to add EQ control: %d\n", ret);
+		dev_err(component->dev, "Failed to add EQ control: %d\n", ret);
 }
 
 static const char *bq_mode_name[] = {"Biquad1 Mode", "Biquad2 Mode"};
 
-static int max98095_get_bq_channel(struct snd_soc_codec *codec,
+static int max98095_get_bq_channel(struct snd_soc_component *component,
 				   const char *name)
 {
 	int i;
@@ -1641,17 +1641,17 @@ static int max98095_get_bq_channel(struct snd_soc_codec *codec,
 			return i;
 
 	/* Shouldn't happen */
-	dev_err(codec->dev, "Bad biquad channel name '%s'\n", name);
+	dev_err(component->dev, "Bad biquad channel name '%s'\n", name);
 	return -EINVAL;
 }
 
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_pdata *pdata = max98095->pdata;
-	int channel = max98095_get_bq_channel(codec, kcontrol->id.name);
+	int channel = max98095_get_bq_channel(component, kcontrol->id.name);
 	struct max98095_cdata *cdata;
 	unsigned int sel = ucontrol->value.enumerated.item[0];
 	struct max98095_biquad_cfg *coef_set;
@@ -1682,7 +1682,7 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	dev_dbg(codec->dev, "Selected %s/%dHz for %dHz sample rate\n",
+	dev_dbg(component->dev, "Selected %s/%dHz for %dHz sample rate\n",
 		pdata->bq_cfg[best].name,
 		pdata->bq_cfg[best].rate, fs);
 
@@ -1691,27 +1691,27 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 	regmask = (channel == 0) ? M98095_BQ1EN : M98095_BQ2EN;
 
 	/* Disable filter while configuring, and save current on/off state */
-	regsave = snd_soc_read(codec, M98095_088_CFG_LEVEL);
-	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, 0);
+	regsave = snd_soc_component_read32(component, M98095_088_CFG_LEVEL);
+	snd_soc_component_update_bits(component, M98095_088_CFG_LEVEL, regmask, 0);
 
 	mutex_lock(&max98095->lock);
-	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
-	m98095_biquad_band(codec, channel, 0, coef_set->band1);
-	m98095_biquad_band(codec, channel, 1, coef_set->band2);
-	snd_soc_update_bits(codec, M98095_00F_HOST_CFG, M98095_SEG, 0);
+	snd_soc_component_update_bits(component, M98095_00F_HOST_CFG, M98095_SEG, M98095_SEG);
+	m98095_biquad_band(component, channel, 0, coef_set->band1);
+	m98095_biquad_band(component, channel, 1, coef_set->band2);
+	snd_soc_component_update_bits(component, M98095_00F_HOST_CFG, M98095_SEG, 0);
 	mutex_unlock(&max98095->lock);
 
 	/* Restore the original on/off state */
-	snd_soc_update_bits(codec, M98095_088_CFG_LEVEL, regmask, regsave);
+	snd_soc_component_update_bits(component, M98095_088_CFG_LEVEL, regmask, regsave);
 	return 0;
 }
 
 static int max98095_get_bq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
-	int channel = max98095_get_bq_channel(codec, kcontrol->id.name);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
+	int channel = max98095_get_bq_channel(component, kcontrol->id.name);
 	struct max98095_cdata *cdata;
 
 	if (channel < 0)
@@ -1723,9 +1723,9 @@ static int max98095_get_bq_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void max98095_handle_bq_pdata(struct snd_soc_codec *codec)
+static void max98095_handle_bq_pdata(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_pdata *pdata = max98095->pdata;
 	struct max98095_biquad_cfg *cfg;
 	unsigned int cfgcnt;
@@ -1779,19 +1779,19 @@ static void max98095_handle_bq_pdata(struct snd_soc_codec *codec)
 	max98095->bq_enum.texts = max98095->bq_texts;
 	max98095->bq_enum.items = max98095->bq_textcnt;
 
-	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_component_controls(component, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(codec->dev, "Failed to add Biquad control: %d\n", ret);
+		dev_err(component->dev, "Failed to add Biquad control: %d\n", ret);
 }
 
-static void max98095_handle_pdata(struct snd_soc_codec *codec)
+static void max98095_handle_pdata(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_pdata *pdata = max98095->pdata;
 	u8 regval = 0;
 
 	if (!pdata) {
-		dev_dbg(codec->dev, "No platform data\n");
+		dev_dbg(component->dev, "No platform data\n");
 		return;
 	}
 
@@ -1802,27 +1802,27 @@ static void max98095_handle_pdata(struct snd_soc_codec *codec)
 	if (pdata->digmic_right_mode)
 		regval |= M98095_DIGMIC_R;
 
-	snd_soc_write(codec, M98095_087_CFG_MIC, regval);
+	snd_soc_component_write(component, M98095_087_CFG_MIC, regval);
 
 	/* Configure equalizers */
 	if (pdata->eq_cfgcnt)
-		max98095_handle_eq_pdata(codec);
+		max98095_handle_eq_pdata(component);
 
 	/* Configure bi-quad filters */
 	if (pdata->bq_cfgcnt)
-		max98095_handle_bq_pdata(codec);
+		max98095_handle_bq_pdata(component);
 }
 
 static irqreturn_t max98095_report_jack(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = data;
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	unsigned int value;
 	int hp_report = 0;
 	int mic_report = 0;
 
 	/* Read the Jack Status Register */
-	value = snd_soc_read(codec, M98095_007_JACK_AUTO_STS);
+	value = snd_soc_component_read32(component, M98095_007_JACK_AUTO_STS);
 
 	/* If ddone is not set, then detection isn't finished yet */
 	if ((value & M98095_DDONE) == 0)
@@ -1853,9 +1853,9 @@ static irqreturn_t max98095_report_jack(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int max98095_jack_detect_enable(struct snd_soc_codec *codec)
+static int max98095_jack_detect_enable(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 	int detect_enable = M98095_JDEN;
 	unsigned int slew = M98095_DEFAULT_SLEW_DELAY;
@@ -1866,41 +1866,41 @@ static int max98095_jack_detect_enable(struct snd_soc_codec *codec)
 	if (max98095->pdata->jack_detect_delay)
 		slew = max98095->pdata->jack_detect_delay;
 
-	ret = snd_soc_write(codec, M98095_08E_JACK_DC_SLEW, slew);
+	ret = snd_soc_component_write(component, M98095_08E_JACK_DC_SLEW, slew);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to cfg auto detect %d\n", ret);
+		dev_err(component->dev, "Failed to cfg auto detect %d\n", ret);
 		return ret;
 	}
 
 	/* configure auto detection to be enabled */
-	ret = snd_soc_write(codec, M98095_089_JACK_DET_AUTO, detect_enable);
+	ret = snd_soc_component_write(component, M98095_089_JACK_DET_AUTO, detect_enable);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to cfg auto detect %d\n", ret);
+		dev_err(component->dev, "Failed to cfg auto detect %d\n", ret);
 		return ret;
 	}
 
 	return ret;
 }
 
-static int max98095_jack_detect_disable(struct snd_soc_codec *codec)
+static int max98095_jack_detect_disable(struct snd_soc_component *component)
 {
 	int ret = 0;
 
 	/* configure auto detection to be disabled */
-	ret = snd_soc_write(codec, M98095_089_JACK_DET_AUTO, 0x0);
+	ret = snd_soc_component_write(component, M98095_089_JACK_DET_AUTO, 0x0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to cfg auto detect %d\n", ret);
+		dev_err(component->dev, "Failed to cfg auto detect %d\n", ret);
 		return ret;
 	}
 
 	return ret;
 }
 
-int max98095_jack_detect(struct snd_soc_codec *codec,
+int max98095_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *client = to_i2c_client(codec->dev);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *client = to_i2c_client(component->dev);
 	int ret = 0;
 
 	max98095->headphone_jack = hp_jack;
@@ -1910,44 +1910,44 @@ int max98095_jack_detect(struct snd_soc_codec *codec,
 	if (!hp_jack && !mic_jack)
 		return -EINVAL;
 
-	max98095_jack_detect_enable(codec);
+	max98095_jack_detect_enable(component);
 
 	/* enable interrupts for headphone jack detection */
-	ret = snd_soc_update_bits(codec, M98095_013_JACK_INT_EN,
+	ret = snd_soc_component_update_bits(component, M98095_013_JACK_INT_EN,
 		M98095_IDDONE, M98095_IDDONE);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to cfg jack irqs %d\n", ret);
+		dev_err(component->dev, "Failed to cfg jack irqs %d\n", ret);
 		return ret;
 	}
 
-	max98095_report_jack(client->irq, codec);
+	max98095_report_jack(client->irq, component);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(max98095_jack_detect);
 
 #ifdef CONFIG_PM
-static int max98095_suspend(struct snd_soc_codec *codec)
+static int max98095_suspend(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 
 	if (max98095->headphone_jack || max98095->mic_jack)
-		max98095_jack_detect_disable(codec);
+		max98095_jack_detect_disable(component);
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int max98095_resume(struct snd_soc_codec *codec)
+static int max98095_resume(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *client = to_i2c_client(codec->dev);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *client = to_i2c_client(component->dev);
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	if (max98095->headphone_jack || max98095->mic_jack) {
-		max98095_jack_detect_enable(codec);
-		max98095_report_jack(client->irq, codec);
+		max98095_jack_detect_enable(component);
+		max98095_report_jack(client->irq, component);
 	}
 
 	return 0;
@@ -1957,30 +1957,30 @@ static int max98095_resume(struct snd_soc_codec *codec)
 #define max98095_resume NULL
 #endif
 
-static int max98095_reset(struct snd_soc_codec *codec)
+static int max98095_reset(struct snd_soc_component *component)
 {
 	int i, ret;
 
 	/* Gracefully reset the DSP core and the codec hardware
 	 * in a proper sequence */
-	ret = snd_soc_write(codec, M98095_00F_HOST_CFG, 0);
+	ret = snd_soc_component_write(component, M98095_00F_HOST_CFG, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to reset DSP: %d\n", ret);
+		dev_err(component->dev, "Failed to reset DSP: %d\n", ret);
 		return ret;
 	}
 
-	ret = snd_soc_write(codec, M98095_097_PWR_SYS, 0);
+	ret = snd_soc_component_write(component, M98095_097_PWR_SYS, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to reset codec: %d\n", ret);
+		dev_err(component->dev, "Failed to reset component: %d\n", ret);
 		return ret;
 	}
 
 	/* Reset to hardware default for registers, as there is not
 	 * a soft reset hardware control register */
 	for (i = M98095_010_HOST_INT_CFG; i < M98095_REG_MAX_CACHED; i++) {
-		ret = snd_soc_write(codec, i, snd_soc_read(codec, i));
+		ret = snd_soc_component_write(component, i, snd_soc_component_read32(component, i));
 		if (ret < 0) {
-			dev_err(codec->dev, "Failed to reset: %d\n", ret);
+			dev_err(component->dev, "Failed to reset: %d\n", ret);
 			return ret;
 		}
 	}
@@ -1988,21 +1988,21 @@ static int max98095_reset(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int max98095_probe(struct snd_soc_codec *codec)
+static int max98095_probe(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
 	struct max98095_cdata *cdata;
 	struct i2c_client *client;
 	int ret = 0;
 
-	max98095->mclk = devm_clk_get(codec->dev, "mclk");
+	max98095->mclk = devm_clk_get(component->dev, "mclk");
 	if (PTR_ERR(max98095->mclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
 	/* reset the codec, the DSP core, and disable all interrupts */
-	max98095_reset(codec);
+	max98095_reset(component);
 
-	client = to_i2c_client(codec->dev);
+	client = to_i2c_client(component->dev);
 
 	/* initialize private data */
 
@@ -2037,85 +2037,85 @@ static int max98095_probe(struct snd_soc_codec *codec)
 		ret = request_threaded_irq(client->irq, NULL,
 			max98095_report_jack,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-			IRQF_ONESHOT, "max98095", codec);
+			IRQF_ONESHOT, "max98095", component);
 		if (ret) {
-			dev_err(codec->dev, "Failed to request IRQ: %d\n", ret);
+			dev_err(component->dev, "Failed to request IRQ: %d\n", ret);
 			goto err_access;
 		}
 	}
 
-	ret = snd_soc_read(codec, M98095_0FF_REV_ID);
+	ret = snd_soc_component_read32(component, M98095_0FF_REV_ID);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failure reading hardware revision: %d\n",
+		dev_err(component->dev, "Failure reading hardware revision: %d\n",
 			ret);
 		goto err_irq;
 	}
-	dev_info(codec->dev, "Hardware revision: %c\n", ret - 0x40 + 'A');
+	dev_info(component->dev, "Hardware revision: %c\n", ret - 0x40 + 'A');
 
-	snd_soc_write(codec, M98095_097_PWR_SYS, M98095_PWRSV);
+	snd_soc_component_write(component, M98095_097_PWR_SYS, M98095_PWRSV);
 
-	snd_soc_write(codec, M98095_048_MIX_DAC_LR,
+	snd_soc_component_write(component, M98095_048_MIX_DAC_LR,
 		M98095_DAI1L_TO_DACL|M98095_DAI1R_TO_DACR);
 
-	snd_soc_write(codec, M98095_049_MIX_DAC_M,
+	snd_soc_component_write(component, M98095_049_MIX_DAC_M,
 		M98095_DAI2M_TO_DACM|M98095_DAI3M_TO_DACM);
 
-	snd_soc_write(codec, M98095_092_PWR_EN_OUT, M98095_SPK_SPREADSPECTRUM);
-	snd_soc_write(codec, M98095_045_CFG_DSP, M98095_DSPNORMAL);
-	snd_soc_write(codec, M98095_04E_CFG_HP, M98095_HPNORMAL);
+	snd_soc_component_write(component, M98095_092_PWR_EN_OUT, M98095_SPK_SPREADSPECTRUM);
+	snd_soc_component_write(component, M98095_045_CFG_DSP, M98095_DSPNORMAL);
+	snd_soc_component_write(component, M98095_04E_CFG_HP, M98095_HPNORMAL);
 
-	snd_soc_write(codec, M98095_02C_DAI1_IOCFG,
+	snd_soc_component_write(component, M98095_02C_DAI1_IOCFG,
 		M98095_S1NORMAL|M98095_SDATA);
 
-	snd_soc_write(codec, M98095_036_DAI2_IOCFG,
+	snd_soc_component_write(component, M98095_036_DAI2_IOCFG,
 		M98095_S2NORMAL|M98095_SDATA);
 
-	snd_soc_write(codec, M98095_040_DAI3_IOCFG,
+	snd_soc_component_write(component, M98095_040_DAI3_IOCFG,
 		M98095_S3NORMAL|M98095_SDATA);
 
-	max98095_handle_pdata(codec);
+	max98095_handle_pdata(component);
 
 	/* take the codec out of the shut down */
-	snd_soc_update_bits(codec, M98095_097_PWR_SYS, M98095_SHDNRUN,
+	snd_soc_component_update_bits(component, M98095_097_PWR_SYS, M98095_SHDNRUN,
 		M98095_SHDNRUN);
 
 	return 0;
 
 err_irq:
 	if (client->irq)
-		free_irq(client->irq, codec);
+		free_irq(client->irq, component);
 err_access:
 	return ret;
 }
 
-static int max98095_remove(struct snd_soc_codec *codec)
+static void max98095_remove(struct snd_soc_component *component)
 {
-	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *client = to_i2c_client(codec->dev);
+	struct max98095_priv *max98095 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *client = to_i2c_client(component->dev);
 
 	if (max98095->headphone_jack || max98095->mic_jack)
-		max98095_jack_detect_disable(codec);
+		max98095_jack_detect_disable(component);
 
 	if (client->irq)
-		free_irq(client->irq, codec);
-
-	return 0;
+		free_irq(client->irq, component);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_max98095 = {
-	.probe   = max98095_probe,
-	.remove  = max98095_remove,
-	.suspend = max98095_suspend,
-	.resume  = max98095_resume,
-	.set_bias_level = max98095_set_bias_level,
-	.component_driver = {
-		.controls		= max98095_snd_controls,
-		.num_controls		= ARRAY_SIZE(max98095_snd_controls),
-		.dapm_widgets		= max98095_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max98095_dapm_widgets),
-		.dapm_routes		= max98095_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(max98095_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_max98095 = {
+	.probe			= max98095_probe,
+	.remove			= max98095_remove,
+	.suspend		= max98095_suspend,
+	.resume			= max98095_resume,
+	.set_bias_level		= max98095_set_bias_level,
+	.controls		= max98095_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98095_snd_controls),
+	.dapm_widgets		= max98095_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98095_dapm_widgets),
+	.dapm_routes		= max98095_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98095_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int max98095_i2c_probe(struct i2c_client *i2c,
@@ -2142,17 +2142,12 @@ static int max98095_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, max98095);
 	max98095->pdata = i2c->dev.platform_data;
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98095,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				     &soc_component_dev_max98095,
 				     max98095_dai, ARRAY_SIZE(max98095_dai));
 	return ret;
 }
 
-static int max98095_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98095_i2c_id[] = {
 	{ "max98095", MAX98095 },
 	{ }
@@ -2171,7 +2166,6 @@ static struct i2c_driver max98095_i2c_driver = {
 		.of_match_table = of_match_ptr(max98095_of_match),
 	},
 	.probe  = max98095_i2c_probe,
-	.remove = max98095_i2c_remove,
 	.id_table = max98095_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98095.h b/sound/soc/codecs/max98095.h
index 2ebbe4e894bf..67886cacddb2 100644
--- a/sound/soc/codecs/max98095.h
+++ b/sound/soc/codecs/max98095.h
@@ -315,7 +315,7 @@
 /* Default Delay used in Slew Rate Calculation for Jack detection */
 #define M98095_DEFAULT_SLEW_DELAY		0x18
 
-extern int max98095_jack_detect(struct snd_soc_codec *codec,
+extern int max98095_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack);
 
 #endif
-- 
2.16.1
