From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci: Convert to use
	devm_ioremap_resource" to the asoc tree
Date: Tue, 25 Aug 2015 10:36:30 +0100
Message-ID: <E1ZUAec-0006F9-1P@debutante>
References: <1440406056.27868.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CDB0260410
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 11:36:44 +0200 (CEST)
In-Reply-To: <1440406056.27868.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci: Convert to use devm_ioremap_resource

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 508a43fdd73072c959f849b4e9eb60a9b523396f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 24 Aug 2015 16:47:36 +0800
Subject: [PATCH] ASoC: davinci: Convert to use devm_ioremap_resource

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-i2s.c   | 25 ++++++-------------------
 sound/soc/davinci/davinci-mcasp.c | 18 ++++--------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 56cb4d95637d..ec98548a5fc9 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -651,23 +651,15 @@ static const struct snd_soc_component_driver davinci_i2s_component = {
 static int davinci_i2s_probe(struct platform_device *pdev)
 {
 	struct davinci_mcbsp_dev *dev;
-	struct resource *mem, *ioarea, *res;
+	struct resource *mem, *res;
+	void __iomem *io_base;
 	int *dma;
 	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "no mem resource?\n");
-		return -ENODEV;
-	}
-
-	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
-					 resource_size(mem),
-					 pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "McBSP region already claimed\n");
-		return -EBUSY;
-	}
+	io_base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_mcbsp_dev),
 			   GFP_KERNEL);
@@ -679,12 +671,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		return -ENODEV;
 	clk_enable(dev->clk);
 
-	dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!dev->base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err_release_clk;
-	}
+	dev->base = io_base;
 
 	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr =
 	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b960e626dad9..add6bb99661d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1613,7 +1613,7 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
-	struct resource *mem, *ioarea, *res, *dat;
+	struct resource *mem, *res, *dat;
 	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
 	char *irq_name;
@@ -1648,22 +1648,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		}
 	}
 
-	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
-			resource_size(mem), pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "Audio region already claimed\n");
-		return -EBUSY;
-	}
+	mcasp->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(mcasp->base))
+		return PTR_ERR(mcasp->base);
 
 	pm_runtime_enable(&pdev->dev);
 
-	mcasp->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (!mcasp->base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto err;
-	}
-
 	mcasp->op_mode = pdata->op_mode;
 	/* sanity check for tdm slots parameter */
 	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
-- 
2.5.0
