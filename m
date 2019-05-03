From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v5] ASoC: fsl_esai: Add pm runtime function
Date: Fri,  3 May 2019 12:49:44 -0700
Message-ID: <20190503194944.30167-1-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, shengjiu.wang@nxp.com
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: "S.j. Wang" <shengjiu.wang@nxp.com>

Add pm runtime support and move clock handling there.
Close the clocks at suspend to reduce the power consumption.

fsl_esai_suspend is replaced by pm_runtime_force_suspend.
fsl_esai_resume is replaced by pm_runtime_force_resume.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changes in v5
-Replaced my Acked-by with Signed-off-by as a resend.

Changes in v4
-resend base on for-5.2

Changes in v3
-refine the commit comments.
-add acked-by

Changes in v2
-refine the commit comments.
-move regcache_mark_dirty to runtime suspend.

 sound/soc/fsl/fsl_esai.c | 141 +++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7410bbfd2af..022368c8a074 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
@@ -466,30 +467,6 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	/*
-	 * Some platforms might use the same bit to gate all three or two of
-	 * clocks, so keep all clocks open/close at the same time for safety
-	 */
-	ret = clk_prepare_enable(esai_priv->coreclk);
-	if (ret)
-		return ret;
-	if (!IS_ERR(esai_priv->spbaclk)) {
-		ret = clk_prepare_enable(esai_priv->spbaclk);
-		if (ret)
-			goto err_spbaclk;
-	}
-	if (!IS_ERR(esai_priv->extalclk)) {
-		ret = clk_prepare_enable(esai_priv->extalclk);
-		if (ret)
-			goto err_extalck;
-	}
-	if (!IS_ERR(esai_priv->fsysclk)) {
-		ret = clk_prepare_enable(esai_priv->fsysclk);
-		if (ret)
-			goto err_fsysclk;
-	}
 
 	if (!dai->active) {
 		/* Set synchronous mode */
@@ -506,16 +483,6 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 
-err_fsysclk:
-	if (!IS_ERR(esai_priv->extalclk))
-		clk_disable_unprepare(esai_priv->extalclk);
-err_extalck:
-	if (!IS_ERR(esai_priv->spbaclk))
-		clk_disable_unprepare(esai_priv->spbaclk);
-err_spbaclk:
-	clk_disable_unprepare(esai_priv->coreclk);
-
-	return ret;
 }
 
 static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
@@ -576,20 +543,6 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
-			      struct snd_soc_dai *dai)
-{
-	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
-
-	if (!IS_ERR(esai_priv->fsysclk))
-		clk_disable_unprepare(esai_priv->fsysclk);
-	if (!IS_ERR(esai_priv->extalclk))
-		clk_disable_unprepare(esai_priv->extalclk);
-	if (!IS_ERR(esai_priv->spbaclk))
-		clk_disable_unprepare(esai_priv->spbaclk);
-	clk_disable_unprepare(esai_priv->coreclk);
-}
-
 static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 			    struct snd_soc_dai *dai)
 {
@@ -658,7 +611,6 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static const struct snd_soc_dai_ops fsl_esai_dai_ops = {
 	.startup = fsl_esai_startup,
-	.shutdown = fsl_esai_shutdown,
 	.trigger = fsl_esai_trigger,
 	.hw_params = fsl_esai_hw_params,
 	.set_sysclk = fsl_esai_set_dai_sysclk,
@@ -947,6 +899,10 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	regcache_cache_only(esai_priv->regmap, true);
+
 	ret = imx_pcm_dma_init(pdev, IMX_ESAI_DMABUF_SIZE);
 	if (ret)
 		dev_err(&pdev->dev, "failed to init imx pcm dma: %d\n", ret);
@@ -954,6 +910,13 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int fsl_esai_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
 static const struct of_device_id fsl_esai_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esai", },
 	{ .compatible = "fsl,vf610-esai", },
@@ -961,22 +924,35 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
 
-#ifdef CONFIG_PM_SLEEP
-static int fsl_esai_suspend(struct device *dev)
-{
-	struct fsl_esai *esai = dev_get_drvdata(dev);
-
-	regcache_cache_only(esai->regmap, true);
-	regcache_mark_dirty(esai->regmap);
-
-	return 0;
-}
-
-static int fsl_esai_resume(struct device *dev)
+#ifdef CONFIG_PM
+static int fsl_esai_runtime_resume(struct device *dev)
 {
 	struct fsl_esai *esai = dev_get_drvdata(dev);
 	int ret;
 
+	/*
+	 * Some platforms might use the same bit to gate all three or two of
+	 * clocks, so keep all clocks open/close at the same time for safety
+	 */
+	ret = clk_prepare_enable(esai->coreclk);
+	if (ret)
+		return ret;
+	if (!IS_ERR(esai->spbaclk)) {
+		ret = clk_prepare_enable(esai->spbaclk);
+		if (ret)
+			goto err_spbaclk;
+	}
+	if (!IS_ERR(esai->extalclk)) {
+		ret = clk_prepare_enable(esai->extalclk);
+		if (ret)
+			goto err_extalclk;
+	}
+	if (!IS_ERR(esai->fsysclk)) {
+		ret = clk_prepare_enable(esai->fsysclk);
+		if (ret)
+			goto err_fsysclk;
+	}
+
 	regcache_cache_only(esai->regmap, false);
 
 	/* FIFO reset for safety */
@@ -987,22 +963,59 @@ static int fsl_esai_resume(struct device *dev)
 
 	ret = regcache_sync(esai->regmap);
 	if (ret)
-		return ret;
+		goto err_regcache_sync;
 
 	/* FIFO reset done */
 	regmap_update_bits(esai->regmap, REG_ESAI_TFCR, ESAI_xFCR_xFR, 0);
 	regmap_update_bits(esai->regmap, REG_ESAI_RFCR, ESAI_xFCR_xFR, 0);
 
+	return 0;
+
+err_regcache_sync:
+	if (!IS_ERR(esai->fsysclk))
+		clk_disable_unprepare(esai->fsysclk);
+err_fsysclk:
+	if (!IS_ERR(esai->extalclk))
+		clk_disable_unprepare(esai->extalclk);
+err_extalclk:
+	if (!IS_ERR(esai->spbaclk))
+		clk_disable_unprepare(esai->spbaclk);
+err_spbaclk:
+	clk_disable_unprepare(esai->coreclk);
+
+	return ret;
+}
+
+static int fsl_esai_runtime_suspend(struct device *dev)
+{
+	struct fsl_esai *esai = dev_get_drvdata(dev);
+
+	regcache_cache_only(esai->regmap, true);
+	regcache_mark_dirty(esai->regmap);
+
+	if (!IS_ERR(esai->fsysclk))
+		clk_disable_unprepare(esai->fsysclk);
+	if (!IS_ERR(esai->extalclk))
+		clk_disable_unprepare(esai->extalclk);
+	if (!IS_ERR(esai->spbaclk))
+		clk_disable_unprepare(esai->spbaclk);
+	clk_disable_unprepare(esai->coreclk);
+
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
+#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops fsl_esai_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(fsl_esai_suspend, fsl_esai_resume)
+	SET_RUNTIME_PM_OPS(fsl_esai_runtime_suspend,
+			   fsl_esai_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static struct platform_driver fsl_esai_driver = {
 	.probe = fsl_esai_probe,
+	.remove = fsl_esai_remove,
 	.driver = {
 		.name = "fsl-esai-dai",
 		.pm = &fsl_esai_pm_ops,
-- 
2.17.1
