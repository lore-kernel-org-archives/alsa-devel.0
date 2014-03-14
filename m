From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/4] ASoC: davinci-mcasp: Provide correct
	filter_data for dmaengine for non-DT boot
Date: Fri, 14 Mar 2014 16:42:46 +0200
Message-ID: <1394808168-32608-3-git-send-email-peter.ujfalusi@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2986C265468
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:42:57 +0100 (CET)
In-Reply-To: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

When we boot with non-DT mode the damengine will need the channel number and
a filter function in order to get the channel.
The filter_data is filled in the DAI driver while the filter_function will
be provided by the edma-pcm driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b0ae0677f023..a01ae97c90aa 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1026,6 +1026,7 @@ nodata:
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_params;
+	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct resource *mem, *ioarea, *res, *dat;
 	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
@@ -1095,6 +1096,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->dat_port = true;
 
 	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
+	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_params->asp_chan_q = pdata->asp_chan_q;
 	dma_params->ram_chan_q = pdata->ram_chan_q;
 	dma_params->sram_pool = pdata->sram_pool;
@@ -1105,7 +1107,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		dma_params->dma_addr = mem->start + pdata->tx_dma_offset;
 
 	/* Unconditional dmaengine stuff */
-	mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].addr = dma_params->dma_addr;
+	dma_data->addr = dma_params->dma_addr;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res)
@@ -1113,7 +1115,14 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	else
 		dma_params->channel = pdata->tx_dma_channel;
 
+	/* dmaengine filter data for DT and non-DT boot */
+	if (pdev->dev.of_node)
+		dma_data->filter_data = "tx";
+	else
+		dma_data->filter_data = &dma_params->channel;
+
 	dma_params = &mcasp->dma_params[SNDRV_PCM_STREAM_CAPTURE];
+	dma_data = &mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE];
 	dma_params->asp_chan_q = pdata->asp_chan_q;
 	dma_params->ram_chan_q = pdata->ram_chan_q;
 	dma_params->sram_pool = pdata->sram_pool;
@@ -1124,7 +1133,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		dma_params->dma_addr = mem->start + pdata->rx_dma_offset;
 
 	/* Unconditional dmaengine stuff */
-	mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE].addr = dma_params->dma_addr;
+	dma_data->addr = dma_params->dma_addr;
 
 	if (mcasp->version < MCASP_VERSION_3) {
 		mcasp->fifo_base = DAVINCI_MCASP_V2_AFIFO_BASE;
@@ -1140,9 +1149,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	else
 		dma_params->channel = pdata->rx_dma_channel;
 
-	/* Unconditional dmaengine stuff */
-	mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data = "tx";
-	mcasp->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data = "rx";
+	/* dmaengine filter data for DT and non-DT boot */
+	if (pdev->dev.of_node)
+		dma_data->filter_data = "rx";
+	else
+		dma_data->filter_data = &dma_params->channel;
 
 	dev_set_drvdata(&pdev->dev, mcasp);
 
-- 
1.9.0
