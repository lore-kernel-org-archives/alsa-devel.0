From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio devices
Date: Wed, 10 Mar 2004 09:26:27 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403091851500.4549-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403091823130.3966@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0403091823130.3966@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> On Tue, 9 Mar 2004, Takashi Iwai wrote:
>
> > BTW, the USB audio is another headache. the current ALSA PCM model isn't
> > perfectly suitable for the devices like USB audio.
>
> Unfortunately I don't see a better model.

Conceptually, USB devices have variable-sized periods.  The question
is whether we actually want to allow this in the API.  Probably not.

I have thought about forcing the period size to one ALSA frame (with
period_elapsed() calls at USB frame boundaries, like it's now).  In
theory, applications should be able to cope with this.

> I don't know much about USB 2.0,

Not too much differences for the driver.  The main difference is that
there are now 8000 microframes per second.  I have written a patch
(see below) and am about to test it.

> but I guess that 1.x compatibility issues brings another overhead
> to this extension which makes it also unuseable when 1.x devices
> are connected to same USB port.

There are some nasty contortions when a 1.x device is connected
through a 2.0 hub, but otherwise there is no overhead for 1.x devices
because logically (and electrically AFAIK) either the 2.0 or the 1.x
host controller device is connected to a specific port.


Regards,
Clemens

-- 
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.87
diff -u -r1.87 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	8 Mar 2004 09:29:51 -0000	1.87
+++ alsa-kernel/usb/usbaudio.c	8 Mar 2004 09:48:09 -0000
@@ -104,6 +104,7 @@
  */

 #define MAX_PACKS	10
+#define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
 #define MAX_URBS	5	/* max. 20ms long packets */
 #define SYNC_URBS	2	/* always two urbs for sync */
 #define MIN_PACKS_URB	1	/* minimum 1 packet per urb */
@@ -165,6 +166,8 @@
 	unsigned int freqm;      /* momentary sampling rate in USB format, i.e. fs/1000 in Q10.14 */
 	unsigned int freqmax;    /* maximum sampling rate, used for buffer management */
 	unsigned int phase;      /* phase accumulator */
+	unsigned int phase_shift;	/* fractional bits of phase */
+	unsigned int phase_mask;	/* (1 << phase_shift) - 1 */
 	unsigned int maxpacksize;	/* max packet size in bytes */
 	unsigned int maxframesize;	/* max packet size in frames */
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
@@ -250,7 +253,6 @@
 		cp[1] = subs->freqn >> 8;
 		cp[2] = subs->freqn >> 16;
 	}
-	urb->interval = 1;
 	return 0;
 }

@@ -301,7 +303,6 @@
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer = ctx->buf;
 	urb->transfer_buffer_length = offs;
-	urb->interval = 1;
 #if 0 // for check
 	if (! urb->bandwidth) {
 		int bustime;
@@ -390,7 +391,6 @@
 		urb->iso_frame_desc[i].length = 3;
 		urb->iso_frame_desc[i].offset = offs;
 	}
-	urb->interval = 1;
 	return 0;
 }

@@ -464,8 +464,8 @@
 		if (subs->fill_max)
 			counts = subs->maxframesize; /* fixed */
 		else {
-			subs->phase = (subs->phase & 0x3fff) + subs->freqm;
-			counts = subs->phase >> 14;
+			subs->phase = (subs->phase & subs->phase_mask) + subs->freqm;
+			counts = subs->phase >> subs->phase_shift;
 			if (counts > subs->maxframesize)
 				counts = subs->maxframesize;
 		}
@@ -515,7 +515,6 @@
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = offs * stride;
 	ctx->transfer = offs;
-	urb->interval = 1;

 	return 0;
 }
@@ -822,15 +821,22 @@
 {
 	unsigned int maxsize, n, i;
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
-	unsigned int npacks[MAX_URBS], total_packs;
+	unsigned int npacks[MAX_URBS], urb_packs, total_packs;

 	/* calculate the frequency in 10.14 format */
 	subs->freqn = subs->freqm = get_usb_rate(rate);
 	subs->freqmax = subs->freqn + (subs->freqn >> 2); /* max. allowed frequency */
 	subs->phase = 0;
+	if (subs->dev->speed == USB_SPEED_HIGH) {
+		subs->phase_shift = 11;
+		subs->phase_mask = 0x07ff;
+	} else {
+		subs->phase_shift = 14;
+		subs->phase_mask = 0x3fff;
+	}

 	/* calculate the max. size of packet */
-	maxsize = ((subs->freqmax + 0x3fff) * (frame_bits >> 3)) >> 14;
+	maxsize = ((subs->freqmax + subs->phase_mask) * (frame_bits >> 3)) >> subs->phase_shift;
 	if (subs->maxpacksize && maxsize > subs->maxpacksize) {
 		//snd_printd(KERN_DEBUG "maxsize %d is greater than defined size %d\n",
 		//	   maxsize, subs->maxpacksize);
@@ -842,9 +848,14 @@
 	else
 		subs->curpacksize = maxsize;

+	if (subs->dev->speed == USB_SPEED_HIGH)
+		urb_packs = nrpacks * 8;
+	else
+		urb_packs = nrpacks;
+
 	/* allocate a temporary buffer for playback */
 	if (is_playback) {
-		subs->tmpbuf = kmalloc(maxsize * nrpacks, GFP_KERNEL);
+		subs->tmpbuf = kmalloc(maxsize * urb_packs, GFP_KERNEL);
 		if (! subs->tmpbuf) {
 			snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
 			return -ENOMEM;
@@ -855,16 +866,16 @@
 	total_packs = (period_bytes + maxsize - 1) / maxsize;
 	if (total_packs < 2 * MIN_PACKS_URB)
 		total_packs = 2 * MIN_PACKS_URB;
-	subs->nurbs = (total_packs + nrpacks - 1) / nrpacks;
+	subs->nurbs = (total_packs + urb_packs - 1) / urb_packs;
 	if (subs->nurbs > MAX_URBS) {
 		/* too much... */
 		subs->nurbs = MAX_URBS;
-		total_packs = MAX_URBS * nrpacks;
+		total_packs = MAX_URBS * urb_packs;
 	}
 	n = total_packs;
 	for (i = 0; i < subs->nurbs; i++) {
-		npacks[i] = n > nrpacks ? nrpacks : n;
-		n -= nrpacks;
+		npacks[i] = n > urb_packs ? urb_packs : n;
+		n -= urb_packs;
 	}
 	if (subs->nurbs <= 1) {
 		/* too little - we need at least two packets
@@ -913,6 +924,7 @@
 		u->urb->pipe = subs->datapipe;
 		u->urb->transfer_flags = URB_ISO_ASAP;
 		u->urb->number_of_packets = u->packets;
+		u->urb->interval = 1;
 		u->urb->context = u;
 		u->urb->complete = snd_usb_complete_callback(snd_complete_urb);
 	}
@@ -935,6 +947,7 @@
 			u->urb->pipe = subs->syncpipe;
 			u->urb->transfer_flags = URB_ISO_ASAP;
 			u->urb->number_of_packets = u->packets;
+			u->urb->interval = subs->dev->speed == USB_SPEED_HIGH ? 8 : 1;
 			u->urb->context = u;
 			u->urb->complete = snd_usb_complete_callback(snd_complete_sync_urb);
 		}




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
