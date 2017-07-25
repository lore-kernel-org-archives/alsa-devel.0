From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 3/3] ASoC: codecs: msm8916-wcd-digital: select DMIC source in CIC filter path
Date: Wed, 26 Jul 2017 01:48:22 +0200
Message-ID: <20170725234822.18763-4-srinivas.kandagatla@linaro.org>
References: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch fixes a missing selection of DMIC in CIC filter source path.
Without this patch dmic is not functional.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 825cc7d..f82a936 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -168,6 +168,9 @@
 
 #define LPASS_CDC_TX2_VOL_CTL_CFG		(0x2A8)
 #define LPASS_CDC_TX1_MUX_CTL			(0x28C)
+#define TX_MUX_CTL_ADC_DMIC_SEL_MASK		BIT(0)
+#define TX_MUX_CTL_ADC_DMIC_SEL_DMIC		BIT(0)
+#define TX_MUX_CTL_ADC_DMIC_SEL_ADC		0
 #define TX_MUX_CTL_CUT_OFF_FREQ_MASK		GENMASK(5, 4)
 #define TX_MUX_CTL_CUT_OFF_FREQ_SHIFT		4
 #define TX_MUX_CTL_CF_NEG_3DB_4HZ		(0x0 << 4)
@@ -439,17 +442,37 @@ static int msm8916_wcd_digital_enable_dmic(struct snd_soc_dapm_widget *w,
 				    DMIC_B1_CTL_DMIC0_CLK_SEL_DIV3);
 		switch (dmic) {
 		case 1:
+			snd_soc_update_bits(codec, LPASS_CDC_TX1_MUX_CTL,
+					    TX_MUX_CTL_ADC_DMIC_SEL_MASK,
+					    TX_MUX_CTL_ADC_DMIC_SEL_DMIC);
 			snd_soc_update_bits(codec, LPASS_CDC_TX1_DMIC_CTL,
 					    TXN_DMIC_CTL_CLK_SEL_MASK,
 					    TXN_DMIC_CTL_CLK_SEL_DIV3);
 			break;
 		case 2:
+			snd_soc_update_bits(codec, LPASS_CDC_TX2_MUX_CTL,
+					    TX_MUX_CTL_ADC_DMIC_SEL_MASK,
+					    TX_MUX_CTL_ADC_DMIC_SEL_DMIC);
 			snd_soc_update_bits(codec, LPASS_CDC_TX2_DMIC_CTL,
 					    TXN_DMIC_CTL_CLK_SEL_MASK,
 					    TXN_DMIC_CTL_CLK_SEL_DIV3);
 			break;
 		}
 		break;
+	case SND_SOC_DAPM_POST_PMD:
+		switch (dmic) {
+		case 1:
+			snd_soc_update_bits(codec, LPASS_CDC_TX1_MUX_CTL,
+					    TX_MUX_CTL_ADC_DMIC_SEL_MASK,
+					    0);
+			break;
+		case 2:
+			snd_soc_update_bits(codec, LPASS_CDC_TX2_MUX_CTL,
+					    TX_MUX_CTL_ADC_DMIC_SEL_MASK,
+					    0);
+			break;
+		}
+		break;
 	}
 
 	return 0;
@@ -536,6 +559,8 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 	/* Connectivity Clock */
 	SND_SOC_DAPM_SUPPLY_S("CDC_CONN", -2, LPASS_CDC_CLK_OTHR_CTL, 2, 0,
 			      NULL, 0),
+	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
 
 };
 
-- 
2.9.3
