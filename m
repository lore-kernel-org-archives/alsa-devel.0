From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] ALSA: core: Whitespace cleanup
Date: Mon, 5 Mar 2018 20:29:15 +0100
Message-ID: <20180305192915.GA3060@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1233F2670F9
 for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2018 20:29:19 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994669AbeCET3Rhhcgb (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Mon, 5 Mar 2018 20:29:17 +0100
Content-Disposition: inline
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
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Remove whitespace on blank line, whitespace before newline and space
before tab.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Hi,

 this is just a side product of reading ALSA code to get better
 clue how core handles codecs. As I enable 'let c_space_errors=1'
 in vimrc, here are 'red spots' corrected. Feel free to ignore,
 apply when you find it usefull :) No functionsl changes.

 regards,
	ladis

 include/sound/pcm.h         | 22 ++++++------
 sound/core/control.c        |  6 ++--
 sound/core/control_compat.c |  2 +-
 sound/core/device.c         |  4 +--
 sound/core/hwdep.c          | 16 ++++-----
 sound/core/init.c           | 17 +++++----
 sound/core/memalloc.c       |  2 +-
 sound/core/memory.c         |  2 +-
 sound/core/pcm.c            | 22 ++++++------
 sound/core/pcm_compat.c     |  2 +-
 sound/core/pcm_lib.c        | 40 ++++++++++-----------
 sound/core/pcm_misc.c       |  2 +-
 sound/core/pcm_native.c     | 88 ++++++++++++++++++++++-----------------------
 sound/core/rawmidi.c        | 18 +++++-----
 sound/core/seq_device.c     |  2 +-
 sound/core/sgbuf.c          |  2 +-
 sound/core/sound_oss.c      | 10 +++---
 sound/core/timer.c          |  4 +--
 sound/core/timer_compat.c   |  2 +-
 19 files changed, 131 insertions(+), 132 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e054c583d3b3..c5a3f8fa7e14 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -243,7 +243,7 @@ struct snd_pcm_hw_rule {
 };
 
 struct snd_pcm_hw_constraints {
-	struct snd_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
+	struct snd_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK -
 			 SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
 	struct snd_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
 			     SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
@@ -382,7 +382,7 @@ struct snd_pcm_runtime {
 
 	/* -- SW params -- */
 	int tstamp_mode;		/* mmap timestamp is updated */
-  	unsigned int period_step;
+	unsigned int period_step;
 	snd_pcm_uframes_t start_threshold;
 	snd_pcm_uframes_t stop_threshold;
 	snd_pcm_uframes_t silence_threshold; /* Silence filling happens when
@@ -400,7 +400,7 @@ struct snd_pcm_runtime {
 	struct snd_pcm_mmap_control *control;
 
 	/* -- locking / scheduling -- */
-	snd_pcm_uframes_t twake; 	/* do transfer (!poll) wakeup if non-zero */
+	snd_pcm_uframes_t twake;	/* do transfer (!poll) wakeup if non-zero */
 	wait_queue_head_t sleep;	/* poll sleep */
 	wait_queue_head_t tsleep;	/* transfer sleep */
 	struct fasync_struct *fasync;
@@ -417,7 +417,7 @@ struct snd_pcm_runtime {
 	unsigned int timer_resolution;	/* timer resolution */
 	int tstamp_type;		/* timestamp type */
 
-	/* -- DMA -- */           
+	/* -- DMA -- */
 	unsigned char *dma_area;	/* DMA area */
 	dma_addr_t dma_addr;		/* physical bus address (not accessible from main CPU) */
 	size_t dma_bytes;		/* size of DMA area */
@@ -835,7 +835,7 @@ static inline int snd_pcm_capture_ready(struct snd_pcm_substream *substream)
 static inline int snd_pcm_playback_data(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
+
 	if (runtime->stop_threshold >= runtime->boundary)
 		return 1;
 	return snd_pcm_playback_avail(runtime) < runtime->buffer_size;
@@ -883,7 +883,7 @@ static inline int snd_pcm_capture_empty(struct snd_pcm_substream *substream)
  * The trigger_master mark is cleared at timestamp updates at the end
  * of trigger operations.
  */
-static inline void snd_pcm_trigger_done(struct snd_pcm_substream *substream, 
+static inline void snd_pcm_trigger_done(struct snd_pcm_substream *substream,
 					struct snd_pcm_substream *master)
 {
 	substream->runtime->trigger_master = master;
@@ -998,7 +998,7 @@ int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_par
 int snd_pcm_hw_constraint_minmax(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 				 unsigned int min, unsigned int max);
 int snd_pcm_hw_constraint_integer(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var);
-int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime,
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
 			       const struct snd_pcm_hw_constraint_list *l);
@@ -1006,15 +1006,15 @@ int snd_pcm_hw_constraint_ranges(struct snd_pcm_runtime *runtime,
 				 unsigned int cond,
 				 snd_pcm_hw_param_t var,
 				 const struct snd_pcm_hw_constraint_ranges *r);
-int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime,
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
 				  const struct snd_pcm_hw_constraint_ratnums *r);
-int snd_pcm_hw_constraint_ratdens(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_ratdens(struct snd_pcm_runtime *runtime,
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
 				  const struct snd_pcm_hw_constraint_ratdens *r);
-int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime,
 				 unsigned int cond,
 				 unsigned int width,
 				 unsigned int msbits);
@@ -1079,7 +1079,7 @@ void snd_pcm_set_ops(struct snd_pcm * pcm, int direction,
 		     const struct snd_pcm_ops *ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream);
 int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
-		      unsigned int cmd, void *arg);                      
+		      unsigned int cmd, void *arg);
 void snd_pcm_period_elapsed(struct snd_pcm_substream *substream);
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *buf, bool interleaved,
diff --git a/sound/core/control.c b/sound/core/control.c
index 69734b0eafd0..a7929ae2a37b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -98,7 +98,7 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
       __error1:
 	if (card)
 		snd_card_unref(card);
-      	return err;
+	return err;
 }
 
 static void snd_ctl_empty_read_queue(struct snd_ctl_file * ctl)
@@ -327,7 +327,7 @@ static bool snd_ctl_remove_numid_conflict(struct snd_card *card,
 	list_for_each_entry(kctl, &card->controls, list) {
 		if (kctl->id.numid < card->last_numid + 1 + count &&
 		    kctl->id.numid + kctl->count > card->last_numid + 1) {
-		    	card->last_numid = kctl->id.numid + kctl->count - 1;
+			card->last_numid = kctl->id.numid + kctl->count - 1;
 			return true;
 		}
 	}
@@ -1664,7 +1664,7 @@ static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
       __end_lock:
 	spin_unlock_irq(&ctl->read_lock);
       __end:
-      	return result > 0 ? result : err;
+	return result > 0 ? result : err;
 }
 
 static __poll_t snd_ctl_poll(struct file *file, poll_table * wait)
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index a848836a5de0..738f4b7894f9 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -428,7 +428,7 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
  error:
 	kfree(data);
 	return err;
-}  
+}
 
 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST32 = _IOWR('U', 0x10, struct snd_ctl_elem_list32),
diff --git a/sound/core/device.c b/sound/core/device.c
index cb0e46f66cc9..69b4ff8324b1 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -145,7 +145,7 @@ EXPORT_SYMBOL_GPL(snd_device_disconnect);
 void snd_device_free(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
-	
+
 	if (snd_BUG_ON(!card || !device_data))
 		return;
 	dev = look_for_dev(card, device_data);
@@ -205,7 +205,7 @@ int snd_device_register_all(struct snd_card *card)
 {
 	struct snd_device *dev;
 	int err;
-	
+
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry(dev, &card->devices, list) {
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 26e71cf05f1e..6fc28fffb310 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -68,7 +68,7 @@ static ssize_t snd_hwdep_read(struct file * file, char __user *buf,
 	struct snd_hwdep *hw = file->private_data;
 	if (hw->ops.read)
 		return hw->ops.read(hw, buf, count, offset);
-	return -ENXIO;	
+	return -ENXIO;
 }
 
 static ssize_t snd_hwdep_write(struct file * file, const char __user *buf,
@@ -77,7 +77,7 @@ static ssize_t snd_hwdep_write(struct file * file, const char __user *buf,
 	struct snd_hwdep *hw = file->private_data;
 	if (hw->ops.write)
 		return hw->ops.write(hw, buf, count, offset);
-	return -ENXIO;	
+	return -ENXIO;
 }
 
 static int snd_hwdep_open(struct inode *inode, struct file * file)
@@ -189,10 +189,10 @@ static int snd_hwdep_info(struct snd_hwdep *hw,
 			  struct snd_hwdep_info __user *_info)
 {
 	struct snd_hwdep_info info;
-	
+
 	memset(&info, 0, sizeof(info));
 	info.card = hw->card->number;
-	strlcpy(info.id, hw->id, sizeof(info.id));	
+	strlcpy(info.id, hw->id, sizeof(info.id));
 	strlcpy(info.name, hw->name, sizeof(info.name));
 	info.iface = hw->iface;
 	if (copy_to_user(_info, &info, sizeof(info)))
@@ -205,7 +205,7 @@ static int snd_hwdep_dsp_status(struct snd_hwdep *hw,
 {
 	struct snd_hwdep_dsp_status info;
 	int err;
-	
+
 	if (! hw->ops.dsp_status)
 		return -ENXIO;
 	memset(&info, 0, sizeof(info));
@@ -222,7 +222,7 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 {
 	struct snd_hwdep_dsp_image info;
 	int err;
-	
+
 	if (! hw->ops.dsp_load)
 		return -ENXIO;
 	memset(&info, 0, sizeof(info));
@@ -333,9 +333,9 @@ static int snd_hwdep_control_ioctl(struct snd_card *card,
 
 static const struct file_operations snd_hwdep_f_ops =
 {
-	.owner = 	THIS_MODULE,
+	.owner =	THIS_MODULE,
 	.llseek =	snd_hwdep_llseek,
-	.read = 	snd_hwdep_read,
+	.read =		snd_hwdep_read,
 	.write =	snd_hwdep_write,
 	.open =		snd_hwdep_open,
 	.release =	snd_hwdep_release,
diff --git a/sound/core/init.c b/sound/core/init.c
index 79b4df1c1dc7..f11c9909f9ff 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -289,7 +289,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	snd_device_free_all(card);
       __error:
 	put_device(&card->card_dev);
-  	return err;
+	return err;
 }
 EXPORT_SYMBOL(snd_card_new);
 
@@ -367,9 +367,9 @@ static int snd_disconnect_fasync(int fd, struct file *file, int on)
 
 static const struct file_operations snd_shutdown_f_ops =
 {
-	.owner = 	THIS_MODULE,
+	.owner =	THIS_MODULE,
 	.llseek =	snd_disconnect_llseek,
-	.read = 	snd_disconnect_read,
+	.read =		snd_disconnect_read,
 	.write =	snd_disconnect_write,
 	.release =	snd_disconnect_release,
 	.poll =		snd_disconnect_poll,
@@ -412,9 +412,8 @@ int snd_card_disconnect(struct snd_card *card)
 	snd_cards[card->number] = NULL;
 	clear_bit(card->number, snd_cards_lock);
 	mutex_unlock(&snd_card_mutex);
-	
+
 	/* phase 2: replace file->f_op with special dummy operations */
-	
 	spin_lock(&card->files_lock);
 	list_for_each_entry(mfile, &card->files_list, list) {
 		/* it's critical part, use endless loop */
@@ -428,7 +427,7 @@ int snd_card_disconnect(struct snd_card *card)
 		mfile->file->f_op = &snd_shutdown_f_ops;
 		fops_get(mfile->file->f_op);
 	}
-	spin_unlock(&card->files_lock);	
+	spin_unlock(&card->files_lock);
 
 	/* phase 3: notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
@@ -449,7 +448,7 @@ int snd_card_disconnect(struct snd_card *card)
 #ifdef CONFIG_PM
 	wake_up(&card->power_sleep);
 #endif
-	return 0;	
+	return 0;
 }
 EXPORT_SYMBOL(snd_card_disconnect);
 
@@ -604,7 +603,7 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 	int len, loops;
 	bool is_default = false;
 	char *id;
-	
+
 	copy_valid_id_string(card, src, nid);
 	id = card->id;
 
@@ -901,7 +900,7 @@ int __init snd_card_info_init(void)
  *
  *  Return: Zero otherwise a negative error code.
  */
-  
+
 int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 7f89d3c79a4b..f347b0310abb 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  *                   Takashi Iwai <tiwai@suse.de>
- * 
+ *
  *  Generic memory allocators
  *
  *
diff --git a/sound/core/memory.c b/sound/core/memory.c
index 19c9ea90d9bf..b6b36df9d921 100644
--- a/sound/core/memory.c
+++ b/sound/core/memory.c
@@ -1,6 +1,6 @@
 /*
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
- * 
+ *
  *  Misc memory accessors
  *
  *
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 09ee8c6b9f75..38141a0e815a 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -163,7 +163,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 	case SNDRV_CTL_IOCTL_PCM_PREFER_SUBDEVICE:
 		{
 			int val;
-			
+
 			if (get_user(val, (int __user *)arg))
 				return -EFAULT;
 			control->preferred_subdevice[SND_CTL_SUBDEV_PCM] = val;
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_format_name);
 #define TSTAMP(v) [SNDRV_PCM_TSTAMP_##v] = #v
 #define ACCESS(v) [SNDRV_PCM_ACCESS_##v] = #v
 #define START(v) [SNDRV_PCM_START_##v] = #v
-#define SUBFORMAT(v) [SNDRV_PCM_SUBFORMAT_##v] = #v 
+#define SUBFORMAT(v) [SNDRV_PCM_SUBFORMAT_##v] = #v
 
 static char *snd_pcm_stream_names[] = {
 	STREAM(PLAYBACK),
@@ -266,7 +266,7 @@ static char *snd_pcm_state_names[] = {
 };
 
 static char *snd_pcm_access_names[] = {
-	ACCESS(MMAP_INTERLEAVED), 
+	ACCESS(MMAP_INTERLEAVED),
 	ACCESS(MMAP_NONINTERLEAVED),
 	ACCESS(MMAP_COMPLEX),
 	ACCESS(RW_INTERLEAVED),
@@ -274,7 +274,7 @@ static char *snd_pcm_access_names[] = {
 };
 
 static char *snd_pcm_subformat_names[] = {
-	SUBFORMAT(STD), 
+	SUBFORMAT(STD),
 };
 
 static char *snd_pcm_tstamp_mode_names[] = {
@@ -404,14 +404,14 @@ static void snd_pcm_substream_proc_hw_params_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "access: %s\n", snd_pcm_access_name(runtime->access));
 	snd_iprintf(buffer, "format: %s\n", snd_pcm_format_name(runtime->format));
 	snd_iprintf(buffer, "subformat: %s\n", snd_pcm_subformat_name(runtime->subformat));
-	snd_iprintf(buffer, "channels: %u\n", runtime->channels);	
-	snd_iprintf(buffer, "rate: %u (%u/%u)\n", runtime->rate, runtime->rate_num, runtime->rate_den);	
-	snd_iprintf(buffer, "period_size: %lu\n", runtime->period_size);	
-	snd_iprintf(buffer, "buffer_size: %lu\n", runtime->buffer_size);	
+	snd_iprintf(buffer, "channels: %u\n", runtime->channels);
+	snd_iprintf(buffer, "rate: %u (%u/%u)\n", runtime->rate, runtime->rate_num, runtime->rate_den);
+	snd_iprintf(buffer, "period_size: %lu\n", runtime->period_size);
+	snd_iprintf(buffer, "buffer_size: %lu\n", runtime->buffer_size);
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	if (substream->oss.oss) {
 		snd_iprintf(buffer, "OSS format: %s\n", snd_pcm_oss_format_name(runtime->oss.format));
-		snd_iprintf(buffer, "OSS channels: %u\n", runtime->oss.channels);	
+		snd_iprintf(buffer, "OSS channels: %u\n", runtime->oss.channels);
 		snd_iprintf(buffer, "OSS rate: %u\n", runtime->oss.rate);
 		snd_iprintf(buffer, "OSS period bytes: %lu\n", (unsigned long)runtime->oss.period_bytes);
 		snd_iprintf(buffer, "OSS periods: %u\n", runtime->oss.periods);
@@ -523,7 +523,7 @@ static int snd_pcm_stream_proc_init(struct snd_pcm_str *pstr)
 	struct snd_info_entry *entry;
 	char name[16];
 
-	sprintf(name, "pcm%i%c", pcm->device, 
+	sprintf(name, "pcm%i%c", pcm->device,
 		pstr->stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c');
 	entry = snd_info_create_card_entry(pcm->card, name,
 					   pcm->card->proc_root);
@@ -763,7 +763,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 		prev = substream;
 	}
 	return 0;
-}				
+}
 EXPORT_SYMBOL(snd_pcm_new_stream);
 
 static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index b719d0bd833e..fce376c74a49 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -314,7 +314,7 @@ static int snd_pcm_status_user_x32(struct snd_pcm_substream *substream,
 
 /* both for HW_PARAMS and HW_REFINE */
 static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
-					  int refine, 
+					  int refine,
 					  struct snd_pcm_hw_params32 __user *data32)
 {
 	struct snd_pcm_hw_params *data;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a83152e7d387..be9efc98d6b7 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -489,7 +489,7 @@ void snd_pcm_set_ops(struct snd_pcm *pcm, int direction,
 {
 	struct snd_pcm_str *stream = &pcm->streams[direction];
 	struct snd_pcm_substream *substream;
-	
+
 	for (substream = stream->substream; substream != NULL; substream = substream->next)
 		substream->ops = ops;
 }
@@ -504,7 +504,7 @@ EXPORT_SYMBOL(snd_pcm_set_ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
+
 	runtime->sync.id32[0] = substream->pcm->card->number;
 	runtime->sync.id32[1] = -1;
 	runtime->sync.id32[2] = -1;
@@ -516,7 +516,7 @@ EXPORT_SYMBOL(snd_pcm_set_sync);
  *  Standard ioctl routine
  */
 
-static inline unsigned int div32(unsigned int a, unsigned int b, 
+static inline unsigned int div32(unsigned int a, unsigned int b,
 				 unsigned int *r)
 {
 	if (b == 0) {
@@ -774,7 +774,7 @@ void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
 /**
  * snd_interval_ratnum - refine the interval value
  * @i: interval to refine
- * @rats_count: number of ratnum_t 
+ * @rats_count: number of ratnum_t
  * @rats: ratnum_t array
  * @nump: pointer to store the resultant numerator
  * @denp: pointer to store the resultant denominator
@@ -829,7 +829,7 @@ int snd_interval_ratnum(struct snd_interval *i,
 	}
 	t.min = div_down(best_num, best_den);
 	t.openmin = !!(best_num % best_den);
-	
+
 	result_num = best_num;
 	result_diff = best_diff;
 	result_den = best_den;
@@ -941,7 +941,7 @@ static int snd_interval_ratden(struct snd_interval *i,
 	}
 	t.min = div_down(best_num, best_den);
 	t.openmin = !!(best_num % best_den);
-	
+
 	best_num = best_den = best_diff = 0;
 	for (k = 0; k < rats_count; ++k) {
 		unsigned int num;
@@ -1233,7 +1233,7 @@ EXPORT_SYMBOL(snd_pcm_hw_constraint_integer);
  * @var: hw_params variable to apply the range
  * @min: the minimal value
  * @max: the maximal value
- * 
+ *
  * Apply the min/max range constraint to an interval parameter.
  *
  * Return: Positive if the value is changed, zero if it's not changed, or a
@@ -1257,7 +1257,7 @@ static int snd_pcm_hw_rule_list(struct snd_pcm_hw_params *params,
 {
 	struct snd_pcm_hw_constraint_list *list = rule->private;
 	return snd_interval_list(hw_param_interval(params, rule->var), list->count, list->list, list->mask);
-}		
+}
 
 
 /**
@@ -1266,7 +1266,7 @@ static int snd_pcm_hw_rule_list(struct snd_pcm_hw_params *params,
  * @cond: condition bits
  * @var: hw_params variable to apply the list constraint
  * @l: list
- * 
+ *
  * Apply the list of constraints to an interval parameter.
  *
  * Return: Zero if successful, or a negative error code on failure.
@@ -1337,7 +1337,7 @@ static int snd_pcm_hw_rule_ratnums(struct snd_pcm_hw_params *params,
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime,
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
 				  const struct snd_pcm_hw_constraint_ratnums *r)
@@ -1371,7 +1371,7 @@ static int snd_pcm_hw_rule_ratdens(struct snd_pcm_hw_params *params,
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_hw_constraint_ratdens(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_ratdens(struct snd_pcm_runtime *runtime,
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
 				  const struct snd_pcm_hw_constraint_ratdens *r)
@@ -1415,7 +1415,7 @@ static int snd_pcm_hw_rule_msbits(struct snd_pcm_hw_params *params,
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime, 
+int snd_pcm_hw_constraint_msbits(struct snd_pcm_runtime *runtime,
 				 unsigned int cond,
 				 unsigned int width,
 				 unsigned int msbits)
@@ -1449,7 +1449,7 @@ int snd_pcm_hw_constraint_step(struct snd_pcm_runtime *runtime,
 			       snd_pcm_hw_param_t var,
 			       unsigned long step)
 {
-	return snd_pcm_hw_rule_add(runtime, cond, var, 
+	return snd_pcm_hw_rule_add(runtime, cond, var,
 				   snd_pcm_hw_rule_step, (void *) step,
 				   var, -1);
 }
@@ -1465,7 +1465,7 @@ static int snd_pcm_hw_rule_pow2(struct snd_pcm_hw_params *params, struct snd_pcm
 	};
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 ARRAY_SIZE(pow2_sizes), pow2_sizes, 0);
-}		
+}
 
 /**
  * snd_pcm_hw_constraint_pow2 - add a hw constraint power-of-2 rule
@@ -1479,7 +1479,7 @@ int snd_pcm_hw_constraint_pow2(struct snd_pcm_runtime *runtime,
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var)
 {
-	return snd_pcm_hw_rule_add(runtime, cond, var, 
+	return snd_pcm_hw_rule_add(runtime, cond, var,
 				   snd_pcm_hw_rule_pow2, NULL,
 				   var, -1);
 }
@@ -1622,8 +1622,8 @@ static int _snd_pcm_hw_param_first(struct snd_pcm_hw_params *params,
  *
  * Return: The minimum, or a negative error code on failure.
  */
-int snd_pcm_hw_param_first(struct snd_pcm_substream *pcm, 
-			   struct snd_pcm_hw_params *params, 
+int snd_pcm_hw_param_first(struct snd_pcm_substream *pcm,
+			   struct snd_pcm_hw_params *params,
 			   snd_pcm_hw_param_t var, int *dir)
 {
 	int changed = _snd_pcm_hw_param_first(params, var);
@@ -1668,7 +1668,7 @@ static int _snd_pcm_hw_param_last(struct snd_pcm_hw_params *params,
  *
  * Return: The maximum, or a negative error code on failure.
  */
-int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm, 
+int snd_pcm_hw_param_last(struct snd_pcm_substream *pcm,
 			  struct snd_pcm_hw_params *params,
 			  snd_pcm_hw_param_t var, int *dir)
 {
@@ -1882,7 +1882,7 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		case SNDRV_PCM_STATE_DRAINING:
 			if (is_playback)
 				err = -EPIPE;
-			else 
+			else
 				avail = 0; /* indicate draining */
 			goto _endloop;
 		case SNDRV_PCM_STATE_OPEN:
@@ -1907,7 +1907,7 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	*availp = avail;
 	return err;
 }
-	
+
 typedef int (*pcm_transfer_f)(struct snd_pcm_substream *substream,
 			      int channel, unsigned long hwoff,
 			      void *buf, unsigned long bytes);
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index c4eb561d2008..29f5cad1ee28 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -18,7 +18,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
-  
+
 #include <linux/time.h>
 #include <linux/export.h>
 #include <sound/core.h>
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 77ba50ddcf9e..6fb1b6bfd585 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -923,7 +923,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 	runtime->avail_max = 0;
 	runtime->overrange = 0;
  _end:
- 	snd_pcm_stream_unlock_irq(substream);
+	snd_pcm_stream_unlock_irq(substream);
 	return 0;
 }
 
@@ -956,7 +956,7 @@ static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime;
 	unsigned int channel;
-	
+
 	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
@@ -977,7 +977,7 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_channel_info info;
 	int res;
-	
+
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	res = snd_pcm_channel_info(substream, &info);
@@ -1077,7 +1077,7 @@ static int snd_pcm_action_single(const struct action_ops *ops,
 				 int state)
 {
 	int res;
-	
+
 	res = ops->pre_action(substream, state);
 	if (res < 0)
 		return res;
@@ -1187,7 +1187,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream, int state)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
-	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
+	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) /
 							    runtime->rate;
 	runtime->status->state = state;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -1875,7 +1875,7 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
 	int result = 0;
-	
+
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
@@ -2111,7 +2111,7 @@ static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params,
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 snd_pcm_known_rates.count,
 				 snd_pcm_known_rates.list, hw->rates);
-}		
+}
 
 static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
@@ -2124,7 +2124,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	t.openmax = 0;
 	t.integer = 1;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
-}		
+}
 
 int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
@@ -2151,98 +2151,98 @@ int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_sample_bits, NULL,
-				  SNDRV_PCM_HW_PARAM_FORMAT, 
+				  SNDRV_PCM_HW_PARAM_FORMAT,
 				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mul, NULL,
 				  SNDRV_PCM_HW_PARAM_SAMPLE_BITS, SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FRAME_BITS,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_FRAME_BITS, SNDRV_PCM_HW_PARAM_SAMPLE_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_BUFFER_TIME, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIODS,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_div, NULL,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_mul, NULL,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_PERIODS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
 				  snd_pcm_hw_rule_muldivk, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_TIME, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				  snd_pcm_hw_rule_muldivk, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_muldivk, (void*) 8,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_PERIOD_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
 				  snd_pcm_hw_rule_mulkdiv, (void*) 1000000,
 				  SNDRV_PCM_HW_PARAM_BUFFER_SIZE, SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
@@ -2306,7 +2306,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_buffer_bytes_max, substream,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
 	if (err < 0)
@@ -2320,7 +2320,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	}
 
 	if (!(hw->rates & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))) {
-		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					  snd_pcm_hw_rule_rate, hw,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 		if (err < 0)
@@ -2510,9 +2510,9 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
       __error:
 	module_put(pcm->card->module);
       __error2:
-      	snd_card_file_remove(pcm->card, file);
+	snd_card_file_remove(pcm->card, file);
       __error1:
-      	return err;
+	return err;
 }
 
 static int snd_pcm_release(struct inode *inode, struct file *file)
@@ -2686,7 +2686,7 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	return err;
 }
-		
+
 static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -2705,7 +2705,7 @@ static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	return err < 0 ? err : n;
 }
-		
+
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			    struct snd_pcm_sync_ptr __user *_sync_ptr)
 {
@@ -2719,7 +2719,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
 		return -EFAULT;
 	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
+		return -EFAULT;
 	status = runtime->status;
 	control = runtime->control;
 	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
@@ -2756,7 +2756,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int arg;
-	
+
 	if (get_user(arg, _arg))
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
@@ -2980,7 +2980,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 {
 	snd_pcm_uframes_t *frames = arg;
 	snd_pcm_sframes_t result;
-	
+
 	switch (cmd) {
 	case SNDRV_PCM_IOCTL_FORWARD:
 	{
@@ -3233,7 +3233,7 @@ static int snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3269,7 +3269,7 @@ static int snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 {
 	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3361,7 +3361,7 @@ static int snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 	unsigned long offset;
 	struct page * page;
 	size_t dma_bytes;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3504,9 +3504,9 @@ EXPORT_SYMBOL(snd_pcm_mmap_data);
 static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 {
 	struct snd_pcm_file * pcm_file;
-	struct snd_pcm_substream *substream;	
+	struct snd_pcm_substream *substream;
 	unsigned long offset;
-	
+
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
@@ -3704,7 +3704,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.llseek =		no_llseek,
 		.poll =			snd_pcm_playback_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
-		.compat_ioctl = 	snd_pcm_ioctl_compat,
+		.compat_ioctl =		snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
 		.get_unmapped_area =	snd_pcm_get_unmapped_area,
@@ -3718,7 +3718,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.llseek =		no_llseek,
 		.poll =			snd_pcm_capture_poll,
 		.unlocked_ioctl =	snd_pcm_ioctl,
-		.compat_ioctl = 	snd_pcm_ioctl_compat,
+		.compat_ioctl =		snd_pcm_ioctl_compat,
 		.mmap =			snd_pcm_mmap,
 		.fasync =		snd_pcm_fasync,
 		.get_unmapped_area =	snd_pcm_get_unmapped_area,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 69616d00481c..e1903a978ffa 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -370,7 +370,7 @@ static int snd_rawmidi_open(struct inode *inode, struct file *file)
 	struct snd_rawmidi_file *rawmidi_file = NULL;
 	wait_queue_entry_t wait;
 
-	if ((file->f_flags & O_APPEND) && !(file->f_flags & O_NONBLOCK)) 
+	if ((file->f_flags & O_APPEND) && !(file->f_flags & O_NONBLOCK))
 		return -EINVAL;		/* invalid combination */
 
 	err = nonseekable_open(inode, file);
@@ -520,7 +520,7 @@ int snd_rawmidi_kernel_release(struct snd_rawmidi_file *rfile)
 
 	if (snd_BUG_ON(!rfile))
 		return -ENXIO;
-	
+
 	rmidi = rfile->rmidi;
 	rawmidi_release_priv(rfile);
 	module_put(rmidi->card->module);
@@ -548,7 +548,7 @@ static int snd_rawmidi_info(struct snd_rawmidi_substream *substream,
 			    struct snd_rawmidi_info *info)
 {
 	struct snd_rawmidi *rmidi;
-	
+
 	if (substream == NULL)
 		return -ENODEV;
 	rmidi = substream->rmidi;
@@ -637,7 +637,7 @@ int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 {
 	char *newbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
-	
+
 	if (substream->append && substream->use_count > 1)
 		return -EBUSY;
 	snd_rawmidi_drain_output(substream);
@@ -836,7 +836,7 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 	case SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE:
 	{
 		int device;
-		
+
 		if (get_user(device, (int __user *)argp))
 			return -EFAULT;
 		if (device >= SNDRV_RAWMIDI_DEVICES) /* next device is -1 */
@@ -858,7 +858,7 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 	case SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE:
 	{
 		int val;
-		
+
 		if (get_user(val, (int __user *)argp))
 			return -EFAULT;
 		control->preferred_subdevice[SND_CTL_SUBDEV_RAWMIDI] = val;
@@ -1064,7 +1064,7 @@ int snd_rawmidi_transmit_empty(struct snd_rawmidi_substream *substream)
 	spin_lock_irqsave(&runtime->lock, flags);
 	result = runtime->avail >= runtime->buffer_size;
 	spin_unlock_irqrestore(&runtime->lock, flags);
-	return result;		
+	return result;
 }
 EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
 
@@ -1202,7 +1202,7 @@ EXPORT_SYMBOL(snd_rawmidi_transmit_ack);
  * @substream: the rawmidi substream
  * @buffer: the buffer pointer
  * @count: the data size to transfer
- * 
+ *
  * Copies data from the buffer to the device and advances the pointer.
  *
  * Return: The copied size if successful, or a negative error code on failure.
@@ -1761,7 +1761,7 @@ void snd_rawmidi_set_ops(struct snd_rawmidi *rmidi, int stream,
 			 const struct snd_rawmidi_ops *ops)
 {
 	struct snd_rawmidi_substream *substream;
-	
+
 	list_for_each_entry(substream, &rmidi->streams[stream].substreams, list)
 		substream->ops = ops;
 }
diff --git a/sound/core/seq_device.c b/sound/core/seq_device.c
index e40a2cba5002..9515bb3632b9 100644
--- a/sound/core/seq_device.c
+++ b/sound/core/seq_device.c
@@ -242,7 +242,7 @@ int snd_seq_device_new(struct snd_card *card, int device, const char *id,
 		put_device(&dev->dev);
 		return err;
 	}
-	
+
 	if (result)
 		*result = dev;
 
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 84fffabdd129..78100aaeb385 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -57,7 +57,7 @@ int snd_free_sgbuf_pages(struct snd_dma_buffer *dmab)
 	kfree(sgbuf->page_table);
 	kfree(sgbuf);
 	dmab->private_data = NULL;
-	
+
 	return 0;
 }
 
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 0a5c66229a22..74a275034235 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -149,14 +149,14 @@ int snd_register_oss_device(int type, struct snd_card *card, int dev,
 	return 0;
 
       __end:
-      	if (register2 >= 0)
-      		unregister_sound_special(register2);
-      	if (register1 >= 0)
-      		unregister_sound_special(register1);
+	if (register2 >= 0)
+		unregister_sound_special(register2);
+	if (register1 >= 0)
+		unregister_sound_special(register1);
 	snd_oss_minors[minor] = NULL;
 	mutex_unlock(&sound_oss_mutex);
 	kfree(preg);
-      	return -EBUSY;
+	return -EBUSY;
 }
 EXPORT_SYMBOL(snd_register_oss_device);
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index dc87728c5b74..225686dac072 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -951,7 +951,7 @@ static int snd_timer_dev_register(struct snd_device *dev)
 		return -ENXIO;
 	if (!(timer->hw.flags & SNDRV_TIMER_HW_SLAVE) &&
 	    !timer->hw.resolution && timer->hw.c_resolution == NULL)
-	    	return -EINVAL;
+		return -EINVAL;
 
 	mutex_lock(&register_mutex);
 	list_for_each_entry(timer1, &snd_timer_list, device_list) {
@@ -2108,7 +2108,7 @@ static const struct file_operations snd_timer_f_ops =
 	.poll =		snd_timer_user_poll,
 	.unlocked_ioctl =	snd_timer_user_ioctl,
 	.compat_ioctl =	snd_timer_user_ioctl_compat,
-	.fasync = 	snd_timer_user_fasync,
+	.fasync =	snd_timer_user_fasync,
 };
 
 /* unregister the system timer */
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index e00f7e399e46..e53563e808fc 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -97,7 +97,7 @@ static int snd_timer_user_status_compat(struct file *file,
 {
 	struct snd_timer_user *tu;
 	struct snd_timer_status32 status;
-	
+
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
-- 
2.16.2
