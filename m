From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 2/4] ASoC: omap-mcbsp: Restructure the code
	within omap_mcbsp_dai_hw_params
Date: Thu, 29 Jul 2010 09:51:26 +0300
Message-ID: <1280386288-22019-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A5F7A103826
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 08:51:28 +0200 (CEST)
In-Reply-To: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

In preparation for the extended threshold mode (sDMA packet mode
support), the code need to be restructured.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 88ca71c..4ac8a08 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -367,18 +367,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
-		dma_data->set_threshold = omap_mcbsp_set_threshold;
-		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
-		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
-						MCBSP_DMA_MODE_THRESHOLD)
-			sync_mode = OMAP_DMA_SYNC_FRAME;
 	} else {
 		return -ENODEV;
 	}
-	dma_data->name = substream->stream ? "Audio Capture" : "Audio Playback";
-	dma_data->dma_req = dma;
-	dma_data->port_addr = port;
-	dma_data->sync_mode = sync_mode;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
@@ -389,6 +380,18 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
+	if (cpu_is_omap343x()) {
+		dma_data->set_threshold = omap_mcbsp_set_threshold;
+		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
+		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
+						MCBSP_DMA_MODE_THRESHOLD)
+			sync_mode = OMAP_DMA_SYNC_FRAME;
+	}
+
+	dma_data->name = substream->stream ? "Audio Capture" : "Audio Playback";
+	dma_data->dma_req = dma;
+	dma_data->port_addr = port;
+	dma_data->sync_mode = sync_mode;
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
-- 
1.7.2
