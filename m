From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: omap-mcbsp: Restructure
	omap_mcbsp_dai_startup code
Date: Tue, 20 Mar 2012 13:13:40 +0200
Message-ID: <1332242021-7494-3-git-send-email-peter.ujfalusi@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D98D103D92
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:14:01 +0100 (CET)
Received: by lbon3 with SMTP id n3so5050074lbo.32
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 04:13:58 -0700 (PDT)
In-Reply-To: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

To facilitate the period_protection feature coming up.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1046083..f6e56ec 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -120,6 +120,9 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	if (!cpu_dai->active)
 		err = omap_mcbsp_request(mcbsp);
 
+	if (!mcbsp->pdata->buffer_size)
+		return err;
+
 	/*
 	 * OMAP3 McBSP FIFO is word structured.
 	 * McBSP2 has 1024 + 256 = 1280 word long buffer,
@@ -134,24 +137,21 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 1 channel (mono): size is 128 frames (128 words)
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
+	 *
+	 * Rule for the buffer size. We should not allow
+	 * smaller buffer than the FIFO size to avoid underruns.
+	 * This applies only for the playback stream.
 	 */
-	if (mcbsp->pdata->buffer_size) {
-		/*
-		* Rule for the buffer size. We should not allow
-		* smaller buffer than the FIFO size to avoid underruns.
-		* This applies only for the playback stream.
-		*/
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			snd_pcm_hw_rule_add(substream->runtime, 0,
-					    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					    omap_mcbsp_hwrule_min_buffersize,
-					    mcbsp,
-					    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-
-		/* Make sure, that the period size is always even */
-		snd_pcm_hw_constraint_step(substream->runtime, 0,
-					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
-	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					omap_mcbsp_hwrule_min_buffersize,
+					mcbsp,
+					SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+
+	/* Make sure, that the period size is always even */
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 
 	return err;
 }
-- 
1.7.8.5
