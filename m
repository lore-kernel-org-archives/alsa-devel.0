From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH 2/2] ASoC: img-spdif-in: Add runtime PM
Date: Mon,  2 Oct 2017 11:01:18 +0100
Message-ID: <1506938478-747-3-git-send-email-ed.blake@sondrel.com>
References: <1506938478-747-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0085.outbound.protection.outlook.com [104.47.2.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 3785826748C
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 12:01:49 +0200 (CEST)
In-Reply-To: <1506938478-747-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Add runtime PM to disable the clock when the device is not in use.
The ASoC core takes care of the pm_runtime_get_sync / put calls so we
just need to provide runtime_suspend / runtime_resume functions and
enable runtime PM.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-spdif-in.c | 85 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index d74bcc5..d070cdc 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <sound/core.h>
@@ -89,6 +90,29 @@ struct img_spdif_in {
 	unsigned int aclkgen_regs[IMG_SPDIF_IN_NUM_ACLKGEN];
 };
 
+static int img_spdif_in_runtime_suspend(struct device *dev)
+{
+	struct img_spdif_in *spdif = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(spdif->clk_sys);
+
+	return 0;
+}
+
+static int img_spdif_in_runtime_resume(struct device *dev)
+{
+	struct img_spdif_in *spdif = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spdif->clk_sys);
+	if (ret) {
+		dev_err(dev, "Unable to enable sys clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static inline void img_spdif_in_writel(struct img_spdif_in *spdif,
 					u32 val, u32 reg)
 {
@@ -681,11 +705,18 @@ static int img_spdif_in_dai_probe(struct snd_soc_dai *dai)
 static int img_spdif_in_dai_suspend(struct snd_soc_dai *dai)
 {
 	struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	if (pm_runtime_status_suspended(spdif->dev)) {
+		ret = img_spdif_in_runtime_resume(spdif->dev);
+		if (ret)
+			return ret;
+	}
 
 	spdif->suspend_clkgen = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CLKGEN);
 	spdif->suspend_ctl = img_spdif_in_readl(spdif, IMG_SPDIF_IN_CTL);
 
-	clk_disable_unprepare(spdif->clk_sys);
+	img_spdif_in_runtime_suspend(spdif->dev);
 
 	return 0;
 }
@@ -693,9 +724,11 @@ static int img_spdif_in_dai_suspend(struct snd_soc_dai *dai)
 static int img_spdif_in_dai_resume(struct snd_soc_dai *dai)
 {
 	struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(dai);
-	int i;
+	int i, ret;
 
-	clk_prepare_enable(spdif->clk_sys);
+	ret = img_spdif_in_runtime_resume(spdif->dev);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < IMG_SPDIF_IN_NUM_ACLKGEN; i++)
 		img_spdif_in_aclkgen_writel(spdif, i);
@@ -703,6 +736,9 @@ static int img_spdif_in_dai_resume(struct snd_soc_dai *dai)
 	img_spdif_in_writel(spdif, spdif->suspend_clkgen, IMG_SPDIF_IN_CLKGEN);
 	img_spdif_in_writel(spdif, spdif->suspend_ctl, IMG_SPDIF_IN_CTL);
 
+	if (pm_runtime_status_suspended(spdif->dev))
+		img_spdif_in_runtime_suspend(spdif->dev);
+
 	return 0;
 }
 
@@ -755,15 +791,21 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif->clk_sys);
 	}
 
-	ret = clk_prepare_enable(spdif->clk_sys);
-	if (ret)
-		return ret;
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = img_spdif_in_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_suspend;
 
 	rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(rst)) {
 		if (PTR_ERR(rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_clk_disable;
+			goto err_pm_put;
 		}
 		dev_dbg(dev, "No top level reset found\n");
 		img_spdif_in_writel(spdif, IMG_SPDIF_IN_SOFT_RESET_MASK,
@@ -791,28 +833,35 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 		IMG_SPDIF_IN_CTL_TRK_MASK;
 	img_spdif_in_writel(spdif, reg, IMG_SPDIF_IN_CTL);
 
+	pm_runtime_put(&pdev->dev);
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 			&img_spdif_in_component, &img_spdif_in_dai, 1);
 	if (ret)
-		goto err_clk_disable;
+		goto err_suspend;
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret)
-		goto err_clk_disable;
+		goto err_suspend;
 
 	return 0;
 
-err_clk_disable:
-	clk_disable_unprepare(spdif->clk_sys);
+err_pm_put:
+	pm_runtime_put(&pdev->dev);
+err_suspend:
+	if (!pm_runtime_enabled(&pdev->dev))
+		img_spdif_in_runtime_suspend(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
 
 static int img_spdif_in_dev_remove(struct platform_device *pdev)
 {
-	struct img_spdif_in *spdif = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(spdif->clk_sys);
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		img_spdif_in_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
@@ -823,10 +872,16 @@ static int img_spdif_in_dev_remove(struct platform_device *pdev)
 };
 MODULE_DEVICE_TABLE(of, img_spdif_in_of_match);
 
+static const struct dev_pm_ops img_spdif_in_pm_ops = {
+	SET_RUNTIME_PM_OPS(img_spdif_in_runtime_suspend,
+			   img_spdif_in_runtime_resume, NULL)
+};
+
 static struct platform_driver img_spdif_in_driver = {
 	.driver = {
 		.name = "img-spdif-in",
-		.of_match_table = img_spdif_in_of_match
+		.of_match_table = img_spdif_in_of_match,
+		.pm = &img_spdif_in_pm_ops
 	},
 	.probe = img_spdif_in_probe,
 	.remove = img_spdif_in_dev_remove
-- 
1.9.1
