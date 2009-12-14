From: John S Gruber <johnsgruber@gmail.com>
Subject: [PATCH - usb/usbaudio.c 1/1] sound/usb: Relax urb data
	align. restriction for HVR-950Q and HVR-850 only
Date: Sun, 13 Dec 2009 19:51:01 -0500
Message-ID: <44c6f3de0912131651y7fc6a0el4d3c9f20cb18873b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Addressing audio quality problem.

In sound/usb/usbaudio.c, for the Hauppage HVR-950Q only, change
retire_capture_urb to copy the entire byte stream while still counting
entire audio frames. urbs unaligned on channel sample boundaries are
still truncated to the next lowest stride (audio slot) size to try to
retain channel alignment in cases of data loss over usb.

With the HVR950Q the left and right channel samples can be split between
two different urbs. Throwing away extra channel samples causes a sound
quality problem for stereo streams as the left and right channels are
swapped repeatedly.

BugLink: https://bugs.launchpad.net/ubuntu/+bug/495745

Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
---
 usb/usbaudio.c |   53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/usb/usbaudio.c b/usb/usbaudio.c
index b074a59..d450b23 100644
--- a/usb/usbaudio.c
+++ b/usb/usbaudio.c
@@ -108,6 +108,7 @@ MODULE_PARM_DESC(ignore_ctl_error,
 #define MAX_URBS	8
 #define SYNC_URBS	4	/* always four urbs for sync */
 #define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
+#define ALLOW_SUBSLOT_BOUNDARIES 0x01	/* quirk */

 struct audioformat {
 	struct list_head list;
@@ -127,6 +128,7 @@ struct audioformat {
 	unsigned int rate_min, rate_max;	/* min/max rates */
 	unsigned int nr_rates;		/* number of rate table entries */
 	unsigned int *rate_table;	/* rate table */
+	unsigned int txfr_quirks;	/* transfer quirks */
 };

 struct snd_usb_substream;
@@ -175,6 +177,8 @@ struct snd_usb_substream {
 	unsigned int running: 1;	/* running status */

 	unsigned int hwptr_done;			/* processed frame position in the buffer */
+	unsigned int byteptr;		/* position, in bytes, of next move */
+	unsigned int txfr_quirks;		/* substream transfer quirks */
 	unsigned int transfer_done;		/* processed frames since last period update */
 	unsigned long active_mask;	/* bitmask of active urbs */
 	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
@@ -343,7 +347,7 @@ static int retire_capture_urb(struct
snd_usb_substream *subs,
 	unsigned long flags;
 	unsigned char *cp;
 	int i;
-	unsigned int stride, len, oldptr;
+	unsigned int stride, len, bytelen, oldbyteptr;
 	int period_elapsed = 0;

 	stride = runtime->frame_bits >> 3;
@@ -354,29 +358,39 @@ static int retire_capture_urb(struct
snd_usb_substream *subs,
 			snd_printd(KERN_ERR "frame %d active: %d\n", i,
urb->iso_frame_desc[i].status);
 			// continue;
 		}
-		len = urb->iso_frame_desc[i].actual_length / stride;
-		if (! len)
+		bytelen = (urb->iso_frame_desc[i].actual_length);
+		if (!bytelen)
 			continue;
+		if (bytelen%(runtime->sample_bits>>3) != 0) {
+			int oldbytelen = bytelen;
+			bytelen = ((bytelen/stride)*stride);
+			snd_printd(KERN_ERR "Corrected urb data len. %d->%d\n",
+				oldbytelen, bytelen);
+		}
+		if (!(subs->txfr_quirks & ALLOW_SUBSLOT_BOUNDARIES))
+			bytelen = (bytelen/stride)*stride;
 		/* update the current pointer */
 		spin_lock_irqsave(&subs->lock, flags);
-		oldptr = subs->hwptr_done;
-		subs->hwptr_done += len;
-		if (subs->hwptr_done >= runtime->buffer_size)
-			subs->hwptr_done -= runtime->buffer_size;
+		len = (bytelen + (subs->byteptr % stride)) / stride;
 		subs->transfer_done += len;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
 			period_elapsed = 1;
 		}
+		oldbyteptr = subs->byteptr;
+		subs->byteptr += bytelen;
+		if (subs->byteptr >= runtime->buffer_size*stride)
+			subs->byteptr -= runtime->buffer_size*stride;
+		subs->hwptr_done = subs->byteptr/stride;
 		spin_unlock_irqrestore(&subs->lock, flags);
 		/* copy a data chunk */
-		if (oldptr + len > runtime->buffer_size) {
-			unsigned int cnt = runtime->buffer_size - oldptr;
-			unsigned int blen = cnt * stride;
-			memcpy(runtime->dma_area + oldptr * stride, cp, blen);
-			memcpy(runtime->dma_area, cp + blen, len * stride - blen);
+		if ((oldbyteptr +  bytelen) > (runtime->buffer_size*stride)) {
+			unsigned int blen;
+			blen = (runtime->buffer_size*stride) - oldbyteptr;
+			memcpy(runtime->dma_area + oldbyteptr, cp, blen);
+			memcpy(runtime->dma_area, cp + blen,  bytelen - blen);
 		} else {
-			memcpy(runtime->dma_area + oldptr * stride, cp, len * stride);
+			memcpy(runtime->dma_area + oldbyteptr, cp, bytelen);
 		}
 	}
 	if (period_elapsed)
@@ -1363,6 +1377,7 @@ static int set_format(struct snd_usb_substream
*subs, struct audioformat *fmt)
 	subs->syncpipe = subs->syncinterval = 0;
 	subs->maxpacksize = fmt->maxpacksize;
 	subs->fill_max = 0;
+	subs->txfr_quirks = fmt->txfr_quirks;

 	/* we need a sync pipe in async OUT or adaptive IN mode */
 	/* check the number of EP, since some devices have broken
@@ -1532,6 +1547,7 @@ static int snd_usb_pcm_prepare(struct
snd_pcm_substream *substream)
 	/* reset the pointer */
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
+	subs->byteptr = 0;
 	subs->phase = 0;
 	runtime->delay = 0;

@@ -2776,6 +2792,7 @@ static int parse_audio_endpoints(struct
snd_usb_audio *chip, int iface_no)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
 					* (fp->maxpacksize & 0x7ff);
 		fp->attributes = csep ? csep[3] : 0;
+		fp->txfr_quirks = 0;

 		/* some quirks for attributes here */

@@ -2804,6 +2821,16 @@ static int parse_audio_endpoints(struct
snd_usb_audio *chip, int iface_no)
 			else
 				fp->ep_attr |= EP_ATTR_SYNC;
 			break;
+		case USB_ID(0x2040, 0x7200): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7221): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7222): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7223): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7224): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7225): /* Hauppage hvr950Q */
+		case USB_ID(0x2040, 0x7230): /* Hauppage hvr850 */
+		case USB_ID(0x2040, 0x7250): /* Hauppage hvr950Q */
+			fp->txfr_quirks |= ALLOW_SUBSLOT_BOUNDARIES;
+			break;
 		}

 		/* ok, let's parse further... */
-- 
1.6.3.3

I'm new to changing the kernel.

Normally the driver should transfer only whole audio frames,
disregarding fragments, in order to keep channel and sample
synchronization in the face of data loss on the bus. That's how the
current driver works.

The patch relaxes this (only) for devices with the quirk.

An earlier version of this patch was posted recently to the
linux-media list. No one there suggested a way to make the au0828 chip
in this equipment behave better. They kindly forwarded me to this
mailing list for review and consideration of the patch.

To test the patch with a non-quirk device run it on a busy or
problematic bus and listen for audio switching channels. To test with
a HVR-950Q use composite input and disconnect either the left or right
channel. Without the patch the audio will alternate between channels
quickly, most easily heard with headphones or earphones, producing a
flutter sound, With the patch the remaining test audio channel appears
only on one channel and is steady.
