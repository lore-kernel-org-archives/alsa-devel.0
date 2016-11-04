From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: codecs: msm8916-wcd-analog: clean parse_dt()
Date: Fri,  4 Nov 2016 14:45:39 +0000
Message-ID: <1478270740-3037-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.com, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Move the code which is not parsing dt from pm8916_wcd_analog_parse_dt()
to make it clear to reader.

No functional changes done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

This change was suggested by Mark http://www.spinics.net/lists/alsa-devel/msg55878.html

thanks,
srini

 sound/soc/codecs/msm8916-wcd-analog.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d9f999b..50ad75a 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -802,7 +802,6 @@ static struct snd_soc_codec_driver pm8916_wcd_analog = {
 static int pm8916_wcd_analog_parse_dt(struct device *dev,
 				       struct pm8916_wcd_analog_priv *priv)
 {
-	int ret, i;

 	if (of_property_read_bool(dev->of_node, "qcom,micbias1-ext-cap"))
 		priv->micbias1_cap_mode = MICB_1_EN_EXT_BYP_CAP;
@@ -814,21 +813,6 @@ static int pm8916_wcd_analog_parse_dt(struct device *dev,
 	else
 		priv->micbias2_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;

-	priv->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(priv->mclk)) {
-		dev_err(dev, "failed to get mclk\n");
-		return PTR_ERR(priv->mclk);
-	}
-	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-		priv->supplies[i].supply = supply_names[i];
-
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
-				    priv->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }

@@ -836,7 +820,7 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 {
 	struct pm8916_wcd_analog_priv *priv;
 	struct device *dev = &pdev->dev;
-	int ret;
+	int ret, i;

 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -846,6 +830,22 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;

+	priv->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(priv->mclk)) {
+		dev_err(dev, "failed to get mclk\n");
+		return PTR_ERR(priv->mclk);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				    priv->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable mclk %d\n", ret);
--
2.10.1
