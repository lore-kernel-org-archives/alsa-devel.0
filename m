From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qdsp6: q6asm-dai: remove component framework related code" to the asoc tree
Date: Wed, 18 Jul 2018 13:28:38 +0100
Message-ID: <E1fflZO-0007Mg-74@debutante>
References: <20180713153632.32511-4-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713153632.32511-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qdsp6: q6asm-dai: remove component framework related code

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f924e4fd89659908107a5529f02c21edb4770dba Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 13 Jul 2018 16:36:30 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: remove component framework related
 code

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 35 ++++----------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 1196dc7483d2..acf96c6549fc 100644
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
@@ -561,14 +560,15 @@ static struct snd_soc_dai_driver q6asm_fe_dais[] = {
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
 
@@ -580,36 +580,10 @@ static int q6asm_dai_bind(struct device *dev, struct device *master, void *data)
 
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
@@ -623,7 +597,6 @@ static struct platform_driver q6asm_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6asm_dai_device_id),
 	},
 	.probe = q6asm_dai_probe,
-	.remove = q6asm_dai_dev_remove,
 };
 module_platform_driver(q6asm_dai_platform_driver);
 
-- 
2.18.0
