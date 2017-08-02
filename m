From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 3/3] ASoC: codecs: msm8916-wcd-digital: add CIC filter source selection path
Date: Wed,  2 Aug 2017 15:17:48 +0200
Message-ID: <20170802131748.10958-4-srinivas.kandagatla@linaro.org>
References: <20170802131748.10958-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802131748.10958-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch fixes a missing selection of DMIC in CIC filter source path
to dapm route. Without this patch dmic is not functional.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 825cc7d..d2993e7 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -218,6 +218,8 @@ static const char *const rx_mix1_text[] = {
 static const char *const dec_mux_text[] = {
 	"ZERO", "ADC1", "ADC2", "ADC3", "DMIC1", "DMIC2"
 };
+
+static const char *const cic_mux_text[] = { "AMIC", "DMIC" };
 static const char *const rx_mix2_text[] = { "ZERO", "IIR1", "IIR2" };
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
 
@@ -256,11 +258,21 @@ static const struct soc_enum dec1_mux_enum = SOC_ENUM_SINGLE(
 static const struct soc_enum dec2_mux_enum = SOC_ENUM_SINGLE(
 				LPASS_CDC_CONN_TX_B1_CTL, 3, 6, dec_mux_text);
 
+/* CIC */
+static const struct soc_enum cic1_mux_enum = SOC_ENUM_SINGLE(
+				LPASS_CDC_TX1_MUX_CTL, 0, 2, cic_mux_text);
+static const struct soc_enum cic2_mux_enum = SOC_ENUM_SINGLE(
+				LPASS_CDC_TX2_MUX_CTL, 0, 2, cic_mux_text);
+
 /* RDAC2 MUX */
 static const struct snd_kcontrol_new dec1_mux = SOC_DAPM_ENUM(
 				"DEC1 MUX Mux", dec1_mux_enum);
 static const struct snd_kcontrol_new dec2_mux = SOC_DAPM_ENUM(
 				"DEC2 MUX Mux",	dec2_mux_enum);
+static const struct snd_kcontrol_new cic1_mux = SOC_DAPM_ENUM(
+				"CIC1 MUX Mux", cic1_mux_enum);
+static const struct snd_kcontrol_new cic2_mux = SOC_DAPM_ENUM(
+				"CIC2 MUX Mux",	cic2_mux_enum);
 static const struct snd_kcontrol_new rx_mix1_inp1_mux = SOC_DAPM_ENUM(
 				"RX1 MIX1 INP1 Mux", rx_mix1_inp_enum[0]);
 static const struct snd_kcontrol_new rx_mix1_inp2_mux = SOC_DAPM_ENUM(
@@ -500,6 +512,8 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("RX3 MIX1 INP3", SND_SOC_NOPM, 0, 0,
 			 &rx3_mix1_inp3_mux),
 
+	SND_SOC_DAPM_MUX("CIC1 MUX", SND_SOC_NOPM, 0, 0, &cic1_mux),
+	SND_SOC_DAPM_MUX("CIC2 MUX", SND_SOC_NOPM, 0, 0, &cic2_mux),
 	/* TX */
 	SND_SOC_DAPM_MIXER("ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -536,6 +550,8 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	/* Connectivity Clock */
 	SND_SOC_DAPM_SUPPLY_S("CDC_CONN", -2, LPASS_CDC_CLK_OTHR_CTL, 2, 0,
 			      NULL, 0),
+	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
 
 };
 
@@ -655,6 +671,11 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"AIF1 Capture", NULL, "I2S TX2"},
 	{"AIF1 Capture", NULL, "I2S TX3"},
 
+	{"CIC1 MUX", "DMIC", "DEC1 MUX"},
+	{"CIC1 MUX", "AMIC", "DEC1 MUX"},
+	{"CIC2 MUX", "DMIC", "DEC2 MUX"},
+	{"CIC2 MUX", "AMIC", "DEC2 MUX"},
+
 	/* Decimator Inputs */
 	{"DEC1 MUX", "DMIC1", "DMIC1"},
 	{"DEC1 MUX", "DMIC2", "DMIC2"},
@@ -673,8 +694,8 @@ static const struct snd_soc_dapm_route msm8916_wcd_digital_audio_map[] = {
 	{"DMIC1", NULL, "DMIC_CLK"},
 	{"DMIC2", NULL, "DMIC_CLK"},
 
-	{"I2S TX1", NULL, "DEC1 MUX"},
-	{"I2S TX2", NULL, "DEC2 MUX"},
+	{"I2S TX1", NULL, "CIC1 MUX"},
+	{"I2S TX2", NULL, "CIC2 MUX"},
 
 	{"I2S TX1", NULL, "TX_I2S_CLK"},
 	{"I2S TX2", NULL, "TX_I2S_CLK"},
-- 
2.9.3
