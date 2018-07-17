From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: rawmidi: Minor code refactoring
Date: Tue, 17 Jul 2018 23:19:48 +0200
Message-ID: <20180717211949.689-4-tiwai@suse.de>
References: <20180717211949.689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A679F267839
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 23:19:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 28086AD9C
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 21:19:51 +0000 (UTC)
In-Reply-To: <20180717211949.689-1-tiwai@suse.de>
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

Unify a few open codes with helper functions to improve the
readability.  Minor behavior changes (rather fixes) are:
- runtime->drain clearance is done within lock
- active_sensing is updated before resizing buffer in
  SNDRV_RAWMIDI_IOCTL_PARAMS ioctl.
Other than that, simply code cleanups.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 77 +++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 6b24c2d2dae6..cc944a3637a2 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -164,17 +164,28 @@ static void snd_rawmidi_input_trigger(struct snd_rawmidi_substream *substream, i
 		cancel_work_sync(&substream->runtime->event_work);
 }
 
-int snd_rawmidi_drop_output(struct snd_rawmidi_substream *substream)
+static void __reset_runtime_ptrs(struct snd_rawmidi_runtime *runtime,
+				 bool is_input)
+{
+	runtime->drain = 0;
+	runtime->appl_ptr = runtime->hw_ptr = 0;
+	runtime->avail = is_input ? 0 : runtime->buffer_size;
+}
+
+static void reset_runtime_ptrs(struct snd_rawmidi_runtime *runtime,
+			       bool is_input)
 {
 	unsigned long flags;
-	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
-	snd_rawmidi_output_trigger(substream, 0);
-	runtime->drain = 0;
 	spin_lock_irqsave(&runtime->lock, flags);
-	runtime->appl_ptr = runtime->hw_ptr = 0;
-	runtime->avail = runtime->buffer_size;
+	__reset_runtime_ptrs(runtime, is_input);
 	spin_unlock_irqrestore(&runtime->lock, flags);
+}
+
+int snd_rawmidi_drop_output(struct snd_rawmidi_substream *substream)
+{
+	snd_rawmidi_output_trigger(substream, 0);
+	reset_runtime_ptrs(substream->runtime, false);
 	return 0;
 }
 EXPORT_SYMBOL(snd_rawmidi_drop_output);
@@ -213,15 +224,8 @@ EXPORT_SYMBOL(snd_rawmidi_drain_output);
 
 int snd_rawmidi_drain_input(struct snd_rawmidi_substream *substream)
 {
-	unsigned long flags;
-	struct snd_rawmidi_runtime *runtime = substream->runtime;
-
 	snd_rawmidi_input_trigger(substream, 0);
-	runtime->drain = 0;
-	spin_lock_irqsave(&runtime->lock, flags);
-	runtime->appl_ptr = runtime->hw_ptr = 0;
-	runtime->avail = 0;
-	spin_unlock_irqrestore(&runtime->lock, flags);
+	reset_runtime_ptrs(substream->runtime, true);
 	return 0;
 }
 EXPORT_SYMBOL(snd_rawmidi_drain_input);
@@ -639,15 +643,12 @@ static int snd_rawmidi_info_select_user(struct snd_card *card,
 	return 0;
 }
 
-int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
-			      struct snd_rawmidi_params *params)
+static int resize_runtime_buffer(struct snd_rawmidi_runtime *runtime,
+				 struct snd_rawmidi_params *params,
+				 bool is_input)
 {
 	char *newbuf, *oldbuf;
-	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
-	if (substream->append && substream->use_count > 1)
-		return -EBUSY;
-	snd_rawmidi_drain_output(substream);
 	if (params->buffer_size < 32 || params->buffer_size > 1024L * 1024L)
 		return -EINVAL;
 	if (params->avail_min < 1 || params->avail_min > params->buffer_size)
@@ -660,42 +661,30 @@ int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 		oldbuf = runtime->buffer;
 		runtime->buffer = newbuf;
 		runtime->buffer_size = params->buffer_size;
-		runtime->avail = runtime->buffer_size;
-		runtime->appl_ptr = runtime->hw_ptr = 0;
+		__reset_runtime_ptrs(runtime, is_input);
 		spin_unlock_irq(&runtime->lock);
 		kfree(oldbuf);
 	}
 	runtime->avail_min = params->avail_min;
-	substream->active_sensing = !params->no_active_sensing;
 	return 0;
 }
+
+int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
+			      struct snd_rawmidi_params *params)
+{
+	if (substream->append && substream->use_count > 1)
+		return -EBUSY;
+	snd_rawmidi_drain_output(substream);
+	substream->active_sensing = !params->no_active_sensing;
+	return resize_runtime_buffer(substream->runtime, params, false);
+}
 EXPORT_SYMBOL(snd_rawmidi_output_params);
 
 int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 			     struct snd_rawmidi_params *params)
 {
-	char *newbuf, *oldbuf;
-	struct snd_rawmidi_runtime *runtime = substream->runtime;
-
 	snd_rawmidi_drain_input(substream);
-	if (params->buffer_size < 32 || params->buffer_size > 1024L * 1024L)
-		return -EINVAL;
-	if (params->avail_min < 1 || params->avail_min > params->buffer_size)
-		return -EINVAL;
-	if (params->buffer_size != runtime->buffer_size) {
-		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
-		if (!newbuf)
-			return -ENOMEM;
-		spin_lock_irq(&runtime->lock);
-		oldbuf = runtime->buffer;
-		runtime->buffer = newbuf;
-		runtime->buffer_size = params->buffer_size;
-		runtime->appl_ptr = runtime->hw_ptr = 0;
-		spin_unlock_irq(&runtime->lock);
-		kfree(oldbuf);
-	}
-	runtime->avail_min = params->avail_min;
-	return 0;
+	return resize_runtime_buffer(substream->runtime, params, true);
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
-- 
2.18.0
