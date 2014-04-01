From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/6] ASoC: davinci-mcasp: Configure the AFIFO
	and DMA burst size at the same place
Date: Tue, 1 Apr 2014 15:55:10 +0300
Message-ID: <1396356912-30466-5-git-send-email-peter.ujfalusi@ti.com>
References: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id C56942652BE
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:28 +0200 (CEST)
In-Reply-To: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Move the dma_params->fifo_level and dma_data->maxburst configuration to the
mcasp_common_hw_param() function where we configure the AFIFO registers.
It makes the code regarding to AFIFO and DMA configuration more easy to
follow since it is now clear how the AFIFO and how the DMA is going to be
configured.
Previously this has been done in two functions using a bit different
calculation form - which ended up with the same result in both case at the
end, but it was confusing.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 9620d0165133..dd6910b289dd 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -460,6 +460,8 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 				    int channels)
 {
+	struct davinci_pcm_dma_params *dma_params = &mcasp->dma_params[stream];
+	struct snd_dmaengine_dai_dma_data *dma_data = &mcasp->dma_data[stream];
 	int i;
 	u8 tx_ser = 0;
 	u8 rx_ser = 0;
@@ -516,9 +518,14 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 		return -EINVAL;
 	}
 
+
 	/* AFIFO is not in use */
-	if (!numevt)
+	if (!numevt) {
+		/* Configure the burst size for platform drivers */
+		dma_params->fifo_level = 0;
+		dma_data->maxburst = 0;
 		return 0;
+	}
 
 	if (numevt * active_serializers > MCASP_MAX_AFIFO_DEPTH)
 		numevt = active_serializers;
@@ -528,6 +535,10 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	mcasp_mod_bits(mcasp, reg, active_serializers, NUMDMA_MASK);
 	mcasp_mod_bits(mcasp, reg, NUMEVT(numevt), NUMEVT_MASK);
 
+	/* Configure the burst size for platform drivers */
+	dma_params->fifo_level = numevt;
+	dma_data->maxburst = numevt;
+
 	return 0;
 }
 
@@ -643,12 +654,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
 	struct davinci_pcm_dma_params *dma_params =
 					&mcasp->dma_params[substream->stream];
-	struct snd_dmaengine_dai_dma_data *dma_data =
-					&mcasp->dma_data[substream->stream];
 	int word_length;
-	u8 fifo_level;
-	u8 slots = mcasp->tdm_slots;
-	u8 active_serializers;
 	int channels = params_channels(params);
 	int ret;
 
@@ -707,21 +713,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Calculate FIFO level */
-	active_serializers = (channels + slots - 1) / slots;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		fifo_level = mcasp->txnumevt * active_serializers;
-	else
-		fifo_level = mcasp->rxnumevt * active_serializers;
-
-	if (mcasp->version == MCASP_VERSION_2 && !fifo_level)
+	if (mcasp->version == MCASP_VERSION_2 && !dma_params->fifo_level)
 		dma_params->acnt = 4;
 	else
 		dma_params->acnt = dma_params->data_type;
 
-	dma_params->fifo_level = fifo_level;
-	dma_data->maxburst = fifo_level;
-
 	davinci_config_channel_size(mcasp, word_length);
 
 	return 0;
-- 
1.9.1
