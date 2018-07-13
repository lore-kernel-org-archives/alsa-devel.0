From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] ASoC: qdsp6: q6asm-dai: remove component framework related code
Date: Fri, 13 Jul 2018 16:36:30 +0100
Message-ID: <20180713153632.32511-4-srinivas.kandagatla@linaro.org>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 199d0fb6f90a..9db9a2944ef2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/component.h>
 #include <sound/soc.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -563,14 +562,15 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
 	Q6ASM_FEDAI_DRIVER(8),
 };
 
-static int q6asm_dai_bind(struct device *dev, struct device *master, void *data)
+static int q6asm_dai_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	struct q6asm_dai_data *pdata;
 	int rc;
 
-	pdata = kzalloc(sizeof(struct q6asm_dai_data), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
@@ -582,36 +582,10 @@ static int q6asm_dai_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, pdata);
 
-	return snd_soc_register_component(dev, &q6asm_fe_dai_component,
+	return devm_snd_soc_register_component(dev, &q6asm_fe_dai_component,
 					q6asm_fe_dais,
 					ARRAY_SIZE(q6asm_fe_dais));
 }
-static void q6asm_dai_unbind(struct device *dev, struct device *master,
-			     void *data)
-{
-	struct q6asm_dai_data *pdata = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-
-	kfree(pdata);
-
-}
-
-static const struct component_ops q6asm_dai_comp_ops = {
-	.bind   = q6asm_dai_bind,
-	.unbind = q6asm_dai_unbind,
-};
-
-static int q6asm_dai_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6asm_dai_comp_ops);
-}
-
-static int q6asm_dai_dev_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6asm_dai_comp_ops);
-	return 0;
-}
 
 static const struct of_device_id q6asm_dai_device_id[] = {
 	{ .compatible = "qcom,q6asm-dais" },
@@ -625,7 +599,6 @@ static struct platform_driver q6asm_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6asm_dai_device_id),
 	},
 	.probe = q6asm_dai_probe,
-	.remove = q6asm_dai_dev_remove,
 };
 module_platform_driver(q6asm_dai_platform_driver);
 
-- 
2.16.2
