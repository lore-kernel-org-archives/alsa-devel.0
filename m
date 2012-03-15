From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: omap-mcbsp: Use DMA packet mode for
	non mono streams on OMAP3+
Date: Thu, 15 Mar 2012 12:37:13 +0200
Message-ID: <1331807834-25675-2-git-send-email-peter.ujfalusi@ti.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 40B1D1045CE
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:37:28 +0100 (CET)
Received: by lboi15 with SMTP id i15so1629336lbo.41
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 03:37:25 -0700 (PDT)
In-Reply-To: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Take the DMA packet mode into use when the McBSP is configured in element
dma_op_mode if the stream is not mono.
In this way we transfer one sample from/to McBSP FIFO upon DMA request.
This change only affects OMAP3+ versions, where the McBSP ports have FIFO.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6912ac7..418dc3c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -71,18 +71,17 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
-	if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-		/*
-		 * Configure McBSP threshold based on either:
-		 * packet_size, when the sDMA is in packet mode, or
-		 * based on the period size.
-		 */
-		if (dma_data->packet_size)
-			words = dma_data->packet_size;
-		else
-			words = snd_pcm_lib_period_bytes(substream) /
-							(mcbsp->wlen / 8);
+	/*
+	 * Configure McBSP threshold based on either:
+	 * packet_size, when the sDMA is in packet mode, or based on the
+	 * period size in THRESHOLD mode, otherwise use McBSP threshold = 1
+	 * for mono streams.
+	 */
+	if (dma_data->packet_size)
+		words = dma_data->packet_size;
+	else if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
+		words = snd_pcm_lib_period_bytes(substream) /
+						(mcbsp->wlen / 8);
 	else
 		words = 1;
 
@@ -230,6 +229,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int format, div, framesize, master;
 
 	dma_data = &mcbsp->dma_data[substream->stream];
+	channels = params_channels(params);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -283,6 +283,10 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			} else {
 				sync_mode = OMAP_DMA_SYNC_FRAME;
 			}
+		} else if (channels > 1) {
+			/* Use packet mode for non mono streams */
+			pkt_size = channels;
+			sync_mode = OMAP_DMA_SYNC_PACKET;
 		}
 	}
 
@@ -301,7 +305,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	regs->rcr1	&= ~(RFRLEN1(0x7f) | RWDLEN1(7));
 	regs->xcr1	&= ~(XFRLEN1(0x7f) | XWDLEN1(7));
 	format = mcbsp->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
-	wpf = channels = params_channels(params);
+	wpf = channels;
 	if (channels == 2 && (format == SND_SOC_DAIFMT_I2S ||
 			      format == SND_SOC_DAIFMT_LEFT_J)) {
 		/* Use dual-phase frames */
-- 
1.7.8.5
