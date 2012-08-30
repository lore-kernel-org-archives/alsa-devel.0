From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 1/3] ALSA: pcm - introduce device_buffer
Date: Fri, 31 Aug 2012 00:42:36 +0530
Message-ID: <1346353958-7746-2-git-send-email-vinod.koul@linux.intel.com>
References: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 3288D266299
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 21:05:40 +0200 (CEST)
In-Reply-To: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
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

In many modern SoCs the audio DSP can buffer the PCM ring buffer data, typically
in SRAMs or any other memry availble.
Today we have no means to represent this buffering and ALSA in some cases when
device still has to render this buffer but app_ptr is equal to hw_ptr alsa
wrongly detects an overrun

This patch tries to add a new field "device_buffer" to represent buffering done in
DSPs. This value is also used for the xrun calculations in ALSA

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/pcm.h     |    1 +
 sound/core/pcm_lib.c    |   14 +++++++++++---
 sound/core/pcm_native.c |    6 +++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c75c0d1..58e669a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -281,6 +281,7 @@ struct snd_pcm_runtime {
 	unsigned long hw_ptr_jiffies;	/* Time when hw_ptr is updated */
 	unsigned long hw_ptr_buffer_jiffies; /* buffer time in jiffies */
 	snd_pcm_sframes_t delay;	/* extra delay; typically FIFO size */
+	snd_pcm_sframes_t device_buffer; /* buffered data in device/driver */
 
 	/* -- HW params -- */
 	snd_pcm_access_t access;	/* access mode */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7ae6719..1d15431 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -292,7 +292,15 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	} else {
-		if (avail >= runtime->stop_threshold) {
+		snd_pcm_uframes_t actual_avail;
+		if (avail < runtime->device_buffer)
+			actual_avail = avail;
+		else
+			actual_avail = avail - runtime->device_buffer;
+		if (actual_avail  >= runtime->stop_threshold) {
+			snd_printd(KERN_ERR  "avail > stop_threshold!!\n");
+			snd_printd(KERN_ERR  "actual_avail %ld, avail %ld, device_buffer %ld!!\n",
+					actual_avail, avail,  runtime->device_buffer);
 			xrun(substream);
 			return -EPIPE;
 		}
@@ -440,9 +448,9 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	if (runtime->hw.info & SNDRV_PCM_INFO_BATCH)
 		goto no_jiffies_check;
 	hdelta = delta;
-	if (hdelta < runtime->delay)
+	if (hdelta < (runtime->delay + runtime->device_buffer))
 		goto no_jiffies_check;
-	hdelta -= runtime->delay;
+	hdelta -= (runtime->delay + runtime->device_buffer);
 	jdelta = curr_jiffies - runtime->hw_ptr_jiffies;
 	if (((hdelta * HZ) / runtime->rate) > jdelta + HZ/100) {
 		delta = jdelta /
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..33f1afa 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -606,13 +606,13 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
 		    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
 			status->delay = runtime->buffer_size - status->avail;
-			status->delay += runtime->delay;
+			status->delay += runtime->delay + runtime->device_buffer;
 		} else
 			status->delay = 0;
 	} else {
 		status->avail = snd_pcm_capture_avail(runtime);
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-			status->delay = status->avail + runtime->delay;
+			status->delay = status->avail + runtime->delay + runtime->device_buffer;
 		else
 			status->delay = 0;
 	}
@@ -2442,7 +2442,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 			n = snd_pcm_playback_hw_avail(runtime);
 		else
 			n = snd_pcm_capture_avail(runtime);
-		n += runtime->delay;
+		n += runtime->delay + runtime->device_buffer;
 		break;
 	case SNDRV_PCM_STATE_XRUN:
 		err = -EPIPE;
-- 
1.7.9.5
