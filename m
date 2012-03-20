From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 13:13:41 +0200
Message-ID: <1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog131.obsmtp.com [74.125.149.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EFD8103DB6
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 12:14:01 +0100 (CET)
Received: by mail-lpp01m010-f53.google.com with SMTP id c1so5910573lah.26
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 04:13:59 -0700 (PDT)
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

Certain application can experience underrun right after the playback start.
This is caused by the McBSP FIFO/sDMA integration:
The sDMA will push samples to the FIFO till it has threshold amount of free
slots available in the FIFO. If the application picks period size which is
smaller than the FIFO size, and it did not prepared multiple periods, or
it did not set the start_threshold for the stream to cover the FIFO size
the hw pointer will move forward, which is causing the underrun.

Add a sysfs entry for McBSP ports: period_protection.
If this property is set the driver will place the constraint agains the
period size, and not for the buffer size. To ensure that we do not hit
underrun, the period size constraint will be increased with the requested
number of frames (the period size will be FIFO size + period_protection).

As default the period_protection is disabled.

Reported-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c      |    2 +
 sound/soc/omap/mcbsp.h      |    1 +
 sound/soc/omap/omap-mcbsp.c |   59 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 34835e8..7d35327 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -806,6 +806,7 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
+THRESHOLD_PROP_BUILDER(period_protection);
 
 static const char *dma_op_modes[] = {
 	"element", "threshold",
@@ -866,6 +867,7 @@ static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
 	&dev_attr_dma_op_mode.attr,
+	&dev_attr_period_protection.attr,
 	NULL,
 };
 
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 262a615..97ba0a1 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -310,6 +310,7 @@ struct omap_mcbsp {
 	int dma_op_mode;
 	u16 max_tx_thres;
 	u16 max_rx_thres;
+	int period_protection;
 	void *reg_cache;
 	int reg_cache_size;
 
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index f6e56ec..ef47117 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -111,6 +111,30 @@ static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(buffer_size, &frames);
 }
 
+static int omap_mcbsp_hwrule_min_periodsize(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *period_size = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct omap_mcbsp *mcbsp = rule->private;
+	struct snd_interval frames;
+	int size;
+
+	snd_interval_any(&frames);
+	size = mcbsp->pdata->buffer_size;
+
+	frames.min = size / channels->min;
+	/*
+	 * Enlarge the period size with the requested period protection number
+	 * of samples to ensure we are not going to underrun.
+	 */
+	frames.min += mcbsp->period_protection;
+	frames.integer = 1;
+	return snd_interval_refine(period_size, &frames);
+}
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *cpu_dai)
 {
@@ -138,16 +162,33 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 *
-	 * Rule for the buffer size. We should not allow
-	 * smaller buffer than the FIFO size to avoid underruns.
-	 * This applies only for the playback stream.
+	 * We need to protect the stream against underrun. This only applies to
+	 * playback stream since the capture direction operates differently,
+	 * which provides this protection.
 	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_pcm_hw_rule_add(substream->runtime, 0,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-					omap_mcbsp_hwrule_min_buffersize,
-					mcbsp,
-					SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (mcbsp->period_protection) {
+			/*
+			 * Rule for the period size. We should not allow
+			 * smaller period than the FIFO size to avoid underruns.
+			 */
+			snd_pcm_hw_rule_add(substream->runtime, 0,
+					    SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					    omap_mcbsp_hwrule_min_periodsize,
+					    mcbsp,
+					    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		} else {
+			/*
+			 * Rule for the buffer size. We should not allow
+			 * smaller buffer than the FIFO size to avoid underruns.
+			 */
+			snd_pcm_hw_rule_add(substream->runtime, 0,
+					    SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					    omap_mcbsp_hwrule_min_buffersize,
+					    mcbsp,
+					    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+		}
+	}
 
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
-- 
1.7.8.5
