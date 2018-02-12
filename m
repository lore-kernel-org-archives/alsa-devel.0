From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9713: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:27 +0000
Message-ID: <E1elDV5-0005WD-Ib@debutante>
References: <87mv0x2wep.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D421A267601
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:29 +0100 (CET)
In-Reply-To: <87mv0x2wep.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm9713: replace codec to component

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

>From 807cef2d327a5148d456d9c4966bfb9b2785ffc8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:11:03 +0000
Subject: [PATCH] ASoC: wm9713: replace codec to component

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
 sound/soc/codecs/wm9713.c | 201 ++++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 104 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index df7220656d98..3d6cf0085005 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -196,16 +196,16 @@ SOC_SINGLE("3D Depth", AC97_REC_GAIN_MIC, 0, 15, 1),
 static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
 				 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	if (WARN_ON(event != SND_SOC_DAPM_PRE_PMD))
 		return -EINVAL;
 
 	/* Gracefully shut down the voice interface. */
-	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0200);
+	snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0f00, 0x0200);
 	schedule_timeout_interruptible(msecs_to_jiffies(1));
-	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0f00);
-	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x1000, 0x1000);
+	snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0f00, 0x0f00);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0x1000, 0x1000);
 
 	return 0;
 }
@@ -229,8 +229,8 @@ static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 	unsigned int val = ucontrol->value.integer.value[0];
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -273,8 +273,8 @@ static int wm9713_hp_mixer_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, shift;
@@ -753,7 +753,7 @@ struct _pll_div {
  * to allow rounding later */
 #define FIXED_PLL_SIZE ((1 << 22) * 10)
 
-static void pll_factors(struct snd_soc_codec *codec,
+static void pll_factors(struct snd_soc_component *component,
 	struct _pll_div *pll_div, unsigned int source)
 {
 	u64 Kpart;
@@ -789,7 +789,7 @@ static void pll_factors(struct snd_soc_codec *codec,
 
 	Ndiv = target / source;
 	if ((Ndiv < 5) || (Ndiv > 12))
-		dev_warn(codec->dev,
+		dev_warn(component->dev,
 			"WM9713 PLL N value %u out of recommended range!\n",
 			Ndiv);
 
@@ -815,28 +815,28 @@ static void pll_factors(struct snd_soc_codec *codec,
  * Please note that changing the PLL input frequency may require
  * resynchronisation with the AC97 controller.
  */
-static int wm9713_set_pll(struct snd_soc_codec *codec,
+static int wm9713_set_pll(struct snd_soc_component *component,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 	u16 reg, reg2;
 	struct _pll_div pll_div;
 
 	/* turn PLL off ? */
 	if (freq_in == 0) {
 		/* disable PLL power and select ext source */
-		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0080);
-		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0200);
+		snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0080, 0x0080);
+		snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0x0200, 0x0200);
 		wm9713->pll_in = 0;
 		return 0;
 	}
 
-	pll_factors(codec, &pll_div, freq_in);
+	pll_factors(component, &pll_div, freq_in);
 
 	if (pll_div.k == 0) {
 		reg = (pll_div.n << 12) | (pll_div.lf << 11) |
 			(pll_div.divsel << 9) | (pll_div.divctl << 8);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 	} else {
 		/* write the fractional k to the reg 0x46 pages */
 		reg2 = (pll_div.n << 12) | (pll_div.lf << 11) | (1 << 10) |
@@ -844,31 +844,31 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 
 		/* K [21:20] */
 		reg = reg2 | (0x5 << 4) | (pll_div.k >> 20);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 
 		/* K [19:16] */
 		reg = reg2 | (0x4 << 4) | ((pll_div.k >> 16) & 0xf);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 
 		/* K [15:12] */
 		reg = reg2 | (0x3 << 4) | ((pll_div.k >> 12) & 0xf);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 
 		/* K [11:8] */
 		reg = reg2 | (0x2 << 4) | ((pll_div.k >> 8) & 0xf);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 
 		/* K [7:4] */
 		reg = reg2 | (0x1 << 4) | ((pll_div.k >> 4) & 0xf);
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 
 		reg = reg2 | (0x0 << 4) | (pll_div.k & 0xf); /* K [3:0] */
-		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_component_write(component, AC97_LINE1_LEVEL, reg);
 	}
 
 	/* turn PLL on and select as source */
-	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0000);
-	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0000);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0x0200, 0x0000);
+	snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0080, 0x0000);
 	wm9713->pll_in = freq_in;
 
 	/* wait 10ms AC97 link frames for the link to stabilise */
@@ -879,8 +879,8 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 static int wm9713_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	return wm9713_set_pll(codec, pll_id, freq_in, freq_out);
+	struct snd_soc_component *component = codec_dai->component;
+	return wm9713_set_pll(component, pll_id, freq_in, freq_out);
 }
 
 /*
@@ -890,10 +890,10 @@ static int wm9713_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
 	int tristate)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	if (tristate)
-		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+		snd_soc_component_update_bits(component, AC97_CENTER_LFE_MASTER,
 				    0x6000, 0x0000);
 
 	return 0;
@@ -906,30 +906,30 @@ static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
 static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	switch (div_id) {
 	case WM9713_PCMCLK_DIV:
-		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, div);
+		snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0f00, div);
 		break;
 	case WM9713_CLKA_MULT:
-		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0002, div);
+		snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0002, div);
 		break;
 	case WM9713_CLKB_MULT:
-		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0004, div);
+		snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x0004, div);
 		break;
 	case WM9713_HIFI_DIV:
-		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x7000, div);
+		snd_soc_component_update_bits(component, AC97_HANDSET_RATE, 0x7000, div);
 		break;
 	case WM9713_PCMBCLK_DIV:
-		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER, 0x0e00, div);
+		snd_soc_component_update_bits(component, AC97_CENTER_LFE_MASTER, 0x0e00, div);
 		break;
 	case WM9713_PCMCLK_PLL_DIV:
-		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+		snd_soc_component_update_bits(component, AC97_LINE1_LEVEL,
 				    0x007f, div | 0x60);
 		break;
 	case WM9713_HIFI_PLL_DIV:
-		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+		snd_soc_component_update_bits(component, AC97_LINE1_LEVEL,
 				    0x007f, div | 0x70);
 		break;
 	default:
@@ -942,8 +942,8 @@ static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 gpio = snd_soc_read(codec, AC97_GPIO_CFG) & 0xffc5;
+	struct snd_soc_component *component = codec_dai->component;
+	u16 gpio = snd_soc_component_read32(component, AC97_GPIO_CFG) & 0xffc5;
 	u16 reg = 0x8000;
 
 	/* clock masters */
@@ -996,8 +996,8 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	snd_soc_write(codec, AC97_GPIO_CFG, gpio);
-	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, reg);
+	snd_soc_component_write(component, AC97_GPIO_CFG, gpio);
+	snd_soc_component_write(component, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -1005,22 +1005,22 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
 	/* enable PCM interface in master mode */
 	switch (params_width(params)) {
 	case 16:
 		break;
 	case 20:
-		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+		snd_soc_component_update_bits(component, AC97_CENTER_LFE_MASTER,
 				    0x000c, 0x0004);
 		break;
 	case 24:
-		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+		snd_soc_component_update_bits(component, AC97_CENTER_LFE_MASTER,
 				    0x000c, 0x0008);
 		break;
 	case 32:
-		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+		snd_soc_component_update_bits(component, AC97_CENTER_LFE_MASTER,
 				    0x000c, 0x000c);
 		break;
 	}
@@ -1030,33 +1030,33 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int reg;
 
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return snd_soc_write(codec, reg, runtime->rate);
+	return snd_soc_component_write(component, reg, runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
-	snd_soc_update_bits(codec, AC97_PCI_SID, 0x8000, 0x8000);
+	snd_soc_component_update_bits(component, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
+	snd_soc_component_update_bits(component, AC97_PCI_SID, 0x8000, 0x8000);
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return snd_soc_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return snd_soc_component_write(component, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
 #define WM9713_RATES (SNDRV_PCM_RATE_8000  |	\
@@ -1142,48 +1142,48 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 	},
 };
 
-static int wm9713_set_bias_level(struct snd_soc_codec *codec,
+static int wm9713_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* enable thermal shutdown */
-		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xe400, 0x0000);
+		snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0xe400, 0x0000);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* enable master bias and vmid */
-		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xc400, 0x0000);
-		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0xc400, 0x0000);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
-		snd_soc_write(codec, AC97_EXTENDED_MID, 0xffff);
-		snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_component_write(component, AC97_EXTENDED_MID, 0xffff);
+		snd_soc_component_write(component, AC97_EXTENDED_MSTATUS, 0xffff);
+		snd_soc_component_write(component, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
 }
 
-static int wm9713_soc_suspend(struct snd_soc_codec *codec)
+static int wm9713_soc_suspend(struct snd_soc_component *component)
 {
 	/* Disable everything except touchpanel - that will be handled
 	 * by the touch driver and left disabled if touch is not in
 	 * use. */
-	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
+	snd_soc_component_update_bits(component, AC97_EXTENDED_MID, 0x7fff,
 				 0x7fff);
-	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
-	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
+	snd_soc_component_write(component, AC97_EXTENDED_MSTATUS, 0xffff);
+	snd_soc_component_write(component, AC97_POWERDOWN, 0x6f00);
+	snd_soc_component_write(component, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
 
-static int wm9713_soc_resume(struct snd_soc_codec *codec)
+static int wm9713_soc_resume(struct snd_soc_component *component)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = snd_ac97_reset(wm9713->ac97, true, WM9713_VENDOR_ID,
@@ -1191,24 +1191,24 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	/* do we need to re-start the PLL ? */
 	if (wm9713->pll_in)
-		wm9713_set_pll(codec, 0, wm9713->pll_in, 0);
+		wm9713_set_pll(component, 0, wm9713->pll_in, 0);
 
 	/* only synchronise the codec if warm reset failed */
 	if (ret == 0) {
-		regcache_mark_dirty(codec->component.regmap);
-		snd_soc_cache_sync(codec);
+		regcache_mark_dirty(component->regmap);
+		snd_soc_component_cache_sync(component);
 	}
 
 	return ret;
 }
 
-static int wm9713_soc_probe(struct snd_soc_codec *codec)
+static int wm9713_soc_probe(struct snd_soc_component *component)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = NULL;
 
 	if (wm9713->mfd_pdata) {
@@ -1216,54 +1216,54 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 		regmap = wm9713->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-		wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
+		wm9713->ac97 = snd_soc_new_ac97_component(component, WM9713_VENDOR_ID,
 						      WM9713_VENDOR_ID_MASK);
 		if (IS_ERR(wm9713->ac97))
 			return PTR_ERR(wm9713->ac97);
 		regmap = regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
 		if (IS_ERR(regmap)) {
-			snd_soc_free_ac97_codec(wm9713->ac97);
+			snd_soc_free_ac97_component(wm9713->ac97);
 			return PTR_ERR(regmap);
 		}
 #endif
 	}
 
-	snd_soc_codec_init_regmap(codec, regmap);
+	snd_soc_component_init_regmap(component, regmap);
 
 	/* unmute the adc - move to kcontrol */
-	snd_soc_update_bits(codec, AC97_CD, 0x7fff, 0x0000);
+	snd_soc_component_update_bits(component, AC97_CD, 0x7fff, 0x0000);
 
 	return 0;
 }
 
-static int wm9713_soc_remove(struct snd_soc_codec *codec)
+static void wm9713_soc_remove(struct snd_soc_component *component)
 {
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 
 	if (!wm9713->mfd_pdata) {
-		snd_soc_codec_exit_regmap(codec);
-		snd_soc_free_ac97_codec(wm9713->ac97);
+		snd_soc_component_exit_regmap(component);
+		snd_soc_free_ac97_component(wm9713->ac97);
 	}
 #endif
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
-	.probe = 	wm9713_soc_probe,
-	.remove = 	wm9713_soc_remove,
-	.suspend =	wm9713_soc_suspend,
-	.resume = 	wm9713_soc_resume,
-	.set_bias_level = wm9713_set_bias_level,
-
-	.component_driver = {
-		.controls		= wm9713_snd_ac97_controls,
-		.num_controls		= ARRAY_SIZE(wm9713_snd_ac97_controls),
-		.dapm_widgets		= wm9713_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm9713_dapm_widgets),
-		.dapm_routes		= wm9713_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(wm9713_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm9713 = {
+	.probe			= wm9713_soc_probe,
+	.remove			= wm9713_soc_remove,
+	.suspend		= wm9713_soc_suspend,
+	.resume			= wm9713_soc_resume,
+	.set_bias_level		= wm9713_set_bias_level,
+	.controls		= wm9713_snd_ac97_controls,
+	.num_controls		= ARRAY_SIZE(wm9713_snd_ac97_controls),
+	.dapm_widgets		= wm9713_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm9713_dapm_widgets),
+	.dapm_routes		= wm9713_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(wm9713_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm9713_probe(struct platform_device *pdev)
@@ -1279,14 +1279,8 @@ static int wm9713_probe(struct platform_device *pdev)
 	wm9713->mfd_pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, wm9713);
 
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
-}
-
-static int wm9713_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
 }
 
 static struct platform_driver wm9713_codec_driver = {
@@ -1295,7 +1289,6 @@ static struct platform_driver wm9713_codec_driver = {
 	},
 
 	.probe = wm9713_probe,
-	.remove = wm9713_remove,
 };
 
 module_platform_driver(wm9713_codec_driver);
-- 
2.16.1
