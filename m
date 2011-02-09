From: Vaibhav Bedia <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/3] ASoC: Davinci: Replace usage of IO_ADDRESS with
	ioremap()
Date: Wed,  9 Feb 2011 18:39:54 +0530
Message-ID: <1297256994-17137-3-git-send-email-vaibhav.bedia@ti.com>
References: <1297256994-17137-1-git-send-email-vaibhav.bedia@ti.com>
	<1297256994-17137-2-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1297256994-17137-2-git-send-email-vaibhav.bedia-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch modifies the Davinci i2s and mcasp drivers to make use of
ioremap() instead of IO_ADDRESS()

Signed-off-by: Vaibhav Bedia <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
---

v2:
Don't call iounmap when ioremap has failed.

Other comments from Sergie on the previous patch has been incorporated in a different patch.

v1:
http://thread.gmane.org/gmane.linux.alsa.devel/80120

 sound/soc/davinci/davinci-i2s.c   |   19 +++++++++++++------
 sound/soc/davinci/davinci-mcasp.c |   20 ++++++++++++++------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index e763d58..d0d60b8 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -694,20 +694,25 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	}
 	clk_enable(dev->clk);
 
-	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
+	dev->base = ioremap(mem->start, resource_size(mem));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_release_clk;
+	}
 
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].dma_addr =
-	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DXR_REG);
+	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DXR_REG);
 
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].dma_addr =
-	    (dma_addr_t)(io_v2p(dev->base) + DAVINCI_MCBSP_DRR_REG);
+	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
 
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_release_clk;
+		goto err_iounmap;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK].channel = res->start;
 
@@ -715,7 +720,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENXIO;
-		goto err_release_clk;
+		goto err_iounmap;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 	dev->dev = &pdev->dev;
@@ -724,10 +729,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_i2s_dai);
 	if (ret != 0)
-		goto err_release_clk;
+		goto err_iounmap;
 
 	return 0;
 
+err_iounmap:
+	iounmap(dev->base);
 err_release_clk:
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e7ae621..a5af834 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -885,7 +885,13 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	clk_enable(dev->clk);
 	dev->clk_active = 1;
 
-	dev->base = (void __iomem *)IO_ADDRESS(mem->start);
+	dev->base = ioremap(mem->start, resource_size(mem));
+	if (!dev->base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err_release_clk;
+	}
+
 	dev->op_mode = pdata->op_mode;
 	dev->tdm_slots = pdata->tdm_slots;
 	dev->num_serializer = pdata->num_serializer;
@@ -899,14 +905,14 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
-							io_v2p(dev->base));
+							mem->start);
 
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_clk;
+		goto err_iounmap;
 	}
 
 	dma_data->channel = res->start;
@@ -915,13 +921,13 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
-							io_v2p(dev->base));
+							mem->start);
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
 		ret = -ENODEV;
-		goto err_release_clk;
+		goto err_iounmap;
 	}
 
 	dma_data->channel = res->start;
@@ -929,9 +935,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_mcasp_dai[pdata->op_mode]);
 
 	if (ret != 0)
-		goto err_release_clk;
+		goto err_iounmap;
 	return 0;
 
+err_iounmap:
+	iounmap(dev->base);
 err_release_clk:
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
-- 
1.6.2.4
