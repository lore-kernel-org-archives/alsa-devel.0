From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 15:36:37 +0530
Message-ID: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8818B265234
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:06:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

In many modern SoCs the audio DSP can buffer the PCM ring buffer data. Today we
have no means to represent this buffering and ALSA wrongly detects an overrun
when hw_ptr reaches app_ptr value, though DSP may still have some buffered data.

This patch tries to add a new field "soc_delay" to represent buffering done in
DSPs. This value is also used for the xrun calculations in ALSA.

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>

--
Once we are okay with this approach, I will send a follow up patch which adds
this notion in ASoC and uses this to compute cpu_dai delay. The codec_dai delay
along with FIFO delay from cpu_dai should be added and reresented by today's
notion of delay.
---
 include/sound/pcm.h     |    1 +
 sound/core/pcm_lib.c    |   14 +++++++++++---
 sound/core/pcm_native.c |    6 +++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index a55d5db..405deb7 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -281,6 +281,7 @@ struct snd_pcm_runtime {
 	unsigned long hw_ptr_jiffies;	/* Time when hw_ptr is updated */
 	unsigned long hw_ptr_buffer_jiffies; /* buffer time in jiffies */
 	snd_pcm_sframes_t delay;	/* extra delay; typically FIFO size */
+	snd_pcm_sframes_t soc_delay;	/* extra delay; typically delay incurred in soc */
 
 	/* -- HW params -- */
 	snd_pcm_access_t access;	/* access mode */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8f312fa..4977012 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -292,7 +292,15 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	} else {
-		if (avail >= runtime->stop_threshold) {
+		snd_pcm_uframes_t actual_avail;
+		if (avail < runtime->soc_delay)
+			actual_avail = avail;
+		else
+			actual_avail = avail - runtime->soc_delay;
+		if (actual_avail  >= runtime->stop_threshold) {
+			snd_printd(KERN_ERR  "avail > stop_threshold!!\n");
+			snd_printd(KERN_ERR  "actual_avail %ld, avail %ld, soc_delay %ld!!\n",
+					actual_avail, avail,  runtime->soc_delay);
 			xrun(substream);
 			return -EPIPE;
 		}
@@ -440,9 +448,9 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	if (runtime->hw.info & SNDRV_PCM_INFO_BATCH)
 		goto no_jiffies_check;
 	hdelta = delta;
-	if (hdelta < runtime->delay)
+	if (hdelta < (runtime->delay + runtime->soc_delay))
 		goto no_jiffies_check;
-	hdelta -= runtime->delay;
+	hdelta -= (runtime->delay + runtime->soc_delay);
 	jdelta = curr_jiffies - runtime->hw_ptr_jiffies;
 	if (((hdelta * HZ) / runtime->rate) > jdelta + HZ/100) {
 		delta = jdelta /
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..fc2d664 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -606,13 +606,13 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
 		    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
 			status->delay = runtime->buffer_size - status->avail;
-			status->delay += runtime->delay;
+			status->delay += runtime->delay + runtime->soc_delay;
 		} else
 			status->delay = 0;
 	} else {
 		status->avail = snd_pcm_capture_avail(runtime);
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-			status->delay = status->avail + runtime->delay;
+			status->delay = status->avail + runtime->delay + runtime->soc_delay;
 		else
 			status->delay = 0;
 	}
@@ -2442,7 +2442,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 			n = snd_pcm_playback_hw_avail(runtime);
 		else
 			n = snd_pcm_capture_avail(runtime);
-		n += runtime->delay;
+		n += runtime->delay + runtime->soc_delay;
 		break;
 	case SNDRV_PCM_STATE_XRUN:
 		err = -EPIPE;
-- 
1.7.0.4
