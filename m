From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 3/4] ASoC: omap-mcbsp: Support for sDMA packet
	mode
Date: Thu, 29 Jul 2010 09:51:27 +0300
Message-ID: <1280386288-22019-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id B2B01103931
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

Utilize the sDMA controller's packet syncronization mode, when
the McBSP FIFO is in use (by extending the THRESHOLD mode).
When the sDMA is configured for packet mode, the sDMA frame size
does not need to match with the McBSP threshold configuration.
Uppon DMA request the sDMA will transfer packet size number of
words, and still trigger interrupt on frame boundary.

The patch extends the original THRESHOLD mode by doing the
following:

if (period_words <= max_threshold)
Current THRESHOLD mode configuration

Otherwise (period_words > max_threshold)
McBSP threshold = sDMA packet size
sDMA frame size = period size

With the extended THRESHOLD mode we can remove the constraint
for the maximum period size, since if the period size is
bigger than the maximum allowed threshold, than the driver
will switch to packet mode, and picks the best (biggest)
threshold value, which can divide evenly the period size.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   62 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 4ac8a08..9fd00b0 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -155,13 +155,23 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct omap_pcm_dma_data *dma_data;
 	int dma_op_mode = omap_mcbsp_get_dma_op_mode(mcbsp_data->bus_id);
 	int words;
 
+	dma_data = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
 	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 	if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-		/* The FIFO size depends on the McBSP word configuration */
-		words = snd_pcm_lib_period_bytes(substream) /
+		/*
+		 * Configure McBSP threshold based on either:
+		 * packet_size, when the sDMA is in packet mode, or
+		 * based on the period size.
+		 */
+		if (dma_data->packet_size)
+			words = dma_data->packet_size;
+		else
+			words = snd_pcm_lib_period_bytes(substream) /
 							(mcbsp_data->wlen / 8);
 	else
 		words = 1;
@@ -351,6 +361,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_pcm_dma_data *dma_data;
 	int dma, bus_id = mcbsp_data->bus_id;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
+	int pkt_size = 0;
 	unsigned long port;
 	unsigned int format, div, framesize, master;
 
@@ -373,9 +384,11 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_data->data_type = OMAP_DMA_DATA_TYPE_S16;
+		wlen = 16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_data->data_type = OMAP_DMA_DATA_TYPE_S32;
+		wlen = 32;
 		break;
 	default:
 		return -EINVAL;
@@ -384,14 +397,53 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
-						MCBSP_DMA_MODE_THRESHOLD)
-			sync_mode = OMAP_DMA_SYNC_FRAME;
+						MCBSP_DMA_MODE_THRESHOLD) {
+			int period_words, max_thrsh;
+
+			period_words = params_period_bytes(params) / (wlen / 8);
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				max_thrsh = omap_mcbsp_get_max_tx_threshold(
+							    mcbsp_data->bus_id);
+			else
+				max_thrsh = omap_mcbsp_get_max_rx_threshold(
+							    mcbsp_data->bus_id);
+			/*
+			 * If the period contains less or equal number of words,
+			 * we are using the original threshold mode setup:
+			 * McBSP threshold = sDMA frame size = period_size
+			 * Otherwise we switch to sDMA packet mode:
+			 * McBSP threshold = sDMA packet size
+			 * sDMA frame size = period size
+			 */
+			if (period_words > max_thrsh) {
+				int divider = 0;
+
+				/*
+				 * Look for the biggest threshold value, which
+				 * divides the period size evenly.
+				 */
+				divider = period_words / max_thrsh;
+				if (period_words % max_thrsh)
+					divider++;
+				while (period_words % divider &&
+					divider < period_words)
+					divider++;
+				if (divider == period_words)
+					return -EINVAL;
+
+				pkt_size = period_words / divider;
+				sync_mode = OMAP_DMA_SYNC_PACKET;
+			} else {
+				sync_mode = OMAP_DMA_SYNC_FRAME;
+			}
+		}
 	}
 
 	dma_data->name = substream->stream ? "Audio Capture" : "Audio Playback";
 	dma_data->dma_req = dma;
 	dma_data->port_addr = port;
 	dma_data->sync_mode = sync_mode;
+	dma_data->packet_size = pkt_size;
 
 	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
@@ -419,7 +471,6 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		/* Set word lengths */
-		wlen = 16;
 		regs->rcr2	|= RWDLEN2(OMAP_MCBSP_WORD_16);
 		regs->rcr1	|= RWDLEN1(OMAP_MCBSP_WORD_16);
 		regs->xcr2	|= XWDLEN2(OMAP_MCBSP_WORD_16);
@@ -427,7 +478,6 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		/* Set word lengths */
-		wlen = 32;
 		regs->rcr2	|= RWDLEN2(OMAP_MCBSP_WORD_32);
 		regs->rcr1	|= RWDLEN1(OMAP_MCBSP_WORD_32);
 		regs->xcr2	|= XWDLEN2(OMAP_MCBSP_WORD_32);
-- 
1.7.2
