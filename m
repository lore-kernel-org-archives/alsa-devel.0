From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH v2] ASoC: pcm512x: Allow independently overclocking PLL, DAC and DSP
Date: Mon, 23 Feb 2015 21:03:33 +0100
Message-ID: <1424721813-6137-2-git-send-email-peda@lysator.liu.se>
References: <20150223143132.GD6236@finisterre.sirena.org.uk>
 <1424721813-6137-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424721813-6137-1-git-send-email-peda@lysator.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Peter Rosin <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

When using non-standard rates, a relatively small amount of overclocking
can make a big difference to a number of cases.

- Not all rates are possible to achieve with the PLL, due to divider
  restrictions.

- The higher oversampling rates that can be used by the DAC, the
  simpler the analog output filters get (mirror frequencies move up,
  away from the desired spectrum).

- The more work the DSP can perform per sample, the better.

For standard rates, there is little to gain as everything is
designed just right, and the needed overclocking to make a
real difference would be significant.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/pcm512x.c |  161 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index f11c76f1acfe..4b5f1fe9be97 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -54,6 +54,9 @@ struct pcm512x_priv {
 	int pll_d;
 	int pll_p;
 	unsigned long real_pll;
+	unsigned long overclock_pll;
+	unsigned long overclock_dac;
+	unsigned long overclock_dsp;
 };
 
 /*
@@ -224,6 +227,90 @@ static bool pcm512x_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
+static int pcm512x_overclock_pll_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = pcm512x->overclock_pll;
+	return 0;
+}
+
+static int pcm512x_overclock_pll_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	switch (codec->dapm.bias_level) {
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	pcm512x->overclock_pll = ucontrol->value.integer.value[0];
+	return 0;
+}
+
+static int pcm512x_overclock_dsp_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = pcm512x->overclock_dsp;
+	return 0;
+}
+
+static int pcm512x_overclock_dsp_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	switch (codec->dapm.bias_level) {
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	pcm512x->overclock_dsp = ucontrol->value.integer.value[0];
+	return 0;
+}
+
+static int pcm512x_overclock_dac_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = pcm512x->overclock_dac;
+	return 0;
+}
+
+static int pcm512x_overclock_dac_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
+
+	switch (codec->dapm.bias_level) {
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_STANDBY:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	pcm512x->overclock_dac = ucontrol->value.integer.value[0];
+	return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -10350, 50, 1);
 static const DECLARE_TLV_DB_SCALE(analog_tlv, -600, 600, 0);
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 0, 80, 0);
@@ -328,6 +415,13 @@ SOC_ENUM("Volume Ramp Up Rate", pcm512x_vnuf),
 SOC_ENUM("Volume Ramp Up Step", pcm512x_vnus),
 SOC_ENUM("Volume Ramp Down Emergency Rate", pcm512x_vedf),
 SOC_ENUM("Volume Ramp Down Emergency Step", pcm512x_veds),
+
+SOC_SINGLE_EXT("Max Overclock PLL", SND_SOC_NOPM, 0, 20, 0,
+	       pcm512x_overclock_pll_get, pcm512x_overclock_pll_put),
+SOC_SINGLE_EXT("Max Overclock DSP", SND_SOC_NOPM, 0, 40, 0,
+	       pcm512x_overclock_dsp_get, pcm512x_overclock_dsp_put),
+SOC_SINGLE_EXT("Max Overclock DAC", SND_SOC_NOPM, 0, 40, 0,
+	       pcm512x_overclock_dac_get, pcm512x_overclock_dac_put),
 };
 
 static const struct snd_soc_dapm_widget pcm512x_dapm_widgets[] = {
@@ -346,6 +440,45 @@ static const struct snd_soc_dapm_route pcm512x_dapm_routes[] = {
 	{ "OUTR", NULL, "DACR" },
 };
 
+static unsigned long pcm512x_pll_max(struct pcm512x_priv *pcm512x)
+{
+	return 25000000 + 25000000 * pcm512x->overclock_pll / 100;
+}
+
+static unsigned long pcm512x_dsp_max(struct pcm512x_priv *pcm512x)
+{
+	return 50000000 + 50000000 * pcm512x->overclock_dsp / 100;
+}
+
+static unsigned long pcm512x_dac_max(struct pcm512x_priv *pcm512x,
+				     unsigned long rate)
+{
+	return rate + rate * pcm512x->overclock_dac / 100;
+}
+
+static unsigned long pcm512x_sck_max(struct pcm512x_priv *pcm512x)
+{
+	if (!pcm512x->pll_out)
+		return 25000000;
+	return pcm512x_pll_max(pcm512x);
+}
+
+static unsigned long pcm512x_ncp_target(struct pcm512x_priv *pcm512x,
+					unsigned long dac_rate)
+{
+	/*
+	 * If the DAC is not actually overclocked, use the good old
+	 * NCP target rate...
+	 */
+	if (dac_rate <= 6144000)
+		return 1536000;
+	/*
+	 * ...but if the DAC is in fact overclocked, bump the NCP target
+	 * rate to get the recommended dividers even when overclocking.
+	 */
+	return pcm512x_dac_max(pcm512x, 1536000);
+}
+
 static const u32 pcm512x_dai_rates[] = {
 	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000,
 	88200, 96000, 176400, 192000, 384000,
@@ -359,6 +492,7 @@ static const struct snd_pcm_hw_constraint_list constraints_slave = {
 static int pcm512x_hw_rule_rate(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
+	struct pcm512x_priv *pcm512x = rule->private;
 	struct snd_interval ranges[2];
 	int frame_size;
 
@@ -377,7 +511,7 @@ static int pcm512x_hw_rule_rate(struct snd_pcm_hw_params *params,
 		 */
 		memset(ranges, 0, sizeof(ranges));
 		ranges[0].min = 8000;
-		ranges[0].max = 25000000 / frame_size / 2;
+		ranges[0].max = pcm512x_sck_max(pcm512x) / frame_size / 2;
 		ranges[1].min = DIV_ROUND_UP(16000000, frame_size);
 		ranges[1].max = 384000;
 		break;
@@ -408,7 +542,7 @@ static int pcm512x_dai_startup_master(struct snd_pcm_substream *substream,
 		return snd_pcm_hw_rule_add(substream->runtime, 0,
 					   SNDRV_PCM_HW_PARAM_RATE,
 					   pcm512x_hw_rule_rate,
-					   NULL,
+					   pcm512x,
 					   SNDRV_PCM_HW_PARAM_FRAME_BITS,
 					   SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
@@ -517,6 +651,8 @@ static unsigned long pcm512x_find_sck(struct snd_soc_dai *dai,
 				      unsigned long bclk_rate)
 {
 	struct device *dev = dai->dev;
+	struct snd_soc_codec *codec = dai->codec;
+	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
 	unsigned long sck_rate;
 	int pow2;
 
@@ -527,9 +663,10 @@ static unsigned long pcm512x_find_sck(struct snd_soc_dai *dai,
 	 * as many factors of 2 as possible, as that makes it easier
 	 * to find a fast DAC rate
 	 */
-	pow2 = 1 << fls((25000000 - 16000000) / bclk_rate);
+	pow2 = 1 << fls((pcm512x_pll_max(pcm512x) - 16000000) / bclk_rate);
 	for (; pow2; pow2 >>= 1) {
-		sck_rate = rounddown(25000000, bclk_rate * pow2);
+		sck_rate = rounddown(pcm512x_pll_max(pcm512x),
+				     bclk_rate * pow2);
 		if (sck_rate >= 16000000)
 			break;
 	}
@@ -678,7 +815,7 @@ static unsigned long pcm512x_pllin_dac_rate(struct snd_soc_dai *dai,
 		return 0; /* futile, quit early */
 
 	/* run DAC no faster than 6144000 Hz */
-	for (dac_rate = rounddown(6144000, osr_rate);
+	for (dac_rate = rounddown(pcm512x_dac_max(pcm512x, 6144000), osr_rate);
 	     dac_rate;
 	     dac_rate -= osr_rate) {
 
@@ -805,7 +942,7 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 	osr_rate = 16 * sample_rate;
 
 	/* run DSP no faster than 50 MHz */
-	dsp_div = mck_rate > 50000000 ? 2 : 1;
+	dsp_div = mck_rate > pcm512x_dsp_max(pcm512x) ? 2 : 1;
 
 	dac_rate = pcm512x_pllin_dac_rate(dai, osr_rate, pllin_rate);
 	if (dac_rate) {
@@ -836,7 +973,8 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 		dacsrc_rate = pllin_rate;
 	} else {
 		/* run DAC no faster than 6144000 Hz */
-		unsigned long dac_mul = 6144000 / osr_rate;
+		unsigned long dac_mul = pcm512x_dac_max(pcm512x, 6144000)
+			/ osr_rate;
 		unsigned long sck_mul = sck_rate / osr_rate;
 
 		for (; dac_mul; dac_mul--) {
@@ -876,7 +1014,8 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 	}
 	dac_rate = dacsrc_rate / dac_div;
 
-	ncp_div = DIV_ROUND_CLOSEST(dac_rate, 1536000);
+	ncp_div = DIV_ROUND_CLOSEST(dac_rate,
+				    pcm512x_ncp_target(pcm512x, dac_rate));
 	if (ncp_div > 128 || dac_rate / ncp_div > 2048000) {
 		/* run NCP no faster than 2048000 Hz, but why? */
 		ncp_div = DIV_ROUND_UP(dac_rate, 2048000);
@@ -938,11 +1077,11 @@ static int pcm512x_set_dividers(struct snd_soc_dai *dai,
 		return ret;
 	}
 
-	if (sample_rate <= 48000)
+	if (sample_rate <= pcm512x_dac_max(pcm512x, 48000))
 		fssp = PCM512x_FSSP_48KHZ;
-	else if (sample_rate <= 96000)
+	else if (sample_rate <= pcm512x_dac_max(pcm512x, 96000))
 		fssp = PCM512x_FSSP_96KHZ;
-	else if (sample_rate <= 192000)
+	else if (sample_rate <= pcm512x_dac_max(pcm512x, 192000))
 		fssp = PCM512x_FSSP_192KHZ;
 	else
 		fssp = PCM512x_FSSP_384KHZ;
-- 
1.7.10.4
