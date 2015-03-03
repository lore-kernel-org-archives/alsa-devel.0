From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Allow complete shutdown
	of McASP when not in use
Date: Tue, 3 Mar 2015 16:26:32 +0200
Message-ID: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B342A261515
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:26:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Rearrange the pm_runtime_get/put_sync calls so the IP will be turned off
when it is not in use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 031c1fb44ae7..a51197ac0b92 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -528,6 +528,7 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
+	pm_runtime_get_sync(mcasp->dev);
 	switch (div_id) {
 	case 0:		/* MCLK divider */
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
@@ -553,6 +554,7 @@ static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
 		return -EINVAL;
 	}
 
+	pm_runtime_put_sync(mcasp->dev);
 	return 0;
 }
 
@@ -567,6 +569,7 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
+	pm_runtime_get_sync(mcasp->dev);
 	if (dir == SND_SOC_CLOCK_OUT) {
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
@@ -579,6 +582,7 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	mcasp->sysclk_freq = freq;
 
+	pm_runtime_put_sync(mcasp->dev);
 	return 0;
 }
 
@@ -1078,6 +1082,9 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 	u32 reg;
 	int i;
 
+	if (!dai->active)
+		pm_runtime_get_sync(mcasp->dev);
+
 	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
 		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
 
@@ -1094,6 +1101,8 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
 						DAVINCI_MCASP_XRSRCTL_REG(i));
 
+	pm_runtime_put_sync(mcasp->dev);
+
 	return 0;
 }
 
@@ -1104,6 +1113,8 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 	u32 reg;
 	int i;
 
+	pm_runtime_get_sync(mcasp->dev);
+
 	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
 		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
 
@@ -1120,6 +1131,9 @@ static int davinci_mcasp_resume(struct snd_soc_dai *dai)
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 			      context->xrsr_regs[i]);
 
+	if (!dai->active)
+		pm_runtime_put_sync(mcasp->dev);
+
 	return 0;
 }
 #else
@@ -1427,13 +1441,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (IS_ERR_VALUE(ret)) {
-		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
-
 	mcasp->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
 	if (!mcasp->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
@@ -1633,14 +1640,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	return 0;
 
 err:
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
 
 static int davinci_mcasp_remove(struct platform_device *pdev)
 {
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.3.0
