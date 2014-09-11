From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: pcxhr: Use nonatomic PCM ops
Date: Thu, 11 Sep 2014 16:00:23 +0200
Message-ID: <1410444025-22772-5-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD8126575D
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2A4E9ACCC
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

This time PCXHR, another Digigram boards: like the previous patches,
the conversion is straightforward, replacing spinlocks with mutexes,
merging the irq tasklet into the threaded irq handler and the PCM
trigger tasklet back to the trigger callback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
Compile tested only.

 sound/pci/pcxhr/pcxhr.c      |  43 ++++++++----------
 sound/pci/pcxhr/pcxhr.h      |   8 +---
 sound/pci/pcxhr/pcxhr_core.c | 102 ++++++++++++++++++++++++-------------------
 sound/pci/pcxhr/pcxhr_core.h |   2 +-
 4 files changed, 77 insertions(+), 78 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 68a37a7906c1..b854fc5e01f5 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -702,13 +702,11 @@ static inline int pcxhr_stream_scheduled_get_pipe(struct pcxhr_stream *stream,
 	return 0;
 }
 
-static void pcxhr_trigger_tasklet(unsigned long arg)
+static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 {
-	unsigned long flags;
 	int i, j, err;
 	struct pcxhr_pipe *pipe;
 	struct snd_pcxhr *chip;
-	struct pcxhr_mgr *mgr = (struct pcxhr_mgr*)(arg);
 	int capture_mask = 0;
 	int playback_mask = 0;
 
@@ -736,11 +734,11 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 	}
 	if (capture_mask == 0 && playback_mask == 0) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_trigger_tasklet : no pipes\n");
+		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : no pipes\n");
 		return;
 	}
 
-	dev_dbg(&mgr->pci->dev, "pcxhr_trigger_tasklet : "
+	dev_dbg(&mgr->pci->dev, "pcxhr_start_linked_stream : "
 		    "playback_mask=%x capture_mask=%x\n",
 		    playback_mask, capture_mask);
 
@@ -748,7 +746,7 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 	err = pcxhr_set_pipe_state(mgr,  playback_mask, capture_mask, 0);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_trigger_tasklet : "
+		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
 			   "error stop pipes (P%x C%x)\n",
 			   playback_mask, capture_mask);
 		return;
@@ -793,7 +791,7 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 	err = pcxhr_set_pipe_state(mgr, playback_mask, capture_mask, 1);
 	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
-		dev_err(&mgr->pci->dev, "pcxhr_trigger_tasklet : "
+		dev_err(&mgr->pci->dev, "pcxhr_start_linked_stream : "
 			   "error start pipes (P%x C%x)\n",
 			   playback_mask, capture_mask);
 		return;
@@ -802,7 +800,7 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 	/* put the streams into the running state now
 	 * (increment pointer by interrupt)
 	 */
-	spin_lock_irqsave(&mgr->lock, flags);
+	mutex_lock(&mgr->lock);
 	for ( i =0; i < mgr->num_cards; i++) {
 		struct pcxhr_stream *stream;
 		chip = mgr->chip[i];
@@ -820,13 +818,13 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 			}
 		}
 	}
-	spin_unlock_irqrestore(&mgr->lock, flags);
+	mutex_unlock(&mgr->lock);
 
 	mutex_unlock(&mgr->setup_mutex);
 
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	do_gettimeofday(&my_tv2);
-	dev_dbg(&mgr->pci->dev, "***TRIGGER TASKLET*** TIME = %ld (err = %x)\n",
+	dev_dbg(&mgr->pci->dev, "***TRIGGER START*** TIME = %ld (err = %x)\n",
 		    (long)(my_tv2.tv_usec - my_tv1.tv_usec), err);
 #endif
 }
@@ -853,7 +851,7 @@ static int pcxhr_trigger(struct snd_pcm_substream *subs, int cmd)
 					PCXHR_STREAM_STATUS_SCHEDULE_RUN;
 				snd_pcm_trigger_done(s, subs);
 			}
-			tasklet_schedule(&chip->mgr->trigger_taskq);
+			pcxhr_start_linked_stream(chip->mgr);
 		} else {
 			stream = subs->runtime->private_data;
 			snd_printdd("Only one Substream %c %d\n",
@@ -1127,20 +1125,19 @@ static int pcxhr_close(struct snd_pcm_substream *subs)
 
 static snd_pcm_uframes_t pcxhr_stream_pointer(struct snd_pcm_substream *subs)
 {
-	unsigned long flags;
 	u_int32_t timer_period_frag;
 	int timer_buf_periods;
 	struct snd_pcxhr *chip = snd_pcm_substream_chip(subs);
 	struct snd_pcm_runtime *runtime = subs->runtime;
 	struct pcxhr_stream *stream  = runtime->private_data;
 
-	spin_lock_irqsave(&chip->mgr->lock, flags);
+	mutex_lock(&chip->mgr->lock);
 
 	/* get the period fragment and the nb of periods in the buffer */
 	timer_period_frag = stream->timer_period_frag;
 	timer_buf_periods = stream->timer_buf_periods;
 
-	spin_unlock_irqrestore(&chip->mgr->lock, flags);
+	mutex_unlock(&chip->mgr->lock);
 
 	return (snd_pcm_uframes_t)((timer_buf_periods * runtime->period_size) +
 				   timer_period_frag);
@@ -1181,6 +1178,7 @@ int pcxhr_create_pcm(struct snd_pcxhr *chip)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcxhr_ops);
 
 	pcm->info_flags = 0;
+	pcm->nonatomic = true;
 	strcpy(pcm->name, name);
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
@@ -1588,8 +1586,9 @@ static int pcxhr_probe(struct pci_dev *pci,
 	mgr->pci = pci;
 	mgr->irq = -1;
 
-	if (request_irq(pci->irq, pcxhr_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, mgr)) {
+	if (request_threaded_irq(pci->irq, pcxhr_interrupt,
+				 pcxhr_threaded_irq, IRQF_SHARED,
+				 KBUILD_MODNAME, mgr)) {
 		dev_err(&pci->dev, "unable to grab IRQ %d\n", pci->irq);
 		pcxhr_free(mgr);
 		return -EBUSY;
@@ -1601,19 +1600,13 @@ static int pcxhr_probe(struct pci_dev *pci,
 		mgr->shortname,
 		mgr->port[0], mgr->port[1], mgr->port[2], mgr->irq);
 
-	/* ISR spinlock  */
-	spin_lock_init(&mgr->lock);
-	spin_lock_init(&mgr->msg_lock);
+	/* ISR lock  */
+	mutex_init(&mgr->lock);
+	mutex_init(&mgr->msg_lock);
 
 	/* init setup mutex*/
 	mutex_init(&mgr->setup_mutex);
 
-	/* init taslket */
-	tasklet_init(&mgr->msg_taskq, pcxhr_msg_tasklet,
-		     (unsigned long) mgr);
-	tasklet_init(&mgr->trigger_taskq, pcxhr_trigger_tasklet,
-		     (unsigned long) mgr);
-
 	mgr->prmh = kmalloc(sizeof(*mgr->prmh) + 
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),
diff --git a/sound/pci/pcxhr/pcxhr.h b/sound/pci/pcxhr/pcxhr.h
index a4c602c45173..9e39e509a3ef 100644
--- a/sound/pci/pcxhr/pcxhr.h
+++ b/sound/pci/pcxhr/pcxhr.h
@@ -78,14 +78,10 @@ struct pcxhr_mgr {
 	char shortname[32];		/* short name of this soundcard */
 	char longname[96];		/* name of this soundcard */
 
-	/* message tasklet */
-	struct tasklet_struct msg_taskq;
 	struct pcxhr_rmh *prmh;
-	/* trigger tasklet */
-	struct tasklet_struct trigger_taskq;
 
-	spinlock_t lock;		/* interrupt spinlock */
-	spinlock_t msg_lock;		/* message spinlock */
+	struct mutex lock;		/* interrupt lock */
+	struct mutex msg_lock;		/* message lock */
 
 	struct mutex setup_mutex;	/* mutex used in hw_params, open and close */
 	struct mutex mixer_mutex;	/* mutex for mixer */
diff --git a/sound/pci/pcxhr/pcxhr_core.c b/sound/pci/pcxhr/pcxhr_core.c
index df9371918601..a584acb61c00 100644
--- a/sound/pci/pcxhr/pcxhr_core.c
+++ b/sound/pci/pcxhr/pcxhr_core.c
@@ -767,11 +767,11 @@ void pcxhr_set_pipe_cmd_params(struct pcxhr_rmh *rmh, int capture,
  */
 int pcxhr_send_msg(struct pcxhr_mgr *mgr, struct pcxhr_rmh *rmh)
 {
-	unsigned long flags;
 	int err;
-	spin_lock_irqsave(&mgr->msg_lock, flags);
+
+	mutex_lock(&mgr->msg_lock);
 	err = pcxhr_send_msg_nolock(mgr, rmh);
-	spin_unlock_irqrestore(&mgr->msg_lock, flags);
+	mutex_unlock(&mgr->msg_lock);
 	return err;
 }
 
@@ -971,17 +971,16 @@ int pcxhr_write_io_num_reg_cont(struct pcxhr_mgr *mgr, unsigned int mask,
 				unsigned int value, int *changed)
 {
 	struct pcxhr_rmh rmh;
-	unsigned long flags;
 	int err;
 
-	spin_lock_irqsave(&mgr->msg_lock, flags);
+	mutex_lock(&mgr->msg_lock);
 	if ((mgr->io_num_reg_cont & mask) == value) {
 		dev_dbg(&mgr->pci->dev,
 			"IO_NUM_REG_CONT mask %x already is set to %x\n",
 			    mask, value);
 		if (changed)
 			*changed = 0;
-		spin_unlock_irqrestore(&mgr->msg_lock, flags);
+		mutex_unlock(&mgr->msg_lock);
 		return 0;	/* already programmed */
 	}
 	pcxhr_init_rmh(&rmh, CMD_ACCESS_IO_WRITE);
@@ -996,7 +995,7 @@ int pcxhr_write_io_num_reg_cont(struct pcxhr_mgr *mgr, unsigned int mask,
 		if (changed)
 			*changed = 1;
 	}
-	spin_unlock_irqrestore(&mgr->msg_lock, flags);
+	mutex_unlock(&mgr->msg_lock);
 	return err;
 }
 
@@ -1043,22 +1042,21 @@ static int pcxhr_handle_async_err(struct pcxhr_mgr *mgr, u32 err,
 }
 
 
-void pcxhr_msg_tasklet(unsigned long arg)
+static void pcxhr_msg_thread(struct pcxhr_mgr *mgr)
 {
-	struct pcxhr_mgr *mgr = (struct pcxhr_mgr *)(arg);
 	struct pcxhr_rmh *prmh = mgr->prmh;
 	int err;
 	int i, j;
 
 	if (mgr->src_it_dsp & PCXHR_IRQ_FREQ_CHANGE)
 		dev_dbg(&mgr->pci->dev,
-			"TASKLET : PCXHR_IRQ_FREQ_CHANGE event occurred\n");
+			"PCXHR_IRQ_FREQ_CHANGE event occurred\n");
 	if (mgr->src_it_dsp & PCXHR_IRQ_TIME_CODE)
 		dev_dbg(&mgr->pci->dev,
-			"TASKLET : PCXHR_IRQ_TIME_CODE event occurred\n");
+			"PCXHR_IRQ_TIME_CODE event occurred\n");
 	if (mgr->src_it_dsp & PCXHR_IRQ_NOTIFY)
 		dev_dbg(&mgr->pci->dev,
-			"TASKLET : PCXHR_IRQ_NOTIFY event occurred\n");
+			"PCXHR_IRQ_NOTIFY event occurred\n");
 	if (mgr->src_it_dsp & (PCXHR_IRQ_FREQ_CHANGE | PCXHR_IRQ_TIME_CODE)) {
 		/* clear events FREQ_CHANGE and TIME_CODE */
 		pcxhr_init_rmh(prmh, CMD_TEST_IT);
@@ -1068,7 +1066,7 @@ void pcxhr_msg_tasklet(unsigned long arg)
 	}
 	if (mgr->src_it_dsp & PCXHR_IRQ_ASYNC) {
 		dev_dbg(&mgr->pci->dev,
-			"TASKLET : PCXHR_IRQ_ASYNC event occurred\n");
+			"PCXHR_IRQ_ASYNC event occurred\n");
 
 		pcxhr_init_rmh(prmh, CMD_ASYNC);
 		prmh->cmd[0] |= 1;	/* add SEL_ASYNC_EVENTS */
@@ -1076,7 +1074,7 @@ void pcxhr_msg_tasklet(unsigned long arg)
 		prmh->stat_len = PCXHR_SIZE_MAX_LONG_STATUS;
 		err = pcxhr_send_msg(mgr, prmh);
 		if (err)
-			dev_err(&mgr->pci->dev, "ERROR pcxhr_msg_tasklet=%x;\n",
+			dev_err(&mgr->pci->dev, "ERROR pcxhr_msg_thread=%x;\n",
 				   err);
 		i = 1;
 		while (i < prmh->stat_len) {
@@ -1220,9 +1218,9 @@ static void pcxhr_update_timer_pos(struct pcxhr_mgr *mgr,
 		}
 
 		if (elapsed) {
-			spin_unlock(&mgr->lock);
+			mutex_unlock(&mgr->lock);
 			snd_pcm_period_elapsed(stream->substream);
-			spin_lock(&mgr->lock);
+			mutex_lock(&mgr->lock);
 		}
 	}
 }
@@ -1231,14 +1229,10 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 {
 	struct pcxhr_mgr *mgr = dev_id;
 	unsigned int reg;
-	int i, j;
-	struct snd_pcxhr *chip;
-
-	spin_lock(&mgr->lock);
+	bool wake_thread = false;
 
 	reg = PCXHR_INPL(mgr, PCXHR_PLX_IRQCS);
 	if (! (reg & PCXHR_IRQCS_ACTIVE_PCIDB)) {
-		spin_unlock(&mgr->lock);
 		/* this device did not cause the interrupt */
 		return IRQ_NONE;
 	}
@@ -1250,6 +1244,44 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 	/* timer irq occurred */
 	if (reg & PCXHR_IRQ_TIMER) {
 		int timer_toggle = reg & PCXHR_IRQ_TIMER;
+		if (timer_toggle == mgr->timer_toggle) {
+			dev_dbg(&mgr->pci->dev, "ERROR TIMER TOGGLE\n");
+			mgr->dsp_time_err++;
+		}
+
+		mgr->timer_toggle = timer_toggle;
+		mgr->src_it_dsp = reg;
+		wake_thread = true;
+	}
+
+	/* other irq's handled in the thread */
+	if (reg & PCXHR_IRQ_MASK) {
+		if (reg & PCXHR_IRQ_ASYNC) {
+			/* as we didn't request any async notifications,
+			 * some kind of xrun error will probably occurred
+			 */
+			/* better resynchronize all streams next interrupt : */
+			mgr->dsp_time_last = PCXHR_DSP_TIME_INVALID;
+		}
+		mgr->src_it_dsp = reg;
+		wake_thread = true;
+	}
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+	if (reg & PCXHR_FATAL_DSP_ERR)
+		dev_dbg(&mgr->pci->dev, "FATAL DSP ERROR : %x\n", reg);
+#endif
+
+	return wake_thread ? IRQ_WAKE_THREAD : IRQ_HANDLED;
+}
+
+irqreturn_t pcxhr_threaded_irq(int irq, void *dev_id)
+{
+	struct pcxhr_mgr *mgr = dev_id;
+	int i, j;
+	struct snd_pcxhr *chip;
+
+	mutex_lock(&mgr->lock);
+	if (mgr->src_it_dsp & PCXHR_IRQ_TIMER) {
 		/* is a 24 bit counter */
 		int dsp_time_new =
 			PCXHR_INPL(mgr, PCXHR_PLX_MBOX4) & PCXHR_DSP_TIME_MASK;
@@ -1290,13 +1322,6 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 #endif
 		mgr->dsp_time_last = dsp_time_new;
 
-		if (timer_toggle == mgr->timer_toggle) {
-			dev_dbg(&mgr->pci->dev, "ERROR TIMER TOGGLE\n");
-			mgr->dsp_time_err++;
-		}
-		mgr->timer_toggle = timer_toggle;
-
-		reg &= ~PCXHR_IRQ_TIMER;
 		for (i = 0; i < mgr->num_cards; i++) {
 			chip = mgr->chip[i];
 			for (j = 0; j < chip->nb_streams_capt; j++)
@@ -1312,22 +1337,7 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 						dsp_time_diff);
 		}
 	}
-	/* other irq's handled in the tasklet */
-	if (reg & PCXHR_IRQ_MASK) {
-		if (reg & PCXHR_IRQ_ASYNC) {
-			/* as we didn't request any async notifications,
-			 * some kind of xrun error will probably occurred
-			 */
-			/* better resynchronize all streams next interrupt : */
-			mgr->dsp_time_last = PCXHR_DSP_TIME_INVALID;
-		}
-		mgr->src_it_dsp = reg;
-		tasklet_schedule(&mgr->msg_taskq);
-	}
-#ifdef CONFIG_SND_DEBUG_VERBOSE
-	if (reg & PCXHR_FATAL_DSP_ERR)
-		dev_dbg(&mgr->pci->dev, "FATAL DSP ERROR : %x\n", reg);
-#endif
-	spin_unlock(&mgr->lock);
-	return IRQ_HANDLED;	/* this device caused the interrupt */
+
+	pcxhr_msg_thread(mgr);
+	return IRQ_HANDLED;
 }
diff --git a/sound/pci/pcxhr/pcxhr_core.h b/sound/pci/pcxhr/pcxhr_core.h
index a81ab6b811e7..dc267e4c1074 100644
--- a/sound/pci/pcxhr/pcxhr_core.h
+++ b/sound/pci/pcxhr/pcxhr_core.h
@@ -200,6 +200,6 @@ int pcxhr_write_io_num_reg_cont(struct pcxhr_mgr *mgr, unsigned int mask,
 
 /* interrupt handling */
 irqreturn_t pcxhr_interrupt(int irq, void *dev_id);
-void pcxhr_msg_tasklet(unsigned long arg);
+irqreturn_t pcxhr_threaded_irq(int irq, void *dev_id);
 
 #endif /* __SOUND_PCXHR_CORE_H */
-- 
2.1.0
