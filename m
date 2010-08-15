From: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
Subject: [PATCH 1/4] sound: soc: msm7k: add mmap interface
Date: Sun, 15 Aug 2010 20:08:10 +0200
Message-ID: <1281895691-25311-1-git-send-email-GNUtoo@no-log.org>
References: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp202.alice.it (smtp202.alice.it [82.57.200.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E77C244F8
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 20:08:21 +0200 (CEST)
In-Reply-To: <1281895083-24953-1-git-send-email-GNUtoo@no-log.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
List-Id: alsa-devel@alsa-project.org

The mmap interface is a patch rebased from this msm7kv2 alsa driver patch:
 commit c25698fee4fbd82a325394263752cb8b843fcfdc
 Author: Asish Bhattacharya <asishb@qualcomm.com>
 Date:   Thu Jan 21 14:38:41 2010 +0530

     alsa: soc: MMAP capability to playback stream

     The current code supports playback non-mmap(copy) mode playback.
     Adding support to do mmap-mode playback.

     Signed-off-by: Asish Bhattacharya <asishb@qualcomm.com>
It is comming from git://codeaurora.org/kernel/msm.git

Note that this is still not usable,because the buffer underrun
  are a lot worse than with non-mmaped interface.
Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
---
 sound/soc/msm/TODO        |    4 ++
 sound/soc/msm/msm-pcm.c   |    8 ++-
 sound/soc/msm/msm-pcm.h   |    7 ++-
 sound/soc/msm/msm7k-pcm.c |  110 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 117 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/msm/TODO

diff --git a/sound/soc/msm/TODO b/sound/soc/msm/TODO
new file mode 100644
index 0000000..87084ea
--- /dev/null
+++ b/sound/soc/msm/TODO
@@ -0,0 +1,4 @@
+ad4974853c00ac1b6ac388a2915d86c06a04447f
+87a86ea6bd2868d9e9b3113f366e7ca440ef6199
+35240ee6cc224db5c916b345ae7a23fbe9b1ade6
+3d02aeb5607c558dec70054a234b2f36007ea362
diff --git a/sound/soc/msm/msm-pcm.c b/sound/soc/msm/msm-pcm.c
index f90c778..23c2c55 100644
--- a/sound/soc/msm/msm-pcm.c
+++ b/sound/soc/msm/msm-pcm.c
@@ -47,8 +47,6 @@
 	msm_adsp_write(prtd->audrec, QDSP_uPAudRecCmdQueue, cmd, len)
 
 int intcnt;
-static int audio_dsp_send_buffer(struct msm_audio *prtd,
-			unsigned idx, unsigned len);
 
 struct audio_frame {
 	uint16_t count_low;
@@ -141,6 +139,9 @@ void alsa_dsp_event(void *data, unsigned id, uint16_t *msg)
 			if (prtd->ops->playback)
 				prtd->ops->playback(prtd);
 
+			if (prtd->mmap_flag)
+                                break;
+
 			spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
 			if (prtd->running) {
 				prtd->out[idx].used = 0;
@@ -631,7 +632,7 @@ int alsa_buffer_read(struct msm_audio *prtd, void __user *buf,
 }
 EXPORT_SYMBOL(alsa_buffer_read);
 
-static int audio_dsp_send_buffer(struct msm_audio *prtd,
+int audio_dsp_send_buffer(struct msm_audio *prtd,
 					unsigned idx, unsigned len)
 {
 	audpp_cmd_pcm_intf_send_buffer cmd;
@@ -645,6 +646,7 @@ static int audio_dsp_send_buffer(struct msm_audio *prtd,
 	return audpp_send_queue2(&cmd, sizeof(cmd));
 }
 
+
 int alsa_rec_dsp_enable(struct msm_audio *prtd, int enable)
 {
 	audrec_cmd_cfg cmd;
diff --git a/sound/soc/msm/msm-pcm.h b/sound/soc/msm/msm-pcm.h
index 9551bb0..62651a7 100644
--- a/sound/soc/msm/msm-pcm.h
+++ b/sound/soc/msm/msm-pcm.h
@@ -52,8 +52,7 @@
 			(SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
 #define USE_RATE_MIN            8000
 #define USE_RATE_MAX            48000
-#define MAX_BUFFER_PLAYBACK_SIZE \
-				(4800*4)
+#define MAX_BUFFER_PLAYBACK_SIZE PLAYBACK_DMASZ
 /* 2048 frames (Mono), 1024 frames (Stereo) */
 #define CAPTURE_SIZE		4096
 #define MAX_BUFFER_CAPTURE_SIZE (4096*4)
@@ -174,6 +173,8 @@ struct msm_audio {
 	int running;
 	int stopped; /* set when stopped, cleared on flush */
 	int eos_ack;
+        int mmap_flag;
+        int period;
 };
 
 
@@ -193,6 +194,8 @@ extern int alsa_audio_disable(struct msm_audio *prtd);
 extern int alsa_adsp_configure(struct msm_audio *prtd);
 extern int alsa_buffer_read(struct msm_audio *prtd, void __user *buf,
 					size_t count, loff_t *pos);
+extern int audio_dsp_send_buffer(struct msm_audio *prtd,
+			unsigned idx, unsigned len);
 ssize_t alsa_send_buffer(struct msm_audio *prtd, const char __user *buf,
 					size_t count, loff_t *pos, int copy_count);
 int msm_audio_volume_update(unsigned id,
diff --git a/sound/soc/msm/msm7k-pcm.c b/sound/soc/msm/msm7k-pcm.c
index c366902..9561e91 100644
--- a/sound/soc/msm/msm7k-pcm.c
+++ b/sound/soc/msm/msm7k-pcm.c
@@ -108,7 +108,9 @@ static unsigned convert_samp_rate(unsigned hz)
 }
 
 static struct snd_pcm_hardware msm_pcm_playback_hardware = {
-	.info =                 SNDRV_PCM_INFO_INTERLEAVED,
+	.info =                 SNDRV_PCM_INFO_MMAP |
+	                        SNDRV_PCM_INFO_MMAP_VALID |
+                                SNDRV_PCM_INFO_INTERLEAVED,
 	.formats =              USE_FORMATS,
 	.rates =                USE_RATE,
 	.rate_min =             USE_RATE_MIN,
@@ -150,10 +152,35 @@ static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
 	.mask = 0,
 };
 
+static void msm_pcm_enqueue_data(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct msm_audio *prtd = runtime->private_data;
+	unsigned int period_size;
+
+	period_size = snd_pcm_lib_period_bytes(substream);
+	audio_dsp_send_buffer(prtd, prtd->out_tail, period_size);
+	prtd->out_tail ^= 1;
+	++copy_count;
+	prtd->period++;
+	if (unlikely(prtd->period >= runtime->periods))
+		prtd->period = 0;
+
+}
+
+
 static void playback_event_handler(void *data)
 {
 	struct msm_audio *prtd = data;
 	snd_pcm_period_elapsed(prtd->playback_substream);
+	if (prtd->mmap_flag) {
+		if (prtd->dir == SNDRV_PCM_STREAM_CAPTURE)
+			return;
+		if (!prtd->stopped)
+			msm_pcm_enqueue_data(prtd->playback_substream);
+		else
+			prtd->out_needed++;
+	}
 }
 
 static void capture_event_handler(void *data)
@@ -171,10 +198,30 @@ static int msm_pcm_playback_prepare(struct snd_pcm_substream *substream)
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
 	prtd->pcm_irq_pos = 0;
 	prtd->pcm_buf_pos = 0;
+	if (prtd->enabled)
+		return 0;
 
 	/* rate and channels are sent to audio driver */
 	prtd->out_sample_rate = runtime->rate;
 	prtd->out_channel_mode = runtime->channels;
+	/* prtd->data = prtd->substream->dma_buffer.area; */
+	/* prtd->phys = prtd->substream->dma_buffer.addr; */
+	/* prtd->out[0].data = prtd->data + 0; */
+	/* prtd->out[0].addr = prtd->phys + 0; */
+	/* prtd->out[0].size = BUFSZ; */
+	/* prtd->out[1].data = prtd->data + BUFSZ; */
+	/* prtd->out[1].addr = prtd->phys + BUFSZ; */
+	/* prtd->out[1].size = BUFSZ; */
+
+	if (prtd->enabled | !(prtd->mmap_flag))
+		return 0;
+
+	prtd->out[0].used = prtd->pcm_count;
+	prtd->out[1].used = prtd->pcm_count;
+
+	mutex_lock(&the_locks.lock);
+	alsa_audio_configure(prtd);
+	mutex_unlock(&the_locks.lock);
 
 	return 0;
 }
@@ -230,19 +277,56 @@ static int msm_pcm_capture_prepare(struct snd_pcm_substream *substream)
 
 static int msm_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct msm_audio *prtd = runtime->private_data;
+	unsigned long flag = 0;
 	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			|| !prtd->mmap_flag)
+			break;
+		if (!prtd->out_needed) {
+			prtd->stopped = 0;
+			break;
+		}
+		spin_lock_irqsave(&the_locks.write_dsp_lock, flag);
+		if (prtd->running == 1) {
+			if (prtd->stopped == 1) {
+				prtd->stopped = 0;
+				prtd->period = 0;
+				if (prtd->pcm_irq_pos == 0) {
+					prtd->out_tail = 0;
+					msm_pcm_enqueue_data(prtd->playback_substream);
+					prtd->out_needed--;
+				} else {
+					prtd->out_tail = 1;
+					msm_pcm_enqueue_data(prtd->playback_substream);
+					prtd->out_needed--;
+				}
+				if (prtd->out_needed) {
+					prtd->out_tail ^= 1;
+					msm_pcm_enqueue_data(prtd->playback_substream);
+					prtd->out_needed--;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&the_locks.write_dsp_lock, flag);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+                if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+                        || !prtd->mmap_flag)
+			break;
+		prtd->stopped = 1;
 		break;
 	default:
 		ret = -EINVAL;
+		break;
 	}
 
 	return ret;
@@ -463,16 +547,27 @@ static snd_pcm_uframes_t msm_pcm_pointer(struct snd_pcm_substream *substream)
 int msm_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
-	if (substream->pcm->device & 1) {
-		runtime->hw.info &= ~SNDRV_PCM_INFO_INTERLEAVED;
-		runtime->hw.info |= SNDRV_PCM_INFO_NONINTERLEAVED;
-	}
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	return 0;
 
 }
 
+int msm_pcm_mmap(struct snd_pcm_substream *substream,
+				struct vm_area_struct *vma)
+ {
+        struct snd_pcm_runtime *runtime = substream->runtime;
+	struct msm_audio *prtd = runtime->private_data;
+
+	prtd->out_head = 0; /* point to First buffer on startup */
+	prtd->mmap_flag = 1;
+	runtime->dma_bytes = snd_pcm_lib_period_bytes(substream)*2;
+	dma_mmap_coherent(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+	return 0;
+}
+
 static struct snd_pcm_ops msm_pcm_ops = {
 	.open           = msm_pcm_open,
 	.copy		= msm_pcm_copy,
@@ -483,6 +578,7 @@ static struct snd_pcm_ops msm_pcm_ops = {
 	.prepare        = msm_pcm_prepare,
 	.trigger        = msm_pcm_trigger,
 	.pointer        = msm_pcm_pointer,
+	.mmap           = msm_pcm_mmap,
 };
 
 
-- 
1.7.0.4
