From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 19/20] ASoC: davinci-mcasp: Support for fck
	reparenting
Date: Thu, 14 Nov 2013 11:35:35 +0200
Message-ID: <1384421737-4467-20-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E7B91265122
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:27 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Optional DT property to specify the desired parent clock for the McASP fck
clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |  3 +-
 sound/soc/davinci/davinci-mcasp.c                  | 44 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 990fa71..569b26c 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -37,7 +37,8 @@ Optional properties:
 - pinctrl-0: Should specify pin control group used for this controller.
 - pinctrl-names: Should contain only one value - "default", for more details
   		 please refer to pinctrl-bindings.txt
-  
+- fck_parent : Should contain a valid clock name which will be used as parent
+	       for the McASP fck
 
 Example:
 
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index fc8c13d..09aabac 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -835,6 +836,46 @@ static const struct of_device_id mcasp_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mcasp_dt_ids);
 
+static int mcasp_reparent_fck(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk *gfclk, *parent_clk;
+	const char *parent_name;
+	int ret;
+
+	if (!node)
+		return 0;
+
+	parent_name = of_get_property(node, "fck_parent", NULL);
+	if (!parent_name)
+		return 0;
+
+	gfclk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(gfclk)) {
+		dev_err(&pdev->dev, "failed to get fck\n");
+		return PTR_ERR(gfclk);
+	}
+
+	parent_clk = clk_get(NULL, parent_name);
+	if (IS_ERR(parent_clk)) {
+		dev_err(&pdev->dev, "failed to get parent clock\n");
+		ret = PTR_ERR(parent_clk);
+		goto err1;
+	}
+
+	ret = clk_set_parent(gfclk, parent_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to reparent fck\n");
+		goto err2;
+	}
+
+err2:
+	clk_put(parent_clk);
+err1:
+	clk_put(gfclk);
+	return ret;
+}
+
 static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 						struct platform_device *pdev)
 {
@@ -1064,6 +1105,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data = "rx";
 
 	dev_set_drvdata(&pdev->dev, mcasp);
+
+	mcasp_reparent_fck(pdev);
+
 	ret = snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
 					 &davinci_mcasp_dai[pdata->op_mode], 1);
 
-- 
1.8.4.2
