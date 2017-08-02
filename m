From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-digital: add CIC filter source selection path" to the asoc tree
Date: Wed, 02 Aug 2017 18:29:44 +0100
Message-ID: <E1dcxSq-0003iZ-NQ@debutante>
References: <20170802131748.10958-4-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802131748.10958-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-digital: add CIC filter source selection path

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3a88a3757dc654c29c87f4537053d0f3dc28d9e0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 2 Aug 2017 15:17:48 +0200
Subject: [PATCH] ASoC: codecs: msm8916-wcd-digital: add CIC filter source
 selection path

This patch fixes a missing selection of DMIC in CIC filter source path
to dapm route. Without this patch dmic is not functional.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 825cc7d70bb3..d2993e72d1e2 100644
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
2.13.2
