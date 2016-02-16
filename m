From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 9/9] ASoC: msm8x16: add dapm routes
Date: Tue, 16 Feb 2016 17:33:48 +0000
Message-ID: <1455644028-2015-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds basic dapm routes to the codec driver, other routes are
configured based on the board wiring.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8x16-wcd.c | 148 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
index f1ae55d..1a73c57 100644
--- a/sound/soc/codecs/msm8x16-wcd.c
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -1876,6 +1876,152 @@ static int msm8x16_wcd_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"RX_I2S_CLK", NULL, "CDC_CONN"},
+	{"I2S RX1", NULL, "RX_I2S_CLK"},
+	{"I2S RX2", NULL, "RX_I2S_CLK"},
+	{"I2S RX3", NULL, "RX_I2S_CLK"},
+
+	{"I2S TX1", NULL, "TX_I2S_CLK"},
+	{"I2S TX2", NULL, "TX_I2S_CLK"},
+
+	{"I2S TX1", NULL, "DEC1 MUX"},
+	{"I2S TX2", NULL, "DEC2 MUX"},
+
+	/* RDAC Connections */
+	{"HPHR DAC", NULL, "RDAC2 MUX"},
+	{"RDAC2 MUX", "RX1", "RX1 CHAIN"},
+	{"RDAC2 MUX", "RX2", "RX2 CHAIN"},
+
+	/* Earpiece (RX MIX1) */
+	{"EAR", NULL, "EAR_S"},
+	{"EAR_S", "Switch", "EAR PA"},
+	{"EAR PA", NULL, "RX_BIAS"},
+	{"EAR PA", NULL, "HPHL DAC"},
+	{"EAR PA", NULL, "HPHR DAC"},
+	{"EAR PA", NULL, "EAR CP"},
+
+	/* Headset (RX MIX1 and RX MIX2) */
+	{"HEADPHONE", NULL, "HPHL PA"},
+	{"HEADPHONE", NULL, "HPHR PA"},
+
+	{"HPHL PA", NULL, "HPHL"},
+	{"HPHR PA", NULL, "HPHR"},
+	{"HPHL", "Switch", "HPHL DAC"},
+	{"HPHR", "Switch", "HPHR DAC"},
+	{"HPHL PA", NULL, "CP"},
+	{"HPHL PA", NULL, "RX_BIAS"},
+	{"HPHR PA", NULL, "CP"},
+	{"HPHR PA", NULL, "RX_BIAS"},
+	{"HPHL DAC", NULL, "RX1 CHAIN"},
+
+	{"SPK_OUT", NULL, "SPK PA"},
+	{"SPK PA", NULL, "SPK_RX_BIAS"},
+	{"SPK PA", NULL, "SPK DAC"},
+	{"SPK DAC", "Switch", "RX3 CHAIN"},
+	{"SPK DAC", NULL, "VDD_SPKDRV"},
+
+	{"RX1 CHAIN", NULL, "RX1 CLK"},
+	{"RX2 CHAIN", NULL, "RX2 CLK"},
+	{"RX3 CHAIN", NULL, "RX3 CLK"},
+	{"RX1 CHAIN", NULL, "RX1 MIX2"},
+	{"RX2 CHAIN", NULL, "RX2 MIX2"},
+	{"RX3 CHAIN", NULL, "RX3 MIX1"},
+
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP1"},
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP2"},
+	{"RX1 MIX1", NULL, "RX1 MIX1 INP3"},
+	{"RX2 MIX1", NULL, "RX2 MIX1 INP1"},
+	{"RX2 MIX1", NULL, "RX2 MIX1 INP2"},
+	{"RX3 MIX1", NULL, "RX3 MIX1 INP1"},
+	{"RX3 MIX1", NULL, "RX3 MIX1 INP2"},
+	{"RX1 MIX2", NULL, "RX1 MIX1"},
+	{"RX1 MIX2", NULL, "RX1 MIX2 INP1"},
+	{"RX2 MIX2", NULL, "RX2 MIX1"},
+	{"RX2 MIX2", NULL, "RX2 MIX2 INP1"},
+
+	{"RX1 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP1", "IIR2", "IIR2"},
+	{"RX1 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX1 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX1 MIX1 INP2", "IIR2", "IIR2"},
+	{"RX1 MIX1 INP3", "RX1", "I2S RX1"},
+	{"RX1 MIX1 INP3", "RX2", "I2S RX2"},
+	{"RX1 MIX1 INP3", "RX3", "I2S RX3"},
+
+	{"RX2 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX2 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX2 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP1", "IIR2", "IIR2"},
+	{"RX2 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX2 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX2 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX2 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX2 MIX1 INP2", "IIR2", "IIR2"},
+
+	{"RX3 MIX1 INP1", "RX1", "I2S RX1"},
+	{"RX3 MIX1 INP1", "RX2", "I2S RX2"},
+	{"RX3 MIX1 INP1", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP1", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP1", "IIR2", "IIR2"},
+	{"RX3 MIX1 INP2", "RX1", "I2S RX1"},
+	{"RX3 MIX1 INP2", "RX2", "I2S RX2"},
+	{"RX3 MIX1 INP2", "RX3", "I2S RX3"},
+	{"RX3 MIX1 INP2", "IIR1", "IIR1"},
+	{"RX3 MIX1 INP2", "IIR2", "IIR2"},
+
+	{"RX1 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX2 MIX2 INP1", "IIR1", "IIR1"},
+	{"RX1 MIX2 INP1", "IIR2", "IIR2"},
+	{"RX2 MIX2 INP1", "IIR2", "IIR2"},
+
+	/* Decimator Inputs */
+	{"DEC1 MUX", "DMIC1", "DMIC1"},
+	{"DEC1 MUX", "DMIC2", "DMIC2"},
+	{"DEC1 MUX", "ADC1", "ADC1"},
+	{"DEC1 MUX", "ADC2", "ADC2"},
+	{"DEC1 MUX", "ADC3", "ADC3"},
+	{"DEC1 MUX", NULL, "CDC_CONN"},
+
+	{"DEC2 MUX", "DMIC1", "DMIC1"},
+	{"DEC2 MUX", "DMIC2", "DMIC2"},
+	{"DEC2 MUX", "ADC1", "ADC1"},
+	{"DEC2 MUX", "ADC2", "ADC2"},
+	{"DEC2 MUX", "ADC3", "ADC3"},
+	{"DEC2 MUX", NULL, "CDC_CONN"},
+
+	/* ADC Connections */
+	{"ADC2", NULL, "ADC2 MUX"},
+	{"ADC3", NULL, "ADC2 MUX"},
+	{"ADC2 MUX", "INP2", "ADC2_INP2"},
+	{"ADC2 MUX", "INP3", "ADC2_INP3"},
+
+	{"ADC1", NULL, "AMIC1"},
+	{"ADC2_INP2", NULL, "AMIC2"},
+	{"ADC2_INP3", NULL, "AMIC3"},
+
+	{"IIR1", NULL, "IIR1 INP1 MUX"},
+	{"IIR1 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR1 INP1 MUX", "DEC2", "DEC2 MUX"},
+	{"IIR2", NULL, "IIR2 INP1 MUX"},
+	{"IIR2 INP1 MUX", "DEC1", "DEC1 MUX"},
+	{"IIR2 INP1 MUX", "DEC2", "DEC2 MUX"},
+	{"MIC BIAS Internal1", NULL, "INT_LDO_H"},
+	{"MIC BIAS Internal2", NULL, "INT_LDO_H"},
+	{"MIC BIAS External", NULL, "INT_LDO_H"},
+	{"MIC BIAS External2", NULL, "INT_LDO_H"},
+	{"MIC BIAS Internal1", NULL, "MICBIAS_REGULATOR"},
+	{"MIC BIAS Internal2", NULL, "MICBIAS_REGULATOR"},
+	{"MIC BIAS External", NULL, "MICBIAS_REGULATOR"},
+	{"MIC BIAS External2", NULL, "MICBIAS_REGULATOR"},
+};
+
 static struct snd_soc_dai_ops msm8x16_wcd_dai_ops = {
 	.startup = msm8x16_wcd_startup,
 	.shutdown = msm8x16_wcd_shutdown,
@@ -1928,6 +2074,8 @@ static struct snd_soc_codec_driver msm8x16_wcd_codec = {
 	.num_controls = ARRAY_SIZE(msm8x16_wcd_snd_controls),
 	.dapm_widgets = msm8x16_wcd_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(msm8x16_wcd_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static int msm8x16_wcd_probe(struct platform_device *pdev)
-- 
1.9.1
