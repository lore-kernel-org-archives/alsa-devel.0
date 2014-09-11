From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: vx: Use nonatomic PCM ops
Date: Thu, 11 Sep 2014 16:00:21 +0200
Message-ID: <1410444025-22772-3-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B04DE265767
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2A415ACAB
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

Rewrite VXpocket and VX222 drivers to use the new PCM nonatomic ops.
The former irq tasklet is replaced with a threaded irq handler, and
the tasklet for the PCM delayed start is simply merged into the normal
PCM trigger, as well as the replacement of spinlock with mutex.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/vx_core.h     |  7 ++---
 sound/drivers/vx/vx_core.c  | 49 +++++++++++++++-----------------
 sound/drivers/vx/vx_mixer.c | 12 +++-----
 sound/drivers/vx/vx_pcm.c   | 68 +++++++++++++++------------------------------
 sound/drivers/vx/vx_uer.c   | 23 +++++++--------
 sound/pci/vx222/vx222.c     |  5 ++--
 sound/pcmcia/vx/vxp_ops.c   | 10 +++----
 sound/pcmcia/vx/vxpocket.c  |  3 +-
 8 files changed, 71 insertions(+), 106 deletions(-)

diff --git a/include/sound/vx_core.h b/include/sound/vx_core.h
index f634f8f85db5..cae9c9d4ef22 100644
--- a/include/sound/vx_core.h
+++ b/include/sound/vx_core.h
@@ -80,8 +80,6 @@ struct vx_pipe {
 
 	unsigned int references;     /* an output pipe may be used for monitoring and/or playback */
 	struct vx_pipe *monitoring_pipe;  /* pointer to the monitoring pipe (capture pipe only)*/
-
-	struct tasklet_struct start_tq;
 };
 
 struct vx_core;
@@ -165,9 +163,7 @@ struct vx_core {
 	struct snd_vx_hardware *hw;
 	struct snd_vx_ops *ops;
 
-	spinlock_t lock;
-	spinlock_t irq_lock;
-	struct tasklet_struct tq;
+	struct mutex lock;
 
 	unsigned int chip_status;
 	unsigned int pcm_running;
@@ -223,6 +219,7 @@ void snd_vx_free_firmware(struct vx_core *chip);
  * interrupt handler; exported for pcmcia
  */
 irqreturn_t snd_vx_irq_handler(int irq, void *dev);
+irqreturn_t snd_vx_threaded_irq_handler(int irq, void *dev);
 
 /*
  * lowlevel functions
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index 83596891cde4..e8cc16993903 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -117,7 +117,7 @@ static int vx_reset_chk(struct vx_core *chip)
  *
  * returns 0 if successful, or a negative error code.
  * the error code can be VX-specific, retrieved via vx_get_error().
- * NB: call with spinlock held!
+ * NB: call with mutex held!
  */
 static int vx_transfer_end(struct vx_core *chip, int cmd)
 {
@@ -155,7 +155,7 @@ static int vx_transfer_end(struct vx_core *chip, int cmd)
  *
  * returns 0 if successful, or a negative error code.
  * the error code can be VX-specific, retrieved via vx_get_error().
- * NB: call with spinlock held!
+ * NB: call with mutex held!
  */
 static int vx_read_status(struct vx_core *chip, struct vx_rmh *rmh)
 {
@@ -236,7 +236,7 @@ static int vx_read_status(struct vx_core *chip, struct vx_rmh *rmh)
  * returns 0 if successful, or a negative error code.
  * the error code can be VX-specific, retrieved via vx_get_error().
  * 
- * this function doesn't call spinlock at all.
+ * this function doesn't call mutex lock at all.
  */
 int vx_send_msg_nolock(struct vx_core *chip, struct vx_rmh *rmh)
 {
@@ -337,7 +337,7 @@ int vx_send_msg_nolock(struct vx_core *chip, struct vx_rmh *rmh)
 
 
 /*
- * vx_send_msg - send a DSP message with spinlock
+ * vx_send_msg - send a DSP message with mutex
  * @rmh: the rmh record to send and receive
  *
  * returns 0 if successful, or a negative error code.
@@ -345,12 +345,11 @@ int vx_send_msg_nolock(struct vx_core *chip, struct vx_rmh *rmh)
  */
 int vx_send_msg(struct vx_core *chip, struct vx_rmh *rmh)
 {
-	unsigned long flags;
 	int err;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	err = vx_send_msg_nolock(chip, rmh);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 	return err;
 }
 
@@ -362,7 +361,7 @@ int vx_send_msg(struct vx_core *chip, struct vx_rmh *rmh)
  * returns 0 if successful, or a negative error code.
  * the error code can be VX-specific, retrieved via vx_get_error().
  *
- * this function doesn't call spinlock at all.
+ * this function doesn't call mutex at all.
  *
  * unlike RMH, no command is sent to DSP.
  */
@@ -398,19 +397,18 @@ int vx_send_rih_nolock(struct vx_core *chip, int cmd)
 
 
 /*
- * vx_send_rih - send an RIH with spinlock
+ * vx_send_rih - send an RIH with mutex
  * @cmd: the command to send
  *
  * see vx_send_rih_nolock().
  */
 int vx_send_rih(struct vx_core *chip, int cmd)
 {
-	unsigned long flags;
 	int err;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	err = vx_send_rih_nolock(chip, cmd);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 	return err;
 }
 
@@ -482,30 +480,30 @@ static int vx_test_irq_src(struct vx_core *chip, unsigned int *ret)
 	int err;
 
 	vx_init_rmh(&chip->irq_rmh, CMD_TEST_IT);
-	spin_lock(&chip->lock);
+	mutex_lock(&chip->lock);
 	err = vx_send_msg_nolock(chip, &chip->irq_rmh);
 	if (err < 0)
 		*ret = 0;
 	else
 		*ret = chip->irq_rmh.Stat[0];
-	spin_unlock(&chip->lock);
+	mutex_unlock(&chip->lock);
 	return err;
 }
 
 
 /*
- * vx_interrupt - soft irq handler
+ * snd_vx_threaded_irq_handler - threaded irq handler
  */
-static void vx_interrupt(unsigned long private_data)
+irqreturn_t snd_vx_threaded_irq_handler(int irq, void *dev)
 {
-	struct vx_core *chip = (struct vx_core *) private_data;
+	struct vx_core *chip = dev;
 	unsigned int events;
 		
 	if (chip->chip_status & VX_STAT_IS_STALE)
-		return;
+		return IRQ_HANDLED;
 
 	if (vx_test_irq_src(chip, &events) < 0)
-		return;
+		return IRQ_HANDLED;
     
 #if 0
 	if (events & 0x000800)
@@ -519,7 +517,7 @@ static void vx_interrupt(unsigned long private_data)
 	 */
 	if (events & FATAL_DSP_ERROR) {
 		snd_printk(KERN_ERR "vx_core: fatal DSP error!!\n");
-		return;
+		return IRQ_HANDLED;
 	}
 
 	/* The start on time code conditions are filled (ie the time code
@@ -534,8 +532,9 @@ static void vx_interrupt(unsigned long private_data)
 
 	/* update the pcm streams */
 	vx_pcm_update_intr(chip, events);
+	return IRQ_HANDLED;
 }
-
+EXPORT_SYMBOL(snd_vx_threaded_irq_handler);
 
 /**
  * snd_vx_irq_handler - interrupt handler
@@ -548,8 +547,8 @@ irqreturn_t snd_vx_irq_handler(int irq, void *dev)
 	    (chip->chip_status & VX_STAT_IS_STALE))
 		return IRQ_NONE;
 	if (! vx_test_and_ack(chip))
-		tasklet_schedule(&chip->tq);
-	return IRQ_HANDLED;
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
 }
 
 EXPORT_SYMBOL(snd_vx_irq_handler);
@@ -790,13 +789,11 @@ struct vx_core *snd_vx_create(struct snd_card *card, struct snd_vx_hardware *hw,
 		snd_printk(KERN_ERR "vx_core: no memory\n");
 		return NULL;
 	}
-	spin_lock_init(&chip->lock);
-	spin_lock_init(&chip->irq_lock);
+	mutex_init(&chip->lock);
 	chip->irq = -1;
 	chip->hw = hw;
 	chip->type = hw->type;
 	chip->ops = ops;
-	tasklet_init(&chip->tq, vx_interrupt, (unsigned long)chip);
 	mutex_init(&chip->mixer_mutex);
 
 	chip->card = card;
diff --git a/sound/drivers/vx/vx_mixer.c b/sound/drivers/vx/vx_mixer.c
index c71b8d148d7f..3b6823fc0606 100644
--- a/sound/drivers/vx/vx_mixer.c
+++ b/sound/drivers/vx/vx_mixer.c
@@ -32,17 +32,15 @@
  */
 static void vx_write_codec_reg(struct vx_core *chip, int codec, unsigned int data)
 {
-	unsigned long flags;
-
 	if (snd_BUG_ON(!chip->ops->write_codec))
 		return;
 
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	chip->ops->write_codec(chip, codec, data);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 /*
@@ -178,14 +176,12 @@ void vx_reset_codec(struct vx_core *chip, int cold_reset)
  */
 static void vx_change_audio_source(struct vx_core *chip, int src)
 {
-	unsigned long flags;
-
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	chip->ops->change_audio_source(chip, src);
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index deed5efff33c..11467272089e 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -229,7 +229,7 @@ static int vx_get_pipe_state(struct vx_core *chip, struct vx_pipe *pipe, int *st
 
 	vx_init_rmh(&rmh, CMD_PIPE_STATE);
 	vx_set_pipe_cmd_params(&rmh, pipe->is_capture, pipe->number, 0);
-	err = vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	err = vx_send_msg(chip, &rmh);
 	if (! err)
 		*state = (rmh.Stat[0] & (1 << pipe->number)) ? 1 : 0;
 	return err;
@@ -280,7 +280,7 @@ static int vx_pipe_can_start(struct vx_core *chip, struct vx_pipe *pipe)
 	vx_set_pipe_cmd_params(&rmh, pipe->is_capture, pipe->number, 0);
 	rmh.Cmd[0] |= 1;
 
-	err = vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	err = vx_send_msg(chip, &rmh);
 	if (! err) {
 		if (rmh.Stat[0])
 			err = 1;
@@ -300,7 +300,7 @@ static int vx_conf_pipe(struct vx_core *chip, struct vx_pipe *pipe)
 	if (pipe->is_capture)
 		rmh.Cmd[0] |= COMMAND_RECORD_MASK;
 	rmh.Cmd[1] = 1 << pipe->number;
-	return vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */
+	return vx_send_msg(chip, &rmh);
 }
 
 /*
@@ -311,7 +311,7 @@ static int vx_send_irqa(struct vx_core *chip)
 	struct vx_rmh rmh;
 
 	vx_init_rmh(&rmh, CMD_SEND_IRQA);
-	return vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	return vx_send_msg(chip, &rmh);
 }
 
 
@@ -389,7 +389,7 @@ static int vx_stop_pipe(struct vx_core *chip, struct vx_pipe *pipe)
 	struct vx_rmh rmh;
 	vx_init_rmh(&rmh, CMD_STOP_PIPE);
 	vx_set_pipe_cmd_params(&rmh, pipe->is_capture, pipe->number, 0);
-	return vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	return vx_send_msg(chip, &rmh);
 }
 
 
@@ -477,7 +477,7 @@ static int vx_start_stream(struct vx_core *chip, struct vx_pipe *pipe)
 	vx_init_rmh(&rmh, CMD_START_ONE_STREAM);
 	vx_set_stream_cmd_params(&rmh, pipe->is_capture, pipe->number);
 	vx_set_differed_time(chip, &rmh, pipe);
-	return vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	return vx_send_msg(chip, &rmh);
 }
 
 
@@ -492,7 +492,7 @@ static int vx_stop_stream(struct vx_core *chip, struct vx_pipe *pipe)
 
 	vx_init_rmh(&rmh, CMD_STOP_STREAM);
 	vx_set_stream_cmd_params(&rmh, pipe->is_capture, pipe->number);
-	return vx_send_msg_nolock(chip, &rmh); /* no lock needed for trigger */ 
+	return vx_send_msg(chip, &rmh);
 }
 
 
@@ -520,8 +520,6 @@ static struct snd_pcm_hardware vx_pcm_playback_hw = {
 };
 
 
-static void vx_pcm_delayed_start(unsigned long arg);
-
 /*
  * vx_pcm_playback_open - open callback for playback
  */
@@ -553,7 +551,6 @@ static int vx_pcm_playback_open(struct snd_pcm_substream *subs)
 	pipe->references++;
 
 	pipe->substream = subs;
-	tasklet_init(&pipe->start_tq, vx_pcm_delayed_start, (unsigned long)subs);
 	chip->playback_pipes[audio] = pipe;
 
 	runtime->hw = vx_pcm_playback_hw;
@@ -646,12 +643,12 @@ static int vx_pcm_playback_transfer_chunk(struct vx_core *chip,
 	/* we don't need irqsave here, because this function
 	 * is called from either trigger callback or irq handler
 	 */
-	spin_lock(&chip->lock); 
+	mutex_lock(&chip->lock);
 	vx_pseudo_dma_write(chip, runtime, pipe, size);
 	err = vx_notify_end_of_buffer(chip, pipe);
 	/* disconnect the host, SIZE_HBUF command always switches to the stream mode */
 	vx_send_rih_nolock(chip, IRQ_CONNECT_STREAM_NEXT);
-	spin_unlock(&chip->lock);
+	mutex_unlock(&chip->lock);
 	return err;
 }
 
@@ -728,31 +725,6 @@ static void vx_pcm_playback_update(struct vx_core *chip,
 }
 
 /*
- * start the stream and pipe.
- * this function is called from tasklet, which is invoked by the trigger
- * START callback.
- */
-static void vx_pcm_delayed_start(unsigned long arg)
-{
-	struct snd_pcm_substream *subs = (struct snd_pcm_substream *)arg;
-	struct vx_core *chip = subs->pcm->private_data;
-	struct vx_pipe *pipe = subs->runtime->private_data;
-	int err;
-
-	/*  printk( KERN_DEBUG "DDDD tasklet delayed start jiffies = %ld\n", jiffies);*/
-
-	if ((err = vx_start_stream(chip, pipe)) < 0) {
-		snd_printk(KERN_ERR "vx: cannot start stream\n");
-		return;
-	}
-	if ((err = vx_toggle_pipe(chip, pipe, 1)) < 0) {
-		snd_printk(KERN_ERR "vx: cannot start pipe\n");
-		return;
-	}
-	/*   printk( KERN_DEBUG "dddd tasklet delayed start jiffies = %ld \n", jiffies);*/
-}
-
-/*
  * vx_pcm_playback_trigger - trigger callback for playback
  */
 static int vx_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
@@ -769,11 +741,17 @@ static int vx_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
 	case SNDRV_PCM_TRIGGER_RESUME:
 		if (! pipe->is_capture)
 			vx_pcm_playback_transfer(chip, subs, pipe, 2);
-		/* FIXME:
-		 * we trigger the pipe using tasklet, so that the interrupts are
-		 * issued surely after the trigger is completed.
-		 */ 
-		tasklet_schedule(&pipe->start_tq);
+		err = vx_start_stream(chip, pipe);
+		if (err < 0) {
+			pr_debug("vx: cannot start stream\n");
+			return err;
+		}
+		err = vx_toggle_pipe(chip, pipe, 1);
+		if (err < 0) {
+			pr_debug("vx: cannot start pipe\n");
+			vx_stop_stream(chip, pipe);
+			return err;
+		}
 		chip->pcm_running++;
 		pipe->running = 1;
 		break;
@@ -955,7 +933,6 @@ static int vx_pcm_capture_open(struct snd_pcm_substream *subs)
 	if (err < 0)
 		return err;
 	pipe->substream = subs;
-	tasklet_init(&pipe->start_tq, vx_pcm_delayed_start, (unsigned long)subs);
 	chip->capture_pipes[audio] = pipe;
 
 	/* check if monitoring is needed */
@@ -1082,7 +1059,7 @@ static void vx_pcm_capture_update(struct vx_core *chip, struct snd_pcm_substream
 		count -= 3;
 	}
 	/* disconnect the host, SIZE_HBUF command always switches to the stream mode */
-	vx_send_rih_nolock(chip, IRQ_CONNECT_STREAM_NEXT);
+	vx_send_rih(chip, IRQ_CONNECT_STREAM_NEXT);
 	/* read the last pending 6 bytes */
 	count = DMA_READ_ALIGN;
 	while (count > 0) {
@@ -1099,7 +1076,7 @@ static void vx_pcm_capture_update(struct vx_core *chip, struct snd_pcm_substream
 
  _error:
 	/* disconnect the host, SIZE_HBUF command always switches to the stream mode */
-	vx_send_rih_nolock(chip, IRQ_CONNECT_STREAM_NEXT);
+	vx_send_rih(chip, IRQ_CONNECT_STREAM_NEXT);
 	return;
 }
 
@@ -1275,6 +1252,7 @@ int snd_vx_pcm_new(struct vx_core *chip)
 		pcm->private_data = chip;
 		pcm->private_free = snd_vx_pcm_free;
 		pcm->info_flags = 0;
+		pcm->nonatomic = true;
 		strcpy(pcm->name, chip->card->shortname);
 		chip->pcm[i] = pcm;
 	}
diff --git a/sound/drivers/vx/vx_uer.c b/sound/drivers/vx/vx_uer.c
index b0560fec6bba..ef0b40c0a594 100644
--- a/sound/drivers/vx/vx_uer.c
+++ b/sound/drivers/vx/vx_uer.c
@@ -60,9 +60,9 @@ static int vx_modify_board_inputs(struct vx_core *chip)
  */
 static int vx_read_one_cbit(struct vx_core *chip, int index)
 {
-	unsigned long flags;
 	int val;
-	spin_lock_irqsave(&chip->lock, flags);
+
+	mutex_lock(&chip->lock);
 	if (chip->type >= VX_TYPE_VXPOCKET) {
 		vx_outb(chip, CSUER, 1); /* read */
 		vx_outb(chip, RUER, index & XX_UER_CBITS_OFFSET_MASK);
@@ -72,7 +72,7 @@ static int vx_read_one_cbit(struct vx_core *chip, int index)
 		vx_outl(chip, RUER, index & XX_UER_CBITS_OFFSET_MASK);
 		val = (vx_inl(chip, RUER) >> 7) & 0x01;
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 	return val;
 }
 
@@ -83,9 +83,8 @@ static int vx_read_one_cbit(struct vx_core *chip, int index)
  */
 static void vx_write_one_cbit(struct vx_core *chip, int index, int val)
 {
-	unsigned long flags;
 	val = !!val;	/* 0 or 1 */
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	if (vx_is_pcmcia(chip)) {
 		vx_outb(chip, CSUER, 0); /* write */
 		vx_outb(chip, RUER, (val << 7) | (index & XX_UER_CBITS_OFFSET_MASK));
@@ -93,7 +92,7 @@ static void vx_write_one_cbit(struct vx_core *chip, int index, int val)
 		vx_outl(chip, CSUER, 0); /* write */
 		vx_outl(chip, RUER, (val << 7) | (index & XX_UER_CBITS_OFFSET_MASK));
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 /*
@@ -190,14 +189,12 @@ static int vx_calc_clock_from_freq(struct vx_core *chip, int freq)
  */
 static void vx_change_clock_source(struct vx_core *chip, int source)
 {
-	unsigned long flags;
-
 	/* we mute DAC to prevent clicks */
 	vx_toggle_dac_mute(chip, 1);
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	chip->ops->set_clock_source(chip, source);
 	chip->clock_source = source;
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 	/* unmute */
 	vx_toggle_dac_mute(chip, 0);
 }
@@ -209,11 +206,11 @@ static void vx_change_clock_source(struct vx_core *chip, int source)
 void vx_set_internal_clock(struct vx_core *chip, unsigned int freq)
 {
 	int clock;
-	unsigned long flags;
+
 	/* Get real clock value */
 	clock = vx_calc_clock_from_freq(chip, freq);
 	snd_printdd(KERN_DEBUG "set internal clock to 0x%x from freq %d\n", clock, freq);
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	if (vx_is_pcmcia(chip)) {
 		vx_outb(chip, HIFREQ, (clock >> 8) & 0x0f);
 		vx_outb(chip, LOFREQ, clock & 0xff);
@@ -221,7 +218,7 @@ void vx_set_internal_clock(struct vx_core *chip, unsigned int freq)
 		vx_outl(chip, HIFREQ, (clock >> 8) & 0x0f);
 		vx_outl(chip, LOFREQ, clock & 0xff);
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 3dc4732142ee..c5a25e39e3a8 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -168,8 +168,9 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 	for (i = 0; i < 2; i++)
 		vx->port[i] = pci_resource_start(pci, i + 1);
 
-	if (request_irq(pci->irq, snd_vx_irq_handler, IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
+	if (request_threaded_irq(pci->irq, snd_vx_irq_handler,
+				 snd_vx_threaded_irq_handler, IRQF_SHARED,
+				 KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_vx222_free(chip);
 		return -EBUSY;
diff --git a/sound/pcmcia/vx/vxp_ops.c b/sound/pcmcia/vx/vxp_ops.c
index fe33e122e372..281972913c32 100644
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -468,12 +468,11 @@ static void vxp_write_codec_reg(struct vx_core *chip, int codec, unsigned int da
 void vx_set_mic_boost(struct vx_core *chip, int boost)
 {
 	struct snd_vxpocket *pchip = (struct snd_vxpocket *)chip;
-	unsigned long flags;
 
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	if (pchip->regCDSP & P24_CDSP_MICS_SEL_MASK) {
 		if (boost) {
 			/* boost: 38 dB */
@@ -486,7 +485,7 @@ void vx_set_mic_boost(struct vx_core *chip, int boost)
                 }
 		vx_outb(chip, CDSP, pchip->regCDSP);
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 /*
@@ -511,17 +510,16 @@ static int vx_compute_mic_level(int level)
 void vx_set_mic_level(struct vx_core *chip, int level)
 {
 	struct snd_vxpocket *pchip = (struct snd_vxpocket *)chip;
-	unsigned long flags;
 
 	if (chip->chip_status & VX_STAT_IS_STALE)
 		return;
 
-	spin_lock_irqsave(&chip->lock, flags);
+	mutex_lock(&chip->lock);
 	if (pchip->regCDSP & VXP_CDSP_MIC_SEL_MASK) {
 		level = vx_compute_mic_level(level);
 		vx_outb(chip, MICRO, level);
 	}
-	spin_unlock_irqrestore(&chip->lock, flags);
+	mutex_unlock(&chip->lock);
 }
 
 
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 786e7e139c9e..14e4aeb9242c 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -229,7 +229,8 @@ static int vxpocket_config(struct pcmcia_device *link)
 	if (ret)
 		goto failed;
 
-	ret = pcmcia_request_irq(link, snd_vx_irq_handler);
+	ret = pcmcia_request_threaded_irq(link, snd_vx_irq_handler,
+					  snd_vx_threaded_irq_handler);
 	if (ret)
 		goto failed;
 
-- 
2.1.0
