From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8983: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:41 +0000
Message-ID: <E1elDWH-0005hk-0h@debutante>
References: <874ln54b4n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F95267E5C
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:43 +0100 (CET)
In-Reply-To: <874ln54b4n.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8983: replace codec to component

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

>From e3a68fd8a8d19454bbff08bc14b959645601a48d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:07:43 +0000
Subject: [PATCH] ASoC: wm8983: replace codec to component

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
 sound/soc/codecs/wm8983.c | 170 +++++++++++++++++++++-------------------------
 1 file changed, 79 insertions(+), 91 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index bfdbe72ee687..9f35801aa85f 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -492,10 +492,10 @@ static const struct snd_soc_dapm_route wm8983_audio_map[] = {
 static int eqmode_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, WM8983_EQ1_LOW_SHELF);
+	reg = snd_soc_component_read32(component, WM8983_EQ1_LOW_SHELF);
 	if (reg & WM8983_EQ3DMODE)
 		ucontrol->value.enumerated.item[0] = 1;
 	else
@@ -507,7 +507,7 @@ static int eqmode_get(struct snd_kcontrol *kcontrol,
 static int eqmode_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	unsigned int regpwr2, regpwr3;
 	unsigned int reg_eq;
 
@@ -515,7 +515,7 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 	    && ucontrol->value.enumerated.item[0] != 1)
 		return -EINVAL;
 
-	reg_eq = snd_soc_read(codec, WM8983_EQ1_LOW_SHELF);
+	reg_eq = snd_soc_component_read32(component, WM8983_EQ1_LOW_SHELF);
 	switch ((reg_eq & WM8983_EQ3DMODE) >> WM8983_EQ3DMODE_SHIFT) {
 	case 0:
 		if (!ucontrol->value.enumerated.item[0])
@@ -527,21 +527,21 @@ static int eqmode_put(struct snd_kcontrol *kcontrol,
 		break;
 	}
 
-	regpwr2 = snd_soc_read(codec, WM8983_POWER_MANAGEMENT_2);
-	regpwr3 = snd_soc_read(codec, WM8983_POWER_MANAGEMENT_3);
+	regpwr2 = snd_soc_component_read32(component, WM8983_POWER_MANAGEMENT_2);
+	regpwr3 = snd_soc_component_read32(component, WM8983_POWER_MANAGEMENT_3);
 	/* disable the DACs and ADCs */
-	snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_2,
+	snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_2,
 			    WM8983_ADCENR_MASK | WM8983_ADCENL_MASK, 0);
-	snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_3,
+	snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_3,
 			    WM8983_DACENR_MASK | WM8983_DACENL_MASK, 0);
 	/* set the desired eqmode */
-	snd_soc_update_bits(codec, WM8983_EQ1_LOW_SHELF,
+	snd_soc_component_update_bits(component, WM8983_EQ1_LOW_SHELF,
 			    WM8983_EQ3DMODE_MASK,
 			    ucontrol->value.enumerated.item[0]
 			    << WM8983_EQ3DMODE_SHIFT);
 	/* restore DAC/ADC configuration */
-	snd_soc_write(codec, WM8983_POWER_MANAGEMENT_2, regpwr2);
-	snd_soc_write(codec, WM8983_POWER_MANAGEMENT_3, regpwr3);
+	snd_soc_component_write(component, WM8983_POWER_MANAGEMENT_2, regpwr2);
+	snd_soc_component_write(component, WM8983_POWER_MANAGEMENT_3, regpwr3);
 	return 0;
 }
 
@@ -562,16 +562,16 @@ static bool wm8983_writeable(struct device *dev, unsigned int reg)
 
 static int wm8983_dac_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
-	return snd_soc_update_bits(codec, WM8983_DAC_CONTROL,
+	return snd_soc_component_update_bits(component, WM8983_DAC_CONTROL,
 				   WM8983_SOFTMUTE_MASK,
 				   !!mute << WM8983_SOFTMUTE_SHIFT);
 }
 
 static int wm8983_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 format, master, bcp, lrp;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -593,7 +593,7 @@ static int wm8983_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8983_AUDIO_INTERFACE,
+	snd_soc_component_update_bits(component, WM8983_AUDIO_INTERFACE,
 			    WM8983_FMT_MASK, format << WM8983_FMT_SHIFT);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -608,7 +608,7 @@ static int wm8983_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8983_CLOCK_GEN_CONTROL,
+	snd_soc_component_update_bits(component, WM8983_CLOCK_GEN_CONTROL,
 			    WM8983_MS_MASK, master << WM8983_MS_SHIFT);
 
 	/* FIXME: We don't currently support DSP A/B modes */
@@ -639,9 +639,9 @@ static int wm8983_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8983_AUDIO_INTERFACE,
+	snd_soc_component_update_bits(component, WM8983_AUDIO_INTERFACE,
 			    WM8983_LRCP_MASK, lrp << WM8983_LRCP_SHIFT);
-	snd_soc_update_bits(codec, WM8983_AUDIO_INTERFACE,
+	snd_soc_component_update_bits(component, WM8983_AUDIO_INTERFACE,
 			    WM8983_BCP_MASK, bcp << WM8983_BCP_SHIFT);
 	return 0;
 }
@@ -651,8 +651,8 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	int i;
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8983_priv *wm8983 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8983_priv *wm8983 = snd_soc_component_get_drvdata(component);
 	u16 blen, srate_idx;
 	u32 tmp;
 	int srate_best;
@@ -660,7 +660,7 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_params_to_bclk(params);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to convert params to bclk: %d\n", ret);
+		dev_err(component->dev, "Failed to convert params to bclk: %d\n", ret);
 		return ret;
 	}
 
@@ -685,7 +685,7 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8983_AUDIO_INTERFACE,
+	snd_soc_component_update_bits(component, WM8983_AUDIO_INTERFACE,
 			    WM8983_WL_MASK, blen << WM8983_WL_SHIFT);
 
 	/*
@@ -702,7 +702,7 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dev_dbg(dai->dev, "Selected SRATE = %d\n", srates[srate_idx]);
-	snd_soc_update_bits(codec, WM8983_ADDITIONAL_CONTROL,
+	snd_soc_component_update_bits(component, WM8983_ADDITIONAL_CONTROL,
 			    WM8983_SR_MASK, srate_idx << WM8983_SR_SHIFT);
 
 	dev_dbg(dai->dev, "Target BCLK = %uHz\n", wm8983->bclk);
@@ -721,7 +721,7 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dev_dbg(dai->dev, "MCLK ratio = %dfs\n", fs_ratios[i].ratio);
-	snd_soc_update_bits(codec, WM8983_CLOCK_GEN_CONTROL,
+	snd_soc_component_update_bits(component, WM8983_CLOCK_GEN_CONTROL,
 			    WM8983_MCLKDIV_MASK, i << WM8983_MCLKDIV_SHIFT);
 
 	/* select the appropriate bclk divider */
@@ -737,7 +737,7 @@ static int wm8983_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dev_dbg(dai->dev, "BCLK div = %d\n", i);
-	snd_soc_update_bits(codec, WM8983_CLOCK_GEN_CONTROL,
+	snd_soc_component_update_bits(component, WM8983_CLOCK_GEN_CONTROL,
 			    WM8983_BCLKDIV_MASK, i << WM8983_BCLKDIV_SHIFT);
 
 	return 0;
@@ -789,13 +789,13 @@ static int wm8983_set_pll(struct snd_soc_dai *dai, int pll_id,
 			  unsigned int freq_out)
 {
 	int ret;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct pll_div pll_div;
 
-	codec = dai->codec;
+	component = dai->component;
 	if (!freq_in || !freq_out) {
 		/* disable the PLL */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 				    WM8983_PLLEN_MASK, 0);
 		return 0;
 	} else {
@@ -804,19 +804,19 @@ static int wm8983_set_pll(struct snd_soc_dai *dai, int pll_id,
 			return ret;
 
 		/* disable the PLL before re-programming it */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 				    WM8983_PLLEN_MASK, 0);
 
 		/* set PLLN and PRESCALE */
-		snd_soc_write(codec, WM8983_PLL_N,
+		snd_soc_component_write(component, WM8983_PLL_N,
 			(pll_div.div2 << WM8983_PLL_PRESCALE_SHIFT)
 			| pll_div.n);
 		/* set PLLK */
-		snd_soc_write(codec, WM8983_PLL_K_3, pll_div.k & 0x1ff);
-		snd_soc_write(codec, WM8983_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
-		snd_soc_write(codec, WM8983_PLL_K_1, (pll_div.k >> 18));
+		snd_soc_component_write(component, WM8983_PLL_K_3, pll_div.k & 0x1ff);
+		snd_soc_component_write(component, WM8983_PLL_K_2, (pll_div.k >> 9) & 0x1ff);
+		snd_soc_component_write(component, WM8983_PLL_K_1, (pll_div.k >> 18));
 		/* enable the PLL */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 					WM8983_PLLEN_MASK, WM8983_PLLEN);
 	}
 
@@ -826,16 +826,16 @@ static int wm8983_set_pll(struct snd_soc_dai *dai, int pll_id,
 static int wm8983_set_sysclk(struct snd_soc_dai *dai,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8983_priv *wm8983 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8983_priv *wm8983 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case WM8983_CLKSRC_MCLK:
-		snd_soc_update_bits(codec, WM8983_CLOCK_GEN_CONTROL,
+		snd_soc_component_update_bits(component, WM8983_CLOCK_GEN_CONTROL,
 				    WM8983_CLKSEL_MASK, 0);
 		break;
 	case WM8983_CLKSRC_PLL:
-		snd_soc_update_bits(codec, WM8983_CLOCK_GEN_CONTROL,
+		snd_soc_component_update_bits(component, WM8983_CLOCK_GEN_CONTROL,
 				    WM8983_CLKSEL_MASK, WM8983_CLKSEL);
 		break;
 	default:
@@ -847,100 +847,100 @@ static int wm8983_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int wm8983_set_bias_level(struct snd_soc_codec *codec,
+static int wm8983_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8983_priv *wm8983 = snd_soc_codec_get_drvdata(codec);
+	struct wm8983_priv *wm8983 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID at 100k */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 				    WM8983_VMIDSEL_MASK,
 				    1 << WM8983_VMIDSEL_SHIFT);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regcache_sync(wm8983->regmap);
 			if (ret < 0) {
-				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
+				dev_err(component->dev, "Failed to sync cache: %d\n", ret);
 				return ret;
 			}
 			/* enable anti-pop features */
-			snd_soc_update_bits(codec, WM8983_OUT4_TO_ADC,
+			snd_soc_component_update_bits(component, WM8983_OUT4_TO_ADC,
 					    WM8983_POBCTRL_MASK | WM8983_DELEN_MASK,
 					    WM8983_POBCTRL | WM8983_DELEN);
 			/* enable thermal shutdown */
-			snd_soc_update_bits(codec, WM8983_OUTPUT_CTRL,
+			snd_soc_component_update_bits(component, WM8983_OUTPUT_CTRL,
 					    WM8983_TSDEN_MASK, WM8983_TSDEN);
 			/* enable BIASEN */
-			snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 					    WM8983_BIASEN_MASK, WM8983_BIASEN);
 			/* VMID at 100k */
-			snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+			snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 					    WM8983_VMIDSEL_MASK,
 					    1 << WM8983_VMIDSEL_SHIFT);
 			msleep(250);
 			/* disable anti-pop features */
-			snd_soc_update_bits(codec, WM8983_OUT4_TO_ADC,
+			snd_soc_component_update_bits(component, WM8983_OUT4_TO_ADC,
 					    WM8983_POBCTRL_MASK |
 					    WM8983_DELEN_MASK, 0);
 		}
 
 		/* VMID at 500k */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 				    WM8983_VMIDSEL_MASK,
 				    2 << WM8983_VMIDSEL_SHIFT);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable thermal shutdown */
-		snd_soc_update_bits(codec, WM8983_OUTPUT_CTRL,
+		snd_soc_component_update_bits(component, WM8983_OUTPUT_CTRL,
 				    WM8983_TSDEN_MASK, 0);
 		/* disable VMIDSEL and BIASEN */
-		snd_soc_update_bits(codec, WM8983_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8983_POWER_MANAGEMENT_1,
 				    WM8983_VMIDSEL_MASK | WM8983_BIASEN_MASK,
 				    0);
 		/* wait for VMID to discharge */
 		msleep(100);
-		snd_soc_write(codec, WM8983_POWER_MANAGEMENT_1, 0);
-		snd_soc_write(codec, WM8983_POWER_MANAGEMENT_2, 0);
-		snd_soc_write(codec, WM8983_POWER_MANAGEMENT_3, 0);
+		snd_soc_component_write(component, WM8983_POWER_MANAGEMENT_1, 0);
+		snd_soc_component_write(component, WM8983_POWER_MANAGEMENT_2, 0);
+		snd_soc_component_write(component, WM8983_POWER_MANAGEMENT_3, 0);
 		break;
 	}
 
 	return 0;
 }
 
-static int wm8983_probe(struct snd_soc_codec *codec)
+static int wm8983_probe(struct snd_soc_component *component)
 {
 	int ret;
 	int i;
 
-	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0);
+	ret = snd_soc_component_write(component, WM8983_SOFTWARE_RESET, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(component->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
 	}
 
 	/* set the vol/gain update bits */
 	for (i = 0; i < ARRAY_SIZE(vol_update_regs); ++i)
-		snd_soc_update_bits(codec, vol_update_regs[i],
+		snd_soc_component_update_bits(component, vol_update_regs[i],
 				    0x100, 0x100);
 
 	/* mute all outputs and set PGAs to minimum gain */
 	for (i = WM8983_LOUT1_HP_VOLUME_CTRL;
 	     i <= WM8983_OUT4_MONO_MIX_CTRL; ++i)
-		snd_soc_update_bits(codec, i, 0x40, 0x40);
+		snd_soc_component_update_bits(component, i, 0x40, 0x40);
 
 	/* enable soft mute */
-	snd_soc_update_bits(codec, WM8983_DAC_CONTROL,
+	snd_soc_component_update_bits(component, WM8983_DAC_CONTROL,
 			    WM8983_SOFTMUTE_MASK,
 			    WM8983_SOFTMUTE);
 
 	/* enable BIASCUT */
-	snd_soc_update_bits(codec, WM8983_BIAS_CTRL,
+	snd_soc_component_update_bits(component, WM8983_BIAS_CTRL,
 			    WM8983_BIASCUT, WM8983_BIASCUT);
 	return 0;
 }
@@ -976,18 +976,20 @@ static struct snd_soc_dai_driver wm8983_dai = {
 	.symmetric_rates = 1
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8983 = {
-	.probe = wm8983_probe,
-	.set_bias_level = wm8983_set_bias_level,
-	.suspend_bias_off = true,
-	.component_driver = {
-		.controls		= wm8983_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8983_snd_controls),
-		.dapm_widgets		= wm8983_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8983_dapm_widgets),
-		.dapm_routes		= wm8983_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(wm8983_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8983 = {
+	.probe			= wm8983_probe,
+	.set_bias_level		= wm8983_set_bias_level,
+	.controls		= wm8983_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8983_snd_controls),
+	.dapm_widgets		= wm8983_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8983_dapm_widgets),
+	.dapm_routes		= wm8983_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(wm8983_audio_map),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8983_regmap = {
@@ -1021,23 +1023,16 @@ static int wm8983_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8983);
 
-	ret = snd_soc_register_codec(&spi->dev,
-				     &soc_codec_dev_wm8983, &wm8983_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+				&soc_component_dev_wm8983, &wm8983_dai, 1);
 	return ret;
 }
 
-static int wm8983_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver wm8983_spi_driver = {
 	.driver = {
 		.name = "wm8983",
 	},
 	.probe = wm8983_spi_probe,
-	.remove = wm8983_spi_remove
 };
 #endif
 
@@ -1061,18 +1056,12 @@ static int wm8983_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8983);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-				     &soc_codec_dev_wm8983, &wm8983_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				&soc_component_dev_wm8983, &wm8983_dai, 1);
 
 	return ret;
 }
 
-static int wm8983_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8983_i2c_id[] = {
 	{ "wm8983", 0 },
 	{ }
@@ -1084,7 +1073,6 @@ static struct i2c_driver wm8983_i2c_driver = {
 		.name = "wm8983",
 	},
 	.probe = wm8983_i2c_probe,
-	.remove = wm8983_i2c_remove,
 	.id_table = wm8983_i2c_id
 };
 #endif
-- 
2.16.1
