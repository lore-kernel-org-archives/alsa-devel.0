From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l42: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:43:10 +0000
Message-ID: <E1elDRu-00051d-2r@debutante>
References: <871sivamnv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 517ED2673A2
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:43:14 +0100 (CET)
In-Reply-To: <871sivamnv.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l42: replace codec to component

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

>From c92614022c6d375e7759a0142a985b4bbfd9046b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:59:27 +0000
Subject: [PATCH] ASoC: cs42l42: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 1	->	.use_pmdown_time = 0
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 154 ++++++++++++++++++++++-----------------------
 sound/soc/codecs/cs42l42.h |   2 +-
 2 files changed, 76 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a2324a0e72ee..651329bf9743 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -468,33 +468,33 @@ static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 static int cs42l42_hpdrv_evt(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Enable the channels */
-		snd_soc_update_bits(codec, CS42L42_ASP_RX_DAI0_EN,
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_EN,
 				CS42L42_ASP_RX0_CH_EN_MASK,
 				(CS42L42_ASP_RX0_CH1_EN |
 				CS42L42_ASP_RX0_CH2_EN) <<
 				CS42L42_ASP_RX0_CH_EN_SHIFT);
 
 		/* Power up */
-		snd_soc_update_bits(codec, CS42L42_PWR_CTL1,
+		snd_soc_component_update_bits(component, CS42L42_PWR_CTL1,
 			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
 				CS42L42_HP_PDN_MASK, 0);
 	} else if (event & SND_SOC_DAPM_PRE_PMD) {
 		/* Disable the channels */
-		snd_soc_update_bits(codec, CS42L42_ASP_RX_DAI0_EN,
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_EN,
 				CS42L42_ASP_RX0_CH_EN_MASK, 0);
 
 		/* Power down */
-		snd_soc_update_bits(codec, CS42L42_PWR_CTL1,
+		snd_soc_component_update_bits(component, CS42L42_PWR_CTL1,
 			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
 				CS42L42_HP_PDN_MASK,
 			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
 				CS42L42_HP_PDN_MASK);
 	} else {
-		dev_err(codec->dev, "Invalid event 0x%x\n", event);
+		dev_err(component->dev, "Invalid event 0x%x\n", event);
 	}
 	return 0;
 }
@@ -515,10 +515,10 @@ static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
 	{"HP", NULL, "HPDRV"}
 };
 
-static int cs42l42_set_bias_level(struct snd_soc_codec *codec,
+static int cs42l42_set_bias_level(struct snd_soc_component *component,
 					enum snd_soc_bias_level level)
 {
-	struct cs42l42_private *cs42l42 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -527,14 +527,14 @@ static int cs42l42_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_cache_only(cs42l42->regmap, false);
 			regcache_sync(cs42l42->regmap);
 			ret = regulator_bulk_enable(
 						ARRAY_SIZE(cs42l42->supplies),
 						cs42l42->supplies);
 			if (ret != 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable regulators: %d\n",
 					ret);
 				return ret;
@@ -552,30 +552,28 @@ static int cs42l42_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int cs42l42_codec_probe(struct snd_soc_codec *codec)
+static int cs42l42_component_probe(struct snd_soc_component *component)
 {
 	struct cs42l42_private *cs42l42 =
-		(struct cs42l42_private *)snd_soc_codec_get_drvdata(codec);
+		(struct cs42l42_private *)snd_soc_component_get_drvdata(component);
 
-	cs42l42->codec = codec;
+	cs42l42->component = component;
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_cs42l42 = {
-	.probe = cs42l42_codec_probe,
-	.set_bias_level = cs42l42_set_bias_level,
-	.ignore_pmdown_time = true,
-
-	.component_driver = {
-		.dapm_widgets = cs42l42_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(cs42l42_dapm_widgets),
-		.dapm_routes = cs42l42_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(cs42l42_audio_map),
-
-		.controls = cs42l42_snd_controls,
-		.num_controls = ARRAY_SIZE(cs42l42_snd_controls),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
+	.probe			= cs42l42_component_probe,
+	.set_bias_level		= cs42l42_set_bias_level,
+	.dapm_widgets		= cs42l42_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
+	.dapm_routes		= cs42l42_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(cs42l42_audio_map),
+	.controls		= cs42l42_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs42l42_snd_controls),
+	.idle_bias_on		= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 struct cs42l42_pll_params {
@@ -613,16 +611,16 @@ static const struct cs42l42_pll_params pll_ratio_table[] = {
 	{ 24576000, 1, 0, 0, 0, 0, 0, 0, 24576000, 0 }
 };
 
-static int cs42l42_pll_config(struct snd_soc_codec *codec)
+static int cs42l42_pll_config(struct snd_soc_component *component)
 {
-	struct cs42l42_private *cs42l42 = snd_soc_codec_get_drvdata(codec);
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
 	u32 fsync;
 
 	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
 		if (pll_ratio_table[i].sclk == cs42l42->sclk) {
 			/* Configure the internal sample rate */
-			snd_soc_update_bits(codec, CS42L42_MCLK_CTL,
+			snd_soc_component_update_bits(component, CS42L42_MCLK_CTL,
 					CS42L42_INTERNAL_FS_MASK,
 					((pll_ratio_table[i].mclk_int !=
 					12000000) &&
@@ -632,7 +630,7 @@ static int cs42l42_pll_config(struct snd_soc_codec *codec)
 			/* Set the MCLK src (PLL or SCLK) and the divide
 			 * ratio
 			 */
-			snd_soc_update_bits(codec, CS42L42_MCLK_SRC_SEL,
+			snd_soc_component_update_bits(component, CS42L42_MCLK_SRC_SEL,
 					CS42L42_MCLK_SRC_SEL_MASK |
 					CS42L42_MCLKDIV_MASK,
 					(pll_ratio_table[i].mclk_src_sel
@@ -643,62 +641,62 @@ static int cs42l42_pll_config(struct snd_soc_codec *codec)
 			fsync = cs42l42->sclk / cs42l42->srate;
 			if (((fsync * cs42l42->srate) != cs42l42->sclk)
 				|| ((fsync % 2) != 0)) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Unsupported sclk %d/sample rate %d\n",
 					cs42l42->sclk,
 					cs42l42->srate);
 				return -EINVAL;
 			}
 			/* Set the LRCLK period */
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_FSYNC_P_LOWER,
 					CS42L42_FSYNC_PERIOD_MASK,
 					CS42L42_FRAC0_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PERIOD_SHIFT);
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_FSYNC_P_UPPER,
 					CS42L42_FSYNC_PERIOD_MASK,
 					CS42L42_FRAC1_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PERIOD_SHIFT);
 			/* Set the LRCLK to 50% duty cycle */
 			fsync = fsync / 2;
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_FSYNC_PW_LOWER,
 					CS42L42_FSYNC_PULSE_WIDTH_MASK,
 					CS42L42_FRAC0_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_FSYNC_PW_UPPER,
 					CS42L42_FSYNC_PULSE_WIDTH_MASK,
 					CS42L42_FRAC1_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_ASP_FRM_CFG,
 					CS42L42_ASP_5050_MASK,
 					CS42L42_ASP_5050_MASK);
 			/* Set the frame delay to 1.0 SCLK clocks */
-			snd_soc_update_bits(codec, CS42L42_ASP_FRM_CFG,
+			snd_soc_component_update_bits(component, CS42L42_ASP_FRM_CFG,
 					CS42L42_ASP_FSD_MASK,
 					CS42L42_ASP_FSD_1_0 <<
 					CS42L42_ASP_FSD_SHIFT);
 			/* Set the sample rates (96k or lower) */
-			snd_soc_update_bits(codec, CS42L42_FS_RATE_EN,
+			snd_soc_component_update_bits(component, CS42L42_FS_RATE_EN,
 					CS42L42_FS_EN_MASK,
 					(CS42L42_FS_EN_IASRC_96K |
 					CS42L42_FS_EN_OASRC_96K) <<
 					CS42L42_FS_EN_SHIFT);
 			/* Set the input/output internal MCLK clock ~12 MHz */
-			snd_soc_update_bits(codec, CS42L42_IN_ASRC_CLK,
+			snd_soc_component_update_bits(component, CS42L42_IN_ASRC_CLK,
 					CS42L42_CLK_IASRC_SEL_MASK,
 					CS42L42_CLK_IASRC_SEL_12 <<
 					CS42L42_CLK_IASRC_SEL_SHIFT);
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_OUT_ASRC_CLK,
 					CS42L42_CLK_OASRC_SEL_MASK,
 					CS42L42_CLK_OASRC_SEL_12 <<
 					CS42L42_CLK_OASRC_SEL_SHIFT);
 			/* channel 1 on low LRCLK, 32 bit */
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_ASP_RX_DAI0_CH1_AP_RES,
 					CS42L42_ASP_RX_CH_AP_MASK |
 					CS42L42_ASP_RX_CH_RES_MASK,
@@ -707,7 +705,7 @@ static int cs42l42_pll_config(struct snd_soc_codec *codec)
 					(CS42L42_ASP_RX_CH_RES_32 <<
 					CS42L42_ASP_RX_CH_RES_SHIFT));
 			/* Channel 2 on high LRCLK, 32 bit */
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					CS42L42_ASP_RX_DAI0_CH2_AP_RES,
 					CS42L42_ASP_RX_CH_AP_MASK |
 					CS42L42_ASP_RX_CH_RES_MASK,
@@ -717,50 +715,50 @@ static int cs42l42_pll_config(struct snd_soc_codec *codec)
 					CS42L42_ASP_RX_CH_RES_SHIFT));
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_CTL1,
 					CS42L42_PLL_START_MASK,	0);
 			} else {
 				/* Configure PLL per table 4-5 */
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_DIV_CFG1,
 					CS42L42_SCLK_PREDIV_MASK,
 					pll_ratio_table[i].sclk_prediv
 					<< CS42L42_SCLK_PREDIV_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_DIV_INT,
 					CS42L42_PLL_DIV_INT_MASK,
 					pll_ratio_table[i].pll_div_int
 					<< CS42L42_PLL_DIV_INT_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_DIV_FRAC0,
 					CS42L42_PLL_DIV_FRAC_MASK,
 					CS42L42_FRAC0_VAL(
 					pll_ratio_table[i].pll_div_frac)
 					<< CS42L42_PLL_DIV_FRAC_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_DIV_FRAC1,
 					CS42L42_PLL_DIV_FRAC_MASK,
 					CS42L42_FRAC1_VAL(
 					pll_ratio_table[i].pll_div_frac)
 					<< CS42L42_PLL_DIV_FRAC_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_DIV_FRAC2,
 					CS42L42_PLL_DIV_FRAC_MASK,
 					CS42L42_FRAC2_VAL(
 					pll_ratio_table[i].pll_div_frac)
 					<< CS42L42_PLL_DIV_FRAC_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_CTL4,
 					CS42L42_PLL_MODE_MASK,
 					pll_ratio_table[i].pll_mode
 					<< CS42L42_PLL_MODE_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_CTL3,
 					CS42L42_PLL_DIVOUT_MASK,
 					pll_ratio_table[i].pll_divout
 					<< CS42L42_PLL_DIVOUT_SHIFT);
-				snd_soc_update_bits(codec,
+				snd_soc_component_update_bits(component,
 					CS42L42_PLL_CAL_RATIO,
 					CS42L42_PLL_CAL_RATIO_MASK,
 					pll_ratio_table[i].pll_cal_ratio
@@ -775,7 +773,7 @@ static int cs42l42_pll_config(struct snd_soc_codec *codec)
 
 static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u32 asp_cfg_val = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -820,7 +818,7 @@ static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		break;
 	}
 
-	snd_soc_update_bits(codec, CS42L42_ASP_CLK_CFG,
+	snd_soc_component_update_bits(component, CS42L42_ASP_CLK_CFG,
 				CS42L42_ASP_MODE_MASK |
 				CS42L42_ASP_SCPOL_IN_DAC_MASK |
 				CS42L42_ASP_LCPOL_IN_MASK, asp_cfg_val);
@@ -832,14 +830,14 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cs42l42_private *cs42l42 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int retval;
 
 	cs42l42->srate = params_rate(params);
 	cs42l42->swidth = params_width(params);
 
-	retval = cs42l42_pll_config(codec);
+	retval = cs42l42_pll_config(component);
 
 	return retval;
 }
@@ -847,8 +845,8 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 				int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct cs42l42_private *cs42l42 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 
 	cs42l42->sclk = freq;
 
@@ -857,7 +855,7 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 
 static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int regval;
 	u8 fullScaleVol;
 
@@ -865,25 +863,25 @@ static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 		/* Mark SCLK as not present to turn on the internal
 		 * oscillator.
 		 */
-		snd_soc_update_bits(codec, CS42L42_OSC_SWITCH,
+		snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
 						CS42L42_SCLK_PRESENT_MASK, 0);
 
-		snd_soc_update_bits(codec, CS42L42_PLL_CTL1,
+		snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 				CS42L42_PLL_START_MASK,
 				0 << CS42L42_PLL_START_SHIFT);
 
 		/* Mute the headphone */
-		snd_soc_update_bits(codec, CS42L42_HP_CTL,
+		snd_soc_component_update_bits(component, CS42L42_HP_CTL,
 				CS42L42_HP_ANA_AMUTE_MASK |
 				CS42L42_HP_ANA_BMUTE_MASK,
 				CS42L42_HP_ANA_AMUTE_MASK |
 				CS42L42_HP_ANA_BMUTE_MASK);
 	} else {
-		snd_soc_update_bits(codec, CS42L42_PLL_CTL1,
+		snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 				CS42L42_PLL_START_MASK,
 				1 << CS42L42_PLL_START_SHIFT);
 		/* Read the headphone load */
-		regval = snd_soc_read(codec, CS42L42_LOAD_DET_RCSTAT);
+		regval = snd_soc_component_read32(component, CS42L42_LOAD_DET_RCSTAT);
 		if (((regval & CS42L42_RLA_STAT_MASK) >>
 			CS42L42_RLA_STAT_SHIFT) == CS42L42_RLA_STAT_15_OHM) {
 			fullScaleVol = CS42L42_HP_FULL_SCALE_VOL_MASK;
@@ -892,13 +890,13 @@ static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 		}
 
 		/* Un-mute the headphone, set the full scale volume flag */
-		snd_soc_update_bits(codec, CS42L42_HP_CTL,
+		snd_soc_component_update_bits(component, CS42L42_HP_CTL,
 				CS42L42_HP_ANA_AMUTE_MASK |
 				CS42L42_HP_ANA_BMUTE_MASK |
 				CS42L42_HP_FULL_SCALE_VOL_MASK, fullScaleVol);
 
 		/* Mark SCLK as present, turn off internal oscillator */
-		snd_soc_update_bits(codec, CS42L42_OSC_SWITCH,
+		snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
 				CS42L42_SCLK_PRESENT_MASK,
 				CS42L42_SCLK_PRESENT_MASK);
 	}
@@ -1262,16 +1260,16 @@ static void cs42l42_handle_button_press(struct cs42l42_private *cs42l42)
 
 	switch (bias_level) {
 	case 1: /* Function C button press */
-		dev_dbg(cs42l42->codec->dev, "Function C button press\n");
+		dev_dbg(cs42l42->component->dev, "Function C button press\n");
 		break;
 	case 2: /* Function B button press */
-		dev_dbg(cs42l42->codec->dev, "Function B button press\n");
+		dev_dbg(cs42l42->component->dev, "Function B button press\n");
 		break;
 	case 3: /* Function D button press */
-		dev_dbg(cs42l42->codec->dev, "Function D button press\n");
+		dev_dbg(cs42l42->component->dev, "Function D button press\n");
 		break;
 	case 4: /* Function A button press */
-		dev_dbg(cs42l42->codec->dev, "Function A button press\n");
+		dev_dbg(cs42l42->component->dev, "Function A button press\n");
 		break;
 	}
 
@@ -1340,7 +1338,7 @@ static const struct cs42l42_irq_params irq_params_table[] = {
 static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 {
 	struct cs42l42_private *cs42l42 = (struct cs42l42_private *)data;
-	struct snd_soc_codec *codec = cs42l42->codec;
+	struct snd_soc_component *component = cs42l42->component;
 	unsigned int stickies[12];
 	unsigned int masks[12];
 	unsigned int current_plug_status;
@@ -1372,7 +1370,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	if ((~masks[5]) & irq_params_table[5].mask) {
 		if (stickies[5] & CS42L42_HSDET_AUTO_DONE_MASK) {
 			cs42l42_process_hs_type_detect(cs42l42);
-			dev_dbg(codec->dev,
+			dev_dbg(component->dev,
 				"Auto detect done (%d)\n",
 				cs42l42->hs_type);
 		}
@@ -1392,7 +1390,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 			if (cs42l42->plug_state != CS42L42_TS_UNPLUG) {
 				cs42l42->plug_state = CS42L42_TS_UNPLUG;
 				cs42l42_cancel_hs_type_detect(cs42l42);
-				dev_dbg(codec->dev,
+				dev_dbg(component->dev,
 					"Unplug event\n");
 			}
 			break;
@@ -1410,7 +1408,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, void *data)
 
 			if (current_button_status &
 				CS42L42_M_DETECT_TF_MASK) {
-				dev_dbg(codec->dev,
+				dev_dbg(component->dev,
 					"Button released\n");
 			} else if (current_button_status &
 				CS42L42_M_DETECT_FT_MASK) {
@@ -1879,8 +1877,8 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 	cs42l42_set_interrupt_masks(cs42l42);
 
 	/* Register codec for machine driver */
-	ret =  snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_dev_cs42l42, &cs42l42_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c_client->dev,
+			&soc_component_dev_cs42l42, &cs42l42_dai, 1);
 	if (ret < 0)
 		goto err_disable;
 	return 0;
@@ -1895,8 +1893,6 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 {
 	struct cs42l42_private *cs42l42 = i2c_get_clientdata(i2c_client);
 
-	snd_soc_unregister_codec(&i2c_client->dev);
-
 	/* Hold down reset */
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index d87a0a5322d5..09b0a93203ef 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -754,7 +754,7 @@ static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 
 struct  cs42l42_private {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[CS42L42_NUM_SUPPLIES];
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
-- 
2.16.1
