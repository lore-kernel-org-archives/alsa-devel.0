From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - usb/usbaudio.c 1/1] sound/usb: Relax urb
 data	align. restriction for HVR-950Q and HVR-850 only
Date: Wed, 16 Dec 2009 10:20:25 +0100
Message-ID: <4B28A659.6070303@ladisch.de>
References: <44c6f3de0912131651y7fc6a0el4d3c9f20cb18873b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4C6791037EE
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 10:20:31 +0100 (CET)
In-Reply-To: <44c6f3de0912131651y7fc6a0el4d3c9f20cb18873b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John S Gruber <johnsgruber@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John S Gruber wrote:
> In sound/usb/usbaudio.c, for the Hauppage HVR-950Q only, change
> retire_capture_urb to copy the entire byte stream while still counting
> entire audio frames.

Now we have two pointers, one for frames and one for bytes.  Since the
first can be computed from the second, it doesn't make much sense to
keep both around.

The patch below modifies the driver to use a byte-based buffer pointer.
Please rewrite your patch to apply on top on that patch.

> urbs unaligned on channel sample boundaries are
> still truncated to the next lowest stride (audio slot) size to try to
> retain channel alignment in cases of data loss over usb.

USB packets are checksummed, so in case of data corruption, the entire
packets would be dropped by the controller, so you'll never get partial
samples.

With your device, one lost packet could potentially corrupt the entire
following stream.  There is no good error handling strategy for that.


Best regards,
Clemens

==========

sound: usb-audio: make buffer pointer based on bytes instead on frames

Since there are devices that do not align the size of their data packets
to frame boundaries, the driver needs to be able to keep track of
partial frames.  This patch prepares for support for such devices by
changing the hwptr_done variable from a frame counter to a byte counter.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux/sound/usb/usbaudio.c
+++ linux/sound/usb/usbaudio.c
@@ -173,7 +173,7 @@ struct snd_usb_substream {
 
 	unsigned int running: 1;	/* running status */
 
-	unsigned int hwptr_done;			/* processed frame position in the buffer */
+	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;		/* processed frames since last period update */
 	unsigned long active_mask;	/* bitmask of active urbs */
 	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
@@ -342,7 +342,7 @@ static int retire_capture_urb(struct snd
 	unsigned long flags;
 	unsigned char *cp;
 	int i;
-	unsigned int stride, len, oldptr;
+	unsigned int stride, frames, bytes, oldptr;
 	int period_elapsed = 0;
 
 	stride = runtime->frame_bits >> 3;
@@ -353,29 +353,28 @@ static int retire_capture_urb(struct snd
 			snd_printd(KERN_ERR "frame %d active: %d\n", i, urb->iso_frame_desc[i].status);
 			// continue;
 		}
-		len = urb->iso_frame_desc[i].actual_length / stride;
-		if (! len)
-			continue;
+		frames = urb->iso_frame_desc[i].actual_length / stride;
+		bytes = frames * stride;
 		/* update the current pointer */
 		spin_lock_irqsave(&subs->lock, flags);
 		oldptr = subs->hwptr_done;
-		subs->hwptr_done += len;
-		if (subs->hwptr_done >= runtime->buffer_size)
-			subs->hwptr_done -= runtime->buffer_size;
-		subs->transfer_done += len;
+		subs->hwptr_done += bytes;
+		if (subs->hwptr_done >= runtime->buffer_size * stride)
+			subs->hwptr_done -= runtime->buffer_size * stride;
+		subs->transfer_done += frames;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
 			period_elapsed = 1;
 		}
 		spin_unlock_irqrestore(&subs->lock, flags);
 		/* copy a data chunk */
-		if (oldptr + len > runtime->buffer_size) {
-			unsigned int cnt = runtime->buffer_size - oldptr;
-			unsigned int blen = cnt * stride;
-			memcpy(runtime->dma_area + oldptr * stride, cp, blen);
-			memcpy(runtime->dma_area, cp + blen, len * stride - blen);
+		if (oldptr + bytes > runtime->buffer_size * stride) {
+			unsigned int bytes1 =
+					runtime->buffer_size * stride - oldptr;
+			memcpy(runtime->dma_area + oldptr, cp, bytes1);
+			memcpy(runtime->dma_area, cp + bytes1, bytes - bytes1);
 		} else {
-			memcpy(runtime->dma_area + oldptr * stride, cp, len * stride);
+			memcpy(runtime->dma_area + oldptr, cp, bytes);
 		}
 	}
 	if (period_elapsed)
@@ -562,24 +561,24 @@ static int prepare_playback_urb(struct s
 				struct snd_pcm_runtime *runtime,
 				struct urb *urb)
 {
-	int i, stride, offs;
-	unsigned int counts;
+	int i, stride;
+	unsigned int counts, frames, bytes;
 	unsigned long flags;
 	int period_elapsed = 0;
 	struct snd_urb_ctx *ctx = urb->context;
 
 	stride = runtime->frame_bits >> 3;
 
-	offs = 0;
+	frames = 0;
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
 	urb->number_of_packets = 0;
 	spin_lock_irqsave(&subs->lock, flags);
 	for (i = 0; i < ctx->packets; i++) {
 		counts = snd_usb_audio_next_packet_size(subs);
 		/* set up descriptor */
-		urb->iso_frame_desc[i].offset = offs * stride;
+		urb->iso_frame_desc[i].offset = frames * stride;
 		urb->iso_frame_desc[i].length = counts * stride;
-		offs += counts;
+		frames += counts;
 		urb->number_of_packets++;
 		subs->transfer_done += counts;
 		if (subs->transfer_done >= runtime->period_size) {
@@ -589,7 +588,7 @@ static int prepare_playback_urb(struct s
 				if (subs->transfer_done > 0) {
 					/* FIXME: fill-max mode is not
 					 * supported yet */
-					offs -= subs->transfer_done;
+					frames -= subs->transfer_done;
 					counts -= subs->transfer_done;
 					urb->iso_frame_desc[i].length =
 						counts * stride;
@@ -599,7 +598,7 @@ static int prepare_playback_urb(struct s
 				if (i < ctx->packets) {
 					/* add a transfer delimiter */
 					urb->iso_frame_desc[i].offset =
-						offs * stride;
+						frames * stride;
 					urb->iso_frame_desc[i].length = 0;
 					urb->number_of_packets++;
 				}
@@ -609,26 +608,25 @@ static int prepare_playback_urb(struct s
 		if (period_elapsed) /* finish at the period boundary */
 			break;
 	}
-	if (subs->hwptr_done + offs > runtime->buffer_size) {
+	bytes = frames * stride;
+	if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
 		/* err, the transferred area goes over buffer boundary. */
-		unsigned int len = runtime->buffer_size - subs->hwptr_done;
+		unsigned int bytes1 =
+			runtime->buffer_size * stride - subs->hwptr_done;
 		memcpy(urb->transfer_buffer,
-		       runtime->dma_area + subs->hwptr_done * stride,
-		       len * stride);
-		memcpy(urb->transfer_buffer + len * stride,
-		       runtime->dma_area,
-		       (offs - len) * stride);
+		       runtime->dma_area + subs->hwptr_done, bytes1);
+		memcpy(urb->transfer_buffer + bytes1,
+		       runtime->dma_area, bytes - bytes1);
 	} else {
 		memcpy(urb->transfer_buffer,
-		       runtime->dma_area + subs->hwptr_done * stride,
-		       offs * stride);
+		       runtime->dma_area + subs->hwptr_done, bytes);
 	}
-	subs->hwptr_done += offs;
-	if (subs->hwptr_done >= runtime->buffer_size)
-		subs->hwptr_done -= runtime->buffer_size;
-	runtime->delay += offs;
+	subs->hwptr_done += bytes;
+	if (subs->hwptr_done >= runtime->buffer_size * stride)
+		subs->hwptr_done -= runtime->buffer_size * stride;
+	runtime->delay += frames;
 	spin_unlock_irqrestore(&subs->lock, flags);
-	urb->transfer_buffer_length = offs * stride;
+	urb->transfer_buffer_length = bytes;
 	if (period_elapsed)
 		snd_pcm_period_elapsed(subs->pcm_substream);
 	return 0;
@@ -901,18 +899,18 @@ static int wait_clear_urbs(struct snd_us
 
 
 /*
- * return the current pcm pointer.  just return the hwptr_done value.
+ * return the current pcm pointer.  just based on the hwptr_done value.
  */
 static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_usb_substream *subs;
-	snd_pcm_uframes_t hwptr_done;
+	unsigned int hwptr_done;
 	
 	subs = (struct snd_usb_substream *)substream->runtime->private_data;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
 	spin_unlock(&subs->lock);
-	return hwptr_done;
+	return hwptr_done / (substream->runtime->frame_bits >> 3);
 }
