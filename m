From: johnsgruber@gmail.com
Subject: [PATCH 1/3] sound: usb-audio: make buffer pointer
	based on bytes instead on frames
Date: Sun, 27 Dec 2009 12:19:57 -0500
Message-ID: <4b37976c.9553f10a.501c.ffffd144@mx.google.com>
References: <s5hy6krtc1r.wl%tiwai@suse.de>
	<1261934399-2820-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1261934399-2820-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patch@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, johnsgruber@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Clemens Ladisch <clemens@ladisch.de>

Since there are devices that do not align the size of their data packets
to frame boundaries, the driver needs to be able to keep track of
partial frames.  This patch prepares for support for such devices by
changing the hwptr_done variable from a frame counter to a byte counter.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/usbaudio.c |   76 ++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 39 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 31b63ea..1ba8f41 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -173,7 +173,7 @@ struct snd_usb_substream {
 
 	unsigned int running: 1;	/* running status */
 
-	unsigned int hwptr_done;			/* processed frame position in the buffer */
+	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;		/* processed frames since last period update */
 	unsigned long active_mask;	/* bitmask of active urbs */
 	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
@@ -342,7 +342,7 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
 	unsigned long flags;
 	unsigned char *cp;
 	int i;
-	unsigned int stride, len, oldptr;
+	unsigned int stride, frames, bytes, oldptr;
 	int period_elapsed = 0;
 
 	stride = runtime->frame_bits >> 3;
@@ -353,29 +353,28 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
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
@@ -562,24 +561,24 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
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
@@ -589,7 +588,7 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 				if (subs->transfer_done > 0) {
 					/* FIXME: fill-max mode is not
 					 * supported yet */
-					offs -= subs->transfer_done;
+					frames -= subs->transfer_done;
 					counts -= subs->transfer_done;
 					urb->iso_frame_desc[i].length =
 						counts * stride;
@@ -599,7 +598,7 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 				if (i < ctx->packets) {
 					/* add a transfer delimiter */
 					urb->iso_frame_desc[i].offset =
-						offs * stride;
+						frames * stride;
 					urb->iso_frame_desc[i].length = 0;
 					urb->number_of_packets++;
 				}
@@ -609,26 +608,25 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
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
@@ -901,18 +899,18 @@ static int wait_clear_urbs(struct snd_usb_substream *subs)
 
 
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
 
 
-- 
1.6.3.3
