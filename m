From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: davinci-mcasp: Fix DIT only McASP
	instance support
Date: Mon, 2 Feb 2015 14:38:33 +0200
Message-ID: <1422880713-25414-3-git-send-email-peter.ujfalusi@ti.com>
References: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D6A522605F4
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:38:43 +0100 (CET)
In-Reply-To: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

One of the McASP instances in DM646x line of DMSoC only supports DIT mode.
This means that the given IP does not have support for rx and all the rx
related resources are missing, like irq and DMA request.
The driver should not fail if any or all  of the RX resource is missing
when the op_mode is set to DIT mode.
Since RX is not possible in DIT mode, we can just ignore the rx resources
when the McASP is used in DIT mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 72 +++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a5e4fe0359ce..de3b155a5011 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1327,16 +1327,19 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 
 	pdata->tx_dma_channel = dma_spec.args[0];
 
-	ret = of_property_match_string(np, "dma-names", "rx");
-	if (ret < 0)
-		goto nodata;
+	/* RX is not valid in DIT mode */
+	if (pdata->op_mode != DAVINCI_MCASP_DIT_MODE) {
+		ret = of_property_match_string(np, "dma-names", "rx");
+		if (ret < 0)
+			goto nodata;
 
-	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
-					 &dma_spec);
-	if (ret < 0)
-		goto nodata;
+		ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
+						 &dma_spec);
+		if (ret < 0)
+			goto nodata;
 
-	pdata->rx_dma_channel = dma_spec.args[0];
+		pdata->rx_dma_channel = dma_spec.args[0];
+	}
 
 	ret = of_property_read_u32(np, "tx-num-evt", &val);
 	if (ret >= 0)
@@ -1532,19 +1535,34 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	else
 		dma_data->filter_data = &dma_params->channel;
 
-	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
-	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
-	dma_params->asp_chan_q = pdata->asp_chan_q;
-	dma_params->ram_chan_q = pdata->ram_chan_q;
-	dma_params->sram_pool = pdata->sram_pool;
-	dma_params->sram_size = pdata->sram_size_capture;
-	if (dat)
-		dma_params->dma_addr = dat->start;
-	else
-		dma_params->dma_addr = mem->start + pdata->rx_dma_offset;
-
-	/* Unconditional dmaengine stuff */
-	dma_data->addr = dma_params->dma_addr;
+	/* RX is not valid in DIT mode */
+	if (mcasp->op_mode != DAVINCI_MCASP_DIT_MODE) {
+		dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
+		dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
+		dma_params->asp_chan_q = pdata->asp_chan_q;
+		dma_params->ram_chan_q = pdata->ram_chan_q;
+		dma_params->sram_pool = pdata->sram_pool;
+		dma_params->sram_size = pdata->sram_size_capture;
+		if (dat)
+			dma_params->dma_addr = dat->start;
+		else
+			dma_params->dma_addr = mem->start + pdata->rx_dma_offset;
+
+		/* Unconditional dmaengine stuff */
+		dma_data->addr = dma_params->dma_addr;
+
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (res)
+			dma_params->channel = res->start;
+		else
+			dma_params->channel = pdata->rx_dma_channel;
+
+		/* dmaengine filter data for DT and non-DT boot */
+		if (pdev->dev.of_node)
+			dma_data->filter_data = "rx";
+		else
+			dma_data->filter_data = &dma_params->channel;
+	}
 
 	if (mcasp->version < MCASP_VERSION_3) {
 		mcasp->fifo_base = DAVINCI_MCASP_V2_AFIFO_BASE;
@@ -1554,18 +1572,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (res)
-		dma_params->channel = res->start;
-	else
-		dma_params->channel = pdata->rx_dma_channel;
-
-	/* dmaengine filter data for DT and non-DT boot */
-	if (pdev->dev.of_node)
-		dma_data->filter_data = "rx";
-	else
-		dma_data->filter_data = &dma_params->channel;
-
 	dev_set_drvdata(&pdev->dev, mcasp);
 
 	mcasp_reparent_fck(pdev);
-- 
2.2.2
