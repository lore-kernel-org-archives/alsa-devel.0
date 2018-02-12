From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8961: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:18 +0000
Message-ID: <E1elDVu-0005cW-Ia@debutante>
References: <87wp012wi1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EC240267E3A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:20 +0100 (CET)
In-Reply-To: <87wp012wi1.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8961: replace codec to component

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

>From ce8d1015a2b8d1301c98f7e6b774fb1c28220cea Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:09:02 +0000
Subject: [PATCH] ASoC: wm8961: replace codec to component

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
 sound/soc/codecs/wm8961.c | 241 ++++++++++++++++++++++------------------------
 1 file changed, 117 insertions(+), 124 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index e23ceac76015..f70f563d59f3 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -194,89 +194,89 @@ static bool wm8961_readable(struct device *dev, unsigned int reg)
 static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 hp_reg = snd_soc_read(codec, WM8961_ANALOGUE_HP_0);
-	u16 cp_reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_1);
-	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
-	u16 dcs_reg = snd_soc_read(codec, WM8961_DC_SERVO_1);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 hp_reg = snd_soc_component_read32(component, WM8961_ANALOGUE_HP_0);
+	u16 cp_reg = snd_soc_component_read32(component, WM8961_CHARGE_PUMP_1);
+	u16 pwr_reg = snd_soc_component_read32(component, WM8961_PWR_MGMT_2);
+	u16 dcs_reg = snd_soc_component_read32(component, WM8961_DC_SERVO_1);
 	int timeout = 500;
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Make sure the output is shorted */
 		hp_reg &= ~(WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT);
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Enable the charge pump */
 		cp_reg |= WM8961_CP_ENA;
-		snd_soc_write(codec, WM8961_CHARGE_PUMP_1, cp_reg);
+		snd_soc_component_write(component, WM8961_CHARGE_PUMP_1, cp_reg);
 		mdelay(5);
 
 		/* Enable the PGA */
 		pwr_reg |= WM8961_LOUT1_PGA | WM8961_ROUT1_PGA;
-		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_component_write(component, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Enable the amplifier */
 		hp_reg |= WM8961_HPR_ENA | WM8961_HPL_ENA;
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Second stage enable */
 		hp_reg |= WM8961_HPR_ENA_DLY | WM8961_HPL_ENA_DLY;
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Enable the DC servo & trigger startup */
 		dcs_reg |=
 			WM8961_DCS_ENA_CHAN_HPR | WM8961_DCS_TRIG_STARTUP_HPR |
 			WM8961_DCS_ENA_CHAN_HPL | WM8961_DCS_TRIG_STARTUP_HPL;
-		dev_dbg(codec->dev, "Enabling DC servo\n");
+		dev_dbg(component->dev, "Enabling DC servo\n");
 
-		snd_soc_write(codec, WM8961_DC_SERVO_1, dcs_reg);
+		snd_soc_component_write(component, WM8961_DC_SERVO_1, dcs_reg);
 		do {
 			msleep(1);
-			dcs_reg = snd_soc_read(codec, WM8961_DC_SERVO_1);
+			dcs_reg = snd_soc_component_read32(component, WM8961_DC_SERVO_1);
 		} while (--timeout &&
 			 dcs_reg & (WM8961_DCS_TRIG_STARTUP_HPR |
 				WM8961_DCS_TRIG_STARTUP_HPL));
 		if (dcs_reg & (WM8961_DCS_TRIG_STARTUP_HPR |
 			       WM8961_DCS_TRIG_STARTUP_HPL))
-			dev_err(codec->dev, "DC servo timed out\n");
+			dev_err(component->dev, "DC servo timed out\n");
 		else
-			dev_dbg(codec->dev, "DC servo startup complete\n");
+			dev_dbg(component->dev, "DC servo startup complete\n");
 
 		/* Enable the output stage */
 		hp_reg |= WM8961_HPR_ENA_OUTP | WM8961_HPL_ENA_OUTP;
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Remove the short on the output stage */
 		hp_reg |= WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT;
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
 		/* Short the output */
 		hp_reg &= ~(WM8961_HPR_RMV_SHORT | WM8961_HPL_RMV_SHORT);
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable the output stage */
 		hp_reg &= ~(WM8961_HPR_ENA_OUTP | WM8961_HPL_ENA_OUTP);
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable DC offset cancellation */
 		dcs_reg &= ~(WM8961_DCS_ENA_CHAN_HPR |
 			     WM8961_DCS_ENA_CHAN_HPL);
-		snd_soc_write(codec, WM8961_DC_SERVO_1, dcs_reg);
+		snd_soc_component_write(component, WM8961_DC_SERVO_1, dcs_reg);
 
 		/* Finish up */
 		hp_reg &= ~(WM8961_HPR_ENA_DLY | WM8961_HPR_ENA |
 			    WM8961_HPL_ENA_DLY | WM8961_HPL_ENA);
-		snd_soc_write(codec, WM8961_ANALOGUE_HP_0, hp_reg);
+		snd_soc_component_write(component, WM8961_ANALOGUE_HP_0, hp_reg);
 
 		/* Disable the PGA */
 		pwr_reg &= ~(WM8961_LOUT1_PGA | WM8961_ROUT1_PGA);
-		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_component_write(component, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Disable the charge pump */
-		dev_dbg(codec->dev, "Disabling charge pump\n");
-		snd_soc_write(codec, WM8961_CHARGE_PUMP_1,
+		dev_dbg(component->dev, "Disabling charge pump\n");
+		snd_soc_component_write(component, WM8961_CHARGE_PUMP_1,
 			     cp_reg & ~WM8961_CP_ENA);
 	}
 
@@ -286,28 +286,28 @@ static int wm8961_hp_event(struct snd_soc_dapm_widget *w,
 static int wm8961_spk_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 pwr_reg = snd_soc_read(codec, WM8961_PWR_MGMT_2);
-	u16 spk_reg = snd_soc_read(codec, WM8961_CLASS_D_CONTROL_1);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u16 pwr_reg = snd_soc_component_read32(component, WM8961_PWR_MGMT_2);
+	u16 spk_reg = snd_soc_component_read32(component, WM8961_CLASS_D_CONTROL_1);
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
 		/* Enable the PGA */
 		pwr_reg |= WM8961_SPKL_PGA | WM8961_SPKR_PGA;
-		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_component_write(component, WM8961_PWR_MGMT_2, pwr_reg);
 
 		/* Enable the amplifier */
 		spk_reg |= WM8961_SPKL_ENA | WM8961_SPKR_ENA;
-		snd_soc_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
+		snd_soc_component_write(component, WM8961_CLASS_D_CONTROL_1, spk_reg);
 	}
 
 	if (event & SND_SOC_DAPM_PRE_PMD) {
 		/* Disable the amplifier */
 		spk_reg &= ~(WM8961_SPKL_ENA | WM8961_SPKR_ENA);
-		snd_soc_write(codec, WM8961_CLASS_D_CONTROL_1, spk_reg);
+		snd_soc_component_write(component, WM8961_CLASS_D_CONTROL_1, spk_reg);
 
 		/* Disable the PGA */
 		pwr_reg &= ~(WM8961_SPKL_PGA | WM8961_SPKR_PGA);
-		snd_soc_write(codec, WM8961_PWR_MGMT_2, pwr_reg);
+		snd_soc_component_write(component, WM8961_PWR_MGMT_2, pwr_reg);
 	}
 
 	return 0;
@@ -505,15 +505,15 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8961_priv *wm8961 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8961_priv *wm8961 = snd_soc_component_get_drvdata(component);
 	int i, best, target, fs;
 	u16 reg;
 
 	fs = params_rate(params);
 
 	if (!wm8961->sysclk) {
-		dev_err(codec->dev, "MCLK has not been specified\n");
+		dev_err(component->dev, "MCLK has not been specified\n");
 		return -EINVAL;
 	}
 
@@ -524,23 +524,23 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 		    abs(wm8961_srate[best].rate - fs))
 			best = i;
 	}
-	reg = snd_soc_read(codec, WM8961_ADDITIONAL_CONTROL_3);
+	reg = snd_soc_component_read32(component, WM8961_ADDITIONAL_CONTROL_3);
 	reg &= ~WM8961_SAMPLE_RATE_MASK;
 	reg |= wm8961_srate[best].val;
-	snd_soc_write(codec, WM8961_ADDITIONAL_CONTROL_3, reg);
-	dev_dbg(codec->dev, "Selected SRATE %dHz for %dHz\n",
+	snd_soc_component_write(component, WM8961_ADDITIONAL_CONTROL_3, reg);
+	dev_dbg(component->dev, "Selected SRATE %dHz for %dHz\n",
 		wm8961_srate[best].rate, fs);
 
 	/* Select a CLK_SYS/fs ratio equal to or higher than required */
 	target = wm8961->sysclk / fs;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && target < 64) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"SYSCLK must be at least 64*fs for DAC\n");
 		return -EINVAL;
 	}
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE && target < 256) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"SYSCLK must be at least 256*fs for ADC\n");
 		return -EINVAL;
 	}
@@ -550,19 +550,19 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 			break;
 	}
 	if (i == ARRAY_SIZE(wm8961_clk_sys_ratio)) {
-		dev_err(codec->dev, "Unable to generate CLK_SYS_RATE\n");
+		dev_err(component->dev, "Unable to generate CLK_SYS_RATE\n");
 		return -EINVAL;
 	}
-	dev_dbg(codec->dev, "Selected CLK_SYS_RATE of %d for %d/%d=%d\n",
+	dev_dbg(component->dev, "Selected CLK_SYS_RATE of %d for %d/%d=%d\n",
 		wm8961_clk_sys_ratio[i].ratio, wm8961->sysclk, fs,
 		wm8961->sysclk / fs);
 
-	reg = snd_soc_read(codec, WM8961_CLOCKING_4);
+	reg = snd_soc_component_read32(component, WM8961_CLOCKING_4);
 	reg &= ~WM8961_CLK_SYS_RATE_MASK;
 	reg |= wm8961_clk_sys_ratio[i].val << WM8961_CLK_SYS_RATE_SHIFT;
-	snd_soc_write(codec, WM8961_CLOCKING_4, reg);
+	snd_soc_component_write(component, WM8961_CLOCKING_4, reg);
 
-	reg = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_0);
+	reg = snd_soc_component_read32(component, WM8961_AUDIO_INTERFACE_0);
 	reg &= ~WM8961_WL_MASK;
 	switch (params_width(params)) {
 	case 16:
@@ -579,15 +579,15 @@ static int wm8961_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	snd_soc_write(codec, WM8961_AUDIO_INTERFACE_0, reg);
+	snd_soc_component_write(component, WM8961_AUDIO_INTERFACE_0, reg);
 
 	/* Sloping stop-band filter is recommended for <= 24kHz */
-	reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_2);
+	reg = snd_soc_component_read32(component, WM8961_ADC_DAC_CONTROL_2);
 	if (fs <= 24000)
 		reg |= WM8961_DACSLOPE;
 	else
 		reg &= ~WM8961_DACSLOPE;
-	snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
+	snd_soc_component_write(component, WM8961_ADC_DAC_CONTROL_2, reg);
 
 	return 0;
 }
@@ -596,25 +596,25 @@ static int wm8961_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			     unsigned int freq,
 			     int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8961_priv *wm8961 = snd_soc_codec_get_drvdata(codec);
-	u16 reg = snd_soc_read(codec, WM8961_CLOCKING1);
+	struct snd_soc_component *component = dai->component;
+	struct wm8961_priv *wm8961 = snd_soc_component_get_drvdata(component);
+	u16 reg = snd_soc_component_read32(component, WM8961_CLOCKING1);
 
 	if (freq > 33000000) {
-		dev_err(codec->dev, "MCLK must be <33MHz\n");
+		dev_err(component->dev, "MCLK must be <33MHz\n");
 		return -EINVAL;
 	}
 
 	if (freq > 16500000) {
-		dev_dbg(codec->dev, "Using MCLK/2 for %dHz MCLK\n", freq);
+		dev_dbg(component->dev, "Using MCLK/2 for %dHz MCLK\n", freq);
 		reg |= WM8961_MCLKDIV;
 		freq /= 2;
 	} else {
-		dev_dbg(codec->dev, "Using MCLK/1 for %dHz MCLK\n", freq);
+		dev_dbg(component->dev, "Using MCLK/1 for %dHz MCLK\n", freq);
 		reg &= ~WM8961_MCLKDIV;
 	}
 
-	snd_soc_write(codec, WM8961_CLOCKING1, reg);
+	snd_soc_component_write(component, WM8961_CLOCKING1, reg);
 
 	wm8961->sysclk = freq;
 
@@ -623,8 +623,8 @@ static int wm8961_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 static int wm8961_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 aif = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_0);
+	struct snd_soc_component *component = dai->component;
+	u16 aif = snd_soc_component_read32(component, WM8961_AUDIO_INTERFACE_0);
 
 	aif &= ~(WM8961_BCLKINV | WM8961_LRP |
 		 WM8961_MS | WM8961_FORMAT_MASK);
@@ -684,26 +684,26 @@ static int wm8961_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	return snd_soc_write(codec, WM8961_AUDIO_INTERFACE_0, aif);
+	return snd_soc_component_write(component, WM8961_AUDIO_INTERFACE_0, aif);
 }
 
 static int wm8961_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = snd_soc_read(codec, WM8961_ADDITIONAL_CONTROL_2);
+	struct snd_soc_component *component = dai->component;
+	u16 reg = snd_soc_component_read32(component, WM8961_ADDITIONAL_CONTROL_2);
 
 	if (tristate)
 		reg |= WM8961_TRIS;
 	else
 		reg &= ~WM8961_TRIS;
 
-	return snd_soc_write(codec, WM8961_ADDITIONAL_CONTROL_2, reg);
+	return snd_soc_component_write(component, WM8961_ADDITIONAL_CONTROL_2, reg);
 }
 
 static int wm8961_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_1);
+	struct snd_soc_component *component = dai->component;
+	u16 reg = snd_soc_component_read32(component, WM8961_ADC_DAC_CONTROL_1);
 
 	if (mute)
 		reg |= WM8961_DACMU;
@@ -712,27 +712,27 @@ static int wm8961_digital_mute(struct snd_soc_dai *dai, int mute)
 
 	msleep(17);
 
-	return snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_1, reg);
+	return snd_soc_component_write(component, WM8961_ADC_DAC_CONTROL_1, reg);
 }
 
 static int wm8961_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 reg;
 
 	switch (div_id) {
 	case WM8961_BCLK:
-		reg = snd_soc_read(codec, WM8961_CLOCKING2);
+		reg = snd_soc_component_read32(component, WM8961_CLOCKING2);
 		reg &= ~WM8961_BCLKDIV_MASK;
 		reg |= div;
-		snd_soc_write(codec, WM8961_CLOCKING2, reg);
+		snd_soc_component_write(component, WM8961_CLOCKING2, reg);
 		break;
 
 	case WM8961_LRCLK:
-		reg = snd_soc_read(codec, WM8961_AUDIO_INTERFACE_2);
+		reg = snd_soc_component_read32(component, WM8961_AUDIO_INTERFACE_2);
 		reg &= ~WM8961_LRCLK_RATE_MASK;
 		reg |= div;
-		snd_soc_write(codec, WM8961_AUDIO_INTERFACE_2, reg);
+		snd_soc_component_write(component, WM8961_AUDIO_INTERFACE_2, reg);
 		break;
 
 	default:
@@ -742,7 +742,7 @@ static int wm8961_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
 	return 0;
 }
 
-static int wm8961_set_bias_level(struct snd_soc_codec *codec,
+static int wm8961_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	u16 reg;
@@ -757,36 +757,36 @@ static int wm8961_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_STANDBY) {
 			/* Enable bias generation */
-			reg = snd_soc_read(codec, WM8961_ANTI_POP);
+			reg = snd_soc_component_read32(component, WM8961_ANTI_POP);
 			reg |= WM8961_BUFIOEN | WM8961_BUFDCOPEN;
-			snd_soc_write(codec, WM8961_ANTI_POP, reg);
+			snd_soc_component_write(component, WM8961_ANTI_POP, reg);
 
 			/* VMID=2*50k, VREF */
-			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_component_read32(component, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VMIDSEL_MASK;
 			reg |= (1 << WM8961_VMIDSEL_SHIFT) | WM8961_VREF;
-			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_component_write(component, WM8961_PWR_MGMT_1, reg);
 		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_PREPARE) {
 			/* VREF off */
-			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_component_read32(component, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VREF;
-			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_component_write(component, WM8961_PWR_MGMT_1, reg);
 
 			/* Bias generation off */
-			reg = snd_soc_read(codec, WM8961_ANTI_POP);
+			reg = snd_soc_component_read32(component, WM8961_ANTI_POP);
 			reg &= ~(WM8961_BUFIOEN | WM8961_BUFDCOPEN);
-			snd_soc_write(codec, WM8961_ANTI_POP, reg);
+			snd_soc_component_write(component, WM8961_ANTI_POP, reg);
 
 			/* VMID off */
-			reg = snd_soc_read(codec, WM8961_PWR_MGMT_1);
+			reg = snd_soc_component_read32(component, WM8961_PWR_MGMT_1);
 			reg &= ~WM8961_VMIDSEL_MASK;
-			snd_soc_write(codec, WM8961_PWR_MGMT_1, reg);
+			snd_soc_component_write(component, WM8961_PWR_MGMT_1, reg);
 		}
 		break;
 
@@ -830,51 +830,51 @@ static struct snd_soc_dai_driver wm8961_dai = {
 	.ops = &wm8961_dai_ops,
 };
 
-static int wm8961_probe(struct snd_soc_codec *codec)
+static int wm8961_probe(struct snd_soc_component *component)
 {
 	u16 reg;
 
 	/* Enable class W */
-	reg = snd_soc_read(codec, WM8961_CHARGE_PUMP_B);
+	reg = snd_soc_component_read32(component, WM8961_CHARGE_PUMP_B);
 	reg |= WM8961_CP_DYN_PWR_MASK;
-	snd_soc_write(codec, WM8961_CHARGE_PUMP_B, reg);
+	snd_soc_component_write(component, WM8961_CHARGE_PUMP_B, reg);
 
 	/* Latch volume update bits (right channel only, we always
 	 * write both out) and default ZC on. */
-	reg = snd_soc_read(codec, WM8961_ROUT1_VOLUME);
-	snd_soc_write(codec, WM8961_ROUT1_VOLUME,
+	reg = snd_soc_component_read32(component, WM8961_ROUT1_VOLUME);
+	snd_soc_component_write(component, WM8961_ROUT1_VOLUME,
 		     reg | WM8961_LO1ZC | WM8961_OUT1VU);
-	snd_soc_write(codec, WM8961_LOUT1_VOLUME, reg | WM8961_LO1ZC);
-	reg = snd_soc_read(codec, WM8961_ROUT2_VOLUME);
-	snd_soc_write(codec, WM8961_ROUT2_VOLUME,
+	snd_soc_component_write(component, WM8961_LOUT1_VOLUME, reg | WM8961_LO1ZC);
+	reg = snd_soc_component_read32(component, WM8961_ROUT2_VOLUME);
+	snd_soc_component_write(component, WM8961_ROUT2_VOLUME,
 		     reg | WM8961_SPKRZC | WM8961_SPKVU);
-	snd_soc_write(codec, WM8961_LOUT2_VOLUME, reg | WM8961_SPKLZC);
+	snd_soc_component_write(component, WM8961_LOUT2_VOLUME, reg | WM8961_SPKLZC);
 
-	reg = snd_soc_read(codec, WM8961_RIGHT_ADC_VOLUME);
-	snd_soc_write(codec, WM8961_RIGHT_ADC_VOLUME, reg | WM8961_ADCVU);
-	reg = snd_soc_read(codec, WM8961_RIGHT_INPUT_VOLUME);
-	snd_soc_write(codec, WM8961_RIGHT_INPUT_VOLUME, reg | WM8961_IPVU);
+	reg = snd_soc_component_read32(component, WM8961_RIGHT_ADC_VOLUME);
+	snd_soc_component_write(component, WM8961_RIGHT_ADC_VOLUME, reg | WM8961_ADCVU);
+	reg = snd_soc_component_read32(component, WM8961_RIGHT_INPUT_VOLUME);
+	snd_soc_component_write(component, WM8961_RIGHT_INPUT_VOLUME, reg | WM8961_IPVU);
 
 	/* Use soft mute by default */
-	reg = snd_soc_read(codec, WM8961_ADC_DAC_CONTROL_2);
+	reg = snd_soc_component_read32(component, WM8961_ADC_DAC_CONTROL_2);
 	reg |= WM8961_DACSMM;
-	snd_soc_write(codec, WM8961_ADC_DAC_CONTROL_2, reg);
+	snd_soc_component_write(component, WM8961_ADC_DAC_CONTROL_2, reg);
 
 	/* Use automatic clocking mode by default; for now this is all
 	 * we support.
 	 */
-	reg = snd_soc_read(codec, WM8961_CLOCKING_3);
+	reg = snd_soc_component_read32(component, WM8961_CLOCKING_3);
 	reg &= ~WM8961_MANUAL_MODE;
-	snd_soc_write(codec, WM8961_CLOCKING_3, reg);
+	snd_soc_component_write(component, WM8961_CLOCKING_3, reg);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
 
-static int wm8961_resume(struct snd_soc_codec *codec)
+static int wm8961_resume(struct snd_soc_component *component)
 {
-	snd_soc_cache_sync(codec);
+	snd_soc_component_cache_sync(component);
 
 	return 0;
 }
@@ -882,20 +882,21 @@ static int wm8961_resume(struct snd_soc_codec *codec)
 #define wm8961_resume NULL
 #endif
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
-	.probe =	wm8961_probe,
-	.resume =	wm8961_resume,
-	.set_bias_level = wm8961_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8961_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8961_snd_controls),
-		.dapm_widgets		= wm8961_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8961_dapm_widgets),
-		.dapm_routes		= audio_paths,
-		.num_dapm_routes	= ARRAY_SIZE(audio_paths),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8961 = {
+	.probe			= wm8961_probe,
+	.resume			= wm8961_resume,
+	.set_bias_level		= wm8961_set_bias_level,
+	.controls		= wm8961_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8961_snd_controls),
+	.dapm_widgets		= wm8961_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8961_dapm_widgets),
+	.dapm_routes		= audio_paths,
+	.num_dapm_routes	= ARRAY_SIZE(audio_paths),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8961_regmap = {
@@ -961,19 +962,12 @@ static int wm8961_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8961);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8961, &wm8961_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8961, &wm8961_dai, 1);
 
 	return ret;
 }
 
-static int wm8961_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8961_i2c_id[] = {
 	{ "wm8961", 0 },
 	{ }
@@ -985,7 +979,6 @@ static struct i2c_driver wm8961_i2c_driver = {
 		.name = "wm8961",
 	},
 	.probe =    wm8961_i2c_probe,
-	.remove =   wm8961_i2c_remove,
 	.id_table = wm8961_i2c_id,
 };
 
-- 
2.16.1
