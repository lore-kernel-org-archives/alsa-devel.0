From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 14/15] ASoC: qcom: apq8016-sbc: add mic support
Date: Mon,  1 Feb 2016 17:29:46 +0000
Message-ID: <1454347786-11044-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch add mic support on apq8016-sbc board aka db410c. Tested it
with headset mic.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8016_sbc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 1efdf00..1289543 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -30,6 +30,7 @@ struct apq8016_sbc_data {
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
+#define MIC_CTRL_TER_WS_SLAVE_SEL	BIT(21)
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
@@ -53,6 +54,12 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 			MIC_CTRL_TLMM_SCLK_EN,
 			pdata->mic_iomux);
 		break;
+	case MI2S_TERTIARY:
+		writel(readl(pdata->mic_iomux) | MIC_CTRL_TER_WS_SLAVE_SEL |
+			MIC_CTRL_TLMM_SCLK_EN,
+			pdata->mic_iomux);
+
+		break;
 
 	default:
 		dev_err(card->dev, "unsupported cpu dai configuration\n");
@@ -126,9 +133,6 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 		}
 
 		link->platform_of_node = link->cpu_of_node;
-		/* For now we only support playback */
-		link->playback_only = true;
-
 		ret = of_property_read_string(np, "link-name", &link->name);
 		if (ret) {
 			dev_err(card->dev, "error getting codec dai_link name\n");
-- 
1.9.1
