From: John S Gruber <johnsgruber@gmail.com>
Subject: Re: [PATCH - usb/usbaudio.c 1/1] sound/usb: Relax urb
	data align. restriction for HVR-950Q and HVR-850 only
Date: Wed, 23 Dec 2009 23:32:56 -0500
Message-ID: <44c6f3de0912232032x3b1291b7k1f50b78fed4957d0@mail.gmail.com>
References: <44c6f3de0912131651y7fc6a0el4d3c9f20cb18873b@mail.gmail.com>
	<4B28A659.6070303@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id DCD111037F9
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 05:33:20 +0100 (CET)
Received: by bwz9 with SMTP id 9so11842930bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 20:33:19 -0800 (PST)
In-Reply-To: <4B28A659.6070303@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

[PATCH 1/2] sound: usb-audio: relax urb data align. restriction
HVR-950Q and HVR-850 only

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
Clemens:

Thank you for your patch. It certainly makes my patch much more straightforward.

>USB packets are checksummed, so in case of data corruption, the entire
>packets would be dropped by the controller, so you'll never get partial
>samples.

>With your device, one lost packet could potentially corrupt the entire
>following stream.  There is no good error handling strategy for that.

You are certainly correct that a dropped packet corrupting the entire
stream. The misaligned packets occur about 1/40 - 1/80 packets, so
that's the odds that a dropped frame will cause the left and right channels
to swap. Much better than 12-24 channel swaps per second, though.

WRT checksum errors, during my last test I saw that the urb's with an odd
byte length coincided with the debugging message produced a few lines up:

Dec 21 22:52:54 gruber-laptop kernel: [178695.608453] ALSA
usbaudio.c:361: frame 0 active: -71
Dec 21 22:52:54 gruber-laptop kernel: [178695.608470] ALSA
usbaudio.c:372: Corrected urb data len. 191->188
Dec 21 22:53:25 gruber-laptop kernel: [178726.396561] ALSA
usbaudio.c:361: frame 0 active: -71
Dec 21 22:53:25 gruber-laptop kernel: [178726.396576] ALSA
usbaudio.c:372: Corrected urb data len. 191->188

While every odd byte length coincided with a -71 packet status (EPROTO?),
there also were -71 packet status messages appearing alone. At other times
there were uncorrelated -18 (-EXDEV?) messages too.

In usb/usbaudio.c retire_capture_urb() I note that the continue statement
that would drop these packets right after the snd_printd() is commented out.

Takashi:

>> +#define ALLOW_SUBSLOT_BOUNDARIES 0x01        /* quirk */

>If it's just a boolean flag, we don't need to use bits.
>Simply use a char flag or a bit-field flag instead of bit-and operation.

>>  struct audioformat {
>>       struct list_head list;
>> @@ -127,6 +128,7 @@ struct audioformat {
>>       unsigned int rate_min, rate_max;        /* min/max rates */
>>       unsigned int nr_rates;          /* number of rate table entries */
>>       unsigned int *rate_table;       /* rate table */
>> +     unsigned int txfr_quirks;       /* transfer quirks */

>I'm not sure whether this flag should belong to audiofmt.
>Isn't it rather controller-wide?  If so, it can be better fit to another,
>more global struct.

I've switched to using bit-field flags instead and moved the format
occurrance of the flag to the more general snd_usb_audio structure.
The flag is copied to the substream structure as an optimization,
of course.

>The rest are just trivial coding-style issues.  For example...

I'm sorry about the style problems. After reworking the patch I've looked again
for style problems and hope that I've found and fixed everything, but I'm new
at Linux kernel changes. I've run the patches through a recent version
checkpatch.pl
and I've tried to check them more thoroughly by hand, too.

>> +                     snd_printd(KERN_ERR "Corrected urb data len. %d->%d\n",
>> +                             oldbytelen, bytelen);

>Hm, how often would it be printed?  If it's really verbose, use
>snd_printdd() instead.

Although the debugging message is produced rather rarely with my device,
I don't know for sure that it won't occur more often on the 850 or other
950Q types. I've changed the snd_printd() to a snd_printdd() at
your suggestion.

*********

I don't know whether a case statement or a quirk in usbquirk.h is more
maintainable. I've added a second patch in case usbquirk.h is preferable. It
uses an unusual positive return code to indicate to the probe code that
processing should continue as normal.

Please review or ignore the second patch as deemed best.

The first patch follows immediately. The prerequisite is Clemens'
patch sound: "usb-audio:
make buffer pointer based on bytes instead on frames".

Thanks for your time and help.

John
---
 usb/usbaudio.c |   28 ++++++++++++++++++++++++++--
 usb/usbaudio.h |    1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/usb/usbaudio.c b/usb/usbaudio.c
index 6e93cb5..8618be2 100644
--- a/usb/usbaudio.c
+++ b/usb/usbaudio.c
@@ -170,6 +170,7 @@ struct snd_usb_substream {
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;	/* current packet size in frames (for capture) */
 	unsigned int fill_max: 1;	/* fill max packet size always */
+	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */

 	unsigned int running: 1;	/* running status */
@@ -354,8 +355,16 @@ static int retire_capture_urb(struct
snd_usb_substream *subs,
 			snd_printd(KERN_ERR "frame %d active: %d\n", i,
urb->iso_frame_desc[i].status);
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
@@ -2225,6 +2234,7 @@ static void init_substream(struct snd_usb_stream
*as, int stream, struct audiofo
 	subs->stream = as;
 	subs->direction = stream;
 	subs->dev = as->chip->dev;
+	subs->txfr_quirk = as->chip->txfr_quirk;
 	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL) {
 		subs->ops = audio_urb_ops[stream];
 	} else {
@@ -3659,6 +3669,20 @@ static void *snd_usb_audio_probe(struct usb_device *dev,
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
diff --git a/usb/usbaudio.h b/usb/usbaudio.h
index 40ba811..f48742d 100644
--- a/usb/usbaudio.h
+++ b/usb/usbaudio.h
@@ -125,6 +125,7 @@ struct snd_usb_audio {
 	struct snd_card *card;
 	u32 usb_id;
 	int shutdown;
+	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	int num_interfaces;
 	int num_suspended_intf;

-- 
1.6.3.3
