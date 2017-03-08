From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ASoC: imx-pcm-dma: simplify pcm_config
Date: Wed,  8 Mar 2017 10:17:02 +0100
Message-ID: <20170308091702.9584-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 507F1267044
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 10:17:05 +0100 (CET)
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The generic snd_dmaengine_pcm is able to retrieve all the needed
information from the attached dmaengine and is in fact able to
provide much more accurate flags to userspace, like the SDMA engine
being only able to operate in batch mode.

To avoid any future inconsistencies between the dmaengine and the
pcm_config, rip out the fixed config and rely on the core to fill
in the right flags derived from the dmaengine information.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 sound/soc/fsl/imx-pcm-dma.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index f3d3d1ffa84e..314814ddd2b0 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -33,48 +33,20 @@ static bool filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static const struct snd_pcm_hardware imx_pcm_hardware = {
-	.info = SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_BLOCK_TRANSFER |
-		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_PAUSE |
-		SNDRV_PCM_INFO_RESUME,
-	.buffer_bytes_max = IMX_DEFAULT_DMABUF_SIZE,
-	.period_bytes_min = 128,
-	.period_bytes_max = 65535, /* Limited by SDMA engine */
-	.periods_min = 2,
-	.periods_max = 255,
-	.fifo_size = 0,
-};
-
 static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
-	.pcm_hardware = &imx_pcm_hardware,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.compat_filter_fn = filter,
-	.prealloc_buffer_size = IMX_DEFAULT_DMABUF_SIZE,
 };
 
 int imx_pcm_dma_init(struct platform_device *pdev, size_t size)
 {
 	struct snd_dmaengine_pcm_config *config;
-	struct snd_pcm_hardware *pcm_hardware;
 
 	config = devm_kzalloc(&pdev->dev,
 			sizeof(struct snd_dmaengine_pcm_config), GFP_KERNEL);
 	if (!config)
 		return -ENOMEM;
 	*config = imx_dmaengine_pcm_config;
-	if (size)
-		config->prealloc_buffer_size = size;
-
-	pcm_hardware = devm_kzalloc(&pdev->dev,
-			sizeof(struct snd_pcm_hardware), GFP_KERNEL);
-	*pcm_hardware = imx_pcm_hardware;
-	if (size)
-		pcm_hardware->buffer_bytes_max = size;
-
-	config->pcm_hardware = pcm_hardware;
 
 	return devm_snd_dmaengine_pcm_register(&pdev->dev,
 		config,
-- 
2.11.0
