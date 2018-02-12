From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8900: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:48:22 +0000
Message-ID: <E1elDWw-00061T-6A@debutante>
References: <87inbl4b9c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A302267AD4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:48:24 +0100 (CET)
In-Reply-To: <87inbl4b9c.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8900: replace codec to component

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

>From 825a52aa768352920b631208cd03250869609936 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:04:55 +0000
Subject: [PATCH] ASoC: wm8900: replace codec to component

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
 sound/soc/codecs/wm8900.c | 251 +++++++++++++++++++++++-----------------------
 1 file changed, 125 insertions(+), 126 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index c77b49a29311..1a14e902949d 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -216,23 +216,23 @@ static bool wm8900_volatile_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static void wm8900_reset(struct snd_soc_codec *codec)
+static void wm8900_reset(struct snd_soc_component *component)
 {
-	snd_soc_write(codec, WM8900_REG_RESET, 0);
+	snd_soc_component_write(component, WM8900_REG_RESET, 0);
 }
 
 static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 hpctl1 = snd_soc_read(codec, WM8900_REG_HPCTL1);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 hpctl1 = snd_soc_component_read32(component, WM8900_REG_HPCTL1);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Clamp headphone outputs */
 		hpctl1 = WM8900_REG_HPCTL1_HP_CLAMP_IP |
 			WM8900_REG_HPCTL1_HP_CLAMP_OP;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -241,41 +241,41 @@ static int wm8900_hp_event(struct snd_soc_dapm_widget *w,
 		hpctl1 |= WM8900_REG_HPCTL1_HP_SHORT |
 			WM8900_REG_HPCTL1_HP_SHORT2 |
 			WM8900_REG_HPCTL1_HP_IPSTAGE_ENA;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 
 		msleep(400);
 
 		/* Enable the output stage */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_CLAMP_OP;
 		hpctl1 |= WM8900_REG_HPCTL1_HP_OPSTAGE_ENA;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Remove the shorts */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_SHORT2;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_SHORT;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Short the output */
 		hpctl1 |= WM8900_REG_HPCTL1_HP_SHORT;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Disable the output stage */
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_OPSTAGE_ENA;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 
 		/* Clamp the outputs and power down input */
 		hpctl1 |= WM8900_REG_HPCTL1_HP_CLAMP_IP |
 			WM8900_REG_HPCTL1_HP_CLAMP_OP;
 		hpctl1 &= ~WM8900_REG_HPCTL1_HP_IPSTAGE_ENA;
-		snd_soc_write(codec, WM8900_REG_HPCTL1, hpctl1);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, hpctl1);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
 		/* Disable everything */
-		snd_soc_write(codec, WM8900_REG_HPCTL1, 0);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, 0);
 		break;
 
 	default:
@@ -635,10 +635,10 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 reg;
 
-	reg = snd_soc_read(codec, WM8900_REG_AUDIO1) & ~0x60;
+	reg = snd_soc_component_read32(component, WM8900_REG_AUDIO1) & ~0x60;
 
 	switch (params_width(params)) {
 	case 16:
@@ -656,17 +656,17 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8900_REG_AUDIO1, reg);
+	snd_soc_component_write(component, WM8900_REG_AUDIO1, reg);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
+		reg = snd_soc_component_read32(component, WM8900_REG_DACCTRL);
 
 		if (params_rate(params) <= 24000)
 			reg |= WM8900_REG_DACCTRL_DAC_SB_FILT;
 		else
 			reg &= ~WM8900_REG_DACCTRL_DAC_SB_FILT;
 
-		snd_soc_write(codec, WM8900_REG_DACCTRL, reg);
+		snd_soc_component_write(component, WM8900_REG_DACCTRL, reg);
 	}
 
 	return 0;
@@ -751,24 +751,24 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm8900_set_fll(struct snd_soc_codec *codec,
+static int wm8900_set_fll(struct snd_soc_component *component,
 	int fll_id, unsigned int freq_in, unsigned int freq_out)
 {
-	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
+	struct wm8900_priv *wm8900 = snd_soc_component_get_drvdata(component);
 	struct _fll_div fll_div;
 
 	if (wm8900->fll_in == freq_in && wm8900->fll_out == freq_out)
 		return 0;
 
 	/* The digital side should be disabled during any change. */
-	snd_soc_update_bits(codec, WM8900_REG_POWER1,
+	snd_soc_component_update_bits(component, WM8900_REG_POWER1,
 			    WM8900_REG_POWER1_FLL_ENA, 0);
 
 	/* Disable the FLL? */
 	if (!freq_in || !freq_out) {
-		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+		snd_soc_component_update_bits(component, WM8900_REG_CLOCKING1,
 				    WM8900_REG_CLOCKING1_MCLK_SRC, 0);
-		snd_soc_update_bits(codec, WM8900_REG_FLLCTL1,
+		snd_soc_component_update_bits(component, WM8900_REG_FLLCTL1,
 				    WM8900_REG_FLLCTL1_OSC_ENA, 0);
 		wm8900->fll_in = freq_in;
 		wm8900->fll_out = freq_out;
@@ -784,32 +784,32 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 
 	/* The osclilator *MUST* be enabled before we enable the
 	 * digital circuit. */
-	snd_soc_write(codec, WM8900_REG_FLLCTL1,
+	snd_soc_component_write(component, WM8900_REG_FLLCTL1,
 		     fll_div.fll_ratio | WM8900_REG_FLLCTL1_OSC_ENA);
 
-	snd_soc_write(codec, WM8900_REG_FLLCTL4, fll_div.n >> 5);
-	snd_soc_write(codec, WM8900_REG_FLLCTL5,
+	snd_soc_component_write(component, WM8900_REG_FLLCTL4, fll_div.n >> 5);
+	snd_soc_component_write(component, WM8900_REG_FLLCTL5,
 		     (fll_div.fllclk_div << 6) | (fll_div.n & 0x1f));
 
 	if (fll_div.k) {
-		snd_soc_write(codec, WM8900_REG_FLLCTL2,
+		snd_soc_component_write(component, WM8900_REG_FLLCTL2,
 			     (fll_div.k >> 8) | 0x100);
-		snd_soc_write(codec, WM8900_REG_FLLCTL3, fll_div.k & 0xff);
+		snd_soc_component_write(component, WM8900_REG_FLLCTL3, fll_div.k & 0xff);
 	} else
-		snd_soc_write(codec, WM8900_REG_FLLCTL2, 0);
+		snd_soc_component_write(component, WM8900_REG_FLLCTL2, 0);
 
 	if (fll_div.fll_slow_lock_ref)
-		snd_soc_write(codec, WM8900_REG_FLLCTL6,
+		snd_soc_component_write(component, WM8900_REG_FLLCTL6,
 			     WM8900_REG_FLLCTL6_FLL_SLOW_LOCK_REF);
 	else
-		snd_soc_write(codec, WM8900_REG_FLLCTL6, 0);
+		snd_soc_component_write(component, WM8900_REG_FLLCTL6, 0);
 
-	snd_soc_update_bits(codec, WM8900_REG_POWER1,
+	snd_soc_component_update_bits(component, WM8900_REG_POWER1,
 			    WM8900_REG_POWER1_FLL_ENA,
 			    WM8900_REG_POWER1_FLL_ENA);
 
 reenable:
-	snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+	snd_soc_component_update_bits(component, WM8900_REG_CLOCKING1,
 			    WM8900_REG_CLOCKING1_MCLK_SRC,
 			    WM8900_REG_CLOCKING1_MCLK_SRC);
 	return 0;
@@ -818,41 +818,41 @@ static int wm8900_set_fll(struct snd_soc_codec *codec,
 static int wm8900_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	return wm8900_set_fll(codec_dai->codec, pll_id, freq_in, freq_out);
+	return wm8900_set_fll(codec_dai->component, pll_id, freq_in, freq_out);
 }
 
 static int wm8900_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 				 int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	switch (div_id) {
 	case WM8900_BCLK_DIV:
-		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+		snd_soc_component_update_bits(component, WM8900_REG_CLOCKING1,
 				    WM8900_REG_CLOCKING1_BCLK_MASK, div);
 		break;
 	case WM8900_OPCLK_DIV:
-		snd_soc_update_bits(codec, WM8900_REG_CLOCKING1,
+		snd_soc_component_update_bits(component, WM8900_REG_CLOCKING1,
 				    WM8900_REG_CLOCKING1_OPCLK_MASK, div);
 		break;
 	case WM8900_DAC_LRCLK:
-		snd_soc_update_bits(codec, WM8900_REG_AUDIO4,
+		snd_soc_component_update_bits(component, WM8900_REG_AUDIO4,
 				    WM8900_LRC_MASK, div);
 		break;
 	case WM8900_ADC_LRCLK:
-		snd_soc_update_bits(codec, WM8900_REG_AUDIO3,
+		snd_soc_component_update_bits(component, WM8900_REG_AUDIO3,
 				    WM8900_LRC_MASK, div);
 		break;
 	case WM8900_DAC_CLKDIV:
-		snd_soc_update_bits(codec, WM8900_REG_CLOCKING2,
+		snd_soc_component_update_bits(component, WM8900_REG_CLOCKING2,
 				    WM8900_REG_CLOCKING2_DAC_CLKDIV, div);
 		break;
 	case WM8900_ADC_CLKDIV:
-		snd_soc_update_bits(codec, WM8900_REG_CLOCKING2,
+		snd_soc_component_update_bits(component, WM8900_REG_CLOCKING2,
 				    WM8900_REG_CLOCKING2_ADC_CLKDIV, div);
 		break;
 	case WM8900_LRCLK_MODE:
-		snd_soc_update_bits(codec, WM8900_REG_DACCTRL,
+		snd_soc_component_update_bits(component, WM8900_REG_DACCTRL,
 				    WM8900_REG_DACCTRL_AIF_LRCLKRATE, div);
 		break;
 	default:
@@ -866,13 +866,13 @@ static int wm8900_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 static int wm8900_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	unsigned int clocking1, aif1, aif3, aif4;
 
-	clocking1 = snd_soc_read(codec, WM8900_REG_CLOCKING1);
-	aif1 = snd_soc_read(codec, WM8900_REG_AUDIO1);
-	aif3 = snd_soc_read(codec, WM8900_REG_AUDIO3);
-	aif4 = snd_soc_read(codec, WM8900_REG_AUDIO4);
+	clocking1 = snd_soc_component_read32(component, WM8900_REG_CLOCKING1);
+	aif1 = snd_soc_component_read32(component, WM8900_REG_AUDIO1);
+	aif3 = snd_soc_component_read32(component, WM8900_REG_AUDIO3);
+	aif4 = snd_soc_component_read32(component, WM8900_REG_AUDIO4);
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -968,27 +968,27 @@ static int wm8900_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8900_REG_CLOCKING1, clocking1);
-	snd_soc_write(codec, WM8900_REG_AUDIO1, aif1);
-	snd_soc_write(codec, WM8900_REG_AUDIO3, aif3);
-	snd_soc_write(codec, WM8900_REG_AUDIO4, aif4);
+	snd_soc_component_write(component, WM8900_REG_CLOCKING1, clocking1);
+	snd_soc_component_write(component, WM8900_REG_AUDIO1, aif1);
+	snd_soc_component_write(component, WM8900_REG_AUDIO3, aif3);
+	snd_soc_component_write(component, WM8900_REG_AUDIO4, aif4);
 
 	return 0;
 }
 
 static int wm8900_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 reg;
 
-	reg = snd_soc_read(codec, WM8900_REG_DACCTRL);
+	reg = snd_soc_component_read32(component, WM8900_REG_DACCTRL);
 
 	if (mute)
 		reg |= WM8900_REG_DACCTRL_MUTE;
 	else
 		reg &= ~WM8900_REG_DACCTRL_MUTE;
 
-	snd_soc_write(codec, WM8900_REG_DACCTRL, reg);
+	snd_soc_component_write(component, WM8900_REG_DACCTRL, reg);
 
 	return 0;
 }
@@ -1028,7 +1028,7 @@ static struct snd_soc_dai_driver wm8900_dai = {
 	.ops = &wm8900_dai_ops,
 };
 
-static int wm8900_set_bias_level(struct snd_soc_codec *codec,
+static int wm8900_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	u16 reg;
@@ -1036,10 +1036,10 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* Enable thermal shutdown */
-		snd_soc_update_bits(codec, WM8900_REG_GPIO,
+		snd_soc_component_update_bits(component, WM8900_REG_GPIO,
 				    WM8900_REG_GPIO_TEMP_ENA,
 				    WM8900_REG_GPIO_TEMP_ENA);
-		snd_soc_update_bits(codec, WM8900_REG_ADDCTL,
+		snd_soc_component_update_bits(component, WM8900_REG_ADDCTL,
 				    WM8900_REG_ADDCTL_TEMP_SD,
 				    WM8900_REG_ADDCTL_TEMP_SD);
 		break;
@@ -1049,113 +1049,113 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		/* Charge capacitors if initial power up */
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			/* STARTUP_BIAS_ENA on */
-			snd_soc_write(codec, WM8900_REG_POWER1,
+			snd_soc_component_write(component, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA);
 
 			/* Startup bias mode */
-			snd_soc_write(codec, WM8900_REG_ADDCTL,
+			snd_soc_component_write(component, WM8900_REG_ADDCTL,
 				     WM8900_REG_ADDCTL_BIAS_SRC |
 				     WM8900_REG_ADDCTL_VMID_SOFTST);
 
 			/* VMID 2x50k */
-			snd_soc_write(codec, WM8900_REG_POWER1,
+			snd_soc_component_write(component, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA | 0x1);
 
 			/* Allow capacitors to charge */
 			schedule_timeout_interruptible(msecs_to_jiffies(400));
 
 			/* Enable bias */
-			snd_soc_write(codec, WM8900_REG_POWER1,
+			snd_soc_component_write(component, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_STARTUP_BIAS_ENA |
 				     WM8900_REG_POWER1_BIAS_ENA | 0x1);
 
-			snd_soc_write(codec, WM8900_REG_ADDCTL, 0);
+			snd_soc_component_write(component, WM8900_REG_ADDCTL, 0);
 
-			snd_soc_write(codec, WM8900_REG_POWER1,
+			snd_soc_component_write(component, WM8900_REG_POWER1,
 				     WM8900_REG_POWER1_BIAS_ENA | 0x1);
 		}
 
-		reg = snd_soc_read(codec, WM8900_REG_POWER1);
-		snd_soc_write(codec, WM8900_REG_POWER1,
+		reg = snd_soc_component_read32(component, WM8900_REG_POWER1);
+		snd_soc_component_write(component, WM8900_REG_POWER1,
 			     (reg & WM8900_REG_POWER1_FLL_ENA) |
 			     WM8900_REG_POWER1_BIAS_ENA | 0x1);
-		snd_soc_write(codec, WM8900_REG_POWER2,
+		snd_soc_component_write(component, WM8900_REG_POWER2,
 			     WM8900_REG_POWER2_SYSCLK_ENA);
-		snd_soc_write(codec, WM8900_REG_POWER3, 0);
+		snd_soc_component_write(component, WM8900_REG_POWER3, 0);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Startup bias enable */
-		reg = snd_soc_read(codec, WM8900_REG_POWER1);
-		snd_soc_write(codec, WM8900_REG_POWER1,
+		reg = snd_soc_component_read32(component, WM8900_REG_POWER1);
+		snd_soc_component_write(component, WM8900_REG_POWER1,
 			     reg & WM8900_REG_POWER1_STARTUP_BIAS_ENA);
-		snd_soc_write(codec, WM8900_REG_ADDCTL,
+		snd_soc_component_write(component, WM8900_REG_ADDCTL,
 			     WM8900_REG_ADDCTL_BIAS_SRC |
 			     WM8900_REG_ADDCTL_VMID_SOFTST);
 
 		/* Discharge caps */
-		snd_soc_write(codec, WM8900_REG_POWER1,
+		snd_soc_component_write(component, WM8900_REG_POWER1,
 			     WM8900_REG_POWER1_STARTUP_BIAS_ENA);
 		schedule_timeout_interruptible(msecs_to_jiffies(500));
 
 		/* Remove clamp */
-		snd_soc_write(codec, WM8900_REG_HPCTL1, 0);
+		snd_soc_component_write(component, WM8900_REG_HPCTL1, 0);
 
 		/* Power down */
-		snd_soc_write(codec, WM8900_REG_ADDCTL, 0);
-		snd_soc_write(codec, WM8900_REG_POWER1, 0);
-		snd_soc_write(codec, WM8900_REG_POWER2, 0);
-		snd_soc_write(codec, WM8900_REG_POWER3, 0);
+		snd_soc_component_write(component, WM8900_REG_ADDCTL, 0);
+		snd_soc_component_write(component, WM8900_REG_POWER1, 0);
+		snd_soc_component_write(component, WM8900_REG_POWER2, 0);
+		snd_soc_component_write(component, WM8900_REG_POWER3, 0);
 
 		/* Need to let things settle before stopping the clock
 		 * to ensure that restart works, see "Stopping the
 		 * master clock" in the datasheet. */
 		schedule_timeout_interruptible(msecs_to_jiffies(1));
-		snd_soc_write(codec, WM8900_REG_POWER2,
+		snd_soc_component_write(component, WM8900_REG_POWER2,
 			     WM8900_REG_POWER2_SYSCLK_ENA);
 		break;
 	}
 	return 0;
 }
 
-static int wm8900_suspend(struct snd_soc_codec *codec)
+static int wm8900_suspend(struct snd_soc_component *component)
 {
-	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
+	struct wm8900_priv *wm8900 = snd_soc_component_get_drvdata(component);
 	int fll_out = wm8900->fll_out;
 	int fll_in  = wm8900->fll_in;
 	int ret;
 
 	/* Stop the FLL in an orderly fashion */
-	ret = wm8900_set_fll(codec, 0, 0, 0);
+	ret = wm8900_set_fll(component, 0, 0, 0);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to stop FLL\n");
+		dev_err(component->dev, "Failed to stop FLL\n");
 		return ret;
 	}
 
 	wm8900->fll_out = fll_out;
 	wm8900->fll_in = fll_in;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8900_resume(struct snd_soc_codec *codec)
+static int wm8900_resume(struct snd_soc_component *component)
 {
-	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
+	struct wm8900_priv *wm8900 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	wm8900_reset(codec);
+	wm8900_reset(component);
 
 	ret = regcache_sync(wm8900->regmap);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to restore cache: %d\n", ret);
+		dev_err(component->dev, "Failed to restore cache: %d\n", ret);
 		return ret;
 	}
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	/* Restart the FLL? */
 	if (wm8900->fll_out) {
@@ -1165,9 +1165,9 @@ static int wm8900_resume(struct snd_soc_codec *codec)
 		wm8900->fll_in = 0;
 		wm8900->fll_out = 0;
 
-		ret = wm8900_set_fll(codec, 0, fll_in, fll_out);
+		ret = wm8900_set_fll(component, 0, fll_in, fll_out);
 		if (ret != 0) {
-			dev_err(codec->dev, "Failed to restart FLL\n");
+			dev_err(component->dev, "Failed to restart FLL\n");
 			return ret;
 		}
 	}
@@ -1175,53 +1175,54 @@ static int wm8900_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm8900_probe(struct snd_soc_codec *codec)
+static int wm8900_probe(struct snd_soc_component *component)
 {
 	int reg;
 
-	reg = snd_soc_read(codec, WM8900_REG_ID);
+	reg = snd_soc_component_read32(component, WM8900_REG_ID);
 	if (reg != 0x8900) {
-		dev_err(codec->dev, "Device is not a WM8900 - ID %x\n", reg);
+		dev_err(component->dev, "Device is not a WM8900 - ID %x\n", reg);
 		return -ENODEV;
 	}
 
-	wm8900_reset(codec);
+	wm8900_reset(component);
 
 	/* Turn the chip on */
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the volume update bits */
-	snd_soc_update_bits(codec, WM8900_REG_LINVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_RINVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_LOUT1CTL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_ROUT1CTL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_LOUT2CTL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_ROUT2CTL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_LDAC_DV, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_RDAC_DV, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_LADC_DV, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8900_REG_RADC_DV, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_LINVOL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_RINVOL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_LOUT1CTL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_ROUT1CTL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_LOUT2CTL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_ROUT2CTL, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_LDAC_DV, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_RDAC_DV, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_LADC_DV, 0x100, 0x100);
+	snd_soc_component_update_bits(component, WM8900_REG_RADC_DV, 0x100, 0x100);
 
 	/* Set the DAC and mixer output bias */
-	snd_soc_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
+	snd_soc_component_write(component, WM8900_REG_OUTBIASCTL, 0x81);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
-	.probe =	wm8900_probe,
-	.suspend =	wm8900_suspend,
-	.resume =	wm8900_resume,
-	.set_bias_level = wm8900_set_bias_level,
-
-	.component_driver = {
-		.controls		= wm8900_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8900_snd_controls),
-		.dapm_widgets		= wm8900_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8900_dapm_widgets),
-		.dapm_routes		= wm8900_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8900_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8900 = {
+	.probe			= wm8900_probe,
+	.suspend		= wm8900_suspend,
+	.resume			= wm8900_resume,
+	.set_bias_level		= wm8900_set_bias_level,
+	.controls		= wm8900_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8900_snd_controls),
+	.dapm_widgets		= wm8900_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8900_dapm_widgets),
+	.dapm_routes		= wm8900_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8900_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8900_regmap = {
@@ -1253,15 +1254,14 @@ static int wm8900_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, wm8900);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_wm8900, &wm8900_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_dev_wm8900, &wm8900_dai, 1);
 
 	return ret;
 }
 
 static int wm8900_spi_remove(struct spi_device *spi)
 {
-	snd_soc_unregister_codec(&spi->dev);
 	return 0;
 }
 
@@ -1292,15 +1292,14 @@ static int wm8900_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8900);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8900, &wm8900_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8900, &wm8900_dai, 1);
 
 	return ret;
 }
 
 static int wm8900_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
