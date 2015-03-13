From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 2/2] ASoC: qcom: Modify test for DSP in LPASS driver
Date: Fri, 13 Mar 2015 00:54:17 -0700
Message-ID: <1426233257-27532-2-git-send-email-kwestfie@codeaurora.org>
References: <1426233257-27532-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1426233257-27532-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kumar Gala <galak@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

As the representation of the DSP in the device
tree has changed from a required subnode to an
optional phandle, modify the test for DSP
existence in the LPASS CPU DAI driver,
accordingly.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index d5167131787f3a7663665c94dffe6899bd050179..6698d058de29600a464be79490bec641736819c3 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -359,45 +359,26 @@ static const struct regmap_config lpass_cpu_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-static int lpass_cpu_parse_of(struct device *dev)
+static int lpass_cpu_platform_probe(struct platform_device *pdev)
 {
+	struct lpass_data *drvdata;
 	struct device_node *dsp_of_node;
+	struct resource *res;
+	int ret;
 
-	dsp_of_node = of_get_child_by_name(dev->of_node, "qcom,adsp");
-	if (!dsp_of_node) {
-		dev_err(dev, "%s() error getting qcom,adsp sub-node\n",
-				__func__);
-		return -EINVAL;
-	}
-
-	if (of_device_is_available(dsp_of_node)) {
-		dev_err(dev, "%s() DSP exists and holds audio resources\n",
+	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
+	if (dsp_of_node) {
+		dev_err(&pdev->dev, "%s() DSP exists and holds audio resources\n",
 				__func__);
 		return -EBUSY;
 	}
 
-	return 0;
-}
-
-static int lpass_cpu_platform_probe(struct platform_device *pdev)
-{
-	struct lpass_data *drvdata;
-	struct resource *res;
-	int ret;
-
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct lpass_data),
 			GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, drvdata);
 
-	ret = lpass_cpu_parse_of(&pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "%s() error getting DT node info: %d\n",
-				__func__, ret);
-		return ret;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpass-lpaif");
 	if (!res) {
 		dev_err(&pdev->dev, "%s() error getting resource\n", __func__);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
