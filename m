From: srinivas.kandagatla@linaro.org
Subject: [PATCH 2/3] ASoC: qcom: apq8016-sbc: set default mclk rate
Date: Mon, 17 Jul 2017 15:54:09 +0200
Message-ID: <20170717135410.26812-3-srinivas.kandagatla@linaro.org>
References: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

MCLK for internal audio codec is expected to be at 9.6MHz by default.
This patch adds support to 9.6MHz to make the default case possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d7468299..1064c1b85c63 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -34,10 +34,12 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+#define DEFAULT_MCLK_RATE		9600000
 
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
 	int rval = 0;
@@ -68,6 +70,10 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 	}
 
+	/* Set default mclk for internal codec */
+	snd_soc_dai_set_sysclk(codec_dai, 0, DEFAULT_MCLK_RATE,
+			       SND_SOC_CLOCK_IN);
+
 	return rval;
 }
 
-- 
2.11.0
