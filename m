From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: qdsp6: q6routing: remove component framework related code
Date: Fri, 13 Jul 2018 16:36:31 +0100
Message-ID: <20180713153632.32511-5-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6routing.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 35269b492761..1d33b00e5b44 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -8,7 +8,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/bitops.h>
-#include <linux/component.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -977,9 +976,10 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
-static int q6routing_dai_bind(struct device *dev, struct device *master,
-			      void *data)
+static int q6pcm_routing_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+
 	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
 	if (!routing_data)
 		return -ENOMEM;
@@ -989,35 +989,15 @@ static int q6routing_dai_bind(struct device *dev, struct device *master,
 	mutex_init(&routing_data->lock);
 	dev_set_drvdata(dev, routing_data);
 
-	return snd_soc_register_component(dev, &msm_soc_routing_component,
+	return devm_snd_soc_register_component(dev, &msm_soc_routing_component,
 					  NULL, 0);
 }
 
-static void q6routing_dai_unbind(struct device *dev, struct device *master,
-				 void *d)
+static int q6pcm_routing_remove(struct platform_device *pdev)
 {
-	struct msm_routing_data *data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-
-	kfree(data);
-
+	kfree(routing_data);
 	routing_data = NULL;
-}
 
-static const struct component_ops q6routing_dai_comp_ops = {
-	.bind   = q6routing_dai_bind,
-	.unbind = q6routing_dai_unbind,
-};
-
-static int q6pcm_routing_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6routing_dai_comp_ops);
-}
-
-static int q6pcm_routing_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6routing_dai_comp_ops);
 	return 0;
 }
 
-- 
2.16.2
