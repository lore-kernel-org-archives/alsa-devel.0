From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: davinci-mcasp: Move pm callbacks
	from platform device to soc_dai_driver
Date: Thu, 30 Jan 2014 15:21:32 +0200
Message-ID: <1391088092-4157-4-git-send-email-peter.ujfalusi@ti.com>
References: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2739B265494
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:21:43 +0100 (CET)
In-Reply-To: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Handle the PM callbacks via the ASoC core instead of device core.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index be79dba789fb..a8a0f2fb4749 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -718,6 +718,41 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.set_sysclk	= davinci_mcasp_set_sysclk,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+
+	mcasp->context.txfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG);
+	mcasp->context.rxfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
+	mcasp->context.txfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMT_REG);
+	mcasp->context.rxfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMT_REG);
+	mcasp->context.aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
+	mcasp->context.aclkrctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG);
+	mcasp->context.pdir = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+
+	return 0;
+}
+
+static int davinci_mcasp_resume(struct snd_soc_dai *dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG, mcasp->context.txfmtctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG, mcasp->context.rxfmtctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMT_REG, mcasp->context.txfmt);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMT_REG, mcasp->context.rxfmt);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, mcasp->context.aclkxctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, mcasp->context.aclkrctl);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PDIR_REG, mcasp->context.pdir);
+
+	return 0;
+}
+#else
+#define davinci_mcasp_suspend NULL
+#define davinci_mcasp_resume NULL
+#endif
+
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
@@ -734,6 +769,8 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
+		.suspend	= davinci_mcasp_suspend,
+		.resume		= davinci_mcasp_resume,
 		.playback	= {
 			.channels_min	= 2,
 			.channels_max	= 32 * 16,
@@ -1126,49 +1163,12 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int davinci_mcasp_suspend(struct device *dev)
-{
-	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
-
-	mcasp->context.txfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG);
-	mcasp->context.rxfmtctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG);
-	mcasp->context.txfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_TXFMT_REG);
-	mcasp->context.rxfmt = mcasp_get_reg(mcasp, DAVINCI_MCASP_RXFMT_REG);
-	mcasp->context.aclkxctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG);
-	mcasp->context.aclkrctl = mcasp_get_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG);
-	mcasp->context.pdir = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
-
-	return 0;
-}
-
-static int davinci_mcasp_resume(struct device *dev)
-{
-	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
-
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMCTL_REG, mcasp->context.txfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMCTL_REG, mcasp->context.rxfmtctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXFMT_REG, mcasp->context.txfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXFMT_REG, mcasp->context.rxfmt);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, mcasp->context.aclkxctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, mcasp->context.aclkrctl);
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PDIR_REG, mcasp->context.pdir);
-
-	return 0;
-}
-#endif
-
-SIMPLE_DEV_PM_OPS(davinci_mcasp_pm_ops,
-		  davinci_mcasp_suspend,
-		  davinci_mcasp_resume);
-
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
-		.pm	= &davinci_mcasp_pm_ops,
 		.of_match_table = mcasp_dt_ids,
 	},
 };
-- 
1.8.5.3
