From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: line6: Reorganize PCM stream handling
Date: Tue, 27 Jan 2015 17:13:15 +0100
Message-ID: <1422375197-17293-4-git-send-email-tiwai@suse.de>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47048260A56
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
In-Reply-To: <1422375197-17293-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The current code deals with the stream start / stop solely via
line6_pcm_acquire() and line6_pcm_release().  This was (supposedly)
intended to avoid the races, but it doesn't work as expected.  The
concurrent acquire and release calls can be performed without proper
protections, thus this might result in memory corruption.
Furthermore, we can't take a mutex to protect the whole function
because it can be called from the PCM trigger callback that is an
atomic context.  Also spinlock isn't appropriate because the function
allocates with kmalloc with GFP_KERNEL.  That is, these function just
lead to singular problems.

This is an attempt to reduce the existing races.  First off, separate
both the stream buffer management and the stream URB management.  The
former is protected via a newly introduced state_mutex while the
latter is protected via each line6_pcm_stream lock.

Secondly, the stream state are now managed in opened and running bit
flags of each line6_pcm_stream.  Not only this a bit clearer than
previous combined bit flags, this also gives a better abstraction.
These rewrites allows us to make common hw_params and hw_free
callbacks for both playback and capture directions.

For the monitor and impulse operations, still line6_pcm_acquire() and
line6_pcm_release() are used.  They call internally the corresponding
functions for both playback and capture streams with proper lock or
mutex.  Unlike the previous versions, these function don't take the
bit masks but the only single type value.  Also they are supposed to
be applied only as duplex operations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  |  88 ++----------
 sound/usb/line6/capture.h  |   1 -
 sound/usb/line6/pcm.c      | 333 +++++++++++++++++++++++++--------------------
 sound/usb/line6/pcm.h      | 144 ++++++--------------
 sound/usb/line6/playback.c | 104 ++------------
 sound/usb/line6/playback.h |   1 -
 sound/usb/line6/toneport.c |   6 +-
 7 files changed, 252 insertions(+), 425 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 21342a9dddd7..1184876f4e00 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -67,20 +67,18 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 
 /*
 	Submit all currently available capture URBs.
+	must be called in line6pcm->out.lock context
 */
 int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 {
-	unsigned long flags;
 	int ret = 0, i;
 
-	spin_lock_irqsave(&line6pcm->in.lock, flags);
 	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
 		ret = submit_audio_in_urb(line6pcm);
 		if (ret < 0)
 			break;
 	}
 
-	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 	return ret;
 }
 
@@ -187,10 +185,10 @@ static void audio_in_callback(struct urb *urb)
 		line6pcm->prev_fbuf = fbuf;
 		line6pcm->prev_fsize = fsize;
 
-		if (!(line6pcm->flags & LINE6_BITS_PCM_IMPULSE))
-			if (test_bit(LINE6_INDEX_PCM_ALSA_CAPTURE_STREAM,
-				     &line6pcm->flags) && (fsize > 0))
-				line6_capture_copy(line6pcm, fbuf, fsize);
+		if (!test_bit(LINE6_STREAM_IMPULSE, &line6pcm->in.running) &&
+		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running) &&
+		    fsize > 0)
+			line6_capture_copy(line6pcm, fbuf, fsize);
 	}
 
 	clear_bit(index, &line6pcm->in.active_urbs);
@@ -201,10 +199,9 @@ static void audio_in_callback(struct urb *urb)
 	if (!shutdown) {
 		submit_audio_in_urb(line6pcm);
 
-		if (!(line6pcm->flags & LINE6_BITS_PCM_IMPULSE))
-			if (test_bit(LINE6_INDEX_PCM_ALSA_CAPTURE_STREAM,
-				     &line6pcm->flags))
-				line6_capture_check_period(line6pcm, length);
+		if (!test_bit(LINE6_STREAM_IMPULSE, &line6pcm->in.running) &&
+		    test_bit(LINE6_STREAM_PCM, &line6pcm->in.running))
+			line6_capture_check_period(line6pcm, length);
 	}
 
 	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
@@ -234,71 +231,6 @@ static int snd_line6_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/* hw_params capture callback */
-static int snd_line6_capture_hw_params(struct snd_pcm_substream *substream,
-				       struct snd_pcm_hw_params *hw_params)
-{
-	int ret;
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	ret = line6_pcm_acquire(line6pcm, LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER);
-
-	if (ret < 0)
-		return ret;
-
-	ret = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (ret < 0) {
-		line6_pcm_release(line6pcm, LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER);
-		return ret;
-	}
-
-	line6pcm->in.period = params_period_bytes(hw_params);
-	return 0;
-}
-
-/* hw_free capture callback */
-static int snd_line6_capture_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	line6_pcm_release(line6pcm, LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER);
-	return snd_pcm_lib_free_pages(substream);
-}
-
-/* trigger callback */
-int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd)
-{
-	int err;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		err = line6_pcm_acquire(line6pcm,
-					LINE6_BIT_PCM_ALSA_CAPTURE_STREAM);
-
-		if (err < 0)
-			return err;
-
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		err = line6_pcm_release(line6pcm,
-					LINE6_BIT_PCM_ALSA_CAPTURE_STREAM);
-
-		if (err < 0)
-			return err;
-
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /* capture pointer callback */
 static snd_pcm_uframes_t
 snd_line6_capture_pointer(struct snd_pcm_substream *substream)
@@ -313,8 +245,8 @@ struct snd_pcm_ops snd_line6_capture_ops = {
 	.open = snd_line6_capture_open,
 	.close = snd_line6_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_line6_capture_hw_params,
-	.hw_free = snd_line6_capture_hw_free,
+	.hw_params = snd_line6_hw_params,
+	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
 	.pointer = snd_line6_capture_pointer,
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index db062e7200a6..890b21bff18c 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -25,6 +25,5 @@ extern void line6_capture_check_period(struct snd_line6_pcm *line6pcm,
 				       int length);
 extern int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm);
-extern int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
 #endif
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index dedbe24cbf60..470fc1049d54 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -51,9 +51,9 @@ static int snd_line6_impulse_volume_put(struct snd_kcontrol *kcontrol,
 
 	line6pcm->impulse_volume = value;
 	if (value > 0)
-		line6_pcm_acquire(line6pcm, LINE6_BITS_PCM_IMPULSE);
+		line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE);
 	else
-		line6_pcm_release(line6pcm, LINE6_BITS_PCM_IMPULSE);
+		line6_pcm_release(line6pcm, LINE6_STREAM_IMPULSE);
 	return 1;
 }
 
@@ -132,176 +132,226 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 			"timeout: still %d active urbs..\n", alive);
 }
 
-static int line6_alloc_stream_buffer(struct snd_line6_pcm *line6pcm,
-				     struct line6_pcm_stream *pcms)
+static inline struct line6_pcm_stream *
+get_stream(struct snd_line6_pcm *line6pcm, int direction)
 {
-	/* Invoked multiple times in a row so allocate once only */
-	if (pcms->buffer)
-		return 0;
-
-	pcms->buffer = kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
-			       line6pcm->max_packet_size, GFP_KERNEL);
-	if (!pcms->buffer)
-		return -ENOMEM;
-	return 0;
+	return (direction == SNDRV_PCM_STREAM_PLAYBACK) ?
+		&line6pcm->out : &line6pcm->in;
 }
 
-static void line6_free_stream_buffer(struct snd_line6_pcm *line6pcm,
-				     struct line6_pcm_stream *pcms)
+/* allocate a buffer if not opened yet;
+ * call this in line6pcm.state_change mutex
+ */
+static int line6_buffer_acquire(struct snd_line6_pcm *line6pcm,
+				struct line6_pcm_stream *pstr, int type)
 {
-	kfree(pcms->buffer);
-	pcms->buffer = NULL;
+	/* Invoked multiple times in a row so allocate once only */
+	if (!test_and_set_bit(type, &pstr->opened) && !pstr->buffer) {
+		pstr->buffer = kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
+				       line6pcm->max_packet_size, GFP_KERNEL);
+		if (!pstr->buffer)
+			return -ENOMEM;
+	}
+	return 0;
 }
 
-static bool test_flags(unsigned long flags0, unsigned long flags1,
-		       unsigned long mask)
+/* free a buffer if all streams are closed;
+ * call this in line6pcm.state_change mutex
+ */
+static void line6_buffer_release(struct snd_line6_pcm *line6pcm,
+				 struct line6_pcm_stream *pstr, int type)
 {
-	return ((flags0 & mask) == 0) && ((flags1 & mask) != 0);
+
+	clear_bit(type, &pstr->opened);
+	if (!pstr->opened) {
+		line6_wait_clear_audio_urbs(line6pcm, pstr);
+		kfree(pstr->buffer);
+		pstr->buffer = NULL;
+	}
 }
 
-int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
+/* start a PCM stream */
+static int line6_stream_start(struct snd_line6_pcm *line6pcm, int direction,
+			      int type)
 {
-	unsigned long flags_old, flags_new, flags_final;
-	int err;
-
-	do {
-		flags_old = ACCESS_ONCE(line6pcm->flags);
-		flags_new = flags_old | channels;
-	} while (cmpxchg(&line6pcm->flags, flags_old, flags_new) != flags_old);
-
-	flags_final = 0;
+	unsigned long flags;
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, direction);
+	int ret = 0;
+
+	spin_lock_irqsave(&pstr->lock, flags);
+	if (!test_and_set_bit(type, &pstr->running)) {
+		if (pstr->active_urbs || pstr->unlink_urbs) {
+			ret = -EBUSY;
+			goto error;
+		}
 
-	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_BUFFER)) {
-		err = line6_alloc_stream_buffer(line6pcm, &line6pcm->in);
-		if (err < 0)
-			goto pcm_acquire_error;
-		flags_final |= channels & LINE6_BITS_CAPTURE_BUFFER;
+		pstr->count = 0;
+		/* Submit all currently available URBs */
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+			ret = line6_submit_audio_out_all_urbs(line6pcm);
+		else
+			ret = line6_submit_audio_in_all_urbs(line6pcm);
 	}
+ error:
+	if (ret < 0)
+		clear_bit(type, &pstr->running);
+	spin_unlock_irqrestore(&pstr->lock, flags);
+	return ret;
+}
 
-	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_STREAM)) {
-		/*
-		   Waiting for completion of active URBs in the stop handler is
-		   a bug, we therefore report an error if capturing is restarted
-		   too soon.
-		 */
-		if (line6pcm->in.active_urbs || line6pcm->in.unlink_urbs) {
-			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
-			err = -EBUSY;
-			goto pcm_acquire_error;
+/* stop a PCM stream; this doesn't sync with the unlinked URBs */
+static void line6_stream_stop(struct snd_line6_pcm *line6pcm, int direction,
+			  int type)
+{
+	unsigned long flags;
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, direction);
+
+	spin_lock_irqsave(&pstr->lock, flags);
+	clear_bit(type, &pstr->running);
+	if (!pstr->running) {
+		line6_unlink_audio_urbs(line6pcm, pstr);
+		if (direction == SNDRV_PCM_STREAM_CAPTURE) {
+			line6pcm->prev_fbuf = NULL;
+			line6pcm->prev_fsize = 0;
 		}
+	}
+	spin_unlock_irqrestore(&pstr->lock, flags);
+}
 
-		line6pcm->in.count = 0;
-		err = line6_submit_audio_in_all_urbs(line6pcm);
+/* common PCM trigger callback */
+int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct snd_pcm_substream *s;
+	int err;
 
-		if (err < 0)
-			goto pcm_acquire_error;
+	clear_bit(LINE6_FLAG_PREPARED, &line6pcm->flags);
 
-		flags_final |= channels & LINE6_BITS_CAPTURE_STREAM;
-	}
+	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
 
-	if (test_flags(flags_old, flags_new, LINE6_BITS_PLAYBACK_BUFFER)) {
-		err = line6_alloc_stream_buffer(line6pcm, &line6pcm->out);
-		if (err < 0)
-			goto pcm_acquire_error;
-		flags_final |= channels & LINE6_BITS_PLAYBACK_BUFFER;
-	}
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_RESUME:
+			err = line6_stream_start(line6pcm, s->stream,
+						 LINE6_STREAM_PCM);
+			if (err < 0)
+				return err;
+			break;
 
-	if (test_flags(flags_old, flags_new, LINE6_BITS_PLAYBACK_STREAM)) {
-		/*
-		  See comment above regarding PCM restart.
-		*/
-		if (line6pcm->out.active_urbs || line6pcm->out.unlink_urbs) {
-			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
-			return -EBUSY;
-		}
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+			line6_stream_stop(line6pcm, s->stream,
+					  LINE6_STREAM_PCM);
+			break;
 
-		line6pcm->out.count = 0;
-		err = line6_submit_audio_out_all_urbs(line6pcm);
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			if (s->stream != SNDRV_PCM_STREAM_PLAYBACK)
+				return -EINVAL;
+			set_bit(LINE6_FLAG_PAUSE_PLAYBACK, &line6pcm->flags);
+			break;
 
-		if (err < 0)
-			goto pcm_acquire_error;
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			if (s->stream != SNDRV_PCM_STREAM_PLAYBACK)
+				return -EINVAL;
+			clear_bit(LINE6_FLAG_PAUSE_PLAYBACK, &line6pcm->flags);
+			break;
 
-		flags_final |= channels & LINE6_BITS_PLAYBACK_STREAM;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-
-pcm_acquire_error:
-	/*
-	   If not all requested resources/streams could be obtained, release
-	   those which were successfully obtained (if any).
-	*/
-	line6_pcm_release(line6pcm, flags_final);
-	return err;
 }
-EXPORT_SYMBOL_GPL(line6_pcm_acquire);
 
-int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
+/* Acquire and start duplex streams:
+ * type is either LINE6_STREAM_IMPULSE or LINE6_STREAM_MONITOR
+ */
+int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type)
 {
-	unsigned long flags_old, flags_new;
-
-	do {
-		flags_old = ACCESS_ONCE(line6pcm->flags);
-		flags_new = flags_old & ~channels;
-	} while (cmpxchg(&line6pcm->flags, flags_old, flags_new) != flags_old);
-
-	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_STREAM)) {
-		line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
-		line6pcm->prev_fbuf = NULL;
-		line6pcm->prev_fsize = 0;
+	struct line6_pcm_stream *pstr;
+	int ret = 0, dir;
+
+	mutex_lock(&line6pcm->state_mutex);
+	for (dir = 0; dir < 2; dir++) {
+		pstr = get_stream(line6pcm, dir);
+		ret = line6_buffer_acquire(line6pcm, pstr, type);
+		if (ret < 0)
+			goto error;
+		if (!pstr->running)
+			line6_wait_clear_audio_urbs(line6pcm, pstr);
 	}
-
-	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_BUFFER)) {
-		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
-		line6_free_stream_buffer(line6pcm, &line6pcm->in);
+	for (dir = 0; dir < 2; dir++) {
+		ret = line6_stream_start(line6pcm, dir, type);
+		if (ret < 0)
+			goto error;
 	}
+ error:
+	mutex_unlock(&line6pcm->state_mutex);
+	if (ret < 0)
+		line6_pcm_release(line6pcm, type);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(line6_pcm_acquire);
 
-	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_STREAM))
-		line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
-
-	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_BUFFER)) {
-		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
-		line6_free_stream_buffer(line6pcm, &line6pcm->out);
+/* Stop and release duplex streams */
+void line6_pcm_release(struct snd_line6_pcm *line6pcm, int type)
+{
+	struct line6_pcm_stream *pstr;
+	int dir;
+
+	mutex_lock(&line6pcm->state_mutex);
+	for (dir = 0; dir < 2; dir++)
+		line6_stream_stop(line6pcm, dir, type);
+	for (dir = 0; dir < 2; dir++) {
+		pstr = get_stream(line6pcm, dir);
+		line6_buffer_release(line6pcm, pstr, type);
 	}
-
-	return 0;
+	mutex_unlock(&line6pcm->state_mutex);
 }
 EXPORT_SYMBOL_GPL(line6_pcm_release);
 
-/* trigger callback */
-int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
+/* common PCM hw_params callback */
+int snd_line6_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *hw_params)
 {
+	int ret;
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-	struct snd_pcm_substream *s;
-	int err = 0;
-
-	clear_bit(LINE6_INDEX_PREPARED, &line6pcm->flags);
-
-	snd_pcm_group_for_each_entry(s, substream) {
-		if (s->pcm->card != substream->pcm->card)
-			continue;
-		switch (s->stream) {
-		case SNDRV_PCM_STREAM_PLAYBACK:
-			err = snd_line6_playback_trigger(line6pcm, cmd);
-			break;
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
+
+	mutex_lock(&line6pcm->state_mutex);
+	ret = line6_buffer_acquire(line6pcm, pstr, LINE6_STREAM_PCM);
+	if (ret < 0)
+		goto error;
+
+	ret = snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
+	if (ret < 0) {
+		line6_buffer_release(line6pcm, pstr, LINE6_STREAM_PCM);
+		goto error;
+	}
 
-		case SNDRV_PCM_STREAM_CAPTURE:
-			err = snd_line6_capture_trigger(line6pcm, cmd);
-			break;
+	pstr->period = params_period_bytes(hw_params);
+ error:
+	mutex_unlock(&line6pcm->state_mutex);
+	return ret;
+}
 
-		default:
-			dev_err(line6pcm->line6->ifcdev,
-				"Unknown stream direction %d\n", s->stream);
-			err = -EINVAL;
-			break;
-		}
-		if (err < 0)
-			break;
-	}
+/* common PCM hw_free callback */
+int snd_line6_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
-	return err;
+	mutex_lock(&line6pcm->state_mutex);
+	line6_buffer_release(line6pcm, pstr, LINE6_STREAM_PCM);
+	mutex_unlock(&line6pcm->state_mutex);
+	return snd_pcm_lib_free_pages(substream);
 }
 
+
 /* control info callback */
 static int snd_line6_control_playback_info(struct snd_kcontrol *kcontrol,
 					   struct snd_ctl_elem_info *uinfo)
@@ -454,6 +504,7 @@ int line6_init_pcm(struct usb_line6 *line6,
 	if (!line6pcm)
 		return -ENOMEM;
 
+	mutex_init(&line6pcm->state_mutex);
 	line6pcm->pcm = pcm;
 	line6pcm->properties = properties;
 	line6pcm->volume_playback[0] = line6pcm->volume_playback[1] = 255;
@@ -500,24 +551,13 @@ EXPORT_SYMBOL_GPL(line6_init_pcm);
 int snd_line6_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
+	struct line6_pcm_stream *pstr = get_stream(line6pcm, substream->stream);
 
-	switch (substream->stream) {
-	case SNDRV_PCM_STREAM_PLAYBACK:
-		if ((line6pcm->flags & LINE6_BITS_PLAYBACK_STREAM) == 0) {
-			line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
-			line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
-		}
-		break;
-
-	case SNDRV_PCM_STREAM_CAPTURE:
-		if ((line6pcm->flags & LINE6_BITS_CAPTURE_STREAM) == 0) {
-			line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
-			line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
-		}
-		break;
-	}
+	mutex_lock(&line6pcm->state_mutex);
+	if (!pstr->running)
+		line6_wait_clear_audio_urbs(line6pcm, pstr);
 
-	if (!test_and_set_bit(LINE6_INDEX_PREPARED, &line6pcm->flags)) {
+	if (!test_and_set_bit(LINE6_FLAG_PREPARED, &line6pcm->flags)) {
 		line6pcm->out.count = 0;
 		line6pcm->out.pos = 0;
 		line6pcm->out.pos_done = 0;
@@ -527,5 +567,6 @@ int snd_line6_prepare(struct snd_pcm_substream *substream)
 		line6pcm->in.bytes = 0;
 	}
 
+	mutex_unlock(&line6pcm->state_mutex);
 	return 0;
 }
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index 4c74f4e85074..66f603dfa34e 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -54,109 +54,33 @@
 	However, from the device's point of view, there is just a single
 	capture and playback stream, which must be shared between these
 	subsystems. It is therefore necessary to maintain the state of the
-	subsystems with respect to PCM usage. We define several constants of
-	the form LINE6_BIT_PCM_<subsystem>_<direction>_<resource> with the
-	following meanings:
-	*) <subsystem> is one of
-	-) ALSA: PCM playback and capture via ALSA
-	-) MONITOR: software monitoring
-	-) IMPULSE: optional impulse response measurement
-	*) <direction> is one of
-	-) PLAYBACK: audio output (from host to device)
-	-) CAPTURE: audio input (from device to host)
-	*) <resource> is one of
-	-) BUFFER: buffer required by PCM data stream
-	-) STREAM: actual PCM data stream
-
-	The subsystems call line6_pcm_acquire() to acquire the (shared)
-	resources needed for a particular operation (e.g., allocate the buffer
-	for ALSA playback or start the capture stream for software monitoring).
-	When a resource is no longer needed, it is released by calling
-	line6_pcm_release(). Buffer allocation and stream startup are handled
-	separately to allow the ALSA kernel driver to perform them at
-	appropriate places (since the callback which starts a PCM stream is not
-	allowed to sleep).
+	subsystems with respect to PCM usage.
+
+	We define two bit flags, "opened" and "running", for each playback
+	or capture stream.  Both can contain the bit flag corresponding to
+	LINE6_STREAM_* type,
+	  LINE6_STREAM_PCM = ALSA PCM playback or capture
+	  LINE6_STREAM_MONITOR = software monitoring
+	  IMPULSE = optional impulse response measurement
+	The opened flag indicates whether the buffer is allocated while
+	the running flag indicates whether the stream is running.
+
+	For monitor or impulse operations, the driver needs to call
+	snd_line6_duplex_acquire() or snd_line6_duplex_release() with the
+	appropriate LINE6_STREAM_* flag.
 */
+
+/* stream types */
+enum {
+	LINE6_STREAM_PCM,
+	LINE6_STREAM_MONITOR,
+	LINE6_STREAM_IMPULSE,
+};
+
+/* misc bit flags for PCM operation */
 enum {
-	/* individual bit indices: */
-	LINE6_INDEX_PCM_ALSA_PLAYBACK_BUFFER,
-	LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM,
-	LINE6_INDEX_PCM_ALSA_CAPTURE_BUFFER,
-	LINE6_INDEX_PCM_ALSA_CAPTURE_STREAM,
-	LINE6_INDEX_PCM_MONITOR_PLAYBACK_BUFFER,
-	LINE6_INDEX_PCM_MONITOR_PLAYBACK_STREAM,
-	LINE6_INDEX_PCM_MONITOR_CAPTURE_BUFFER,
-	LINE6_INDEX_PCM_MONITOR_CAPTURE_STREAM,
-	LINE6_INDEX_PCM_IMPULSE_PLAYBACK_BUFFER,
-	LINE6_INDEX_PCM_IMPULSE_PLAYBACK_STREAM,
-	LINE6_INDEX_PCM_IMPULSE_CAPTURE_BUFFER,
-	LINE6_INDEX_PCM_IMPULSE_CAPTURE_STREAM,
-	LINE6_INDEX_PAUSE_PLAYBACK,
-	LINE6_INDEX_PREPARED,
-
-#define LINE6_BIT(x) LINE6_BIT_ ## x = 1 << LINE6_INDEX_ ## x
-
-	/* individual bit masks: */
-	LINE6_BIT(PCM_ALSA_PLAYBACK_BUFFER),
-	LINE6_BIT(PCM_ALSA_PLAYBACK_STREAM),
-	LINE6_BIT(PCM_ALSA_CAPTURE_BUFFER),
-	LINE6_BIT(PCM_ALSA_CAPTURE_STREAM),
-	LINE6_BIT(PCM_MONITOR_PLAYBACK_BUFFER),
-	LINE6_BIT(PCM_MONITOR_PLAYBACK_STREAM),
-	LINE6_BIT(PCM_MONITOR_CAPTURE_BUFFER),
-	LINE6_BIT(PCM_MONITOR_CAPTURE_STREAM),
-	LINE6_BIT(PCM_IMPULSE_PLAYBACK_BUFFER),
-	LINE6_BIT(PCM_IMPULSE_PLAYBACK_STREAM),
-	LINE6_BIT(PCM_IMPULSE_CAPTURE_BUFFER),
-	LINE6_BIT(PCM_IMPULSE_CAPTURE_STREAM),
-	LINE6_BIT(PAUSE_PLAYBACK),
-	LINE6_BIT(PREPARED),
-
-	/* combined bit masks (by operation): */
-	LINE6_BITS_PCM_ALSA_BUFFER =
-	    LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER |
-	    LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER,
-
-	LINE6_BITS_PCM_ALSA_STREAM =
-	    LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM |
-	    LINE6_BIT_PCM_ALSA_CAPTURE_STREAM,
-
-	LINE6_BITS_PCM_MONITOR =
-	    LINE6_BIT_PCM_MONITOR_PLAYBACK_BUFFER |
-	    LINE6_BIT_PCM_MONITOR_PLAYBACK_STREAM |
-	    LINE6_BIT_PCM_MONITOR_CAPTURE_BUFFER |
-	    LINE6_BIT_PCM_MONITOR_CAPTURE_STREAM,
-
-	LINE6_BITS_PCM_IMPULSE =
-	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_BUFFER |
-	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_STREAM |
-	    LINE6_BIT_PCM_IMPULSE_CAPTURE_BUFFER |
-	    LINE6_BIT_PCM_IMPULSE_CAPTURE_STREAM,
-
-	/* combined bit masks (by direction): */
-	LINE6_BITS_PLAYBACK_BUFFER =
-	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_BUFFER |
-	    LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER |
-	    LINE6_BIT_PCM_MONITOR_PLAYBACK_BUFFER,
-
-	LINE6_BITS_PLAYBACK_STREAM =
-	    LINE6_BIT_PCM_IMPULSE_PLAYBACK_STREAM |
-	    LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM |
-	    LINE6_BIT_PCM_MONITOR_PLAYBACK_STREAM,
-
-	LINE6_BITS_CAPTURE_BUFFER =
-	    LINE6_BIT_PCM_IMPULSE_CAPTURE_BUFFER |
-	    LINE6_BIT_PCM_ALSA_CAPTURE_BUFFER |
-	    LINE6_BIT_PCM_MONITOR_CAPTURE_BUFFER,
-
-	LINE6_BITS_CAPTURE_STREAM =
-	    LINE6_BIT_PCM_IMPULSE_CAPTURE_STREAM |
-	    LINE6_BIT_PCM_ALSA_CAPTURE_STREAM |
-	    LINE6_BIT_PCM_MONITOR_CAPTURE_STREAM,
-
-	LINE6_BITS_STREAM =
-	    LINE6_BITS_PLAYBACK_STREAM |
-	    LINE6_BITS_CAPTURE_STREAM
+	LINE6_FLAG_PAUSE_PLAYBACK,
+	LINE6_FLAG_PREPARED,
 };
 
 struct line6_pcm_properties {
@@ -205,6 +129,12 @@ struct line6_pcm_stream {
 	 */
 	spinlock_t lock;
 
+	/* Bit flags for operational stream types */
+	unsigned long opened;
+
+	/* Bit flags for running stream types */
+	unsigned long running;
+
 	int last_frame;
 };
 
@@ -224,6 +154,9 @@ struct snd_line6_pcm {
 	*/
 	struct snd_pcm *pcm;
 
+	/* protection to state changes of in/out streams */
+	struct mutex state_mutex;
+
 	/* Capture and playback streams */
 	struct line6_pcm_stream in;
 	struct line6_pcm_stream out;
@@ -269,7 +202,7 @@ struct snd_line6_pcm {
 	int impulse_count;
 
 	/**
-		 Several status bits (see LINE6_BIT_*).
+		 Several status bits (see LINE6_FLAG_*).
 	*/
 	unsigned long flags;
 };
@@ -278,8 +211,11 @@ extern int line6_init_pcm(struct usb_line6 *line6,
 			  struct line6_pcm_properties *properties);
 extern int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd);
 extern int snd_line6_prepare(struct snd_pcm_substream *substream);
+extern int snd_line6_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *hw_params);
+extern int snd_line6_hw_free(struct snd_pcm_substream *substream);
 extern void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm);
-extern int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels);
-extern int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels);
+extern int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int type);
+extern void line6_pcm_release(struct snd_line6_pcm *line6pcm, int type);
 
 #endif
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index c1063f1847c3..f8b04e2d36b3 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -194,8 +194,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	urb_out->transfer_buffer_length = urb_size;
 	urb_out->context = line6pcm;
 
-	if (test_bit(LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM, &line6pcm->flags) &&
-	    !test_bit(LINE6_INDEX_PAUSE_PLAYBACK, &line6pcm->flags)) {
+	if (test_bit(LINE6_STREAM_PCM, &line6pcm->out.running) &&
+	    !test_bit(LINE6_FLAG_PAUSE_PLAYBACK, &line6pcm->flags)) {
 		struct snd_pcm_runtime *runtime =
 		    get_substream(line6pcm, SNDRV_PCM_STREAM_PLAYBACK)->runtime;
 
@@ -239,11 +239,10 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 	spin_lock_nested(&line6pcm->in.lock, SINGLE_DEPTH_NESTING);
 	if (line6pcm->prev_fbuf) {
-		if (line6pcm->flags & LINE6_BITS_PCM_IMPULSE) {
+		if (test_bit(LINE6_STREAM_IMPULSE, &line6pcm->out.running)) {
 			create_impulse_test_signal(line6pcm, urb_out,
 						   bytes_per_frame);
-			if (line6pcm->flags &
-			    LINE6_BIT_PCM_ALSA_CAPTURE_STREAM) {
+			if (test_bit(LINE6_STREAM_PCM, &line6pcm->in.running)) {
 				line6_capture_copy(line6pcm,
 						   urb_out->transfer_buffer,
 						   urb_out->
@@ -252,11 +251,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 					urb_out->transfer_buffer_length);
 			}
 		} else {
-			if (!
-			    (line6pcm->line6->
-			     properties->capabilities & LINE6_CAP_HWMON)
-			    && (line6pcm->flags & LINE6_BITS_PLAYBACK_STREAM)
-			    && (line6pcm->flags & LINE6_BITS_CAPTURE_STREAM))
+			if (!(line6pcm->line6->properties->capabilities & LINE6_CAP_HWMON)
+			    && line6pcm->out.running && line6pcm->in.running)
 				add_monitor_signal(urb_out, line6pcm->prev_fbuf,
 						   line6pcm->volume_monitor,
 						   bytes_per_frame);
@@ -279,20 +275,18 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 /*
 	Submit all currently available playback URBs.
-*/
+	must be called in line6pcm->out.lock context
+ */
 int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 {
-	unsigned long flags;
 	int ret = 0, i;
 
-	spin_lock_irqsave(&line6pcm->out.lock, flags);
 	for (i = 0; i < LINE6_ISO_BUFFERS; ++i) {
 		ret = submit_audio_out_urb(line6pcm);
 		if (ret < 0)
 			break;
 	}
 
-	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 	return ret;
 }
 
@@ -326,7 +320,7 @@ static void audio_out_callback(struct urb *urb)
 
 	spin_lock_irqsave(&line6pcm->out.lock, flags);
 
-	if (test_bit(LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM, &line6pcm->flags)) {
+	if (test_bit(LINE6_STREAM_PCM, &line6pcm->out.running)) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 
 		line6pcm->out.pos_done +=
@@ -350,8 +344,7 @@ static void audio_out_callback(struct urb *urb)
 	if (!shutdown) {
 		submit_audio_out_urb(line6pcm);
 
-		if (test_bit(LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM,
-			     &line6pcm->flags)) {
+		if (test_bit(LINE6_STREAM_PCM, &line6pcm->out.running)) {
 			line6pcm->out.bytes += length;
 			if (line6pcm->out.bytes >= line6pcm->out.period) {
 				line6pcm->out.bytes %= line6pcm->out.period;
@@ -387,79 +380,6 @@ static int snd_line6_playback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/* hw_params playback callback */
-static int snd_line6_playback_hw_params(struct snd_pcm_substream *substream,
-					struct snd_pcm_hw_params *hw_params)
-{
-	int ret;
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	ret = line6_pcm_acquire(line6pcm, LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER);
-
-	if (ret < 0)
-		return ret;
-
-	ret = snd_pcm_lib_malloc_pages(substream,
-				       params_buffer_bytes(hw_params));
-	if (ret < 0) {
-		line6_pcm_release(line6pcm, LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER);
-		return ret;
-	}
-
-	line6pcm->out.period = params_period_bytes(hw_params);
-	return 0;
-}
-
-/* hw_free playback callback */
-static int snd_line6_playback_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
-
-	line6_pcm_release(line6pcm, LINE6_BIT_PCM_ALSA_PLAYBACK_BUFFER);
-	return snd_pcm_lib_free_pages(substream);
-}
-
-/* trigger playback callback */
-int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd)
-{
-	int err;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		err = line6_pcm_acquire(line6pcm,
-					LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM);
-
-		if (err < 0)
-			return err;
-
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		err = line6_pcm_release(line6pcm,
-					LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM);
-
-		if (err < 0)
-			return err;
-
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		set_bit(LINE6_INDEX_PAUSE_PLAYBACK, &line6pcm->flags);
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		clear_bit(LINE6_INDEX_PAUSE_PLAYBACK, &line6pcm->flags);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /* playback pointer callback */
 static snd_pcm_uframes_t
 snd_line6_playback_pointer(struct snd_pcm_substream *substream)
@@ -474,8 +394,8 @@ struct snd_pcm_ops snd_line6_playback_ops = {
 	.open = snd_line6_playback_open,
 	.close = snd_line6_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = snd_line6_playback_hw_params,
-	.hw_free = snd_line6_playback_hw_free,
+	.hw_params = snd_line6_hw_params,
+	.hw_free = snd_line6_hw_free,
 	.prepare = snd_line6_prepare,
 	.trigger = snd_line6_trigger,
 	.pointer = snd_line6_playback_pointer,
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index f6a9e18f87b6..51fce29e8726 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -31,6 +31,5 @@ extern struct snd_pcm_ops snd_line6_playback_ops;
 
 extern int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm);
-extern int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
 #endif
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 33d16ecf18a0..61fa6256d7b0 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -189,9 +189,9 @@ static int snd_toneport_monitor_put(struct snd_kcontrol *kcontrol,
 	line6pcm->volume_monitor = ucontrol->value.integer.value[0];
 
 	if (line6pcm->volume_monitor > 0)
-		line6_pcm_acquire(line6pcm, LINE6_BITS_PCM_MONITOR);
+		line6_pcm_acquire(line6pcm, LINE6_STREAM_MONITOR);
 	else
-		line6_pcm_release(line6pcm, LINE6_BITS_PCM_MONITOR);
+		line6_pcm_release(line6pcm, LINE6_STREAM_MONITOR);
 
 	return 1;
 }
@@ -252,7 +252,7 @@ static void toneport_start_pcm(unsigned long arg)
 	struct usb_line6_toneport *toneport = (struct usb_line6_toneport *)arg;
 	struct usb_line6 *line6 = &toneport->line6;
 
-	line6_pcm_acquire(line6->line6pcm, LINE6_BITS_PCM_MONITOR);
+	line6_pcm_acquire(line6->line6pcm, LINE6_STREAM_MONITOR);
 }
 
 /* control definition */
-- 
2.2.2
