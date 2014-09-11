From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: lx6464es: Use nonatomic PCM ops
Date: Thu, 11 Sep 2014 16:00:24 +0200
Message-ID: <1410444025-22772-6-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DEB45265768
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2D985AD31
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 14:00:30 +0000 (UTC)
In-Reply-To: <1410444025-22772-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Like the other previous changes, this patch for lx6464es takes the
same strategy for converting to nonatomic PCM ops: replacing spinlock
with mutex, converting the irq tasklet to the threaded irq, and
merging the trigger tasklets back to the trigger callback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
Compile tested only.

 sound/pci/lx6464es/lx6464es.c |  43 +++----
 sound/pci/lx6464es/lx6464es.h |   9 +-
 sound/pci/lx6464es/lx_core.c  | 252 +++++++++++++++---------------------------
 sound/pci/lx6464es/lx_core.h  |   4 +-
 4 files changed, 108 insertions(+), 200 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index a671f0865f71..601315a1f58f 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -279,7 +279,6 @@ static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
 {
 	struct lx6464es *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_uframes_t pos;
-	unsigned long flags;
 	int is_capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 
 	struct lx_stream *lx_stream = is_capture ? &chip->capture_stream :
@@ -287,9 +286,9 @@ static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
 
 	dev_dbg(chip->card->dev, "->lx_pcm_stream_pointer\n");
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	pos = lx_stream->frame_pos * substream->runtime->period_size;
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 
 	dev_dbg(chip->card->dev, "stream_pointer at %ld\n", pos);
 	return pos;
@@ -485,8 +484,8 @@ static void lx_trigger_stop(struct lx6464es *chip, struct lx_stream *lx_stream)
 
 }
 
-static void lx_trigger_tasklet_dispatch_stream(struct lx6464es *chip,
-					       struct lx_stream *lx_stream)
+static void lx_trigger_dispatch_stream(struct lx6464es *chip,
+				       struct lx_stream *lx_stream)
 {
 	switch (lx_stream->status) {
 	case LX_STREAM_STATUS_SCHEDULE_RUN:
@@ -502,24 +501,12 @@ static void lx_trigger_tasklet_dispatch_stream(struct lx6464es *chip,
 	}
 }
 
-static void lx_trigger_tasklet(unsigned long data)
-{
-	struct lx6464es *chip = (struct lx6464es *)data;
-	unsigned long flags;
-
-	dev_dbg(chip->card->dev, "->lx_trigger_tasklet\n");
-
-	spin_lock_irqsave(&chip->lock, flags);
-	lx_trigger_tasklet_dispatch_stream(chip, &chip->capture_stream);
-	lx_trigger_tasklet_dispatch_stream(chip, &chip->playback_stream);
-	spin_unlock_irqrestore(&chip->lock, flags);
-}
-
 static int lx_pcm_trigger_dispatch(struct lx6464es *chip,
 				   struct lx_stream *lx_stream, int cmd)
 {
 	int err = 0;
 
+	mutex_lock(&chip->lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		lx_stream->status = LX_STREAM_STATUS_SCHEDULE_RUN;
@@ -533,9 +520,12 @@ static int lx_pcm_trigger_dispatch(struct lx6464es *chip,
 		err = -EINVAL;
 		goto exit;
 	}
-	tasklet_schedule(&chip->trigger_tasklet);
+
+	lx_trigger_dispatch_stream(chip, &chip->capture_stream);
+	lx_trigger_dispatch_stream(chip, &chip->playback_stream);
 
 exit:
+	mutex_unlock(&chip->lock);
 	return err;
 }
 
@@ -861,6 +851,7 @@ static int lx_pcm_create(struct lx6464es *chip)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &lx_ops_capture);
 
 	pcm->info_flags = 0;
+	pcm->nonatomic = true;
 	strcpy(pcm->name, card_name);
 
 	err = snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
@@ -1009,15 +1000,9 @@ static int snd_lx6464es_create(struct snd_card *card,
 	chip->irq = -1;
 
 	/* initialize synchronization structs */
-	spin_lock_init(&chip->lock);
-	spin_lock_init(&chip->msg_lock);
+	mutex_init(&chip->lock);
+	mutex_init(&chip->msg_lock);
 	mutex_init(&chip->setup_mutex);
-	tasklet_init(&chip->trigger_tasklet, lx_trigger_tasklet,
-		     (unsigned long)chip);
-	tasklet_init(&chip->tasklet_capture, lx_tasklet_capture,
-		     (unsigned long)chip);
-	tasklet_init(&chip->tasklet_playback, lx_tasklet_playback,
-		     (unsigned long)chip);
 
 	/* request resources */
 	err = pci_request_regions(pci, card_name);
@@ -1032,8 +1017,8 @@ static int snd_lx6464es_create(struct snd_card *card,
 	/* dsp port */
 	chip->port_dsp_bar = pci_ioremap_bar(pci, 2);
 
-	err = request_irq(pci->irq, lx_interrupt, IRQF_SHARED,
-			  KBUILD_MODNAME, chip);
+	err = request_threaded_irq(pci->irq, lx_interrupt, lx_threaded_irq,
+				   IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (err) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		goto request_irq_failed;
diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.h
index 6792eda9c9a5..1bec187d772f 100644
--- a/sound/pci/lx6464es/lx6464es.h
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -71,14 +71,10 @@ struct lx6464es {
 
 	u8			mac_address[6];
 
-	spinlock_t		lock;        /* interrupt spinlock */
+	struct mutex		lock;        /* interrupt lock */
 	struct mutex            setup_mutex; /* mutex used in hw_params, open
 					      * and close */
 
-	struct tasklet_struct   trigger_tasklet; /* trigger tasklet */
-	struct tasklet_struct   tasklet_capture;
-	struct tasklet_struct   tasklet_playback;
-
 	/* ports */
 	unsigned long		port_plx;	   /* io port (size=256) */
 	void __iomem           *port_plx_remapped; /* remapped plx port */
@@ -87,8 +83,9 @@ struct lx6464es {
 						    * size=8K) */
 
 	/* messaging */
-	spinlock_t		msg_lock;          /* message spinlock */
+	struct mutex		msg_lock;          /* message lock */
 	struct lx_rmh           rmh;
+	u32			irqsrc;
 
 	/* configuration */
 	uint			freq_ratio : 2;
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index e8f38e5df10a..f3d62020ef66 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -332,27 +332,25 @@ polling_successful:
 int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 {
 	u16 ret;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 
 	lx_message_init(&chip->rmh, CMD_01_GET_SYS_CFG);
 	ret = lx_message_send_atomic(chip, &chip->rmh);
 
 	*rdsp_version = chip->rmh.stat[1];
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return ret;
 }
 
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 {
 	u16 ret = 0;
-	unsigned long flags;
 	u32 freq_raw = 0;
 	u32 freq = 0;
 	u32 frequency = 0;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 
 	lx_message_init(&chip->rmh, CMD_01_GET_SYS_CFG);
 	ret = lx_message_send_atomic(chip, &chip->rmh);
@@ -370,7 +368,7 @@ int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 			frequency = 48000;
 	}
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 
 	*rfreq = frequency * chip->freq_ratio;
 
@@ -398,25 +396,23 @@ int lx_dsp_get_mac(struct lx6464es *chip)
 
 int lx_dsp_set_granularity(struct lx6464es *chip, u32 gran)
 {
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 
 	lx_message_init(&chip->rmh, CMD_02_SET_GRANULARITY);
 	chip->rmh.cmd[0] |= gran;
 
 	ret = lx_message_send_atomic(chip, &chip->rmh);
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return ret;
 }
 
 int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data)
 {
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 
 	lx_message_init(&chip->rmh, CMD_04_GET_EVENT);
 	chip->rmh.stat_len = 9;	/* we don't necessarily need the full length */
@@ -426,7 +422,7 @@ int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data)
 	if (!ret)
 		memcpy(data, chip->rmh.stat, chip->rmh.stat_len * sizeof(u32));
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return ret;
 }
 
@@ -440,18 +436,16 @@ int lx_pipe_allocate(struct lx6464es *chip, u32 pipe, int is_capture,
 		     int channels)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_06_ALLOCATE_PIPE);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 	chip->rmh.cmd[0] |= channels;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 
 	if (err != 0)
 		dev_err(chip->card->dev, "could not allocate pipe\n");
@@ -462,17 +456,15 @@ int lx_pipe_allocate(struct lx6464es *chip, u32 pipe, int is_capture,
 int lx_pipe_release(struct lx6464es *chip, u32 pipe, int is_capture)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_07_RELEASE_PIPE);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 
 	return err;
 }
@@ -481,8 +473,6 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 		  u32 *r_needed, u32 *r_freed, u32 *size_array)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
 #ifdef CONFIG_SND_DEBUG
@@ -493,7 +483,7 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 	*r_needed = 0;
 	*r_freed = 0;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_08_ASK_BUFFERS);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -527,7 +517,7 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 		}
 	}
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -535,36 +525,32 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 int lx_pipe_stop(struct lx6464es *chip, u32 pipe, int is_capture)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_09_STOP_PIPE);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
 static int lx_pipe_toggle_state(struct lx6464es *chip, u32 pipe, int is_capture)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0B_TOGGLE_PIPE_STATE);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -600,11 +586,9 @@ int lx_pipe_sample_count(struct lx6464es *chip, u32 pipe, int is_capture,
 			 u64 *rsample_count)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0A_GET_PIPE_SPL_COUNT);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -621,18 +605,16 @@ int lx_pipe_sample_count(struct lx6464es *chip, u32 pipe, int is_capture,
 			+ chip->rmh.stat[1]; /* lo part */
 	}
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
 int lx_pipe_state(struct lx6464es *chip, u32 pipe, int is_capture, u16 *rstate)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0A_GET_PIPE_SPL_COUNT);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -644,7 +626,7 @@ int lx_pipe_state(struct lx6464es *chip, u32 pipe, int is_capture, u16 *rstate)
 	else
 		*rstate = (chip->rmh.stat[0] >> PSTATE_OFFSET) & 0x0F;
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -686,18 +668,16 @@ int lx_stream_set_state(struct lx6464es *chip, u32 pipe,
 			       int is_capture, enum stream_state_t state)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_13_SET_STREAM_STATE);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
 	chip->rmh.cmd[0] |= state;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 
 	return err;
 }
@@ -706,17 +686,14 @@ int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *runtime,
 			 u32 pipe, int is_capture)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
-
 	u32 channels = runtime->channels;
 
 	if (runtime->channels != channels)
 		dev_err(chip->card->dev, "channel count mismatch: %d vs %d",
 			   runtime->channels, channels);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0C_DEF_STREAM);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -732,7 +709,7 @@ int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *runtime,
 	chip->rmh.cmd[0] |= channels-1;
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 
 	return err;
 }
@@ -741,11 +718,9 @@ int lx_stream_state(struct lx6464es *chip, u32 pipe, int is_capture,
 		    int *rstate)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0E_GET_STREAM_SPL_COUNT);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -754,7 +729,7 @@ int lx_stream_state(struct lx6464es *chip, u32 pipe, int is_capture,
 
 	*rstate = (chip->rmh.stat[0] & SF_START) ? START_STATE : PAUSE_STATE;
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -762,11 +737,9 @@ int lx_stream_sample_position(struct lx6464es *chip, u32 pipe, int is_capture,
 			      u64 *r_bytepos)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0E_GET_STREAM_SPL_COUNT);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -777,7 +750,7 @@ int lx_stream_sample_position(struct lx6464es *chip, u32 pipe, int is_capture,
 		      << 32)	     /* hi part */
 		+ chip->rmh.stat[1]; /* lo part */
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -787,11 +760,9 @@ int lx_buffer_give(struct lx6464es *chip, u32 pipe, int is_capture,
 		   u32 *r_buffer_index)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0F_UPDATE_BUFFER);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -828,7 +799,7 @@ int lx_buffer_give(struct lx6464es *chip, u32 pipe, int is_capture,
 			"lx_buffer_give EB_CMD_REFUSED\n");
 
  done:
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -836,11 +807,9 @@ int lx_buffer_free(struct lx6464es *chip, u32 pipe, int is_capture,
 		   u32 *r_buffer_size)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_11_CANCEL_BUFFER);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -852,7 +821,7 @@ int lx_buffer_free(struct lx6464es *chip, u32 pipe, int is_capture,
 	if (err == 0)
 		*r_buffer_size = chip->rmh.stat[0]  & MASK_DATA_SIZE;
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -860,11 +829,9 @@ int lx_buffer_cancel(struct lx6464es *chip, u32 pipe, int is_capture,
 		     u32 buffer_index)
 {
 	int err;
-	unsigned long flags;
-
 	u32 pipe_cmd = PIPE_INFO_TO_CMD(is_capture, pipe);
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_11_CANCEL_BUFFER);
 
 	chip->rmh.cmd[0] |= pipe_cmd;
@@ -872,7 +839,7 @@ int lx_buffer_cancel(struct lx6464es *chip, u32 pipe, int is_capture,
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -885,12 +852,10 @@ int lx_buffer_cancel(struct lx6464es *chip, u32 pipe, int is_capture,
 int lx_level_unmute(struct lx6464es *chip, int is_capture, int unmute)
 {
 	int err;
-	unsigned long flags;
-
 	/* bit set to 1: channel muted */
 	u64 mute_mask = unmute ? 0 : 0xFFFFFFFFFFFFFFFFLLU;
 
-	spin_lock_irqsave(&chip->msg_lock, flags);
+	mutex_lock(&chip->msg_lock);
 	lx_message_init(&chip->rmh, CMD_0D_SET_MUTE);
 
 	chip->rmh.cmd[0] |= PIPE_INFO_TO_CMD(is_capture, 0);
@@ -904,7 +869,7 @@ int lx_level_unmute(struct lx6464es *chip, int is_capture, int unmute)
 
 	err = lx_message_send_atomic(chip, &chip->rmh);
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -931,10 +896,9 @@ int lx_level_peaks(struct lx6464es *chip, int is_capture, int channels,
 		   u32 *r_levels)
 {
 	int err = 0;
-	unsigned long flags;
 	int i;
-	spin_lock_irqsave(&chip->msg_lock, flags);
 
+	mutex_lock(&chip->msg_lock);
 	for (i = 0; i < channels; i += 4) {
 		u32 s0, s1, s2, s3;
 
@@ -959,7 +923,7 @@ int lx_level_peaks(struct lx6464es *chip, int is_capture, int channels,
 		r_levels += 4;
 	}
 
-	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	mutex_unlock(&chip->msg_lock);
 	return err;
 }
 
@@ -1075,7 +1039,6 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 	struct snd_pcm_substream *substream = lx_stream->stream;
 	const unsigned int is_capture = lx_stream->is_capture;
 	int err;
-	unsigned long flags;
 
 	const u32 channels = substream->runtime->channels;
 	const u32 bytes_per_frame = channels * 3;
@@ -1095,7 +1058,7 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 
 	dev_dbg(chip->card->dev, "->lx_interrupt_request_new_buffer\n");
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 
 	err = lx_buffer_ask(chip, 0, is_capture, &needed, &freed, size_array);
 	dev_dbg(chip->card->dev,
@@ -1109,85 +1072,28 @@ static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
 		    buffer_index, (unsigned long)buf, period_bytes);
 
 	lx_stream->frame_pos = next_pos;
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 
 	return err;
 }
 
-void lx_tasklet_playback(unsigned long data)
-{
-	struct lx6464es *chip = (struct lx6464es *)data;
-	struct lx_stream *lx_stream = &chip->playback_stream;
-	int err;
-
-	dev_dbg(chip->card->dev, "->lx_tasklet_playback\n");
-
-	err = lx_interrupt_request_new_buffer(chip, lx_stream);
-	if (err < 0)
-		dev_err(chip->card->dev,
-			   "cannot request new buffer for playback\n");
-
-	snd_pcm_period_elapsed(lx_stream->stream);
-}
-
-void lx_tasklet_capture(unsigned long data)
-{
-	struct lx6464es *chip = (struct lx6464es *)data;
-	struct lx_stream *lx_stream = &chip->capture_stream;
-	int err;
-
-	dev_dbg(chip->card->dev, "->lx_tasklet_capture\n");
-	err = lx_interrupt_request_new_buffer(chip, lx_stream);
-	if (err < 0)
-		dev_err(chip->card->dev,
-			   "cannot request new buffer for capture\n");
-
-	snd_pcm_period_elapsed(lx_stream->stream);
-}
-
-
-
-static int lx_interrupt_handle_audio_transfer(struct lx6464es *chip,
-					      u64 notified_in_pipe_mask,
-					      u64 notified_out_pipe_mask)
-{
-	int err = 0;
-
-	if (notified_in_pipe_mask) {
-		dev_dbg(chip->card->dev,
-			"requesting audio transfer for capture\n");
-		tasklet_hi_schedule(&chip->tasklet_capture);
-	}
-
-	if (notified_out_pipe_mask) {
-		dev_dbg(chip->card->dev,
-			"requesting audio transfer for playback\n");
-		tasklet_hi_schedule(&chip->tasklet_playback);
-	}
-
-	return err;
-}
-
-
 irqreturn_t lx_interrupt(int irq, void *dev_id)
 {
 	struct lx6464es *chip = dev_id;
 	int async_pending, async_escmd;
 	u32 irqsrc;
-
-	spin_lock(&chip->lock);
+	bool wake_thread = false;
 
 	dev_dbg(chip->card->dev,
 		"**************************************************\n");
 
 	if (!lx_interrupt_ack(chip, &irqsrc, &async_pending, &async_escmd)) {
-		spin_unlock(&chip->lock);
 		dev_dbg(chip->card->dev, "IRQ_NONE\n");
 		return IRQ_NONE; /* this device did not cause the interrupt */
 	}
 
 	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
-		goto exit;
+		return IRQ_HANDLED;
 
 	if (irqsrc & MASK_SYS_STATUS_EOBI)
 		dev_dbg(chip->card->dev, "interrupt: EOBI\n");
@@ -1202,27 +1108,8 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 		dev_dbg(chip->card->dev, "interrupt: ORUN\n");
 
 	if (async_pending) {
-		u64 notified_in_pipe_mask = 0;
-		u64 notified_out_pipe_mask = 0;
-		int freq_changed;
-		int err;
-
-		/* handle async events */
-		err = lx_interrupt_handle_async_events(chip, irqsrc,
-						       &freq_changed,
-						       &notified_in_pipe_mask,
-						       &notified_out_pipe_mask);
-		if (err)
-			dev_err(chip->card->dev,
-				   "error handling async events\n");
-
-		err = lx_interrupt_handle_audio_transfer(chip,
-							 notified_in_pipe_mask,
-							 notified_out_pipe_mask
-			);
-		if (err)
-			dev_err(chip->card->dev,
-				   "error during audio transfer\n");
+		wake_thread = true;
+		chip->irqsrc = irqsrc;
 	}
 
 	if (async_escmd) {
@@ -1235,9 +1122,50 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 		dev_dbg(chip->card->dev, "interrupt requests escmd handling\n");
 	}
 
-exit:
-	spin_unlock(&chip->lock);
-	return IRQ_HANDLED;	/* this device caused the interrupt */
+	return wake_thread ? IRQ_WAKE_THREAD : IRQ_HANDLED;
+}
+
+irqreturn_t lx_threaded_irq(int irq, void *dev_id)
+{
+	struct lx6464es *chip = dev_id;
+	u64 notified_in_pipe_mask = 0;
+	u64 notified_out_pipe_mask = 0;
+	int freq_changed;
+	int err;
+
+	/* handle async events */
+	err = lx_interrupt_handle_async_events(chip, chip->irqsrc,
+					       &freq_changed,
+					       &notified_in_pipe_mask,
+					       &notified_out_pipe_mask);
+	if (err)
+		dev_err(chip->card->dev, "error handling async events\n");
+
+	if (notified_in_pipe_mask) {
+		struct lx_stream *lx_stream = &chip->capture_stream;
+
+		dev_dbg(chip->card->dev,
+			"requesting audio transfer for capture\n");
+		err = lx_interrupt_request_new_buffer(chip, lx_stream);
+		if (err < 0)
+			dev_err(chip->card->dev,
+				"cannot request new buffer for capture\n");
+		snd_pcm_period_elapsed(lx_stream->stream);
+	}
+
+	if (notified_out_pipe_mask) {
+		struct lx_stream *lx_stream = &chip->playback_stream;
+
+		dev_dbg(chip->card->dev,
+			"requesting audio transfer for playback\n");
+		err = lx_interrupt_request_new_buffer(chip, lx_stream);
+		if (err < 0)
+			dev_err(chip->card->dev,
+				"cannot request new buffer for playback\n");
+		snd_pcm_period_elapsed(lx_stream->stream);
+	}
+
+	return IRQ_HANDLED;
 }
 
 
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
index 5ec5e04da1a5..0cc140ca98e3 100644
--- a/sound/pci/lx6464es/lx_core.h
+++ b/sound/pci/lx6464es/lx_core.h
@@ -181,12 +181,10 @@ int lx_level_peaks(struct lx6464es *chip, int is_capture, int channels,
 
 /* interrupt handling */
 irqreturn_t lx_interrupt(int irq, void *dev_id);
+irqreturn_t lx_threaded_irq(int irq, void *dev_id);
 void lx_irq_enable(struct lx6464es *chip);
 void lx_irq_disable(struct lx6464es *chip);
 
-void lx_tasklet_capture(unsigned long data);
-void lx_tasklet_playback(unsigned long data);
-
 
 /* Stream Format Header Defines (for LIN and IEEE754) */
 #define HEADER_FMT_BASE		HEADER_FMT_BASE_LIN
-- 
2.1.0
