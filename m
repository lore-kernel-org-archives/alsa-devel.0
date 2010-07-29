From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 4/4] ASoC: omap-mcbsp: Remove period size
	constraint in THRESHOLD mode
Date: Thu, 29 Jul 2010 09:51:28 +0300
Message-ID: <1280386288-22019-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 13025103933
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 08:51:29 +0200 (CEST)
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

The use of sDMA packet mode in THRESHOLD mode removes the restriction on the
period size.
With the extended THRESHOLD mode user space can ask for any
period size it wishes, and the driver will configure the
sDMA and McBSP FIFO accordingly.

Replace the hw_rule for the period size with static constraint,
which will make sure that the period size will be always
even (to avoid prime period size, which could be possible in
mono stream)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   43 ++++---------------------------------------
 1 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9fd00b0..86f2139 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -202,31 +202,6 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(buffer_size, &frames);
 }
 
-static int omap_mcbsp_hwrule_max_periodsize(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
-{
-	struct snd_interval *period_size = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
-	struct snd_interval *channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_pcm_substream *substream = rule->private;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
-	struct snd_interval frames;
-	int size;
-
-	snd_interval_any(&frames);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		size = omap_mcbsp_get_max_tx_threshold(mcbsp_data->bus_id);
-	else
-		size = omap_mcbsp_get_max_rx_threshold(mcbsp_data->bus_id);
-
-	frames.max = size / channels->min;
-	frames.integer = 1;
-	return snd_interval_refine(period_size, &frames);
-}
-
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
@@ -255,10 +230,8 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
 	if (cpu_is_omap343x()) {
-		int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
-
 		/*
-		* The first rule is for the buffer size, we should not allow
+		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
 		*/
 		snd_pcm_hw_rule_add(substream->runtime, 0,
@@ -267,17 +240,9 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				    mcbsp_data,
 				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 
-		/*
-		 * In case of threshold mode, the rule will ensure, that the
-		 * period size is not bigger than the maximum allowed threshold
-		 * value.
-		 */
-		if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-			snd_pcm_hw_rule_add(substream->runtime, 0,
-					    SNDRV_PCM_HW_PARAM_CHANNELS,
-					    omap_mcbsp_hwrule_max_periodsize,
-					    substream,
-					    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+		/* Make sure, that the period size is always even */
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 	}
 
 	return err;
-- 
1.7.2
