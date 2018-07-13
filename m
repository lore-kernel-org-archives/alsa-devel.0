From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] ASoC: qdsp6: q6afe-dai: remove
	component fw related code
Date: Fri, 13 Jul 2018 16:36:29 +0100
Message-ID: <20180713153632.32511-3-srinivas.kandagatla@linaro.org>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id A6A1A267727
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 17:39:23 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so4816065wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2018 08:39:23 -0700 (PDT)
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 24d1ffc3e5db..3081464befc7 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -4,7 +4,6 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/component.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -1405,11 +1404,12 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 	}
 }
 
-static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
+static int q6afe_dai_dev_probe(struct platform_device *pdev)
 {
 	struct q6afe_dai_data *dai_data;
+	struct device *dev = &pdev->dev;
 
-	dai_data = kzalloc(sizeof(*dai_data), GFP_KERNEL);
+	dai_data = devm_kzalloc(dev, sizeof(*dai_data), GFP_KERNEL);
 	if (!dai_data)
 		return -ENOMEM;
 
@@ -1417,35 +1417,10 @@ static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
 
 	of_q6afe_parse_dai_data(dev, dai_data);
 
-	return snd_soc_register_component(dev, &q6afe_dai_component,
+	return devm_snd_soc_register_component(dev, &q6afe_dai_component,
 					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
 }
 
-static void q6afe_dai_unbind(struct device *dev, struct device *master,
-			     void *data)
-{
-	struct q6afe_dai_data *dai_data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-	kfree(dai_data);
-}
-
-static const struct component_ops q6afe_dai_comp_ops = {
-	.bind   = q6afe_dai_bind,
-	.unbind = q6afe_dai_unbind,
-};
-
-static int q6afe_dai_dev_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6afe_dai_comp_ops);
-}
-
-static int q6afe_dai_dev_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6afe_dai_comp_ops);
-	return 0;
-}
-
 static const struct of_device_id q6afe_dai_device_id[] = {
 	{ .compatible = "qcom,q6afe-dais" },
 	{},
@@ -1458,7 +1433,6 @@ static struct platform_driver q6afe_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6afe_dai_device_id),
 	},
 	.probe = q6afe_dai_dev_probe,
-	.remove = q6afe_dai_dev_remove,
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-- 
2.16.2
