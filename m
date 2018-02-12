From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9081: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:57 +0000
Message-ID: <E1elDVZ-0005Zk-IZ@debutante>
References: <87shap2wgl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EAD0F267923
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:59 +0100 (CET)
In-Reply-To: <87shap2wgl.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm9081: replace codec to component

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

>From 48c3387642967d62fc47aff4ad0e3816bf8292e3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:09:52 +0000
Subject: [PATCH] ASoC: wm9081: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = true	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming	= 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9081.c | 228 +++++++++++++++++++++++-----------------------
 1 file changed, 112 insertions(+), 116 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 6febef337dd2..52dd610cd8dc 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -339,10 +339,10 @@ static SOC_ENUM_SINGLE_DECL(speaker_mode, WM9081_ANALOGUE_SPEAKER_2, 6,
 static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
+	reg = snd_soc_component_read32(component, WM9081_ANALOGUE_SPEAKER_2);
 	if (reg & WM9081_SPK_MODE)
 		ucontrol->value.enumerated.item[0] = 1;
 	else
@@ -360,9 +360,9 @@ static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	unsigned int reg_pwr = snd_soc_read(codec, WM9081_POWER_MANAGEMENT);
-	unsigned int reg2 = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int reg_pwr = snd_soc_component_read32(component, WM9081_POWER_MANAGEMENT);
+	unsigned int reg2 = snd_soc_component_read32(component, WM9081_ANALOGUE_SPEAKER_2);
 
 	/* Are we changing anything? */
 	if (ucontrol->value.enumerated.item[0] ==
@@ -383,7 +383,7 @@ static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 		reg2 &= ~WM9081_SPK_MODE;
 	}
 
-	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_2, reg2);
+	snd_soc_component_write(component, WM9081_ANALOGUE_SPEAKER_2, reg2);
 
 	return 0;
 }
@@ -546,10 +546,10 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
+static int wm9081_set_fll(struct snd_soc_component *component, int fll_id,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 	u16 reg1, reg4, reg5;
 	struct _fll_div fll_div;
 	int ret;
@@ -561,7 +561,7 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 
 	/* Disable the FLL */
 	if (Fout == 0) {
-		dev_dbg(codec->dev, "FLL disabled\n");
+		dev_dbg(component->dev, "FLL disabled\n");
 		wm9081->fll_fref = 0;
 		wm9081->fll_fout = 0;
 
@@ -572,7 +572,7 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 	if (ret != 0)
 		return ret;
 
-	reg5 = snd_soc_read(codec, WM9081_FLL_CONTROL_5);
+	reg5 = snd_soc_component_read32(component, WM9081_FLL_CONTROL_5);
 	reg5 &= ~WM9081_FLL_CLK_SRC_MASK;
 
 	switch (fll_id) {
@@ -581,55 +581,55 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 		break;
 
 	default:
-		dev_err(codec->dev, "Unknown FLL ID %d\n", fll_id);
+		dev_err(component->dev, "Unknown FLL ID %d\n", fll_id);
 		return -EINVAL;
 	}
 
 	/* Disable CLK_SYS while we reconfigure */
-	clk_sys_reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_3);
+	clk_sys_reg = snd_soc_component_read32(component, WM9081_CLOCK_CONTROL_3);
 	if (clk_sys_reg & WM9081_CLK_SYS_ENA)
-		snd_soc_write(codec, WM9081_CLOCK_CONTROL_3,
+		snd_soc_component_write(component, WM9081_CLOCK_CONTROL_3,
 			     clk_sys_reg & ~WM9081_CLK_SYS_ENA);
 
 	/* Any FLL configuration change requires that the FLL be
 	 * disabled first. */
-	reg1 = snd_soc_read(codec, WM9081_FLL_CONTROL_1);
+	reg1 = snd_soc_component_read32(component, WM9081_FLL_CONTROL_1);
 	reg1 &= ~WM9081_FLL_ENA;
-	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_1, reg1);
 
 	/* Apply the configuration */
 	if (fll_div.k)
 		reg1 |= WM9081_FLL_FRAC_MASK;
 	else
 		reg1 &= ~WM9081_FLL_FRAC_MASK;
-	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_1, reg1);
 
-	snd_soc_write(codec, WM9081_FLL_CONTROL_2,
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_2,
 		     (fll_div.fll_outdiv << WM9081_FLL_OUTDIV_SHIFT) |
 		     (fll_div.fll_fratio << WM9081_FLL_FRATIO_SHIFT));
-	snd_soc_write(codec, WM9081_FLL_CONTROL_3, fll_div.k);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_3, fll_div.k);
 
-	reg4 = snd_soc_read(codec, WM9081_FLL_CONTROL_4);
+	reg4 = snd_soc_component_read32(component, WM9081_FLL_CONTROL_4);
 	reg4 &= ~WM9081_FLL_N_MASK;
 	reg4 |= fll_div.n << WM9081_FLL_N_SHIFT;
-	snd_soc_write(codec, WM9081_FLL_CONTROL_4, reg4);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_4, reg4);
 
 	reg5 &= ~WM9081_FLL_CLK_REF_DIV_MASK;
 	reg5 |= fll_div.fll_clk_ref_div << WM9081_FLL_CLK_REF_DIV_SHIFT;
-	snd_soc_write(codec, WM9081_FLL_CONTROL_5, reg5);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_5, reg5);
 
 	/* Set gain to the recommended value */
-	snd_soc_update_bits(codec, WM9081_FLL_CONTROL_4,
+	snd_soc_component_update_bits(component, WM9081_FLL_CONTROL_4,
 			    WM9081_FLL_GAIN_MASK, 0);
 
 	/* Enable the FLL */
-	snd_soc_write(codec, WM9081_FLL_CONTROL_1, reg1 | WM9081_FLL_ENA);
+	snd_soc_component_write(component, WM9081_FLL_CONTROL_1, reg1 | WM9081_FLL_ENA);
 
 	/* Then bring CLK_SYS up again if it was disabled */
 	if (clk_sys_reg & WM9081_CLK_SYS_ENA)
-		snd_soc_write(codec, WM9081_CLOCK_CONTROL_3, clk_sys_reg);
+		snd_soc_component_write(component, WM9081_CLOCK_CONTROL_3, clk_sys_reg);
 
-	dev_dbg(codec->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
+	dev_dbg(component->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
 
 	wm9081->fll_fref = Fref;
 	wm9081->fll_fout = Fout;
@@ -637,9 +637,9 @@ static int wm9081_set_fll(struct snd_soc_codec *codec, int fll_id,
 	return 0;
 }
 
-static int configure_clock(struct snd_soc_codec *codec)
+static int configure_clock(struct snd_soc_component *component)
 {
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 	int new_sysclk, i, target;
 	unsigned int reg;
 	int ret = 0;
@@ -654,7 +654,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 		} else {
 			wm9081->sysclk_rate = wm9081->mclk_rate;
 		}
-		wm9081_set_fll(codec, WM9081_SYSCLK_FLL_MCLK, 0, 0);
+		wm9081_set_fll(component, WM9081_SYSCLK_FLL_MCLK, 0, 0);
 		break;
 
 	case WM9081_SYSCLK_FLL_MCLK:
@@ -695,7 +695,7 @@ static int configure_clock(struct snd_soc_codec *codec)
 			new_sysclk = 12288000;
 		}
 
-		ret = wm9081_set_fll(codec, WM9081_SYSCLK_FLL_MCLK,
+		ret = wm9081_set_fll(component, WM9081_SYSCLK_FLL_MCLK,
 				     wm9081->mclk_rate, new_sysclk);
 		if (ret == 0) {
 			wm9081->sysclk_rate = new_sysclk;
@@ -711,21 +711,21 @@ static int configure_clock(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_1);
+	reg = snd_soc_component_read32(component, WM9081_CLOCK_CONTROL_1);
 	if (mclkdiv)
 		reg |= WM9081_MCLKDIV2;
 	else
 		reg &= ~WM9081_MCLKDIV2;
-	snd_soc_write(codec, WM9081_CLOCK_CONTROL_1, reg);
+	snd_soc_component_write(component, WM9081_CLOCK_CONTROL_1, reg);
 
-	reg = snd_soc_read(codec, WM9081_CLOCK_CONTROL_3);
+	reg = snd_soc_component_read32(component, WM9081_CLOCK_CONTROL_3);
 	if (fll)
 		reg |= WM9081_CLK_SRC_SEL;
 	else
 		reg &= ~WM9081_CLK_SRC_SEL;
-	snd_soc_write(codec, WM9081_CLOCK_CONTROL_3, reg);
+	snd_soc_component_write(component, WM9081_CLOCK_CONTROL_3, reg);
 
-	dev_dbg(codec->dev, "CLK_SYS is %dHz\n", wm9081->sysclk_rate);
+	dev_dbg(component->dev, "CLK_SYS is %dHz\n", wm9081->sysclk_rate);
 
 	return ret;
 }
@@ -733,31 +733,31 @@ static int configure_clock(struct snd_soc_codec *codec)
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 
 	/* This should be done on init() for bypass paths */
 	switch (wm9081->sysclk_source) {
 	case WM9081_SYSCLK_MCLK:
-		dev_dbg(codec->dev, "Using %dHz MCLK\n", wm9081->mclk_rate);
+		dev_dbg(component->dev, "Using %dHz MCLK\n", wm9081->mclk_rate);
 		break;
 	case WM9081_SYSCLK_FLL_MCLK:
-		dev_dbg(codec->dev, "Using %dHz MCLK with FLL\n",
+		dev_dbg(component->dev, "Using %dHz MCLK with FLL\n",
 			wm9081->mclk_rate);
 		break;
 	default:
-		dev_err(codec->dev, "System clock not configured\n");
+		dev_err(component->dev, "System clock not configured\n");
 		return -EINVAL;
 	}
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		configure_clock(codec);
+		configure_clock(component);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable the FLL if it's running */
-		wm9081_set_fll(codec, 0, 0, 0);
+		wm9081_set_fll(component, 0, 0, 0);
 		break;
 	}
 
@@ -816,10 +816,10 @@ static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 	{ "SPKP", NULL, "Speaker" },
 };
 
-static int wm9081_set_bias_level(struct snd_soc_codec *codec,
+static int wm9081_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -827,31 +827,31 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*40k */
-		snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+		snd_soc_component_update_bits(component, WM9081_VMID_CONTROL,
 				    WM9081_VMID_SEL_MASK, 0x2);
 
 		/* Normal bias current */
-		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+		snd_soc_component_update_bits(component, WM9081_BIAS_CONTROL_1,
 				    WM9081_STBY_BIAS_ENA, 0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Initial cold start */
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_cache_only(wm9081->regmap, false);
 			regcache_sync(wm9081->regmap);
 
 			/* Disable LINEOUT discharge */
-			snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
+			snd_soc_component_update_bits(component, WM9081_ANTI_POP_CONTROL,
 					    WM9081_LINEOUT_DISCH, 0);
 
 			/* Select startup bias source */
-			snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+			snd_soc_component_update_bits(component, WM9081_BIAS_CONTROL_1,
 					    WM9081_BIAS_SRC | WM9081_BIAS_ENA,
 					    WM9081_BIAS_SRC | WM9081_BIAS_ENA);
 
 			/* VMID 2*4k; Soft VMID ramp enable */
-			snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+			snd_soc_component_update_bits(component, WM9081_VMID_CONTROL,
 					    WM9081_VMID_RAMP |
 					    WM9081_VMID_SEL_MASK,
 					    WM9081_VMID_RAMP | 0x6);
@@ -859,37 +859,37 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 			mdelay(100);
 
 			/* Normal bias enable & soft start off */
-			snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+			snd_soc_component_update_bits(component, WM9081_VMID_CONTROL,
 					    WM9081_VMID_RAMP, 0);
 
 			/* Standard bias source */
-			snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+			snd_soc_component_update_bits(component, WM9081_BIAS_CONTROL_1,
 					    WM9081_BIAS_SRC, 0);
 		}
 
 		/* VMID 2*240k */
-		snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+		snd_soc_component_update_bits(component, WM9081_VMID_CONTROL,
 				    WM9081_VMID_SEL_MASK, 0x04);
 
 		/* Standby bias current on */
-		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+		snd_soc_component_update_bits(component, WM9081_BIAS_CONTROL_1,
 				    WM9081_STBY_BIAS_ENA,
 				    WM9081_STBY_BIAS_ENA);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Startup bias source and disable bias */
-		snd_soc_update_bits(codec, WM9081_BIAS_CONTROL_1,
+		snd_soc_component_update_bits(component, WM9081_BIAS_CONTROL_1,
 				    WM9081_BIAS_SRC | WM9081_BIAS_ENA,
 				    WM9081_BIAS_SRC);
 
 		/* Disable VMID with soft ramping */
-		snd_soc_update_bits(codec, WM9081_VMID_CONTROL,
+		snd_soc_component_update_bits(component, WM9081_VMID_CONTROL,
 				    WM9081_VMID_RAMP | WM9081_VMID_SEL_MASK,
 				    WM9081_VMID_RAMP);
 
 		/* Actively discharge LINEOUT */
-		snd_soc_update_bits(codec, WM9081_ANTI_POP_CONTROL,
+		snd_soc_component_update_bits(component, WM9081_ANTI_POP_CONTROL,
 				    WM9081_LINEOUT_DISCH,
 				    WM9081_LINEOUT_DISCH);
 
@@ -903,9 +903,9 @@ static int wm9081_set_bias_level(struct snd_soc_codec *codec,
 static int wm9081_set_dai_fmt(struct snd_soc_dai *dai,
 			      unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
-	unsigned int aif2 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_2);
+	struct snd_soc_component *component = dai->component;
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
+	unsigned int aif2 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_2);
 
 	aif2 &= ~(WM9081_AIF_BCLK_INV | WM9081_AIF_LRCLK_INV |
 		  WM9081_BCLK_DIR | WM9081_LRCLK_DIR | WM9081_AIF_FMT_MASK);
@@ -986,7 +986,7 @@ static int wm9081_set_dai_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
+	snd_soc_component_write(component, WM9081_AUDIO_INTERFACE_2, aif2);
 
 	return 0;
 }
@@ -995,23 +995,23 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 	int ret, i, best, best_val, cur_val;
 	unsigned int clk_ctrl2, aif1, aif2, aif3, aif4;
 
-	clk_ctrl2 = snd_soc_read(codec, WM9081_CLOCK_CONTROL_2);
+	clk_ctrl2 = snd_soc_component_read32(component, WM9081_CLOCK_CONTROL_2);
 	clk_ctrl2 &= ~(WM9081_CLK_SYS_RATE_MASK | WM9081_SAMPLE_RATE_MASK);
 
-	aif1 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_1);
+	aif1 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_1);
 
-	aif2 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_2);
+	aif2 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_2);
 	aif2 &= ~WM9081_AIF_WL_MASK;
 
-	aif3 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_3);
+	aif3 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_3);
 	aif3 &= ~WM9081_BCLK_DIV_MASK;
 
-	aif4 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_4);
+	aif4 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_4);
 	aif4 &= ~WM9081_LRCLK_RATE_MASK;
 
 	wm9081->fs = params_rate(params);
@@ -1047,9 +1047,9 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	dev_dbg(codec->dev, "Target BCLK is %dHz\n", wm9081->bclk);
+	dev_dbg(component->dev, "Target BCLK is %dHz\n", wm9081->bclk);
 
-	ret = configure_clock(codec);
+	ret = configure_clock(component);
 	if (ret != 0)
 		return ret;
 
@@ -1065,7 +1065,7 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected CLK_SYS_RATIO of %d\n",
+	dev_dbg(component->dev, "Selected CLK_SYS_RATIO of %d\n",
 		clk_sys_rates[best].ratio);
 	clk_ctrl2 |= (clk_sys_rates[best].clk_sys_rate
 		      << WM9081_CLK_SYS_RATE_SHIFT);
@@ -1081,7 +1081,7 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected SAMPLE_RATE of %dHz\n",
+	dev_dbg(component->dev, "Selected SAMPLE_RATE of %dHz\n",
 		sample_rates[best].rate);
 	clk_ctrl2 |= (sample_rates[best].sample_rate
 			<< WM9081_SAMPLE_RATE_SHIFT);
@@ -1100,12 +1100,12 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 	wm9081->bclk = (wm9081->sysclk_rate * 10) / bclk_divs[best].div;
-	dev_dbg(codec->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
+	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
 		bclk_divs[best].div, wm9081->bclk);
 	aif3 |= bclk_divs[best].bclk_div;
 
 	/* LRCLK is a simple fraction of BCLK */
-	dev_dbg(codec->dev, "LRCLK_RATE is %d\n", wm9081->bclk / wm9081->fs);
+	dev_dbg(component->dev, "LRCLK_RATE is %d\n", wm9081->bclk / wm9081->fs);
 	aif4 |= wm9081->bclk / wm9081->fs;
 
 	/* Apply a ReTune Mobile configuration if it's in use */
@@ -1126,51 +1126,51 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 		}
 		s = &pdata->retune_configs[best];
 
-		dev_dbg(codec->dev, "ReTune Mobile %s tuned for %dHz\n",
+		dev_dbg(component->dev, "ReTune Mobile %s tuned for %dHz\n",
 			s->name, s->rate);
 
 		/* If the EQ is enabled then disable it while we write out */
-		eq1 = snd_soc_read(codec, WM9081_EQ_1) & WM9081_EQ_ENA;
+		eq1 = snd_soc_component_read32(component, WM9081_EQ_1) & WM9081_EQ_ENA;
 		if (eq1 & WM9081_EQ_ENA)
-			snd_soc_write(codec, WM9081_EQ_1, 0);
+			snd_soc_component_write(component, WM9081_EQ_1, 0);
 
 		/* Write out the other values */
 		for (i = 1; i < ARRAY_SIZE(s->config); i++)
-			snd_soc_write(codec, WM9081_EQ_1 + i, s->config[i]);
+			snd_soc_component_write(component, WM9081_EQ_1 + i, s->config[i]);
 
 		eq1 |= (s->config[0] & ~WM9081_EQ_ENA);
-		snd_soc_write(codec, WM9081_EQ_1, eq1);
+		snd_soc_component_write(component, WM9081_EQ_1, eq1);
 	}
 
-	snd_soc_write(codec, WM9081_CLOCK_CONTROL_2, clk_ctrl2);
-	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_2, aif2);
-	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_3, aif3);
-	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_4, aif4);
+	snd_soc_component_write(component, WM9081_CLOCK_CONTROL_2, clk_ctrl2);
+	snd_soc_component_write(component, WM9081_AUDIO_INTERFACE_2, aif2);
+	snd_soc_component_write(component, WM9081_AUDIO_INTERFACE_3, aif3);
+	snd_soc_component_write(component, WM9081_AUDIO_INTERFACE_4, aif4);
 
 	return 0;
 }
 
 static int wm9081_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	unsigned int reg;
 
-	reg = snd_soc_read(codec, WM9081_DAC_DIGITAL_2);
+	snd_soc_component_read32(component, WM9081_DAC_DIGITAL_2);
 
 	if (mute)
 		reg |= WM9081_DAC_MUTE;
 	else
 		reg &= ~WM9081_DAC_MUTE;
 
-	snd_soc_write(codec, WM9081_DAC_DIGITAL_2, reg);
+	snd_soc_component_write(component, WM9081_DAC_DIGITAL_2, reg);
 
 	return 0;
 }
 
-static int wm9081_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+static int wm9081_set_sysclk(struct snd_soc_component *component, int clk_id,
 			     int source, unsigned int freq, int dir)
 {
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case WM9081_SYSCLK_MCLK:
@@ -1189,9 +1189,9 @@ static int wm9081_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
-	unsigned int aif1 = snd_soc_read(codec, WM9081_AUDIO_INTERFACE_1);
+	struct snd_soc_component *component = dai->component;
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
+	unsigned int aif1 = snd_soc_component_read32(component, WM9081_AUDIO_INTERFACE_1);
 
 	aif1 &= ~(WM9081_AIFDAC_TDM_SLOT_MASK | WM9081_AIFDAC_TDM_MODE_MASK);
 
@@ -1221,7 +1221,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM9081_AUDIO_INTERFACE_1, aif1);
+	snd_soc_component_write(component, WM9081_AUDIO_INTERFACE_1, aif1);
 
 	return 0;
 }
@@ -1254,42 +1254,39 @@ static struct snd_soc_dai_driver wm9081_dai = {
 	.ops = &wm9081_dai_ops,
 };
 
-static int wm9081_probe(struct snd_soc_codec *codec)
+static int wm9081_probe(struct snd_soc_component *component)
 {
-	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	struct wm9081_priv *wm9081 = snd_soc_component_get_drvdata(component);
 
 	/* Enable zero cross by default */
-	snd_soc_update_bits(codec, WM9081_ANALOGUE_LINEOUT,
+	snd_soc_component_update_bits(component, WM9081_ANALOGUE_LINEOUT,
 			    WM9081_LINEOUTZC, WM9081_LINEOUTZC);
-	snd_soc_update_bits(codec, WM9081_ANALOGUE_SPEAKER_PGA,
+	snd_soc_component_update_bits(component, WM9081_ANALOGUE_SPEAKER_PGA,
 			    WM9081_SPKPGAZC, WM9081_SPKPGAZC);
 
 	if (!wm9081->pdata.num_retune_configs) {
-		dev_dbg(codec->dev,
+		dev_dbg(component->dev,
 			"No ReTune Mobile data, using normal EQ\n");
-		snd_soc_add_codec_controls(codec, wm9081_eq_controls,
+		snd_soc_add_component_controls(component, wm9081_eq_controls,
 				     ARRAY_SIZE(wm9081_eq_controls));
 	}
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
-	.probe = 	wm9081_probe,
-
-	.set_sysclk = wm9081_set_sysclk,
-	.set_bias_level = wm9081_set_bias_level,
-
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm9081_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm9081_snd_controls),
-		.dapm_widgets		= wm9081_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm9081_dapm_widgets),
-		.dapm_routes		= wm9081_audio_paths,
-		.num_dapm_routes	= ARRAY_SIZE(wm9081_audio_paths),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm9081 = {
+	.probe			= wm9081_probe,
+	.set_sysclk		= wm9081_set_sysclk,
+	.set_bias_level		= wm9081_set_bias_level,
+	.controls		= wm9081_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm9081_snd_controls),
+	.dapm_widgets		= wm9081_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm9081_dapm_widgets),
+	.dapm_routes		= wm9081_audio_paths,
+	.num_dapm_routes	= ARRAY_SIZE(wm9081_audio_paths),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm9081_regmap = {
@@ -1355,8 +1352,8 @@ static int wm9081_i2c_probe(struct i2c_client *i2c,
 
 	regcache_cache_only(wm9081->regmap, true);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm9081, &wm9081_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm9081, &wm9081_dai, 1);
 	if (ret < 0)
 		return ret;
 
@@ -1365,7 +1362,6 @@ static int wm9081_i2c_probe(struct i2c_client *i2c,
 
 static int wm9081_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
