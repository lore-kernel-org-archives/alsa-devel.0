From: johnsgruber@gmail.com
Subject: [PATCH 2/3] sound: usb-audio: relax urb data align.
	restriction HVR-950Q and HVR-850 only
Date: Sun, 27 Dec 2009 12:19:58 -0500
Message-ID: <4b379785.9453f10a.5e00.ffffcc0a@mx.google.com>
References: <s5hy6krtc1r.wl%tiwai@suse.de>
	<1261934399-2820-1-git-send-email-me>
	<1261934399-2820-2-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1261934399-2820-2-git-send-email-me>
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
Cc: patch@alsa-project.org, "John S. Gruber" <JohnSGruber@gmail.com>, johnsgruber@gmail.com
List-Id: alsa-devel@alsa-project.org

From: John S. Gruber <JohnSGruber@gmail.com>

Addressing audio quality problem.

In sound/usb/usbaudio.c, for the Hauppage HVR-950Q and HVR-850 only, change
retire_capture_urb to allow transfers on audio sub-slot boundaries rather
than audio slots boundaries.

With these devices the left and right channel samples can be split between
two different urbs. Throwing away extra channel samples causes a sound
quality problem for stereo streams as the left and right channels are
swapped repeatedly, perhaps many times per second.

Urbs unaligned on sub-slot boundaries are still truncated to the next
lowest stride (audio slot) to retain synchronization on samples even
though left/right channel synchronization may be lost in this case.

Detect the quirk using a case statement in snd_usb_audio_probe.

BugLink: https://bugs.launchpad.net/ubuntu/+bug/495745

Signed-off-by: John S. Gruber <JohnSGruber@gmail.com>
---
 sound/usb/usbaudio.c |   29 +++++++++++++++++++++++++++--
 sound/usb/usbaudio.h |    1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 1ba8f41..be6f017 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -169,6 +169,7 @@ struct snd_usb_substream {
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;	/* current packet size in frames (for capture) */
 	unsigned int fill_max: 1;	/* fill max packet size always */
+	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 
 	unsigned int running: 1;	/* running status */
@@ -353,14 +354,23 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
 			snd_printd(KERN_ERR "frame %d active: %d\n", i, urb->iso_frame_desc[i].status);
 			// continue;
 		}
-		frames = urb->iso_frame_desc[i].actual_length / stride;
-		bytes = frames * stride;
+		bytes = urb->iso_frame_desc[i].actual_length;
+		frames = bytes / stride;
+		if (!subs->txfr_quirk)
+			bytes = frames * stride;
+		if (bytes % (runtime->sample_bits >> 3) != 0) {
+			int oldbytes = bytes;
+			bytes = frames * stride;
+			snd_printdd(KERN_ERR "Corrected urb data len. %d->%d\n",
+							oldbytes, bytes);
+		}
 		/* update the current pointer */
 		spin_lock_irqsave(&subs->lock, flags);
 		oldptr = subs->hwptr_done;
 		subs->hwptr_done += bytes;
 		if (subs->hwptr_done >= runtime->buffer_size * stride)
 			subs->hwptr_done -= runtime->buffer_size * stride;
+		frames = (bytes + (oldptr % stride)) / stride;
 		subs->transfer_done += frames;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
@@ -2189,6 +2199,7 @@ static void init_substream(struct snd_usb_stream *as, int stream, struct audiofo
 	subs->stream = as;
 	subs->direction = stream;
 	subs->dev = as->chip->dev;
+	subs->txfr_quirk = as->chip->txfr_quirk;
 	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL) {
 		subs->ops = audio_urb_ops[stream];
 	} else {
@@ -3569,6 +3580,20 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
 		}
 	}
 
+	switch (chip->usb_id) {
+	case USB_ID(0x2040, 0x7200): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7221): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7222): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7223): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7224): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7225): /* Hauppage hvr950Q */
+	case USB_ID(0x2040, 0x7230): /* Hauppage hvr850 */
+	case USB_ID(0x2040, 0x7250): /* Hauppage hvr950Q */
+		chip->txfr_quirk = 1;
+		break;
+	default:
+		chip->txfr_quirk = 0;
+		}
 	err = 1; /* continue */
 	if (quirk && quirk->ifnum != QUIRK_NO_INTERFACE) {
 		/* need some special handlings */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 9826337..228da06 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -125,6 +125,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	u32 usb_id;
 	int shutdown;
+	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	int num_interfaces;
 	int num_suspended_intf;
 
-- 
1.6.3.3
