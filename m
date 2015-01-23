From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/16] ALSA: line6: Rearrange PCM structure
Date: Fri, 23 Jan 2015 18:13:18 +0100
Message-ID: <1422033203-23254-12-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A237026553A
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:42 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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

Introduce a new line6_pcm_stream structure and group individual
fields of snd_line6_pcm struct to playback and capture groups.

This patch itself just does rename and nothing else.  More
meaningful cleanups based on these fields shuffling will follow.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  |  64 +++++++++---------
 sound/usb/line6/pcm.c      |  50 +++++++-------
 sound/usb/line6/pcm.h      | 158 +++++++++++++--------------------------------
 sound/usb/line6/playback.c |  78 +++++++++++-----------
 4 files changed, 142 insertions(+), 208 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index bad1b5b02786..439f1941eb56 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -29,17 +29,17 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 	int ret;
 	struct urb *urb_in;
 
-	spin_lock_irqsave(&line6pcm->lock_audio_in, flags);
+	spin_lock_irqsave(&line6pcm->in.lock, flags);
 	index =
-	    find_first_zero_bit(&line6pcm->active_urb_in, LINE6_ISO_BUFFERS);
+	    find_first_zero_bit(&line6pcm->in.active_urbs, LINE6_ISO_BUFFERS);
 
 	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
-		spin_unlock_irqrestore(&line6pcm->lock_audio_in, flags);
+		spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
 
-	urb_in = line6pcm->urb_audio_in[index];
+	urb_in = line6pcm->in.urbs[index];
 	urb_size = 0;
 
 	for (i = 0; i < LINE6_ISO_PACKETS; ++i) {
@@ -51,7 +51,7 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 	}
 
 	urb_in->transfer_buffer =
-	    line6pcm->buffer_in +
+	    line6pcm->in.buffer +
 	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size;
 	urb_in->transfer_buffer_length = urb_size;
 	urb_in->context = line6pcm;
@@ -59,12 +59,12 @@ static int submit_audio_in_urb(struct snd_line6_pcm *line6pcm)
 	ret = usb_submit_urb(urb_in, GFP_ATOMIC);
 
 	if (ret == 0)
-		set_bit(index, &line6pcm->active_urb_in);
+		set_bit(index, &line6pcm->in.active_urbs);
 	else
 		dev_err(line6pcm->line6->ifcdev,
 			"URB in #%d submission failed (%d)\n", index, ret);
 
-	spin_unlock_irqrestore(&line6pcm->lock_audio_in, flags);
+	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 	return 0;
 }
 
@@ -92,9 +92,9 @@ void line6_unlink_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 	unsigned int i;
 
 	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (test_bit(i, &line6pcm->active_urb_in)) {
-			if (!test_and_set_bit(i, &line6pcm->unlink_urb_in)) {
-				struct urb *u = line6pcm->urb_audio_in[i];
+		if (test_bit(i, &line6pcm->in.active_urbs)) {
+			if (!test_and_set_bit(i, &line6pcm->in.unlink_urbs)) {
+				struct urb *u = line6pcm->in.urbs[i];
 
 				usb_unlink_urb(u);
 			}
@@ -115,7 +115,7 @@ void line6_wait_clear_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 	do {
 		alive = 0;
 		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-			if (test_bit(i, &line6pcm->active_urb_in))
+			if (test_bit(i, &line6pcm->in.active_urbs))
 				alive++;
 		}
 		if (!alive)
@@ -150,18 +150,18 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 	if (runtime == NULL)
 		return;
 
-	if (line6pcm->pos_in_done + frames > runtime->buffer_size) {
+	if (line6pcm->in.pos_done + frames > runtime->buffer_size) {
 		/*
 		   The transferred area goes over buffer boundary,
 		   copy two separate chunks.
 		 */
 		int len;
 
-		len = runtime->buffer_size - line6pcm->pos_in_done;
+		len = runtime->buffer_size - line6pcm->in.pos_done;
 
 		if (len > 0) {
 			memcpy(runtime->dma_area +
-			       line6pcm->pos_in_done * bytes_per_frame, fbuf,
+			       line6pcm->in.pos_done * bytes_per_frame, fbuf,
 			       len * bytes_per_frame);
 			memcpy(runtime->dma_area, fbuf + len * bytes_per_frame,
 			       (frames - len) * bytes_per_frame);
@@ -173,12 +173,12 @@ void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
 	} else {
 		/* copy single chunk */
 		memcpy(runtime->dma_area +
-		       line6pcm->pos_in_done * bytes_per_frame, fbuf, fsize);
+		       line6pcm->in.pos_done * bytes_per_frame, fbuf, fsize);
 	}
 
-	line6pcm->pos_in_done += frames;
-	if (line6pcm->pos_in_done >= runtime->buffer_size)
-		line6pcm->pos_in_done -= runtime->buffer_size;
+	line6pcm->in.pos_done += frames;
+	if (line6pcm->in.pos_done >= runtime->buffer_size)
+		line6pcm->in.pos_done -= runtime->buffer_size;
 }
 
 void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
@@ -186,17 +186,17 @@ void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
 	struct snd_pcm_substream *substream =
 	    get_substream(line6pcm, SNDRV_PCM_STREAM_CAPTURE);
 
-	line6pcm->bytes_in += length;
-	if (line6pcm->bytes_in >= line6pcm->period_in) {
-		line6pcm->bytes_in %= line6pcm->period_in;
+	line6pcm->in.bytes += length;
+	if (line6pcm->in.bytes >= line6pcm->in.period) {
+		line6pcm->in.bytes %= line6pcm->in.period;
 		snd_pcm_period_elapsed(substream);
 	}
 }
 
 void line6_free_capture_buffer(struct snd_line6_pcm *line6pcm)
 {
-	kfree(line6pcm->buffer_in);
-	line6pcm->buffer_in = NULL;
+	kfree(line6pcm->in.buffer);
+	line6pcm->in.buffer = NULL;
 }
 
 /*
@@ -209,14 +209,14 @@ static void audio_in_callback(struct urb *urb)
 
 	struct snd_line6_pcm *line6pcm = (struct snd_line6_pcm *)urb->context;
 
-	line6pcm->last_frame_in = urb->start_frame;
+	line6pcm->in.last_frame = urb->start_frame;
 
 	/* find index of URB */
 	for (index = 0; index < LINE6_ISO_BUFFERS; ++index)
-		if (urb == line6pcm->urb_audio_in[index])
+		if (urb == line6pcm->in.urbs[index])
 			break;
 
-	spin_lock_irqsave(&line6pcm->lock_audio_in, flags);
+	spin_lock_irqsave(&line6pcm->in.lock, flags);
 
 	for (i = 0; i < LINE6_ISO_PACKETS; ++i) {
 		char *fbuf;
@@ -249,12 +249,12 @@ static void audio_in_callback(struct urb *urb)
 				line6_capture_copy(line6pcm, fbuf, fsize);
 	}
 
-	clear_bit(index, &line6pcm->active_urb_in);
+	clear_bit(index, &line6pcm->in.active_urbs);
 
-	if (test_and_clear_bit(index, &line6pcm->unlink_urb_in))
+	if (test_and_clear_bit(index, &line6pcm->in.unlink_urbs))
 		shutdown = 1;
 
-	spin_unlock_irqrestore(&line6pcm->lock_audio_in, flags);
+	spin_unlock_irqrestore(&line6pcm->in.lock, flags);
 
 	if (!shutdown) {
 		submit_audio_in_urb(line6pcm);
@@ -309,7 +309,7 @@ static int snd_line6_capture_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	line6pcm->period_in = params_period_bytes(hw_params);
+	line6pcm->in.period = params_period_bytes(hw_params);
 	return 0;
 }
 
@@ -361,7 +361,7 @@ snd_line6_capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 
-	return line6pcm->pos_in_done;
+	return line6pcm->in.pos_done;
 }
 
 /* capture operators */
@@ -386,7 +386,7 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		struct urb *urb;
 
 		/* URB for audio in: */
-		urb = line6pcm->urb_audio_in[i] =
+		urb = line6pcm->in.urbs[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
 		if (urb == NULL)
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 43474c4ebb6b..738bfd82cecd 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -112,11 +112,11 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_BUFFER)) {
 		/* Invoked multiple times in a row so allocate once only */
-		if (!line6pcm->buffer_in) {
-			line6pcm->buffer_in =
+		if (!line6pcm->in.buffer) {
+			line6pcm->in.buffer =
 				kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
 					line6pcm->max_packet_size, GFP_KERNEL);
-			if (!line6pcm->buffer_in) {
+			if (!line6pcm->in.buffer) {
 				err = -ENOMEM;
 				goto pcm_acquire_error;
 			}
@@ -131,13 +131,13 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		   a bug, we therefore report an error if capturing is restarted
 		   too soon.
 		 */
-		if (line6pcm->active_urb_in || line6pcm->unlink_urb_in) {
+		if (line6pcm->in.active_urbs || line6pcm->in.unlink_urbs) {
 			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
 			err = -EBUSY;
 			goto pcm_acquire_error;
 		}
 
-		line6pcm->count_in = 0;
+		line6pcm->in.count = 0;
 		line6pcm->prev_fsize = 0;
 		err = line6_submit_audio_in_all_urbs(line6pcm);
 
@@ -149,11 +149,11 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_PLAYBACK_BUFFER)) {
 		/* Invoked multiple times in a row so allocate once only */
-		if (!line6pcm->buffer_out) {
-			line6pcm->buffer_out =
+		if (!line6pcm->out.buffer) {
+			line6pcm->out.buffer =
 				kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
 					line6pcm->max_packet_size, GFP_KERNEL);
-			if (!line6pcm->buffer_out) {
+			if (!line6pcm->out.buffer) {
 				err = -ENOMEM;
 				goto pcm_acquire_error;
 			}
@@ -166,12 +166,12 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		/*
 		  See comment above regarding PCM restart.
 		*/
-		if (line6pcm->active_urb_out || line6pcm->unlink_urb_out) {
+		if (line6pcm->out.active_urbs || line6pcm->out.unlink_urbs) {
 			dev_err(line6pcm->line6->ifcdev, "Device not yet ready\n");
 			return -EBUSY;
 		}
 
-		line6pcm->count_out = 0;
+		line6pcm->out.count = 0;
 		err = line6_submit_audio_out_all_urbs(line6pcm);
 
 		if (err < 0)
@@ -331,13 +331,13 @@ static void line6_cleanup_pcm(struct snd_pcm *pcm)
 	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
 
 	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (line6pcm->urb_audio_out[i]) {
-			usb_kill_urb(line6pcm->urb_audio_out[i]);
-			usb_free_urb(line6pcm->urb_audio_out[i]);
+		if (line6pcm->out.urbs[i]) {
+			usb_kill_urb(line6pcm->out.urbs[i]);
+			usb_free_urb(line6pcm->out.urbs[i]);
 		}
-		if (line6pcm->urb_audio_in[i]) {
-			usb_kill_urb(line6pcm->urb_audio_in[i]);
-			usb_free_urb(line6pcm->urb_audio_in[i]);
+		if (line6pcm->in.urbs[i]) {
+			usb_kill_urb(line6pcm->in.urbs[i]);
+			usb_free_urb(line6pcm->in.urbs[i]);
 		}
 	}
 	kfree(line6pcm);
@@ -415,8 +415,8 @@ int line6_init_pcm(struct usb_line6 *line6,
 			usb_maxpacket(line6->usbdev,
 				usb_sndisocpipe(line6->usbdev, ep_write), 1));
 
-	spin_lock_init(&line6pcm->lock_audio_out);
-	spin_lock_init(&line6pcm->lock_audio_in);
+	spin_lock_init(&line6pcm->out.lock);
+	spin_lock_init(&line6pcm->in.lock);
 	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
 
 	line6->line6pcm = line6pcm;
@@ -464,13 +464,13 @@ int snd_line6_prepare(struct snd_pcm_substream *substream)
 	}
 
 	if (!test_and_set_bit(LINE6_INDEX_PREPARED, &line6pcm->flags)) {
-		line6pcm->count_out = 0;
-		line6pcm->pos_out = 0;
-		line6pcm->pos_out_done = 0;
-		line6pcm->bytes_out = 0;
-		line6pcm->count_in = 0;
-		line6pcm->pos_in_done = 0;
-		line6pcm->bytes_in = 0;
+		line6pcm->out.count = 0;
+		line6pcm->out.pos = 0;
+		line6pcm->out.pos_done = 0;
+		line6pcm->out.bytes = 0;
+		line6pcm->in.count = 0;
+		line6pcm->in.pos_done = 0;
+		line6pcm->in.bytes = 0;
 	}
 
 	return 0;
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index a84753ee0fa2..4c74f4e85074 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -165,115 +165,78 @@ struct line6_pcm_properties {
 	int bytes_per_frame;
 };
 
-struct snd_line6_pcm {
-	/**
-		 Pointer back to the Line 6 driver data structure.
-	*/
-	struct usb_line6 *line6;
+struct line6_pcm_stream {
+	/* allocated URBs */
+	struct urb *urbs[LINE6_ISO_BUFFERS];
 
-	/**
-		 Properties.
-	*/
-	struct line6_pcm_properties *properties;
+	/* Temporary buffer;
+	 * Since the packet size is not known in advance, this buffer is
+	 * large enough to store maximum size packets.
+	 */
+	unsigned char *buffer;
 
-	/**
-		 ALSA pcm stream
-	*/
-	struct snd_pcm *pcm;
+	/* Free frame position in the buffer. */
+	snd_pcm_uframes_t pos;
 
-	/**
-		 URBs for audio playback.
-	*/
-	struct urb *urb_audio_out[LINE6_ISO_BUFFERS];
+	/* Count processed bytes;
+	 * This is modulo period size (to determine when a period is finished).
+	 */
+	unsigned bytes;
 
-	/**
-		 URBs for audio capture.
-	*/
-	struct urb *urb_audio_in[LINE6_ISO_BUFFERS];
+	/* Counter to create desired sample rate */
+	unsigned count;
 
-	/**
-		 Temporary buffer for playback.
-		 Since the packet size is not known in advance, this buffer is
-		 large enough to store maximum size packets.
-	*/
-	unsigned char *buffer_out;
+	/* period size in bytes */
+	unsigned period;
 
-	/**
-		 Temporary buffer for capture.
-		 Since the packet size is not known in advance, this buffer is
-		 large enough to store maximum size packets.
-	*/
-	unsigned char *buffer_in;
+	/* Processed frame position in the buffer;
+	 * The contents of the ring buffer have been consumed by the USB
+	 * subsystem (i.e., sent to the USB device) up to this position.
+	 */
+	snd_pcm_uframes_t pos_done;
 
-	/**
-		 Previously captured frame (for software monitoring).
-	*/
-	unsigned char *prev_fbuf;
+	/* Bit mask of active URBs */
+	unsigned long active_urbs;
 
-	/**
-		 Size of previously captured frame (for software monitoring).
-	*/
-	int prev_fsize;
-
-	/**
-		 Free frame position in the playback buffer.
-	*/
-	snd_pcm_uframes_t pos_out;
+	/* Bit mask of URBs currently being unlinked */
+	unsigned long unlink_urbs;
 
-	/**
-		 Count processed bytes for playback.
-		 This is modulo period size (to determine when a period is
-		 finished).
-	*/
-	unsigned bytes_out;
+	/* Spin lock to protect updates of the buffer positions (not contents)
+	 */
+	spinlock_t lock;
 
-	/**
-		 Counter to create desired playback sample rate.
-	*/
-	unsigned count_out;
-
-	/**
-		 Playback period size in bytes
-	*/
-	unsigned period_out;
+	int last_frame;
+};
 
+struct snd_line6_pcm {
 	/**
-		 Processed frame position in the playback buffer.
-		 The contents of the output ring buffer have been consumed by
-		 the USB subsystem (i.e., sent to the USB device) up to this
-		 position.
+		 Pointer back to the Line 6 driver data structure.
 	*/
-	snd_pcm_uframes_t pos_out_done;
+	struct usb_line6 *line6;
 
 	/**
-		 Count processed bytes for capture.
-		 This is modulo period size (to determine when a period is
-		 finished).
+		 Properties.
 	*/
-	unsigned bytes_in;
+	struct line6_pcm_properties *properties;
 
 	/**
-		 Counter to create desired capture sample rate.
+		 ALSA pcm stream
 	*/
-	unsigned count_in;
+	struct snd_pcm *pcm;
 
-	/**
-		 Capture period size in bytes
-	*/
-	unsigned period_in;
+	/* Capture and playback streams */
+	struct line6_pcm_stream in;
+	struct line6_pcm_stream out;
 
 	/**
-		 Processed frame position in the capture buffer.
-		 The contents of the output ring buffer have been consumed by
-		 the USB subsystem (i.e., sent to the USB device) up to this
-		 position.
+		 Previously captured frame (for software monitoring).
 	*/
-	snd_pcm_uframes_t pos_in_done;
+	unsigned char *prev_fbuf;
 
 	/**
-		 Bit mask of active playback URBs.
+		 Size of previously captured frame (for software monitoring).
 	*/
-	unsigned long active_urb_out;
+	int prev_fsize;
 
 	/**
 		 Maximum size of USB packet.
@@ -281,33 +244,6 @@ struct snd_line6_pcm {
 	int max_packet_size;
 
 	/**
-		 Bit mask of active capture URBs.
-	*/
-	unsigned long active_urb_in;
-
-	/**
-		 Bit mask of playback URBs currently being unlinked.
-	*/
-	unsigned long unlink_urb_out;
-
-	/**
-		 Bit mask of capture URBs currently being unlinked.
-	*/
-	unsigned long unlink_urb_in;
-
-	/**
-		 Spin lock to protect updates of the playback buffer positions (not
-		 contents!)
-	*/
-	spinlock_t lock_audio_out;
-
-	/**
-		 Spin lock to protect updates of the capture buffer positions (not
-		 contents!)
-	*/
-	spinlock_t lock_audio_in;
-
-	/**
 		 PCM playback volume (left and right).
 	*/
 	int volume_playback[2];
@@ -336,8 +272,6 @@ struct snd_line6_pcm {
 		 Several status bits (see LINE6_BIT_*).
 	*/
 	unsigned long flags;
-
-	int last_frame_in, last_frame_out;
 };
 
 extern int line6_init_pcm(struct usb_line6 *line6,
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 7e031b1761aa..d619c1718306 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -145,17 +145,17 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	    (USB_INTERVALS_PER_SECOND / LINE6_ISO_INTERVAL);
 	struct urb *urb_out;
 
-	spin_lock_irqsave(&line6pcm->lock_audio_out, flags);
+	spin_lock_irqsave(&line6pcm->out.lock, flags);
 	index =
-	    find_first_zero_bit(&line6pcm->active_urb_out, LINE6_ISO_BUFFERS);
+	    find_first_zero_bit(&line6pcm->out.active_urbs, LINE6_ISO_BUFFERS);
 
 	if (index < 0 || index >= LINE6_ISO_BUFFERS) {
-		spin_unlock_irqrestore(&line6pcm->lock_audio_out, flags);
+		spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "no free URB found\n");
 		return -EINVAL;
 	}
 
-	urb_out = line6pcm->urb_audio_out[index];
+	urb_out = line6pcm->out.urbs[index];
 	urb_size = 0;
 
 	for (i = 0; i < LINE6_ISO_PACKETS; ++i) {
@@ -170,9 +170,9 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		if (fsize == 0) {
 			int n;
 
-			line6pcm->count_out += frame_increment;
-			n = line6pcm->count_out / frame_factor;
-			line6pcm->count_out -= n * frame_factor;
+			line6pcm->out.count += frame_increment;
+			n = line6pcm->out.count / frame_factor;
+			line6pcm->out.count -= n * frame_factor;
 			fsize = n * bytes_per_frame;
 		}
 
@@ -183,14 +183,14 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 
 	if (urb_size == 0) {
 		/* can't determine URB size */
-		spin_unlock_irqrestore(&line6pcm->lock_audio_out, flags);
+		spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 		dev_err(line6pcm->line6->ifcdev, "driver bug: urb_size = 0\n");
 		return -EINVAL;
 	}
 
 	urb_frames = urb_size / bytes_per_frame;
 	urb_out->transfer_buffer =
-	    line6pcm->buffer_out +
+	    line6pcm->out.buffer +
 	    index * LINE6_ISO_PACKETS * line6pcm->max_packet_size;
 	urb_out->transfer_buffer_length = urb_size;
 	urb_out->context = line6pcm;
@@ -200,19 +200,19 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		struct snd_pcm_runtime *runtime =
 		    get_substream(line6pcm, SNDRV_PCM_STREAM_PLAYBACK)->runtime;
 
-		if (line6pcm->pos_out + urb_frames > runtime->buffer_size) {
+		if (line6pcm->out.pos + urb_frames > runtime->buffer_size) {
 			/*
 			   The transferred area goes over buffer boundary,
 			   copy the data to the temp buffer.
 			 */
 			int len;
 
-			len = runtime->buffer_size - line6pcm->pos_out;
+			len = runtime->buffer_size - line6pcm->out.pos;
 
 			if (len > 0) {
 				memcpy(urb_out->transfer_buffer,
 				       runtime->dma_area +
-				       line6pcm->pos_out * bytes_per_frame,
+				       line6pcm->out.pos * bytes_per_frame,
 				       len * bytes_per_frame);
 				memcpy(urb_out->transfer_buffer +
 				       len * bytes_per_frame, runtime->dma_area,
@@ -223,13 +223,13 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		} else {
 			memcpy(urb_out->transfer_buffer,
 			       runtime->dma_area +
-			       line6pcm->pos_out * bytes_per_frame,
+			       line6pcm->out.pos * bytes_per_frame,
 			       urb_out->transfer_buffer_length);
 		}
 
-		line6pcm->pos_out += urb_frames;
-		if (line6pcm->pos_out >= runtime->buffer_size)
-			line6pcm->pos_out -= runtime->buffer_size;
+		line6pcm->out.pos += urb_frames;
+		if (line6pcm->out.pos >= runtime->buffer_size)
+			line6pcm->out.pos -= runtime->buffer_size;
 	} else {
 		memset(urb_out->transfer_buffer, 0,
 		       urb_out->transfer_buffer_length);
@@ -265,12 +265,12 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 	ret = usb_submit_urb(urb_out, GFP_ATOMIC);
 
 	if (ret == 0)
-		set_bit(index, &line6pcm->active_urb_out);
+		set_bit(index, &line6pcm->out.active_urbs);
 	else
 		dev_err(line6pcm->line6->ifcdev,
 			"URB out #%d submission failed (%d)\n", index, ret);
 
-	spin_unlock_irqrestore(&line6pcm->lock_audio_out, flags);
+	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 	return 0;
 }
 
@@ -298,9 +298,9 @@ void line6_unlink_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 	unsigned int i;
 
 	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (test_bit(i, &line6pcm->active_urb_out)) {
-			if (!test_and_set_bit(i, &line6pcm->unlink_urb_out)) {
-				struct urb *u = line6pcm->urb_audio_out[i];
+		if (test_bit(i, &line6pcm->out.active_urbs)) {
+			if (!test_and_set_bit(i, &line6pcm->out.unlink_urbs)) {
+				struct urb *u = line6pcm->out.urbs[i];
 
 				usb_unlink_urb(u);
 			}
@@ -321,7 +321,7 @@ void line6_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 	do {
 		alive = 0;
 		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-			if (test_bit(i, &line6pcm->active_urb_out))
+			if (test_bit(i, &line6pcm->out.active_urbs))
 				alive++;
 		}
 		if (!alive)
@@ -344,8 +344,8 @@ void line6_unlink_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 
 void line6_free_playback_buffer(struct snd_line6_pcm *line6pcm)
 {
-	kfree(line6pcm->buffer_out);
-	line6pcm->buffer_out = NULL;
+	kfree(line6pcm->out.buffer);
+	line6pcm->out.buffer = NULL;
 }
 
 /*
@@ -363,11 +363,11 @@ static void audio_out_callback(struct urb *urb)
 	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
 #endif
 
-	line6pcm->last_frame_out = urb->start_frame;
+	line6pcm->out.last_frame = urb->start_frame;
 
 	/* find index of URB */
 	for (index = 0; index < LINE6_ISO_BUFFERS; index++)
-		if (urb == line6pcm->urb_audio_out[index])
+		if (urb == line6pcm->out.urbs[index])
 			break;
 
 	if (index >= LINE6_ISO_BUFFERS)
@@ -376,19 +376,19 @@ static void audio_out_callback(struct urb *urb)
 	for (i = 0; i < LINE6_ISO_PACKETS; i++)
 		length += urb->iso_frame_desc[i].length;
 
-	spin_lock_irqsave(&line6pcm->lock_audio_out, flags);
+	spin_lock_irqsave(&line6pcm->out.lock, flags);
 
 	if (test_bit(LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM, &line6pcm->flags)) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 
-		line6pcm->pos_out_done +=
+		line6pcm->out.pos_done +=
 		    length / line6pcm->properties->bytes_per_frame;
 
-		if (line6pcm->pos_out_done >= runtime->buffer_size)
-			line6pcm->pos_out_done -= runtime->buffer_size;
+		if (line6pcm->out.pos_done >= runtime->buffer_size)
+			line6pcm->out.pos_done -= runtime->buffer_size;
 	}
 
-	clear_bit(index, &line6pcm->active_urb_out);
+	clear_bit(index, &line6pcm->out.active_urbs);
 
 	for (i = 0; i < LINE6_ISO_PACKETS; i++)
 		if (urb->iso_frame_desc[i].status == -EXDEV) {
@@ -396,19 +396,19 @@ static void audio_out_callback(struct urb *urb)
 			break;
 		}
 
-	if (test_and_clear_bit(index, &line6pcm->unlink_urb_out))
+	if (test_and_clear_bit(index, &line6pcm->out.unlink_urbs))
 		shutdown = 1;
 
-	spin_unlock_irqrestore(&line6pcm->lock_audio_out, flags);
+	spin_unlock_irqrestore(&line6pcm->out.lock, flags);
 
 	if (!shutdown) {
 		submit_audio_out_urb(line6pcm);
 
 		if (test_bit(LINE6_INDEX_PCM_ALSA_PLAYBACK_STREAM,
 			     &line6pcm->flags)) {
-			line6pcm->bytes_out += length;
-			if (line6pcm->bytes_out >= line6pcm->period_out) {
-				line6pcm->bytes_out %= line6pcm->period_out;
+			line6pcm->out.bytes += length;
+			if (line6pcm->out.bytes >= line6pcm->out.period) {
+				line6pcm->out.bytes %= line6pcm->out.period;
 				snd_pcm_period_elapsed(substream);
 			}
 		}
@@ -457,7 +457,7 @@ static int snd_line6_playback_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	line6pcm->period_out = params_period_bytes(hw_params);
+	line6pcm->out.period = params_period_bytes(hw_params);
 	return 0;
 }
 
@@ -517,7 +517,7 @@ snd_line6_playback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_line6_pcm *line6pcm = snd_pcm_substream_chip(substream);
 
-	return line6pcm->pos_out_done;
+	return line6pcm->out.pos_done;
 }
 
 /* playback operators */
@@ -542,7 +542,7 @@ int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 		struct urb *urb;
 
 		/* URB for audio out: */
-		urb = line6pcm->urb_audio_out[i] =
+		urb = line6pcm->out.urbs[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
 		if (urb == NULL)
-- 
2.2.2
