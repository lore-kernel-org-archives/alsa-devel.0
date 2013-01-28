From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 6/6] sound/core/pcm_native.c: cosmetics,
	fix use of spaces
Date: Mon, 28 Jan 2013 23:42:32 +0100
Message-ID: <1359412952-1680-7-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 67A5A265B47
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 23:45:04 +0100 (CET)
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

Misc cosmetics fixes:

  * Indent with TABs instead of spaces

  * Remove trailing spaces

  * Remove excess of leading spaces. I left labels with one space
    indentation to be consistent with other labels used in the file.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/core/pcm_native.c |  120 +++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 09b4286..022bad1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -161,7 +161,7 @@ static const char * const snd_pcm_hw_param_names[] = {
 };
 #endif
 
-int snd_pcm_hw_refine(struct snd_pcm_substream *substream, 
+int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params)
 {
 	unsigned int k;
@@ -214,7 +214,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		if (i->empty)
 			printk("empty");
 		else
-			printk("%c%u %u%c", 
+			printk("%c%u %u%c",
 			       i->openmin ? '(' : '[', i->min,
 			       i->max, i->openmax ? ')' : ']');
 		printk(" -> ");
@@ -223,8 +223,8 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 #ifdef RULES_DEBUG
 		if (i->empty)
 			printk("empty\n");
-		else 
-			printk("%c%u %u%c\n", 
+		else
+			printk("%c%u %u%c\n",
 			       i->openmin ? '(' : '[', i->min,
 			       i->max, i->openmax ? ')' : ']');
 #endif
@@ -236,7 +236,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
+	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
 	do {
 		again = 0;
@@ -266,7 +266,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 					if (i->empty)
 						printk("empty");
 					else
-						printk("%c%u %u%c", 
+						printk("%c%u %u%c",
 						       i->openmin ? '(' : '[', i->min,
 						       i->max, i->openmax ? ')' : ']');
 				}
@@ -282,7 +282,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 					if (i->empty)
 						printk("empty");
 					else
-						printk("%c%u %u%c", 
+						printk("%c%u %u%c",
 						       i->openmin ? '(' : '[', i->min,
 						       i->max, i->openmax ? ')' : ']');
 				}
@@ -321,7 +321,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 		m = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 		if (snd_mask_min(m) == snd_mask_max(m) &&
-                    snd_interval_min(i) == snd_interval_max(i)) {
+			snd_interval_min(i) == snd_interval_max(i)) {
 			changed = substream->ops->ioctl(substream,
 					SNDRV_PCM_IOCTL1_FIFO_SIZE, params);
 			if (changed < 0)
@@ -563,7 +563,7 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 	runtime->stop_threshold = params->stop_threshold;
 	runtime->silence_threshold = params->silence_threshold;
 	runtime->silence_size = params->silence_size;
-        params->boundary = runtime->boundary;
+	params->boundary = runtime->boundary;
 	if (snd_pcm_running(substream)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 		    runtime->silence_size > 0)
@@ -640,7 +640,7 @@ static int snd_pcm_status_user(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_status status;
 	int res;
-	
+
 	memset(&status, 0, sizeof(status));
 	res = snd_pcm_status(substream, &status);
 	if (res < 0)
@@ -655,7 +655,7 @@ static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime;
 	unsigned int channel;
-	
+
 	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
@@ -676,7 +676,7 @@ static int snd_pcm_channel_info_user(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_channel_info info;
 	int res;
-	
+
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
 	res = snd_pcm_channel_info(substream, &info);
@@ -767,7 +767,7 @@ static int snd_pcm_action_single(struct action_ops *ops,
 				 int state)
 {
 	int res;
-	
+
 	res = ops->pre_action(substream, state);
 	if (res < 0)
 		return res;
@@ -877,7 +877,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream, int state)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
-	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
+	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) /
 							    runtime->rate;
 	runtime->status->state = state;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -1553,7 +1553,7 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
 	int result = 0;
-	
+
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
@@ -1683,7 +1683,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 		kfree(substream->group);
 	}
 	relink_to_local(substream);
-       _end:
+ _end:
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
 	return res;
@@ -1795,7 +1795,7 @@ static int snd_pcm_hw_rule_rate(struct snd_pcm_hw_params *params,
 	return snd_interval_list(hw_param_interval(params, rule->var),
 				 snd_pcm_known_rates.count,
 				 snd_pcm_known_rates.list, hw->rates);
-}		
+}
 
 static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 					    struct snd_pcm_hw_rule *rule)
@@ -1808,7 +1808,7 @@ static int snd_pcm_hw_rule_buffer_bytes_max(struct snd_pcm_hw_params *params,
 	t.openmax = 0;
 	t.integer = 1;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
-}		
+}
 
 int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
@@ -1835,98 +1835,98 @@ int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
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
@@ -1941,9 +1941,9 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	int err;
 	unsigned int mask = 0;
 
-        if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
+	if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
 		mask |= 1 << SNDRV_PCM_ACCESS_RW_INTERLEAVED;
-        if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
+	if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
 		mask |= 1 << SNDRV_PCM_ACCESS_RW_NONINTERLEAVED;
 	if (hw->info & SNDRV_PCM_INFO_MMAP) {
 		if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
@@ -1990,7 +1990,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				  snd_pcm_hw_rule_buffer_bytes_max, substream,
 				  SNDRV_PCM_HW_PARAM_BUFFER_BYTES, -1);
 	if (err < 0)
@@ -2004,7 +2004,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 	}
 
 	if (!(hw->rates & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))) {
-		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, 
+		err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 					  snd_pcm_hw_rule_rate, hw,
 					  SNDRV_PCM_HW_PARAM_RATE, -1);
 		if (err < 0)
@@ -2192,12 +2192,12 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 		goto __error;
 	return err;
 
-      __error:
+ __error:
 	module_put(pcm->card->module);
-      __error2:
-      	snd_card_file_remove(pcm->card, file);
-      __error1:
-      	return err;
+ __error2:
+	snd_card_file_remove(pcm->card, file);
+ __error1:
+	return err;
 }
 
 static int snd_pcm_release(struct inode *inode, struct file *file)
@@ -2444,7 +2444,7 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	return err;
 }
-		
+
 static int snd_pcm_delay(struct snd_pcm_substream *substream,
 			 snd_pcm_sframes_t __user *res)
 {
@@ -2484,7 +2484,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 			err = -EFAULT;
 	return err;
 }
-		
+
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 			    struct snd_pcm_sync_ptr __user *_sync_ptr)
 {
@@ -2498,7 +2498,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
 	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
 		return -EFAULT;
 	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
+		return -EFAULT;
 	status = runtime->status;
 	control = runtime->control;
 	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
@@ -2529,7 +2529,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int arg;
-	
+
 	if (get_user(arg, _arg))
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
@@ -2539,7 +2539,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 		runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC;
 	return 0;
 }
-		
+
 static int snd_pcm_common_ioctl1(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
@@ -2801,7 +2801,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 {
 	mm_segment_t fs;
 	int result;
-	
+
 	fs = snd_enter_user();
 	switch (substream->stream) {
 	case SNDRV_PCM_STREAM_PLAYBACK:
@@ -2945,7 +2945,7 @@ static unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-        unsigned int mask;
+	unsigned int mask;
 	snd_pcm_uframes_t avail;
 
 	pcm_file = file->private_data;
@@ -2984,7 +2984,7 @@ static unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-        unsigned int mask;
+	unsigned int mask;
 	snd_pcm_uframes_t avail;
 
 	pcm_file = file->private_data;
@@ -3039,7 +3039,7 @@ static int snd_pcm_mmap_status_fault(struct vm_area_struct *area,
 {
 	struct snd_pcm_substream *substream = area->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3076,7 +3076,7 @@ static int snd_pcm_mmap_control_fault(struct vm_area_struct *area,
 {
 	struct snd_pcm_substream *substream = area->vm_private_data;
 	struct snd_pcm_runtime *runtime;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3152,7 +3152,7 @@ static int snd_pcm_mmap_data_fault(struct vm_area_struct *area,
 	unsigned long offset;
 	struct page * page;
 	size_t dma_bytes;
-	
+
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
@@ -3290,9 +3290,9 @@ EXPORT_SYMBOL(snd_pcm_mmap_data);
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
-- 
1.7.10.4
