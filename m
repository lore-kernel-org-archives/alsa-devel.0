From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 1/4] ASoC: omap-mcbsp: Code cleanup in
	omap_mcbsp_dai_hw_params
Date: Thu, 29 Jul 2010 09:51:25 +0300
Message-ID: <1280386288-22019-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A6372103927
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

To make the code a bit more readable, change the indexed
references to the omap_mcbsp_dai_dma_params elements with
pointer.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index aebd3af..88ca71c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -348,11 +348,13 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
-	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
+	struct omap_pcm_dma_data *dma_data;
+	int dma, bus_id = mcbsp_data->bus_id;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	unsigned long port;
 	unsigned int format, div, framesize, master;
 
+	dma_data = &omap_mcbsp_dai_dma_params[cpu_dai->id][substream->stream];
 	if (cpu_class_is_omap1()) {
 		dma = omap1_dma_reqs[bus_id][substream->stream];
 		port = omap1_mcbsp_port[bus_id][substream->stream];
@@ -365,8 +367,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap343x()) {
 		dma = omap24xx_dma_reqs[bus_id][substream->stream];
 		port = omap34xx_mcbsp_port[bus_id][substream->stream];
-		omap_mcbsp_dai_dma_params[id][substream->stream].set_threshold =
-						omap_mcbsp_set_threshold;
+		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
 						MCBSP_DMA_MODE_THRESHOLD)
@@ -374,26 +375,22 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else {
 		return -ENODEV;
 	}
-	omap_mcbsp_dai_dma_params[id][substream->stream].name =
-		substream->stream ? "Audio Capture" : "Audio Playback";
-	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
-	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
-	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
+	dma_data->name = substream->stream ? "Audio Capture" : "Audio Playback";
+	dma_data->dma_req = dma;
+	dma_data->port_addr = port;
+	dma_data->sync_mode = sync_mode;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
-			 OMAP_DMA_DATA_TYPE_S16;
+		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
-			 OMAP_DMA_DATA_TYPE_S32;
+		dma_data->data_type = OMAP_DMA_DATA_TYPE_S32;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	snd_soc_dai_set_dma_data(cpu_dai, substream,
-		&omap_mcbsp_dai_dma_params[id][substream->stream]);
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	if (mcbsp_data->configured) {
 		/* McBSP already configured by another stream */
-- 
1.7.2
