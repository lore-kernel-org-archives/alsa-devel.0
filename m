From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] ASoC: davinci: Convert to use
	devm_ioremap_resource
Date: Mon, 24 Aug 2015 16:47:36 +0800
Message-ID: <1440406056.27868.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A51BF260471
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 10:47:42 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so1812168pab.1
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 01:47:41 -0700 (PDT)
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
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Thomas =?ISO-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
List-Id: alsa-devel@alsa-project.org

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/davinci/davinci-i2s.c   | 25 ++++++-------------------
 sound/soc/davinci/davinci-mcasp.c | 18 ++++--------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 56cb4d9..ec98548 100644
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
index b960e62..add6bb9 100644
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
2.1.0
