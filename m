From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8991: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:24 +0000
Message-ID: <E1elDW0-0005eE-S2@debutante>
References: <87zi4x2wiw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC9F267E4C
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:27 +0100 (CET)
In-Reply-To: <87zi4x2wiw.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8991: replace codec to component

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

>From bf338e5b6c00859a259ce3f56b9f04a3f0bb075b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:08:29 +0000
Subject: [PATCH] ASoC: wm8991: replace codec to component

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
 sound/soc/codecs/wm8991.c | 167 ++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 87 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 802c0694e5c3..76a639df6417 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -133,7 +133,7 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_sidetone_tlv,
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	int reg = kcontrol->private_value & 0xff;
 	int ret;
 	u16 val;
@@ -143,8 +143,8 @@ static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	/* now hit the volume update bits (always bit 8) */
-	val = snd_soc_read(codec, reg);
-	return snd_soc_write(codec, reg, val | 0x0100);
+	val = snd_soc_component_read32(component, reg);
+	return snd_soc_component_write(component, reg, val | 0x0100);
 }
 
 static const char *wm8991_digital_sidetone[] =
@@ -361,14 +361,14 @@ static const struct snd_kcontrol_new wm8991_snd_controls[] = {
 static int outmixer_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	u32 reg_shift = kcontrol->private_value & 0xfff;
 	int ret = 0;
 	u16 reg;
 
 	switch (reg_shift) {
 	case WM8991_SPEAKER_MIXER | (WM8991_LDSPK_BIT << 8):
-		reg = snd_soc_read(codec, WM8991_OUTPUT_MIXER1);
+		reg = snd_soc_component_read32(component, WM8991_OUTPUT_MIXER1);
 		if (reg & WM8991_LDLO) {
 			printk(KERN_WARNING
 			       "Cannot set as Output Mixer 1 LDLO Set\n");
@@ -377,7 +377,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case WM8991_SPEAKER_MIXER | (WM8991_RDSPK_BIT << 8):
-		reg = snd_soc_read(codec, WM8991_OUTPUT_MIXER2);
+		reg = snd_soc_component_read32(component, WM8991_OUTPUT_MIXER2);
 		if (reg & WM8991_RDRO) {
 			printk(KERN_WARNING
 			       "Cannot set as Output Mixer 2 RDRO Set\n");
@@ -386,7 +386,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case WM8991_OUTPUT_MIXER1 | (WM8991_LDLO_BIT << 8):
-		reg = snd_soc_read(codec, WM8991_SPEAKER_MIXER);
+		reg = snd_soc_component_read32(component, WM8991_SPEAKER_MIXER);
 		if (reg & WM8991_LDSPK) {
 			printk(KERN_WARNING
 			       "Cannot set as Speaker Mixer LDSPK Set\n");
@@ -395,7 +395,7 @@ static int outmixer_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case WM8991_OUTPUT_MIXER2 | (WM8991_RDRO_BIT << 8):
-		reg = snd_soc_read(codec, WM8991_SPEAKER_MIXER);
+		reg = snd_soc_component_read32(component, WM8991_SPEAKER_MIXER);
 		if (reg & WM8991_RDSPK) {
 			printk(KERN_WARNING
 			       "Cannot set as Speaker Mixer RDSPK Set\n");
@@ -927,31 +927,31 @@ static int wm8991_set_dai_pll(struct snd_soc_dai *codec_dai,
 			      int pll_id, int src, unsigned int freq_in, unsigned int freq_out)
 {
 	u16 reg;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	struct _pll_div pll_div;
 
 	if (freq_in && freq_out) {
 		pll_factors(&pll_div, freq_out * 4, freq_in);
 
 		/* Turn on PLL */
-		reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
+		reg = snd_soc_component_read32(component, WM8991_POWER_MANAGEMENT_2);
 		reg |= WM8991_PLL_ENA;
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_2, reg);
 
 		/* sysclk comes from PLL */
-		reg = snd_soc_read(codec, WM8991_CLOCKING_2);
-		snd_soc_write(codec, WM8991_CLOCKING_2, reg | WM8991_SYSCLK_SRC);
+		reg = snd_soc_component_read32(component, WM8991_CLOCKING_2);
+		snd_soc_component_write(component, WM8991_CLOCKING_2, reg | WM8991_SYSCLK_SRC);
 
 		/* set up N , fractional mode and pre-divisor if necessary */
-		snd_soc_write(codec, WM8991_PLL1, pll_div.n | WM8991_SDM |
+		snd_soc_component_write(component, WM8991_PLL1, pll_div.n | WM8991_SDM |
 			      (pll_div.div2 ? WM8991_PRESCALE : 0));
-		snd_soc_write(codec, WM8991_PLL2, (u8)(pll_div.k>>8));
-		snd_soc_write(codec, WM8991_PLL3, (u8)(pll_div.k & 0xFF));
+		snd_soc_component_write(component, WM8991_PLL2, (u8)(pll_div.k>>8));
+		snd_soc_component_write(component, WM8991_PLL3, (u8)(pll_div.k & 0xFF));
 	} else {
 		/* Turn on PLL */
-		reg = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_2);
+		reg = snd_soc_component_read32(component, WM8991_POWER_MANAGEMENT_2);
 		reg &= ~WM8991_PLL_ENA;
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_2, reg);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_2, reg);
 	}
 	return 0;
 }
@@ -962,11 +962,11 @@ static int wm8991_set_dai_pll(struct snd_soc_dai *codec_dai,
 static int wm8991_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 audio1, audio3;
 
-	audio1 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_1);
-	audio3 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_3);
+	audio1 = snd_soc_component_read32(component, WM8991_AUDIO_INTERFACE_1);
+	audio3 = snd_soc_component_read32(component, WM8991_AUDIO_INTERFACE_3);
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1007,37 +1007,37 @@ static int wm8991_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_1, audio1);
-	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_3, audio3);
+	snd_soc_component_write(component, WM8991_AUDIO_INTERFACE_1, audio1);
+	snd_soc_component_write(component, WM8991_AUDIO_INTERFACE_3, audio3);
 	return 0;
 }
 
 static int wm8991_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 				 int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 reg;
 
 	switch (div_id) {
 	case WM8991_MCLK_DIV:
-		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8991_CLOCKING_2) &
 		      ~WM8991_MCLK_DIV_MASK;
-		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8991_CLOCKING_2, reg | div);
 		break;
 	case WM8991_DACCLK_DIV:
-		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8991_CLOCKING_2) &
 		      ~WM8991_DAC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8991_CLOCKING_2, reg | div);
 		break;
 	case WM8991_ADCCLK_DIV:
-		reg = snd_soc_read(codec, WM8991_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8991_CLOCKING_2) &
 		      ~WM8991_ADC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8991_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8991_CLOCKING_2, reg | div);
 		break;
 	case WM8991_BCLK_DIV:
-		reg = snd_soc_read(codec, WM8991_CLOCKING_1) &
+		reg = snd_soc_component_read32(component, WM8991_CLOCKING_1) &
 		      ~WM8991_BCLK_DIV_MASK;
-		snd_soc_write(codec, WM8991_CLOCKING_1, reg | div);
+		snd_soc_component_write(component, WM8991_CLOCKING_1, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -1053,8 +1053,8 @@ static int wm8991_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 audio1 = snd_soc_read(codec, WM8991_AUDIO_INTERFACE_1);
+	struct snd_soc_component *component = dai->component;
+	u16 audio1 = snd_soc_component_read32(component, WM8991_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8991_AIF_WL_MASK;
 	/* bit size */
@@ -1072,27 +1072,27 @@ static int wm8991_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_write(codec, WM8991_AUDIO_INTERFACE_1, audio1);
+	snd_soc_component_write(component, WM8991_AUDIO_INTERFACE_1, audio1);
 	return 0;
 }
 
 static int wm8991_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u16 val;
 
-	val  = snd_soc_read(codec, WM8991_DAC_CTRL) & ~WM8991_DAC_MUTE;
+	val  = snd_soc_component_read32(component, WM8991_DAC_CTRL) & ~WM8991_DAC_MUTE;
 	if (mute)
-		snd_soc_write(codec, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
+		snd_soc_component_write(component, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
 	else
-		snd_soc_write(codec, WM8991_DAC_CTRL, val);
+		snd_soc_component_write(component, WM8991_DAC_CTRL, val);
 	return 0;
 }
 
-static int wm8991_set_bias_level(struct snd_soc_codec *codec,
+static int wm8991_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8991_priv *wm8991 = snd_soc_codec_get_drvdata(codec);
+	struct wm8991_priv *wm8991 = snd_soc_component_get_drvdata(component);
 	u16 val;
 
 	switch (level) {
@@ -1101,22 +1101,22 @@ static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*50k */
-		val = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1) &
+		val = snd_soc_component_read32(component, WM8991_POWER_MANAGEMENT_1) &
 		      ~WM8991_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, val | 0x2);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, val | 0x2);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			regcache_sync(wm8991->regmap);
 			/* Enable all output discharge bits */
-			snd_soc_write(codec, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
+			snd_soc_component_write(component, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
 				      WM8991_DIS_RLINE | WM8991_DIS_OUT3 |
 				      WM8991_DIS_OUT4 | WM8991_DIS_LOUT |
 				      WM8991_DIS_ROUT);
 
 			/* Enable POBCTRL, SOFT_ST, VMIDTOG and BUFDCOPEN */
-			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+			snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_SOFTST |
 				      WM8991_BUFDCOPEN | WM8991_POBCTRL |
 				      WM8991_VMIDTOG);
 
@@ -1124,78 +1124,78 @@ static int wm8991_set_bias_level(struct snd_soc_codec *codec,
 			msleep(300);
 
 			/* Disable VMIDTOG */
-			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+			snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_SOFTST |
 				      WM8991_BUFDCOPEN | WM8991_POBCTRL);
 
 			/* disable all output discharge bits */
-			snd_soc_write(codec, WM8991_ANTIPOP1, 0);
+			snd_soc_component_write(component, WM8991_ANTIPOP1, 0);
 
 			/* Enable outputs */
-			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1b00);
+			snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x1b00);
 
 			msleep(50);
 
 			/* Enable VMID at 2x50k */
-			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f02);
+			snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x1f02);
 
 			msleep(100);
 
 			/* Enable VREF */
-			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f03);
+			snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x1f03);
 
 			msleep(600);
 
 			/* Enable BUFIOEN */
-			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+			snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_SOFTST |
 				      WM8991_BUFDCOPEN | WM8991_POBCTRL |
 				      WM8991_BUFIOEN);
 
 			/* Disable outputs */
-			snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x3);
+			snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x3);
 
 			/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-			snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_BUFIOEN);
+			snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_BUFIOEN);
 		}
 
 		/* VMID=2*250k */
-		val = snd_soc_read(codec, WM8991_POWER_MANAGEMENT_1) &
+		val = snd_soc_component_read32(component, WM8991_POWER_MANAGEMENT_1) &
 		      ~WM8991_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, val | 0x4);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, val | 0x4);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Enable POBCTRL and SOFT_ST */
-		snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+		snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_SOFTST |
 			      WM8991_POBCTRL | WM8991_BUFIOEN);
 
 		/* Enable POBCTRL, SOFT_ST and BUFDCOPEN */
-		snd_soc_write(codec, WM8991_ANTIPOP2, WM8991_SOFTST |
+		snd_soc_component_write(component, WM8991_ANTIPOP2, WM8991_SOFTST |
 			      WM8991_BUFDCOPEN | WM8991_POBCTRL |
 			      WM8991_BUFIOEN);
 
 		/* mute DAC */
-		val = snd_soc_read(codec, WM8991_DAC_CTRL);
-		snd_soc_write(codec, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
+		val = snd_soc_component_read32(component, WM8991_DAC_CTRL);
+		snd_soc_component_write(component, WM8991_DAC_CTRL, val | WM8991_DAC_MUTE);
 
 		/* Enable any disabled outputs */
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f03);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x1f03);
 
 		/* Disable VMID */
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x1f01);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x1f01);
 
 		msleep(300);
 
 		/* Enable all output discharge bits */
-		snd_soc_write(codec, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
+		snd_soc_component_write(component, WM8991_ANTIPOP1, WM8991_DIS_LLINE |
 			      WM8991_DIS_RLINE | WM8991_DIS_OUT3 |
 			      WM8991_DIS_OUT4 | WM8991_DIS_LOUT |
 			      WM8991_DIS_ROUT);
 
 		/* Disable VREF */
-		snd_soc_write(codec, WM8991_POWER_MANAGEMENT_1, 0x0);
+		snd_soc_component_write(component, WM8991_POWER_MANAGEMENT_1, 0x0);
 
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-		snd_soc_write(codec, WM8991_ANTIPOP2, 0x0);
+		snd_soc_component_write(component, WM8991_ANTIPOP2, 0x0);
 		regcache_mark_dirty(wm8991->regmap);
 		break;
 	}
@@ -1242,18 +1242,19 @@ static struct snd_soc_dai_driver wm8991_dai = {
 	.ops = &wm8991_ops
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
-	.set_bias_level = wm8991_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8991_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8991_snd_controls),
-		.dapm_widgets		= wm8991_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8991_dapm_widgets),
-		.dapm_routes		= wm8991_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8991_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8991 = {
+	.set_bias_level		= wm8991_set_bias_level,
+	.controls		= wm8991_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8991_snd_controls),
+	.dapm_widgets		= wm8991_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8991_dapm_widgets),
+	.dapm_routes		= wm8991_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8991_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8991_regmap = {
@@ -1319,19 +1320,12 @@ static int wm8991_i2c_probe(struct i2c_client *i2c,
 	regmap_write(wm8991->regmap, WM8991_RIGHT_OUTPUT_VOLUME,
 		     0x50 | (1<<8));
 
-	ret = snd_soc_register_codec(&i2c->dev,
-				     &soc_codec_dev_wm8991, &wm8991_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				     &soc_component_dev_wm8991, &wm8991_dai, 1);
 
 	return ret;
 }
 
-static int wm8991_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8991_i2c_id[] = {
 	{ "wm8991", 0 },
 	{ }
@@ -1343,7 +1337,6 @@ static struct i2c_driver wm8991_i2c_driver = {
 		.name = "wm8991",
 	},
 	.probe = wm8991_i2c_probe,
-	.remove = wm8991_i2c_remove,
 	.id_table = wm8991_i2c_id,
 };
 
-- 
2.16.1
