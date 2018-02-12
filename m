From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:48:26 +0000
Message-ID: <E1elDX0-00062v-Pb@debutante>
References: <87lggh4ba8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B1E4267ECF
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:48:29 +0100 (CET)
In-Reply-To: <87lggh4ba8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8753: replace codec to component

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

>From 22d15fc51ea79e0554cfa1c9ca78af0a8d5cd20b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:04:21 +0000
Subject: [PATCH] ASoC: wm8753: replace codec to component

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
 sound/soc/codecs/wm8753.c | 289 ++++++++++++++++++++++------------------------
 1 file changed, 138 insertions(+), 151 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 0271a5253bd3..1e2823e2a906 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -55,9 +55,9 @@ static int caps_charge = 2000;
 module_param(caps_charge, int, 0);
 MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
 
-static int wm8753_hifi_write_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_hifi_write_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt);
-static int wm8753_voice_write_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_voice_write_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt);
 
 /*
@@ -150,7 +150,7 @@ struct wm8753_priv {
 	struct delayed_work charge_work;
 };
 
-#define wm8753_reset(c) snd_soc_write(c, WM8753_RESET, 0)
+#define wm8753_reset(c) snd_soc_component_write(c, WM8753_RESET, 0)
 
 /*
  * WM8753 Controls
@@ -229,8 +229,8 @@ SOC_ENUM_SINGLE(WM8753_OUTCTL, 2, 2, wm8753_rout2_phase),
 static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8753->dai_func;
 	return 0;
@@ -239,17 +239,17 @@ static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 	u16 ioctl;
 
 	if (wm8753->dai_func == ucontrol->value.enumerated.item[0])
 		return 0;
 
-	if (snd_soc_codec_is_active(codec))
+	if (snd_soc_component_is_active(component))
 		return -EBUSY;
 
-	ioctl = snd_soc_read(codec, WM8753_IOCTL);
+	ioctl = snd_soc_component_read32(component, WM8753_IOCTL);
 
 	wm8753->dai_func = ucontrol->value.enumerated.item[0];
 
@@ -257,11 +257,11 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 		return 1;
 
 	ioctl = (ioctl & 0x1f3) | (wm8753->dai_func << 2);
-	snd_soc_write(codec, WM8753_IOCTL, ioctl);
+	snd_soc_component_write(component, WM8753_IOCTL, ioctl);
 
 
-	wm8753_hifi_write_dai_fmt(codec, wm8753->hifi_fmt);
-	wm8753_voice_write_dai_fmt(codec, wm8753->voice_fmt);
+	wm8753_hifi_write_dai_fmt(component, wm8753->hifi_fmt);
+	wm8753_voice_write_dai_fmt(component, wm8753->voice_fmt);
 
 	return 1;
 }
@@ -745,7 +745,7 @@ static int wm8753_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 {
 	u16 reg, enable;
 	int offset;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 
 	if (pll_id < WM8753_PLL1 || pll_id > WM8753_PLL2)
 		return -ENODEV;
@@ -753,17 +753,17 @@ static int wm8753_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	if (pll_id == WM8753_PLL1) {
 		offset = 0;
 		enable = 0x10;
-		reg = snd_soc_read(codec, WM8753_CLOCK) & 0xffef;
+		reg = snd_soc_component_read32(component, WM8753_CLOCK) & 0xffef;
 	} else {
 		offset = 4;
 		enable = 0x8;
-		reg = snd_soc_read(codec, WM8753_CLOCK) & 0xfff7;
+		reg = snd_soc_component_read32(component, WM8753_CLOCK) & 0xfff7;
 	}
 
 	if (!freq_in || !freq_out) {
 		/* disable PLL  */
-		snd_soc_write(codec, WM8753_PLL1CTL1 + offset, 0x0026);
-		snd_soc_write(codec, WM8753_CLOCK, reg);
+		snd_soc_component_write(component, WM8753_PLL1CTL1 + offset, 0x0026);
+		snd_soc_component_write(component, WM8753_CLOCK, reg);
 		return 0;
 	} else {
 		u16 value = 0;
@@ -774,20 +774,20 @@ static int wm8753_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		/* set up N and K PLL divisor ratios */
 		/* bits 8:5 = PLL_N, bits 3:0 = PLL_K[21:18] */
 		value = (pll_div.n << 5) + ((pll_div.k & 0x3c0000) >> 18);
-		snd_soc_write(codec, WM8753_PLL1CTL2 + offset, value);
+		snd_soc_component_write(component, WM8753_PLL1CTL2 + offset, value);
 
 		/* bits 8:0 = PLL_K[17:9] */
 		value = (pll_div.k & 0x03fe00) >> 9;
-		snd_soc_write(codec, WM8753_PLL1CTL3 + offset, value);
+		snd_soc_component_write(component, WM8753_PLL1CTL3 + offset, value);
 
 		/* bits 8:0 = PLL_K[8:0] */
 		value = pll_div.k & 0x0001ff;
-		snd_soc_write(codec, WM8753_PLL1CTL4 + offset, value);
+		snd_soc_component_write(component, WM8753_PLL1CTL4 + offset, value);
 
 		/* set PLL as input and enable */
-		snd_soc_write(codec, WM8753_PLL1CTL1 + offset, 0x0027 |
+		snd_soc_component_write(component, WM8753_PLL1CTL1 + offset, 0x0027 |
 			(pll_div.div2 << 3));
-		snd_soc_write(codec, WM8753_CLOCK, reg | enable);
+		snd_soc_component_write(component, WM8753_CLOCK, reg | enable);
 	}
 	return 0;
 }
@@ -866,8 +866,8 @@ static int get_coeff(int mclk, int rate)
 static int wm8753_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	switch (freq) {
 	case 11289600:
@@ -890,10 +890,10 @@ static int wm8753_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 /*
  * Set's ADC and Voice DAC format.
  */
-static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
-	u16 voice = snd_soc_read(codec, WM8753_PCM) & 0x01ec;
+	u16 voice = snd_soc_component_read32(component, WM8753_PCM) & 0x01ec;
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -915,7 +915,7 @@ static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8753_PCM, voice);
+	snd_soc_component_write(component, WM8753_PCM, voice);
 	return 0;
 }
 
@@ -926,10 +926,10 @@ static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
-	u16 voice = snd_soc_read(codec, WM8753_PCM) & 0x01f3;
-	u16 srate = snd_soc_read(codec, WM8753_SRATE1) & 0x017f;
+	struct snd_soc_component *component = dai->component;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
+	u16 voice = snd_soc_component_read32(component, WM8753_PCM) & 0x01f3;
+	u16 srate = snd_soc_component_read32(component, WM8753_SRATE1) & 0x017f;
 
 	/* bit size */
 	switch (params_width(params)) {
@@ -949,22 +949,22 @@ static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* sample rate */
 	if (params_rate(params) * 384 == wm8753->pcmclk)
 		srate |= 0x80;
-	snd_soc_write(codec, WM8753_SRATE1, srate);
+	snd_soc_component_write(component, WM8753_SRATE1, srate);
 
-	snd_soc_write(codec, WM8753_PCM, voice);
+	snd_soc_component_write(component, WM8753_PCM, voice);
 	return 0;
 }
 
 /*
  * Set's PCM dai fmt and BCLK.
  */
-static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_pcm_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
 	u16 voice, ioctl;
 
-	voice = snd_soc_read(codec, WM8753_PCM) & 0x011f;
-	ioctl = snd_soc_read(codec, WM8753_IOCTL) & 0x015d;
+	voice = snd_soc_component_read32(component, WM8753_PCM) & 0x011f;
+	ioctl = snd_soc_component_read32(component, WM8753_IOCTL) & 0x015d;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1018,29 +1018,29 @@ static int wm8753_pcm_set_dai_fmt(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8753_PCM, voice);
-	snd_soc_write(codec, WM8753_IOCTL, ioctl);
+	snd_soc_component_write(component, WM8753_PCM, voice);
+	snd_soc_component_write(component, WM8753_IOCTL, ioctl);
 	return 0;
 }
 
 static int wm8753_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 reg;
 
 	switch (div_id) {
 	case WM8753_PCMDIV:
-		reg = snd_soc_read(codec, WM8753_CLOCK) & 0x003f;
-		snd_soc_write(codec, WM8753_CLOCK, reg | div);
+		reg = snd_soc_component_read32(component, WM8753_CLOCK) & 0x003f;
+		snd_soc_component_write(component, WM8753_CLOCK, reg | div);
 		break;
 	case WM8753_BCLKDIV:
-		reg = snd_soc_read(codec, WM8753_SRATE2) & 0x01c7;
-		snd_soc_write(codec, WM8753_SRATE2, reg | div);
+		reg = snd_soc_component_read32(component, WM8753_SRATE2) & 0x01c7;
+		snd_soc_component_write(component, WM8753_SRATE2, reg | div);
 		break;
 	case WM8753_VXCLKDIV:
-		reg = snd_soc_read(codec, WM8753_SRATE2) & 0x003f;
-		snd_soc_write(codec, WM8753_SRATE2, reg | div);
+		reg = snd_soc_component_read32(component, WM8753_SRATE2) & 0x003f;
+		snd_soc_component_write(component, WM8753_SRATE2, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -1051,10 +1051,10 @@ static int wm8753_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 /*
  * Set's HiFi DAC format.
  */
-static int wm8753_hdac_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_hdac_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
-	u16 hifi = snd_soc_read(codec, WM8753_HIFI) & 0x01e0;
+	u16 hifi = snd_soc_component_read32(component, WM8753_HIFI) & 0x01e0;
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -1076,20 +1076,20 @@ static int wm8753_hdac_set_dai_fmt(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8753_HIFI, hifi);
+	snd_soc_component_write(component, WM8753_HIFI, hifi);
 	return 0;
 }
 
 /*
  * Set's I2S DAI format.
  */
-static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_i2s_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
 	u16 ioctl, hifi;
 
-	hifi = snd_soc_read(codec, WM8753_HIFI) & 0x013f;
-	ioctl = snd_soc_read(codec, WM8753_IOCTL) & 0x00ae;
+	hifi = snd_soc_component_read32(component, WM8753_HIFI) & 0x013f;
+	ioctl = snd_soc_component_read32(component, WM8753_IOCTL) & 0x00ae;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1143,8 +1143,8 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8753_HIFI, hifi);
-	snd_soc_write(codec, WM8753_IOCTL, ioctl);
+	snd_soc_component_write(component, WM8753_HIFI, hifi);
+	snd_soc_component_write(component, WM8753_IOCTL, ioctl);
 	return 0;
 }
 
@@ -1155,10 +1155,10 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
-	u16 srate = snd_soc_read(codec, WM8753_SRATE1) & 0x01c0;
-	u16 hifi = snd_soc_read(codec, WM8753_HIFI) & 0x01f3;
+	struct snd_soc_component *component = dai->component;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
+	u16 srate = snd_soc_component_read32(component, WM8753_SRATE1) & 0x01c0;
+	u16 hifi = snd_soc_component_read32(component, WM8753_HIFI) & 0x01f3;
 	int coeff;
 
 	/* is digital filter coefficient valid ? */
@@ -1167,7 +1167,7 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 		printk(KERN_ERR "wm8753 invalid MCLK or rate\n");
 		return coeff;
 	}
-	snd_soc_write(codec, WM8753_SRATE1, srate | (coeff_div[coeff].sr << 1) |
+	snd_soc_component_write(component, WM8753_SRATE1, srate | (coeff_div[coeff].sr << 1) |
 		coeff_div[coeff].usb);
 
 	/* bit size */
@@ -1185,70 +1185,70 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_write(codec, WM8753_HIFI, hifi);
+	snd_soc_component_write(component, WM8753_HIFI, hifi);
 	return 0;
 }
 
-static int wm8753_mode1v_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_mode1v_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
 	u16 clock;
 
 	/* set clk source as pcmclk */
-	clock = snd_soc_read(codec, WM8753_CLOCK) & 0xfffb;
-	snd_soc_write(codec, WM8753_CLOCK, clock);
+	clock = snd_soc_component_read32(component, WM8753_CLOCK) & 0xfffb;
+	snd_soc_component_write(component, WM8753_CLOCK, clock);
 
-	return wm8753_vdac_adc_set_dai_fmt(codec, fmt);
+	return wm8753_vdac_adc_set_dai_fmt(component, fmt);
 }
 
-static int wm8753_mode1h_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_mode1h_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
-	return wm8753_hdac_set_dai_fmt(codec, fmt);
+	return wm8753_hdac_set_dai_fmt(component, fmt);
 }
 
-static int wm8753_mode2_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_mode2_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
 	u16 clock;
 
 	/* set clk source as pcmclk */
-	clock = snd_soc_read(codec, WM8753_CLOCK) & 0xfffb;
-	snd_soc_write(codec, WM8753_CLOCK, clock);
+	clock = snd_soc_component_read32(component, WM8753_CLOCK) & 0xfffb;
+	snd_soc_component_write(component, WM8753_CLOCK, clock);
 
-	return wm8753_vdac_adc_set_dai_fmt(codec, fmt);
+	return wm8753_vdac_adc_set_dai_fmt(component, fmt);
 }
 
-static int wm8753_mode3_4_set_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_mode3_4_set_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
 	u16 clock;
 
 	/* set clk source as mclk */
-	clock = snd_soc_read(codec, WM8753_CLOCK) & 0xfffb;
-	snd_soc_write(codec, WM8753_CLOCK, clock | 0x4);
+	clock = snd_soc_component_read32(component, WM8753_CLOCK) & 0xfffb;
+	snd_soc_component_write(component, WM8753_CLOCK, clock | 0x4);
 
-	if (wm8753_hdac_set_dai_fmt(codec, fmt) < 0)
+	if (wm8753_hdac_set_dai_fmt(component, fmt) < 0)
 		return -EINVAL;
-	return wm8753_vdac_adc_set_dai_fmt(codec, fmt);
+	return wm8753_vdac_adc_set_dai_fmt(component, fmt);
 }
 
-static int wm8753_hifi_write_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_hifi_write_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	switch (wm8753->dai_func) {
 	case 0:
-		ret = wm8753_mode1h_set_dai_fmt(codec, fmt);
+		ret = wm8753_mode1h_set_dai_fmt(component, fmt);
 		break;
 	case 1:
-		ret = wm8753_mode2_set_dai_fmt(codec, fmt);
+		ret = wm8753_mode2_set_dai_fmt(component, fmt);
 		break;
 	case 2:
 	case 3:
-		ret = wm8753_mode3_4_set_dai_fmt(codec, fmt);
+		ret = wm8753_mode3_4_set_dai_fmt(component, fmt);
 		break;
 	default:
 		 break;
@@ -1256,33 +1256,33 @@ static int wm8753_hifi_write_dai_fmt(struct snd_soc_codec *codec,
 	if (ret)
 		return ret;
 
-	return wm8753_i2s_set_dai_fmt(codec, fmt);
+	return wm8753_i2s_set_dai_fmt(component, fmt);
 }
 
 static int wm8753_hifi_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	wm8753->hifi_fmt = fmt;
 
-	return wm8753_hifi_write_dai_fmt(codec, fmt);
+	return wm8753_hifi_write_dai_fmt(component, fmt);
 };
 
-static int wm8753_voice_write_dai_fmt(struct snd_soc_codec *codec,
+static int wm8753_voice_write_dai_fmt(struct snd_soc_component *component,
 		unsigned int fmt)
 {
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	if (wm8753->dai_func != 0)
 		return 0;
 
-	ret = wm8753_mode1v_set_dai_fmt(codec, fmt);
+	ret = wm8753_mode1v_set_dai_fmt(component, fmt);
 	if (ret)
 		return ret;
-	ret = wm8753_pcm_set_dai_fmt(codec, fmt);
+	ret = wm8753_pcm_set_dai_fmt(component, fmt);
 	if (ret)
 		return ret;
 
@@ -1292,30 +1292,30 @@ static int wm8753_voice_write_dai_fmt(struct snd_soc_codec *codec,
 static int wm8753_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	wm8753->voice_fmt = fmt;
 
-	return wm8753_voice_write_dai_fmt(codec, fmt);
+	return wm8753_voice_write_dai_fmt(component, fmt);
 };
 
 static int wm8753_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8753_DAC) & 0xfff7;
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8753_DAC) & 0xfff7;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	/* the digital mute covers the HiFi and Voice DAC's on the WM8753.
 	 * make sure we check if they are not both active when we mute */
 	if (mute && wm8753->dai_func == 1) {
-		if (!snd_soc_codec_is_active(codec))
-			snd_soc_write(codec, WM8753_DAC, mute_reg | 0x8);
+		if (!snd_soc_component_is_active(component))
+			snd_soc_component_write(component, WM8753_DAC, mute_reg | 0x8);
 	} else {
 		if (mute)
-			snd_soc_write(codec, WM8753_DAC, mute_reg | 0x8);
+			snd_soc_component_write(component, WM8753_DAC, mute_reg | 0x8);
 		else
-			snd_soc_write(codec, WM8753_DAC, mute_reg);
+			snd_soc_component_write(component, WM8753_DAC, mute_reg);
 	}
 
 	return 0;
@@ -1330,35 +1330,35 @@ static void wm8753_charge_work(struct work_struct *work)
 	regmap_update_bits(wm8753->regmap, WM8753_PWR1, 0x0180, 0x0100);
 }
 
-static int wm8753_set_bias_level(struct snd_soc_codec *codec,
+static int wm8753_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
-	u16 pwr_reg = snd_soc_read(codec, WM8753_PWR1) & 0xfe3e;
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
+	u16 pwr_reg = snd_soc_component_read32(component, WM8753_PWR1) & 0xfe3e;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x00c0);
+		snd_soc_component_write(component, WM8753_PWR1, pwr_reg | 0x00c0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* Wait until fully charged */
 		flush_delayed_work(&wm8753->charge_work);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			/* set vmid to 5k for quick power up */
-			snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x01c1);
+			snd_soc_component_write(component, WM8753_PWR1, pwr_reg | 0x01c1);
 			schedule_delayed_work(&wm8753->charge_work,
 				msecs_to_jiffies(caps_charge));
 		} else {
 			/* mute dac and set vmid to 500k, enable VREF */
-			snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x0141);
+			snd_soc_component_write(component, WM8753_PWR1, pwr_reg | 0x0141);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		cancel_delayed_work_sync(&wm8753->charge_work);
-		snd_soc_write(codec, WM8753_PWR1, 0x0001);
+		snd_soc_component_write(component, WM8753_PWR1, 0x0001);
 		break;
 	}
 	return 0;
@@ -1440,59 +1440,60 @@ static struct snd_soc_dai_driver wm8753_dai[] = {
 },
 };
 
-static int wm8753_resume(struct snd_soc_codec *codec)
+static int wm8753_resume(struct snd_soc_component *component)
 {
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 
 	regcache_sync(wm8753->regmap);
 
 	return 0;
 }
 
-static int wm8753_probe(struct snd_soc_codec *codec)
+static int wm8753_probe(struct snd_soc_component *component)
 {
-	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	struct wm8753_priv *wm8753 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	INIT_DELAYED_WORK(&wm8753->charge_work, wm8753_charge_work);
 
-	ret = wm8753_reset(codec);
+	ret = wm8753_reset(component);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(component->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
 	}
 
 	wm8753->dai_func = 0;
 
 	/* set the update bits */
-	snd_soc_update_bits(codec, WM8753_LDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_RDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_LADC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_RADC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_LOUT1V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_ROUT1V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_LOUT2V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_ROUT2V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_LINVOL, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_RINVOL, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_LDAC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_RDAC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_LADC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_RADC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_LOUT1V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_ROUT1V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_LOUT2V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_ROUT2V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_LINVOL, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8753_RINVOL, 0x0100, 0x0100);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
-	.probe =	wm8753_probe,
-	.resume =	wm8753_resume,
-	.set_bias_level = wm8753_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8753_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8753_snd_controls),
-		.dapm_widgets		= wm8753_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8753_dapm_widgets),
-		.dapm_routes		= wm8753_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8753_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8753 = {
+	.probe			= wm8753_probe,
+	.resume			= wm8753_resume,
+	.set_bias_level		= wm8753_set_bias_level,
+	.controls		= wm8753_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8753_snd_controls),
+	.dapm_widgets		= wm8753_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8753_dapm_widgets),
+	.dapm_routes		= wm8753_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8753_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8753_of_match[] = {
@@ -1534,7 +1535,7 @@ static int wm8753_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_wm8753,
+	ret = devm_snd_soc_register_component(&spi->dev, &soc_component_dev_wm8753,
 				     wm8753_dai, ARRAY_SIZE(wm8753_dai));
 	if (ret != 0)
 		dev_err(&spi->dev, "Failed to register CODEC: %d\n", ret);
@@ -1542,19 +1543,12 @@ static int wm8753_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
-static int wm8753_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver wm8753_spi_driver = {
 	.driver = {
 		.name	= "wm8753",
 		.of_match_table = wm8753_of_match,
 	},
 	.probe		= wm8753_spi_probe,
-	.remove		= wm8753_spi_remove,
 };
 #endif /* CONFIG_SPI_MASTER */
 
@@ -1580,7 +1574,7 @@ static int wm8753_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm8753,
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_dev_wm8753,
 				     wm8753_dai, ARRAY_SIZE(wm8753_dai));
 	if (ret != 0)
 		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
@@ -1588,12 +1582,6 @@ static int wm8753_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int wm8753_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8753_i2c_id[] = {
 	{ "wm8753", 0 },
 	{ }
@@ -1606,7 +1594,6 @@ static struct i2c_driver wm8753_i2c_driver = {
 		.of_match_table = wm8753_of_match,
 	},
 	.probe =    wm8753_i2c_probe,
-	.remove =   wm8753_i2c_remove,
 	.id_table = wm8753_i2c_id,
 };
 #endif
-- 
2.16.1
