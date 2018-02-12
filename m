From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8400: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:51:14 +0000
Message-ID: <E1elDZi-0006Me-6z@debutante>
References: <877es15q1t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B1BA8267B33
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:51:16 +0100 (CET)
In-Reply-To: <877es15q1t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8400: replace codec to component

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

>From 10dc44c6462db0a4b60efa3add18684205088583 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:00:04 +0000
Subject: [PATCH] ASoC: wm8400: replace codec to component

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
 sound/soc/codecs/wm8400.c | 211 ++++++++++++++++++++++------------------------
 1 file changed, 102 insertions(+), 109 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index a36adf881bca..c237365d1184 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -65,9 +65,9 @@ struct wm8400_priv {
 	int fll_in, fll_out;
 };
 
-static void wm8400_codec_reset(struct snd_soc_codec *codec)
+static void wm8400_component_reset(struct snd_soc_component *component)
 {
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
+	struct wm8400_priv *wm8400 = snd_soc_component_get_drvdata(component);
 
 	wm8400_reset_codec_reg_cache(wm8400->wm8400);
 }
@@ -91,7 +91,7 @@ static const DECLARE_TLV_DB_SCALE(out_sidetone_tlv, -3600, 0, 0);
 static int wm8400_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
         struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int reg = mc->reg;
@@ -103,8 +103,8 @@ static int wm8400_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
                 return ret;
 
         /* now hit the volume update bits (always bit 8) */
-        val = snd_soc_read(codec, reg);
-        return snd_soc_write(codec, reg, val | 0x0100);
+        val = snd_soc_component_read32(component, reg);
+        return snd_soc_component_write(component, reg, val | 0x0100);
 }
 
 #define WM8400_OUTPGA_SINGLE_R_TLV(xname, reg, shift, max, invert, tlv_array) \
@@ -324,7 +324,7 @@ SOC_SINGLE("RIN34 Mute Switch", WM8400_RIGHT_LINE_INPUT_3_4_VOLUME,
 static int outmixer_event (struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol * kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	u32 reg_shift = mc->shift;
@@ -333,7 +333,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 
 	switch (reg_shift) {
 	case WM8400_SPEAKER_MIXER | (WM8400_LDSPK << 8) :
-		reg = snd_soc_read(codec, WM8400_OUTPUT_MIXER1);
+		reg = snd_soc_component_read32(component, WM8400_OUTPUT_MIXER1);
 		if (reg & WM8400_LDLO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 1 LDLO Set\n");
@@ -341,7 +341,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8400_SPEAKER_MIXER | (WM8400_RDSPK << 8):
-		reg = snd_soc_read(codec, WM8400_OUTPUT_MIXER2);
+		reg = snd_soc_component_read32(component, WM8400_OUTPUT_MIXER2);
 		if (reg & WM8400_RDRO) {
 			printk(KERN_WARNING
 			"Cannot set as Output Mixer 2 RDRO Set\n");
@@ -349,7 +349,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8400_OUTPUT_MIXER1 | (WM8400_LDLO << 8):
-		reg = snd_soc_read(codec, WM8400_SPEAKER_MIXER);
+		reg = snd_soc_component_read32(component, WM8400_SPEAKER_MIXER);
 		if (reg & WM8400_LDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer LDSPK Set\n");
@@ -357,7 +357,7 @@ static int outmixer_event (struct snd_soc_dapm_widget *w,
 		}
 		break;
 	case WM8400_OUTPUT_MIXER2 | (WM8400_RDRO << 8):
-		reg = snd_soc_read(codec, WM8400_SPEAKER_MIXER);
+		reg = snd_soc_component_read32(component, WM8400_SPEAKER_MIXER);
 		if (reg & WM8400_RDSPK) {
 			printk(KERN_WARNING
 			"Cannot set as Speaker Mixer RDSPK Set\n");
@@ -849,8 +849,8 @@ static const struct snd_soc_dapm_route wm8400_dapm_routes[] = {
 static int wm8400_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8400_priv *wm8400 = snd_soc_component_get_drvdata(component);
 
 	wm8400->sysclk = freq;
 	return 0;
@@ -938,8 +938,8 @@ static int wm8400_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 			      int source, unsigned int freq_in,
 			      unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8400_priv *wm8400 = snd_soc_component_get_drvdata(component);
 	struct fll_factors factors;
 	int ret;
 	u16 reg;
@@ -962,13 +962,13 @@ static int wm8400_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	wm8400->fll_in = freq_in;
 
 	/* We *must* disable the FLL before any changes */
-	reg = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_2);
+	reg = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_2);
 	reg &= ~WM8400_FLL_ENA;
-	snd_soc_write(codec, WM8400_POWER_MANAGEMENT_2, reg);
+	snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_2, reg);
 
-	reg = snd_soc_read(codec, WM8400_FLL_CONTROL_1);
+	reg = snd_soc_component_read32(component, WM8400_FLL_CONTROL_1);
 	reg &= ~WM8400_FLL_OSC_ENA;
-	snd_soc_write(codec, WM8400_FLL_CONTROL_1, reg);
+	snd_soc_component_write(component, WM8400_FLL_CONTROL_1, reg);
 
 	if (!freq_out)
 		return 0;
@@ -976,15 +976,15 @@ static int wm8400_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	reg &= ~(WM8400_FLL_REF_FREQ | WM8400_FLL_FRATIO_MASK);
 	reg |= WM8400_FLL_FRAC | factors.fratio;
 	reg |= factors.freq_ref << WM8400_FLL_REF_FREQ_SHIFT;
-	snd_soc_write(codec, WM8400_FLL_CONTROL_1, reg);
+	snd_soc_component_write(component, WM8400_FLL_CONTROL_1, reg);
 
-	snd_soc_write(codec, WM8400_FLL_CONTROL_2, factors.k);
-	snd_soc_write(codec, WM8400_FLL_CONTROL_3, factors.n);
+	snd_soc_component_write(component, WM8400_FLL_CONTROL_2, factors.k);
+	snd_soc_component_write(component, WM8400_FLL_CONTROL_3, factors.n);
 
-	reg = snd_soc_read(codec, WM8400_FLL_CONTROL_4);
+	reg = snd_soc_component_read32(component, WM8400_FLL_CONTROL_4);
 	reg &= ~WM8400_FLL_OUTDIV_MASK;
 	reg |= factors.outdiv;
-	snd_soc_write(codec, WM8400_FLL_CONTROL_4, reg);
+	snd_soc_component_write(component, WM8400_FLL_CONTROL_4, reg);
 
 	return 0;
 }
@@ -995,11 +995,11 @@ static int wm8400_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static int wm8400_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 audio1, audio3;
 
-	audio1 = snd_soc_read(codec, WM8400_AUDIO_INTERFACE_1);
-	audio3 = snd_soc_read(codec, WM8400_AUDIO_INTERFACE_3);
+	audio1 = snd_soc_component_read32(component, WM8400_AUDIO_INTERFACE_1);
+	audio3 = snd_soc_component_read32(component, WM8400_AUDIO_INTERFACE_3);
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1040,37 +1040,37 @@ static int wm8400_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8400_AUDIO_INTERFACE_1, audio1);
-	snd_soc_write(codec, WM8400_AUDIO_INTERFACE_3, audio3);
+	snd_soc_component_write(component, WM8400_AUDIO_INTERFACE_1, audio1);
+	snd_soc_component_write(component, WM8400_AUDIO_INTERFACE_3, audio3);
 	return 0;
 }
 
 static int wm8400_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 reg;
 
 	switch (div_id) {
 	case WM8400_MCLK_DIV:
-		reg = snd_soc_read(codec, WM8400_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8400_CLOCKING_2) &
 			~WM8400_MCLK_DIV_MASK;
-		snd_soc_write(codec, WM8400_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8400_CLOCKING_2, reg | div);
 		break;
 	case WM8400_DACCLK_DIV:
-		reg = snd_soc_read(codec, WM8400_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8400_CLOCKING_2) &
 			~WM8400_DAC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8400_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8400_CLOCKING_2, reg | div);
 		break;
 	case WM8400_ADCCLK_DIV:
-		reg = snd_soc_read(codec, WM8400_CLOCKING_2) &
+		reg = snd_soc_component_read32(component, WM8400_CLOCKING_2) &
 			~WM8400_ADC_CLKDIV_MASK;
-		snd_soc_write(codec, WM8400_CLOCKING_2, reg | div);
+		snd_soc_component_write(component, WM8400_CLOCKING_2, reg | div);
 		break;
 	case WM8400_BCLK_DIV:
-		reg = snd_soc_read(codec, WM8400_CLOCKING_1) &
+		reg = snd_soc_component_read32(component, WM8400_CLOCKING_1) &
 			~WM8400_BCLK_DIV_MASK;
-		snd_soc_write(codec, WM8400_CLOCKING_1, reg | div);
+		snd_soc_component_write(component, WM8400_CLOCKING_1, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -1086,8 +1086,8 @@ static int wm8400_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 audio1 = snd_soc_read(codec, WM8400_AUDIO_INTERFACE_1);
+	struct snd_soc_component *component = dai->component;
+	u16 audio1 = snd_soc_component_read32(component, WM8400_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8400_AIF_WL_MASK;
 	/* bit size */
@@ -1105,28 +1105,28 @@ static int wm8400_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_write(codec, WM8400_AUDIO_INTERFACE_1, audio1);
+	snd_soc_component_write(component, WM8400_AUDIO_INTERFACE_1, audio1);
 	return 0;
 }
 
 static int wm8400_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 val = snd_soc_read(codec, WM8400_DAC_CTRL) & ~WM8400_DAC_MUTE;
+	struct snd_soc_component *component = dai->component;
+	u16 val = snd_soc_component_read32(component, WM8400_DAC_CTRL) & ~WM8400_DAC_MUTE;
 
 	if (mute)
-		snd_soc_write(codec, WM8400_DAC_CTRL, val | WM8400_DAC_MUTE);
+		snd_soc_component_write(component, WM8400_DAC_CTRL, val | WM8400_DAC_MUTE);
 	else
-		snd_soc_write(codec, WM8400_DAC_CTRL, val);
+		snd_soc_component_write(component, WM8400_DAC_CTRL, val);
 
 	return 0;
 }
 
 /* TODO: set bias for best performance at standby */
-static int wm8400_set_bias_level(struct snd_soc_codec *codec,
+static int wm8400_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8400_priv *wm8400 = snd_soc_codec_get_drvdata(codec);
+	struct wm8400_priv *wm8400 = snd_soc_component_get_drvdata(component);
 	u16 val;
 	int ret;
 
@@ -1136,13 +1136,13 @@ static int wm8400_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID=2*50k */
-		val = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1) &
+		val = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1) &
 			~WM8400_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val | 0x2);
+		snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val | 0x2);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(power),
 						    &power[0]);
 			if (ret != 0) {
@@ -1152,74 +1152,74 @@ static int wm8400_set_bias_level(struct snd_soc_codec *codec,
 				return ret;
 			}
 
-			snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1,
+			snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1,
 				     WM8400_CODEC_ENA | WM8400_SYSCLK_ENA);
 
 			/* Enable POBCTRL, SOFT_ST, VMIDTOG and BUFDCOPEN */
-			snd_soc_write(codec, WM8400_ANTIPOP2, WM8400_SOFTST |
+			snd_soc_component_write(component, WM8400_ANTIPOP2, WM8400_SOFTST |
 				     WM8400_BUFDCOPEN | WM8400_POBCTRL);
 
 			msleep(50);
 
 			/* Enable VREF & VMID at 2x50k */
-			val = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1);
+			val = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1);
 			val |= 0x2 | WM8400_VREF_ENA;
-			snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val);
+			snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val);
 
 			/* Enable BUFIOEN */
-			snd_soc_write(codec, WM8400_ANTIPOP2, WM8400_SOFTST |
+			snd_soc_component_write(component, WM8400_ANTIPOP2, WM8400_SOFTST |
 				     WM8400_BUFDCOPEN | WM8400_POBCTRL |
 				     WM8400_BUFIOEN);
 
 			/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-			snd_soc_write(codec, WM8400_ANTIPOP2, WM8400_BUFIOEN);
+			snd_soc_component_write(component, WM8400_ANTIPOP2, WM8400_BUFIOEN);
 		}
 
 		/* VMID=2*300k */
-		val = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1) &
+		val = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1) &
 			~WM8400_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val | 0x4);
+		snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val | 0x4);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Enable POBCTRL and SOFT_ST */
-		snd_soc_write(codec, WM8400_ANTIPOP2, WM8400_SOFTST |
+		snd_soc_component_write(component, WM8400_ANTIPOP2, WM8400_SOFTST |
 			WM8400_POBCTRL | WM8400_BUFIOEN);
 
 		/* Enable POBCTRL, SOFT_ST and BUFDCOPEN */
-		snd_soc_write(codec, WM8400_ANTIPOP2, WM8400_SOFTST |
+		snd_soc_component_write(component, WM8400_ANTIPOP2, WM8400_SOFTST |
 			WM8400_BUFDCOPEN | WM8400_POBCTRL |
 			WM8400_BUFIOEN);
 
 		/* mute DAC */
-		val = snd_soc_read(codec, WM8400_DAC_CTRL);
-		snd_soc_write(codec, WM8400_DAC_CTRL, val | WM8400_DAC_MUTE);
+		val = snd_soc_component_read32(component, WM8400_DAC_CTRL);
+		snd_soc_component_write(component, WM8400_DAC_CTRL, val | WM8400_DAC_MUTE);
 
 		/* Enable any disabled outputs */
-		val = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1);
+		val = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1);
 		val |= WM8400_SPK_ENA | WM8400_OUT3_ENA |
 			WM8400_OUT4_ENA | WM8400_LOUT_ENA |
 			WM8400_ROUT_ENA;
-		snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val);
+		snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val);
 
 		/* Disable VMID */
 		val &= ~WM8400_VMID_MODE_MASK;
-		snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val);
+		snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val);
 
 		msleep(300);
 
 		/* Enable all output discharge bits */
-		snd_soc_write(codec, WM8400_ANTIPOP1, WM8400_DIS_LLINE |
+		snd_soc_component_write(component, WM8400_ANTIPOP1, WM8400_DIS_LLINE |
 			WM8400_DIS_RLINE | WM8400_DIS_OUT3 |
 			WM8400_DIS_OUT4 | WM8400_DIS_LOUT |
 			WM8400_DIS_ROUT);
 
 		/* Disable VREF */
 		val &= ~WM8400_VREF_ENA;
-		snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, val);
+		snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, val);
 
 		/* disable POBCTRL, SOFT_ST and BUFDCOPEN */
-		snd_soc_write(codec, WM8400_ANTIPOP2, 0x0);
+		snd_soc_component_write(component, WM8400_ANTIPOP2, 0x0);
 
 		ret = regulator_bulk_disable(ARRAY_SIZE(power),
 					     &power[0]);
@@ -1273,93 +1273,86 @@ static struct snd_soc_dai_driver wm8400_dai = {
 	.ops = &wm8400_dai_ops,
 };
 
-static int wm8400_codec_probe(struct snd_soc_codec *codec)
+static int wm8400_component_probe(struct snd_soc_component *component)
 {
-	struct wm8400 *wm8400 = dev_get_platdata(codec->dev);
+	struct wm8400 *wm8400 = dev_get_platdata(component->dev);
 	struct wm8400_priv *priv;
 	int ret;
 	u16 reg;
 
-	priv = devm_kzalloc(codec->dev, sizeof(struct wm8400_priv),
+	priv = devm_kzalloc(component->dev, sizeof(struct wm8400_priv),
 			    GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	snd_soc_codec_init_regmap(codec, wm8400->regmap);
-	snd_soc_codec_set_drvdata(codec, priv);
+	snd_soc_component_init_regmap(component, wm8400->regmap);
+	snd_soc_component_set_drvdata(component, priv);
 	priv->wm8400 = wm8400;
 
 	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to get regulators: %d\n", ret);
+		dev_err(component->dev, "Failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
-	wm8400_codec_reset(codec);
+	wm8400_component_reset(component);
 
-	reg = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1);
-	snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1, reg | WM8400_CODEC_ENA);
+	reg = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1);
+	snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1, reg | WM8400_CODEC_ENA);
 
 	/* Latch volume update bits */
-	reg = snd_soc_read(codec, WM8400_LEFT_LINE_INPUT_1_2_VOLUME);
-	snd_soc_write(codec, WM8400_LEFT_LINE_INPUT_1_2_VOLUME,
+	reg = snd_soc_component_read32(component, WM8400_LEFT_LINE_INPUT_1_2_VOLUME);
+	snd_soc_component_write(component, WM8400_LEFT_LINE_INPUT_1_2_VOLUME,
 		     reg & WM8400_IPVU);
-	reg = snd_soc_read(codec, WM8400_RIGHT_LINE_INPUT_1_2_VOLUME);
-	snd_soc_write(codec, WM8400_RIGHT_LINE_INPUT_1_2_VOLUME,
+	reg = snd_soc_component_read32(component, WM8400_RIGHT_LINE_INPUT_1_2_VOLUME);
+	snd_soc_component_write(component, WM8400_RIGHT_LINE_INPUT_1_2_VOLUME,
 		     reg & WM8400_IPVU);
 
-	snd_soc_write(codec, WM8400_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
-	snd_soc_write(codec, WM8400_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
+	snd_soc_component_write(component, WM8400_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
+	snd_soc_component_write(component, WM8400_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
 	return 0;
 }
 
-static int  wm8400_codec_remove(struct snd_soc_codec *codec)
+static void  wm8400_component_remove(struct snd_soc_component *component)
 {
 	u16 reg;
 
-	reg = snd_soc_read(codec, WM8400_POWER_MANAGEMENT_1);
-	snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1,
+	reg = snd_soc_component_read32(component, WM8400_POWER_MANAGEMENT_1);
+	snd_soc_component_write(component, WM8400_POWER_MANAGEMENT_1,
 		     reg & (~WM8400_CODEC_ENA));
-
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
-	.probe =	wm8400_codec_probe,
-	.remove =	wm8400_codec_remove,
-	.set_bias_level = wm8400_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8400_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8400_snd_controls),
-		.dapm_widgets		= wm8400_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8400_dapm_widgets),
-		.dapm_routes		= wm8400_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8400_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8400 = {
+	.probe			= wm8400_component_probe,
+	.remove			= wm8400_component_remove,
+	.set_bias_level		= wm8400_set_bias_level,
+	.controls		= wm8400_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8400_snd_controls),
+	.dapm_widgets		= wm8400_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8400_dapm_widgets),
+	.dapm_routes		= wm8400_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8400_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm8400_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8400,
+	return snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_wm8400,
 			&wm8400_dai, 1);
 }
 
-static int wm8400_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver wm8400_codec_driver = {
 	.driver = {
 		   .name = "wm8400-codec",
 		   },
 	.probe = wm8400_probe,
-	.remove = wm8400_remove,
 };
 
 module_platform_driver(wm8400_codec_driver);
-- 
2.16.1
