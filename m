From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks
Date: Thu, 3 Jan 2019 16:05:50 +0200
Message-ID: <20190103140552.29809-2-peter.ujfalusi@ti.com>
References: <20190103140552.29809-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103140552.29809-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, jsarha@ti.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

McASP can loose it's context when runtime_pm is disabled.
Save and restore the context when suspending and resuming the device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 136 +++++++++++++++++------------------
 1 file changed, 64 insertions(+), 72 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index ee9ab58d4d0c..a6a470a76900 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -108,7 +108,7 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
 
@@ -1486,74 +1486,6 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	context->pm_state = pm_runtime_active(mcasp->dev);
-	if (!context->pm_state)
-		pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
-						DAVINCI_MCASP_XRSRCTL_REG(i));
-
-	pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-
-static int davinci_mcasp_resume(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-			      context->xrsr_regs[i]);
-
-	if (!context->pm_state)
-		pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-#else
-#define davinci_mcasp_suspend NULL
-#define davinci_mcasp_resume NULL
-#endif
-
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
@@ -1571,8 +1503,6 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
-		.suspend	= davinci_mcasp_suspend,
-		.resume		= davinci_mcasp_resume,
 		.playback	= {
 			.channels_min	= 1,
 			.channels_max	= 32 * 16,
@@ -1976,7 +1906,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	mcasp->num_serializer = pdata->num_serializer;
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
 					mcasp->num_serializer, sizeof(u32),
 					GFP_KERNEL);
@@ -2180,11 +2110,73 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_mcasp_runtime_suspend(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
+						DAVINCI_MCASP_XRSRCTL_REG(i));
+
+	return 0;
+}
+
+static int davinci_mcasp_runtime_resume(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+			      context->xrsr_regs[i]);
+
+	return 0;
+}
+
+#endif
+
+static const struct dev_pm_ops davinci_mcasp_pm_ops = {
+	SET_RUNTIME_PM_OPS(davinci_mcasp_runtime_suspend,
+			   davinci_mcasp_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
+		.pm     = &davinci_mcasp_pm_ops,
 		.of_match_table = mcasp_dt_ids,
 	},
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
