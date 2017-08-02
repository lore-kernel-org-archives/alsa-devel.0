From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 2/3] ASoC: qcom: apq8016-sbc: set default mclk rate
Date: Wed,  2 Aug 2017 15:17:47 +0200
Message-ID: <20170802131748.10958-3-srinivas.kandagatla@linaro.org>
References: <20170802131748.10958-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802131748.10958-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

MCLK for internal audio codec is expected to be at 9.6MHz by default.
This patch adds support to 9.6MHz to make the default case possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d74..f07aa1e 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -34,13 +34,16 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+#define DEFAULT_MCLK_RATE		9600000
 
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
-	int rval = 0;
+	int i, rval;
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -63,12 +66,24 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 	default:
 		dev_err(card->dev, "unsupported cpu dai configuration\n");
-		rval = -EINVAL;
-		break;
+		return -EINVAL;
+
+	}
 
+	for (i = 0 ; i < dai_link->num_codecs; i++) {
+		struct snd_soc_dai *dai = rtd->codec_dais[i];
+
+		codec = dai->codec;
+		/* Set default mclk for internal codec */
+		rval = snd_soc_codec_set_sysclk(codec, 0, 0, DEFAULT_MCLK_RATE,
+				       SND_SOC_CLOCK_IN);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set mclk: %d\n", rval);
+			return rval;
+		}
 	}
 
-	return rval;
+	return 0;
 }
 
 static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
-- 
2.9.3
