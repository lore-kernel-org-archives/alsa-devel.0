From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: davinci-mcasp: Optimize pm_runtime
	usage and clean up the init code
Date: Tue, 22 Apr 2014 14:03:14 +0300
Message-ID: <1398164594-29169-4-git-send-email-peter.ujfalusi@ti.com>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A11A4261A92
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:03:29 +0200 (CEST)
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

Move the pm_runtime_enable/disable to dai driver probe/remove callbacks from
module probe/remove callbacks.
With this change we can remove the platform driver's remove function since
it became NULL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 45 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 14058dc6eaf8..c858c9ccf774 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -778,6 +778,8 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
+	pm_runtime_enable(mcasp->dev);
+
 	if (mcasp->version == MCASP_VERSION_4) {
 		/* Using dmaengine PCM */
 		dai->playback_dma_data =
@@ -793,6 +795,15 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static int davinci_mcasp_dai_remove(struct snd_soc_dai *dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+
+	pm_runtime_disable(mcasp->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 {
@@ -847,6 +858,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
+		.remove		= davinci_mcasp_dai_remove,
 		.suspend	= davinci_mcasp_suspend,
 		.resume		= davinci_mcasp_resume,
 		.playback	= {
@@ -867,6 +879,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.1",
 		.probe		= davinci_mcasp_dai_probe,
+		.remove		= davinci_mcasp_dai_remove,
 		.playback 	= {
 			.channels_min	= 1,
 			.channels_max	= 384,
@@ -1122,19 +1135,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (IS_ERR_VALUE(ret)) {
-		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
-		return ret;
-	}
-
 	mcasp->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!mcasp->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err;
+		return -ENOMEM;
 	}
 
 	mcasp->op_mode = pdata->op_mode;
@@ -1220,7 +1224,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 					&davinci_mcasp_dai[pdata->op_mode], 1);
 
 	if (ret != 0)
-		goto err;
+		return ret;
 
 	switch (mcasp->version) {
 	case MCASP_VERSION_1:
@@ -1238,30 +1242,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		goto err;
-	}
-
-	return 0;
-
-err:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
-static int davinci_mcasp_remove(struct platform_device *pdev)
-{
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
-	return 0;
-}
-
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
-	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
-- 
1.9.2
