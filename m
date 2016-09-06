From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 3/6] ASoC: qcom: apq8016-sbc: add board specific dapm mic widgets
Date: Tue,  6 Sep 2016 10:57:42 +0100
Message-ID: <1473155865-13361-4-git-send-email-srinivas.kandagatla@linaro.org>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473155865-13361-1-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support to board specific dapm mic widgets so that these
can be used to specify proper connections of various micbias supported by
the board and SOC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/qcom/apq8016_sbc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 1289543..5c3ccf3 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -147,6 +147,15 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 	return data;
 }
 
+static const struct snd_soc_dapm_widget apq8016_sbc_dapm_widgets[] = {
+
+	SND_SOC_DAPM_MIC("Handset Mic", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Secondary Mic", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic1", NULL),
+	SND_SOC_DAPM_MIC("Digital Mic2", NULL),
+};
+
 static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -159,6 +168,8 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
+	card->dapm_widgets = apq8016_sbc_dapm_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(apq8016_sbc_dapm_widgets);
 	data = apq8016_sbc_parse_of(card);
 	if (IS_ERR(data)) {
 		dev_err(&pdev->dev, "Error resolving dai links: %ld\n",
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
