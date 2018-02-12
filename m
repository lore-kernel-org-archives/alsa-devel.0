From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7210: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:42:49 +0000
Message-ID: <E1elDRZ-0004xj-Kw@debutante>
References: <87zi4xz55f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ED33E267CA9
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:42:51 +0100 (CET)
In-Reply-To: <87zi4xz55f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: da7210: replace codec to component

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

>From d06f33aed85cf73703555879157bf33866f8af05 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:01:06 +0000
Subject: [PATCH] ASoC: da7210: replace codec to component

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
 sound/soc/codecs/da7210.c | 181 +++++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 97 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 1af443ccbc51..07153be52c52 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -331,12 +331,12 @@ static SOC_ENUM_SINGLE_DECL(da7210_hp_mode_sel,
 static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 
 	if (ucontrol->value.integer.value[0]) {
 		/* Check if noise suppression is enabled */
-		if (snd_soc_read(codec, DA7210_CONTROL) & DA7210_NOISE_SUP_EN) {
-			dev_dbg(codec->dev,
+		if (snd_soc_component_read32(component, DA7210_CONTROL) & DA7210_NOISE_SUP_EN) {
+			dev_dbg(component->dev,
 				"Disable noise suppression to enable ALC\n");
 			return -EINVAL;
 		}
@@ -354,32 +354,32 @@ static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
 static int da7210_put_noise_sup_sw(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	u8 val;
 
 	if (ucontrol->value.integer.value[0]) {
 		/* Check if ALC is enabled */
-		if (snd_soc_read(codec, DA7210_ADC) & DA7210_ADC_ALC_EN)
+		if (snd_soc_component_read32(component, DA7210_ADC) & DA7210_ADC_ALC_EN)
 			goto err;
 
 		/* Check ZC for HP and AUX1 PGA */
-		if ((snd_soc_read(codec, DA7210_ZERO_CROSS) &
+		if ((snd_soc_component_read32(component, DA7210_ZERO_CROSS) &
 			(DA7210_AUX1_L_ZC | DA7210_AUX1_R_ZC | DA7210_HP_L_ZC |
 			DA7210_HP_R_ZC)) != (DA7210_AUX1_L_ZC |
 			DA7210_AUX1_R_ZC | DA7210_HP_L_ZC | DA7210_HP_R_ZC))
 			goto err;
 
 		/* Check INPGA_L_VOL and INPGA_R_VOL */
-		val = snd_soc_read(codec, DA7210_IN_GAIN);
+		val = snd_soc_component_read32(component, DA7210_IN_GAIN);
 		if (((val & DA7210_INPGA_L_VOL) < DA7210_INPGA_MIN_VOL_NS) ||
 			(((val & DA7210_INPGA_R_VOL) >> 4) <
 			DA7210_INPGA_MIN_VOL_NS))
 			goto err;
 
 		/* Check AUX1_L_VOL and AUX1_R_VOL */
-		if (((snd_soc_read(codec, DA7210_AUX1_L) & DA7210_AUX1_L_VOL) <
+		if (((snd_soc_component_read32(component, DA7210_AUX1_L) & DA7210_AUX1_L_VOL) <
 		    DA7210_AUX1_MIN_VOL_NS) ||
-		    ((snd_soc_read(codec, DA7210_AUX1_R) & DA7210_AUX1_R_VOL) <
+		    ((snd_soc_component_read32(component, DA7210_AUX1_R) & DA7210_AUX1_R_VOL) <
 		    DA7210_AUX1_MIN_VOL_NS))
 			goto err;
 	}
@@ -760,19 +760,19 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct da7210_priv *da7210 = snd_soc_component_get_drvdata(component);
 	u32 dai_cfg1;
 	u32 fs, sysclk;
 
 	/* set DAI source to Left and Right ADC */
-	snd_soc_write(codec, DA7210_DAI_SRC_SEL,
+	snd_soc_component_write(component, DA7210_DAI_SRC_SEL,
 		     DA7210_DAI_OUT_R_SRC | DA7210_DAI_OUT_L_SRC);
 
 	/* Enable DAI */
-	snd_soc_write(codec, DA7210_DAI_CFG3, DA7210_DAI_OE | DA7210_DAI_EN);
+	snd_soc_component_write(component, DA7210_DAI_CFG3, DA7210_DAI_OE | DA7210_DAI_EN);
 
-	dai_cfg1 = 0xFC & snd_soc_read(codec, DA7210_DAI_CFG1);
+	dai_cfg1 = 0xFC & snd_soc_component_read32(component, DA7210_DAI_CFG1);
 
 	switch (params_width(params)) {
 	case 16:
@@ -791,7 +791,7 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, DA7210_DAI_CFG1, dai_cfg1);
+	snd_soc_component_write(component, DA7210_DAI_CFG1, dai_cfg1);
 
 	switch (params_rate(params)) {
 	case 8000:
@@ -839,17 +839,17 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Disable active mode */
-	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
+	snd_soc_component_update_bits(component, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
 
-	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_FS_MASK, fs);
+	snd_soc_component_update_bits(component, DA7210_PLL, DA7210_PLL_FS_MASK, fs);
 
 	if (da7210->mclk_rate && (da7210->mclk_rate != sysclk)) {
 		/* PLL mode, disable PLL bypass */
-		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
+		snd_soc_component_update_bits(component, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
 
 		if (!da7210->master) {
 			/* PLL slave mode, also enable SRM */
-			snd_soc_update_bits(codec, DA7210_PLL,
+			snd_soc_component_update_bits(component, DA7210_PLL,
 						   (DA7210_MCLK_SRM_EN |
 						    DA7210_MCLK_DET_EN),
 						   (DA7210_MCLK_SRM_EN |
@@ -857,13 +857,13 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 		}
 	} else {
 		/* PLL bypass mode, enable PLL bypass and Auto Detection */
-		snd_soc_update_bits(codec, DA7210_PLL, DA7210_MCLK_DET_EN,
+		snd_soc_component_update_bits(component, DA7210_PLL, DA7210_MCLK_DET_EN,
 						       DA7210_MCLK_DET_EN);
-		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP,
+		snd_soc_component_update_bits(component, DA7210_PLL_DIV3, DA7210_PLL_BYP,
 							    DA7210_PLL_BYP);
 	}
 	/* Enable active mode */
-	snd_soc_update_bits(codec, DA7210_STARTUP1,
+	snd_soc_component_update_bits(component, DA7210_STARTUP1,
 			    DA7210_SC_MST_EN, DA7210_SC_MST_EN);
 
 	return 0;
@@ -874,16 +874,16 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
  */
 static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct da7210_priv *da7210 = snd_soc_component_get_drvdata(component);
 	u32 dai_cfg1;
 	u32 dai_cfg3;
 
-	dai_cfg1 = 0x7f & snd_soc_read(codec, DA7210_DAI_CFG1);
-	dai_cfg3 = 0xfc & snd_soc_read(codec, DA7210_DAI_CFG3);
+	dai_cfg1 = 0x7f & snd_soc_component_read32(component, DA7210_DAI_CFG1);
+	dai_cfg3 = 0xfc & snd_soc_component_read32(component, DA7210_DAI_CFG3);
 
-	if ((snd_soc_read(codec, DA7210_PLL) & DA7210_PLL_EN) &&
-		(!(snd_soc_read(codec, DA7210_PLL_DIV3) & DA7210_PLL_BYP)))
+	if ((snd_soc_component_read32(component, DA7210_PLL) & DA7210_PLL_EN) &&
+		(!(snd_soc_component_read32(component, DA7210_PLL_DIV3) & DA7210_PLL_BYP)))
 		return -EINVAL;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -923,21 +923,21 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 	 */
 	dai_cfg1 |= DA7210_DAI_FLEN_64BIT;
 
-	snd_soc_write(codec, DA7210_DAI_CFG1, dai_cfg1);
-	snd_soc_write(codec, DA7210_DAI_CFG3, dai_cfg3);
+	snd_soc_component_write(component, DA7210_DAI_CFG1, dai_cfg1);
+	snd_soc_component_write(component, DA7210_DAI_CFG3, dai_cfg3);
 
 	return 0;
 }
 
 static int da7210_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u8 mute_reg = snd_soc_read(codec, DA7210_DAC_HPF) & 0xFB;
+	struct snd_soc_component *component = dai->component;
+	u8 mute_reg = snd_soc_component_read32(component, DA7210_DAC_HPF) & 0xFB;
 
 	if (mute)
-		snd_soc_write(codec, DA7210_DAC_HPF, mute_reg | 0x4);
+		snd_soc_component_write(component, DA7210_DAC_HPF, mute_reg | 0x4);
 	else
-		snd_soc_write(codec, DA7210_DAC_HPF, mute_reg);
+		snd_soc_component_write(component, DA7210_DAC_HPF, mute_reg);
 	return 0;
 }
 
@@ -947,8 +947,8 @@ static int da7210_mute(struct snd_soc_dai *dai, int mute)
 static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct da7210_priv *da7210 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case DA7210_CLKSRC_MCLK:
@@ -988,8 +988,8 @@ static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			      int source, unsigned int fref, unsigned int fout)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct da7210_priv *da7210 = snd_soc_component_get_drvdata(component);
 
 	u8 pll_div1, pll_div2, pll_div3, cnt;
 
@@ -1014,18 +1014,18 @@ static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		goto err;
 
 	/* Disable active mode */
-	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
+	snd_soc_component_update_bits(component, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
 	/* Write PLL dividers */
-	snd_soc_write(codec, DA7210_PLL_DIV1, pll_div1);
-	snd_soc_write(codec, DA7210_PLL_DIV2, pll_div2);
-	snd_soc_update_bits(codec, DA7210_PLL_DIV3,
+	snd_soc_component_write(component, DA7210_PLL_DIV1, pll_div1);
+	snd_soc_component_write(component, DA7210_PLL_DIV2, pll_div2);
+	snd_soc_component_update_bits(component, DA7210_PLL_DIV3,
 				   DA7210_PLL_DIV_L_MASK, pll_div3);
 
 	/* Enable PLL */
-	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
+	snd_soc_component_update_bits(component, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
 
 	/* Enable active mode */
-	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN,
+	snd_soc_component_update_bits(component, DA7210_STARTUP1, DA7210_SC_MST_EN,
 						    DA7210_SC_MST_EN);
 	return 0;
 err:
@@ -1064,53 +1064,53 @@ static struct snd_soc_dai_driver da7210_dai = {
 	.symmetric_rates = 1,
 };
 
-static int da7210_probe(struct snd_soc_codec *codec)
+static int da7210_probe(struct snd_soc_component *component)
 {
-	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	struct da7210_priv *da7210 = snd_soc_component_get_drvdata(component);
 
-	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
+	dev_info(component->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
 	da7210->mclk_rate       = 0;    /* This will be set from set_sysclk() */
 	da7210->master          = 0;    /* This will be set from set_fmt() */
 
 	/* Enable internal regulator & bias current */
-	snd_soc_write(codec, DA7210_CONTROL, DA7210_REG_EN | DA7210_BIAS_EN);
+	snd_soc_component_write(component, DA7210_CONTROL, DA7210_REG_EN | DA7210_BIAS_EN);
 
 	/*
 	 * ADC settings
 	 */
 
 	/* Enable Left & Right MIC PGA and Mic Bias */
-	snd_soc_write(codec, DA7210_MIC_L, DA7210_MIC_L_EN | DA7210_MICBIAS_EN);
-	snd_soc_write(codec, DA7210_MIC_R, DA7210_MIC_R_EN);
+	snd_soc_component_write(component, DA7210_MIC_L, DA7210_MIC_L_EN | DA7210_MICBIAS_EN);
+	snd_soc_component_write(component, DA7210_MIC_R, DA7210_MIC_R_EN);
 
 	/* Enable Left and Right input PGA */
-	snd_soc_write(codec, DA7210_INMIX_L, DA7210_IN_L_EN);
-	snd_soc_write(codec, DA7210_INMIX_R, DA7210_IN_R_EN);
+	snd_soc_component_write(component, DA7210_INMIX_L, DA7210_IN_L_EN);
+	snd_soc_component_write(component, DA7210_INMIX_R, DA7210_IN_R_EN);
 
 	/* Enable Left and Right ADC */
-	snd_soc_write(codec, DA7210_ADC, DA7210_ADC_L_EN | DA7210_ADC_R_EN);
+	snd_soc_component_write(component, DA7210_ADC, DA7210_ADC_L_EN | DA7210_ADC_R_EN);
 
 	/*
 	 * DAC settings
 	 */
 
 	/* Enable Left and Right DAC */
-	snd_soc_write(codec, DA7210_DAC_SEL,
+	snd_soc_component_write(component, DA7210_DAC_SEL,
 		     DA7210_DAC_L_SRC_DAI_L | DA7210_DAC_L_EN |
 		     DA7210_DAC_R_SRC_DAI_R | DA7210_DAC_R_EN);
 
 	/* Enable Left and Right out PGA */
-	snd_soc_write(codec, DA7210_OUTMIX_L, DA7210_OUT_L_EN);
-	snd_soc_write(codec, DA7210_OUTMIX_R, DA7210_OUT_R_EN);
+	snd_soc_component_write(component, DA7210_OUTMIX_L, DA7210_OUT_L_EN);
+	snd_soc_component_write(component, DA7210_OUTMIX_R, DA7210_OUT_R_EN);
 
 	/* Enable Left and Right HeadPhone PGA */
-	snd_soc_write(codec, DA7210_HP_CFG,
+	snd_soc_component_write(component, DA7210_HP_CFG,
 		     DA7210_HP_2CAP_MODE | DA7210_HP_SENSE_EN |
 		     DA7210_HP_L_EN | DA7210_HP_MODE | DA7210_HP_R_EN);
 
 	/* Enable ramp mode for DAC gain update */
-	snd_soc_write(codec, DA7210_SOFTMUTE, DA7210_RAMP_EN);
+	snd_soc_component_write(component, DA7210_SOFTMUTE, DA7210_RAMP_EN);
 
 	/*
 	 * For DA7210 codec, there are two ways to enable/disable analog IOs
@@ -1138,43 +1138,44 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	 */
 
 	/* Enable Line out amplifiers */
-	snd_soc_write(codec, DA7210_OUT1_L, DA7210_OUT1_L_EN);
-	snd_soc_write(codec, DA7210_OUT1_R, DA7210_OUT1_R_EN);
-	snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
+	snd_soc_component_write(component, DA7210_OUT1_L, DA7210_OUT1_L_EN);
+	snd_soc_component_write(component, DA7210_OUT1_R, DA7210_OUT1_R_EN);
+	snd_soc_component_write(component, DA7210_OUT2, DA7210_OUT2_EN |
 		     DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
 
 	/* Enable Aux1 */
-	snd_soc_write(codec, DA7210_AUX1_L, DA7210_AUX1_L_EN);
-	snd_soc_write(codec, DA7210_AUX1_R, DA7210_AUX1_R_EN);
+	snd_soc_component_write(component, DA7210_AUX1_L, DA7210_AUX1_L_EN);
+	snd_soc_component_write(component, DA7210_AUX1_R, DA7210_AUX1_R_EN);
 	/* Enable Aux2 */
-	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
+	snd_soc_component_write(component, DA7210_AUX2, DA7210_AUX2_EN);
 
 	/* Set PLL Master clock range 10-20 MHz, enable PLL bypass */
-	snd_soc_write(codec, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ |
+	snd_soc_component_write(component, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ |
 					      DA7210_PLL_BYP);
 
 	/* Diable PLL and bypass it */
-	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
+	snd_soc_component_write(component, DA7210_PLL, DA7210_PLL_FS_48000);
 
 	/* Activate all enabled subsystem */
-	snd_soc_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
+	snd_soc_component_write(component, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
-	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
+	dev_info(component->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_da7210 = {
+static const struct snd_soc_component_driver soc_component_dev_da7210 = {
 	.probe			= da7210_probe,
-
-	.component_driver = {
-		.controls		= da7210_snd_controls,
-		.num_controls		= ARRAY_SIZE(da7210_snd_controls),
-		.dapm_widgets		= da7210_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(da7210_dapm_widgets),
-		.dapm_routes		= da7210_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
-	},
+	.controls		= da7210_snd_controls,
+	.num_controls		= ARRAY_SIZE(da7210_snd_controls),
+	.dapm_widgets		= da7210_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(da7210_dapm_widgets),
+	.dapm_routes		= da7210_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(da7210_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 #if IS_ENABLED(CONFIG_I2C)
@@ -1232,20 +1233,14 @@ static int da7210_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_da7210, &da7210_dai, 1);
+	ret =  snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_da7210, &da7210_dai, 1);
 	if (ret < 0)
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 
 	return ret;
 }
 
-static int da7210_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id da7210_i2c_id[] = {
 	{ "da7210", 0 },
 	{ }
@@ -1258,7 +1253,6 @@ static struct i2c_driver da7210_i2c_driver = {
 		.name = "da7210",
 	},
 	.probe		= da7210_i2c_probe,
-	.remove		= da7210_i2c_remove,
 	.id_table	= da7210_i2c_id,
 };
 #endif
@@ -1325,24 +1319,17 @@ static int da7210_spi_probe(struct spi_device *spi)
 	if (ret != 0)
 		dev_warn(&spi->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_da7210, &da7210_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_da7210, &da7210_dai, 1);
 
 	return ret;
 }
 
-static int da7210_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver da7210_spi_driver = {
 	.driver = {
 		.name = "da7210",
 	},
 	.probe = da7210_spi_probe,
-	.remove = da7210_spi_remove
 };
 #endif
 
-- 
2.16.1
