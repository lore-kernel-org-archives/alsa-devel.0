From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Rename the pointer to
	davinci dma_params as dma_params
Date: Fri, 7 Mar 2014 15:03:55 +0200
Message-ID: <1394197435-32529-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D202659E8
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 14:04:01 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

It is quite confusing to name the pointer to davinci_pcm_dma_params as
dma_data. Rename the pointer to avoid confusion.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 44 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 35b9b5505f07..b0ae0677f023 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1025,7 +1025,7 @@ nodata:
 
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
-	struct davinci_pcm_dma_params *dma_data;
+	struct davinci_pcm_dma_params *dma_params;
 	struct resource *mem, *ioarea, *res, *dat;
 	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
@@ -1094,41 +1094,41 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (dat)
 		mcasp->dat_port = true;
 
-	dma_data = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
-	dma_data->asp_chan_q = pdata->asp_chan_q;
-	dma_data->ram_chan_q = pdata->ram_chan_q;
-	dma_data->sram_pool = pdata->sram_pool;
-	dma_data->sram_size = pdata->sram_size_playback;
+	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_params->asp_chan_q = pdata->asp_chan_q;
+	dma_params->ram_chan_q = pdata->ram_chan_q;
+	dma_params->sram_pool = pdata->sram_pool;
+	dma_params->sram_size = pdata->sram_size_playback;
 	if (dat)
-		dma_data->dma_addr = dat->start;
+		dma_params->dma_addr = dat->start;
 	else
-		dma_data->dma_addr = mem->start + pdata->tx_dma_offset;
+		dma_params->dma_addr = mem->start + pdata->tx_dma_offset;
 
 	/* Unconditional dmaengine stuff */
-	mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr = dma_data->dma_addr;
+	mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr = dma_params->dma_addr;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res)
-		dma_data->channel = res->start;
+		dma_params->channel = res->start;
 	else
-		dma_data->channel = pdata->tx_dma_channel;
+		dma_params->channel = pdata->tx_dma_channel;
 
-	dma_data = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
-	dma_data->asp_chan_q = pdata->asp_chan_q;
-	dma_data->ram_chan_q = pdata->ram_chan_q;
-	dma_data->sram_pool = pdata->sram_pool;
-	dma_data->sram_size = pdata->sram_size_capture;
+	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
+	dma_params->asp_chan_q = pdata->asp_chan_q;
+	dma_params->ram_chan_q = pdata->ram_chan_q;
+	dma_params->sram_pool = pdata->sram_pool;
+	dma_params->sram_size = pdata->sram_size_capture;
 	if (dat)
-		dma_data->dma_addr = dat->start;
+		dma_params->dma_addr = dat->start;
 	else
-		dma_data->dma_addr = mem->start + pdata->rx_dma_offset;
+		dma_params->dma_addr = mem->start + pdata->rx_dma_offset;
 
 	/* Unconditional dmaengine stuff */
-	mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr = dma_data->dma_addr;
+	mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr = dma_params->dma_addr;
 
 	if (mcasp->version < MCASP_VERSION_3) {
 		mcasp->fifo_base = DAVINCI_MCASP_V2_AFIFO_BASE;
-		/* dma_data->dma_addr is pointing to the data port address */
+		/* dma_params->dma_addr is pointing to the data port address */
 		mcasp->dat_port = true;
 	} else {
 		mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
@@ -1136,9 +1136,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (res)
-		dma_data->channel = res->start;
+		dma_params->channel = res->start;
 	else
-		dma_data->channel = pdata->rx_dma_channel;
+		dma_params->channel = pdata->rx_dma_channel;
 
 	/* Unconditional dmaengine stuff */
 	mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = "tx";
-- 
1.9.0
