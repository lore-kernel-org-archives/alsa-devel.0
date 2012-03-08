From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/3] ASoC: omap-mcbsp: place size constrain on
	period, not buffer
Date: Fri,  9 Mar 2012 01:19:16 +0200
Message-ID: <1331248757-3408-3-git-send-email-notasas@gmail.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B4C810BB1B
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:19:31 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id ed3so778100wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 15:19:31 -0800 (PST)
In-Reply-To: <1331248757-3408-1-git-send-email-notasas@gmail.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Placing a constraint on buffer size is not enough, programs are
still free to use periods that are smaller than FIFO, which causes
transmit underflows as soon as the stream starts if program operates
in period-sized writes, ending up in endless loop of underruns.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap-mcbsp.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 207365c..b9d1272 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -93,11 +93,11 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 		omap_mcbsp_set_rx_threshold(mcbsp, words);
 }
 
-static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
+static int omap_mcbsp_hwrule_min_period_size(struct snd_pcm_hw_params *params,
+					     struct snd_pcm_hw_rule *rule)
 {
-	struct snd_interval *buffer_size = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+	struct snd_interval *period_size = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct omap_mcbsp *mcbsp = rule->private;
@@ -109,7 +109,7 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 
 	frames.min = size / channels->min;
 	frames.integer = 1;
-	return snd_interval_refine(buffer_size, &frames);
+	return snd_interval_refine(period_size, &frames);
 }
 
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
@@ -138,12 +138,12 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 */
 	if (mcbsp->pdata->buffer_size) {
 		/*
-		* Rule for the buffer size. We should not allow
-		* smaller buffer than the FIFO size to avoid underruns
+		* Rule for the period size. We should not allow
+		* smaller period than the FIFO size to avoid underruns
 		*/
 		snd_pcm_hw_rule_add(substream->runtime, 0,
-				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-				    omap_mcbsp_hwrule_min_buffersize,
+				    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+				    omap_mcbsp_hwrule_min_period_size,
 				    mcbsp,
 				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 
-- 
1.7.0.4
