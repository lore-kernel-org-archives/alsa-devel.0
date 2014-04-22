From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: davinci-pcm: Convert to use
	devm_snd_soc_register_platform()
Date: Tue, 22 Apr 2014 14:03:12 +0300
Message-ID: <1398164594-29169-2-git-send-email-peter.ujfalusi@ti.com>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id A7BFD261A9F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:03:22 +0200 (CEST)
In-Reply-To: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, daniel@zonque.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Remove the cleanup code related to the platform from the DAI drivers at the
same time to avoid breakage.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-i2s.c   |  1 -
 sound/soc/davinci/davinci-mcasp.c | 15 ---------------
 sound/soc/davinci/davinci-pcm.c   |  8 +-------
 sound/soc/davinci/davinci-pcm.h   |  4 ----
 sound/soc/davinci/davinci-vcif.c  |  1 -
 5 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index ebe82947bab3..7682af31d6e6 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -757,7 +757,6 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	struct davinci_mcbsp_dev *dev = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
-	davinci_soc_platform_unregister(&pdev->dev);
 
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d505fe7292a4..44a03840f76c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1254,23 +1254,8 @@ err_release_clk:
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
-	struct davinci_mcasp *mcasp = dev_get_drvdata(&pdev->dev);
-
 	snd_soc_unregister_component(&pdev->dev);
 
-	switch (mcasp->version) {
-	case MCASP_VERSION_1:
-	case MCASP_VERSION_2:
-	case MCASP_VERSION_3:
-		davinci_soc_platform_unregister(&pdev->dev);
-		break;
-	case MCASP_VERSION_4:
-		/* Using the resource managed omap-pcm as platform driver */
-		break;
-	default:
-		break;
-	}
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 14145cdf8a11..7809e9d935fc 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -852,16 +852,10 @@ static struct snd_soc_platform_driver davinci_soc_platform = {
 
 int davinci_soc_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(dev, &davinci_soc_platform);
+	return devm_snd_soc_register_platform(dev, &davinci_soc_platform);
 }
 EXPORT_SYMBOL_GPL(davinci_soc_platform_register);
 
-void davinci_soc_platform_unregister(struct device *dev)
-{
-	snd_soc_unregister_platform(dev);
-}
-EXPORT_SYMBOL_GPL(davinci_soc_platform_unregister);
-
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 5fd4737ab398..0fe2346a9aa2 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -31,15 +31,11 @@ struct davinci_pcm_dma_params {
 
 #if IS_ENABLED(CONFIG_SND_DAVINCI_SOC)
 int davinci_soc_platform_register(struct device *dev);
-void davinci_soc_platform_unregister(struct device *dev);
 #else
 static inline int davinci_soc_platform_register(struct device *dev)
 {
 	return 0;
 }
-static inline void davinci_soc_platform_unregister(struct device *dev)
-{
-}
 #endif /* CONFIG_SND_DAVINCI_SOC */
 
 #endif
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 30587c0cdbd2..77aef05588c3 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -258,7 +258,6 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 static int davinci_vcif_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_component(&pdev->dev);
-	davinci_soc_platform_unregister(&pdev->dev);
 
 	return 0;
 }
-- 
1.9.2
