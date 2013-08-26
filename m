From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Mon, 26 Aug 2013 14:37:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308261419100.886-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1308211654010.1297-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308211654010.1297-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Clemens and everyone else:

Not having heard any responses to the patch posted last Wednesday, I 
have updated and completed it.  The version below is ready for testing.  
Please let me know what you find.

It is not very different from the previous version.  I got rid of the
nrpacks module parameter and figured out how to pass the frames/period
and periods/buffer values to data_ep_set_params().  (Maybe this isn't
the best way to do it, but it works.)  I also fixed up the calculation 
that limits URBs to a sync interval.

Of greater interest, I decided to limit each URB to 6 ms and the total
queue to 18 ms, thereby encouraging the driver to use three URBs rather
than two.  (These values could be increased to 8 and 24, respectively.)  
This helps to reduce the effects of an underrun, as follows:

With only two URBs, following an underrun the driver would submit URB1
and URB2.  Because of the delay, it can easily happen that the last
packet of URB1 comes before the isochronous scheduling threshold.  The
URB gets scheduled, but the hardware never sees it.  Consequently there
is no completion interrupt until URB2 finishes, at which point the
queue is empty, causing a secondary underrun.  I actually saw this
happen several times during testing.

James, this patch should be tested along with Clemens's original
"maxpacket is too large" patch and my "EHCI accepts late iso URBs"  
patches.  It should allow you to go down to ridiculously low parameter
values, provided only that the total latency is higher than ~1.2 ms.  
For example, at 48 KHz this patch should work okay with 8 frames/period
and 8 periods/buffer.  Of course, larger values will provide greater
resilience against underruns.

Alan Stern



Index: usb-3.11/sound/usb/usbaudio.h
===================================================================
--- usb-3.11.orig/sound/usb/usbaudio.h
+++ usb-3.11/sound/usb/usbaudio.h
@@ -55,7 +55,6 @@ struct snd_usb_audio {
 	struct list_head mixer_list;	/* list of mixer interfaces */
 
 	int setup;			/* from the 'device_setup' module param */
-	int nrpacks;			/* from the 'nrpacks' module param */
 	bool autoclock;			/* from the 'autoclock' module param */
 
 	struct usb_host_interface *ctrl_intf;	/* the audio control interface */
Index: usb-3.11/sound/usb/card.c
===================================================================
--- usb-3.11.orig/sound/usb/card.c
+++ usb-3.11/sound/usb/card.c
@@ -79,7 +79,6 @@ static bool enable[SNDRV_CARDS] = SNDRV_
 /* Vendor/product IDs for this card */
 static int vid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
 static int pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 };
-static int nrpacks = 8;		/* max. number of packets per urb */
 static int device_setup[SNDRV_CARDS]; /* device parameter for this card */
 static bool ignore_ctl_error;
 static bool autoclock = true;
@@ -94,8 +93,6 @@ module_param_array(vid, int, NULL, 0444)
 MODULE_PARM_DESC(vid, "Vendor ID for the USB audio device.");
 module_param_array(pid, int, NULL, 0444);
 MODULE_PARM_DESC(pid, "Product ID for the USB audio device.");
-module_param(nrpacks, int, 0644);
-MODULE_PARM_DESC(nrpacks, "Max. number of packets per URB.");
 module_param_array(device_setup, int, NULL, 0444);
 MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
 module_param(ignore_ctl_error, bool, 0444);
@@ -374,7 +371,6 @@ static int snd_usb_audio_create(struct u
 	chip->dev = dev;
 	chip->card = card;
 	chip->setup = device_setup[idx];
-	chip->nrpacks = nrpacks;
 	chip->autoclock = autoclock;
 	chip->probing = 1;
 
@@ -756,10 +752,6 @@ static struct usb_driver usb_audio_drive
 
 static int __init snd_usb_audio_init(void)
 {
-	if (nrpacks < 1 || nrpacks > MAX_PACKS) {
-		printk(KERN_WARNING "invalid nrpacks value.\n");
-		return -EINVAL;
-	}
 	return usb_register(&usb_audio_driver);
 }
 
Index: usb-3.11/sound/usb/endpoint.h
===================================================================
--- usb-3.11.orig/sound/usb/endpoint.h
+++ usb-3.11/sound/usb/endpoint.h
@@ -12,6 +12,8 @@ int snd_usb_endpoint_set_params(struct s
 				snd_pcm_format_t pcm_format,
 				unsigned int channels,
 				unsigned int period_bytes,
+				unsigned int period_frames,
+				unsigned int buffer_periods,
 				unsigned int rate,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep);
Index: usb-3.11/sound/usb/card.h
===================================================================
--- usb-3.11.orig/sound/usb/card.h
+++ usb-3.11/sound/usb/card.h
@@ -2,11 +2,11 @@
 #define __USBAUDIO_CARD_H
 
 #define MAX_NR_RATES	1024
-#define MAX_PACKS	20
+#define MAX_PACKS	6		/* per URB */
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
-#define MAX_URBS	8
+#define MAX_URBS	12
 #define SYNC_URBS	4	/* always four urbs for sync */
-#define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
+#define MAX_QUEUE	18	/* try not to exceed this queue length, in ms */
 
 struct audioformat {
 	struct list_head list;
@@ -87,6 +87,7 @@ struct snd_usb_endpoint {
 	unsigned int phase;		/* phase accumulator */
 	unsigned int maxpacksize;	/* max packet size in bytes */
 	unsigned int maxframesize;      /* max packet size in frames */
+	unsigned int max_urb_frames;	/* max URB size in frames */
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;      /* current packet size in frames (for capture) */
 	unsigned int syncmaxsize;	/* sync endpoint packet size */
@@ -116,6 +117,8 @@ struct snd_usb_substream {
 	unsigned int channels_max;	/* max channels in the all audiofmts */
 	unsigned int cur_rate;		/* current rate (for hw_params callback) */
 	unsigned int period_bytes;	/* current period bytes (for hw_params callback) */
+	unsigned int period_frames;	/* current frames per period */
+	unsigned int buffer_periods;	/* current periods per buffer */
 	unsigned int altset_idx;     /* USB data format: index of alternate setting */
 	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
@@ -125,6 +128,7 @@ struct snd_usb_substream {
 
 	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;		/* processed frames since last period update */
+	unsigned int frame_limit;	/* limits number of packets in URB */
 
 	/* data and sync endpoints for this stream */
 	unsigned int ep_num;		/* the endpoint number */
Index: usb-3.11/sound/usb/pcm.c
===================================================================
--- usb-3.11.orig/sound/usb/pcm.c
+++ usb-3.11/sound/usb/pcm.c
@@ -562,6 +562,7 @@ static int configure_sync_endpoint(struc
 						   subs->pcm_format,
 						   subs->channels,
 						   subs->period_bytes,
+						   0, 0,
 						   subs->cur_rate,
 						   subs->cur_audiofmt,
 						   NULL);
@@ -598,6 +599,7 @@ static int configure_sync_endpoint(struc
 					  subs->pcm_format,
 					  sync_fp->channels,
 					  sync_period_bytes,
+					  0, 0,
 					  subs->cur_rate,
 					  sync_fp,
 					  NULL);
@@ -620,6 +622,8 @@ static int configure_endpoint(struct snd
 					  subs->pcm_format,
 					  subs->channels,
 					  subs->period_bytes,
+					  subs->period_frames,
+					  subs->buffer_periods,
 					  subs->cur_rate,
 					  subs->cur_audiofmt,
 					  subs->sync_endpoint);
@@ -656,6 +660,8 @@ static int snd_usb_hw_params(struct snd_
 
 	subs->pcm_format = params_format(hw_params);
 	subs->period_bytes = params_period_bytes(hw_params);
+	subs->period_frames = params_period_size(hw_params);
+	subs->buffer_periods = params_periods(hw_params);
 	subs->channels = params_channels(hw_params);
 	subs->cur_rate = params_rate(hw_params);
 
@@ -1330,6 +1336,7 @@ static void prepare_playback_urb(struct
 	frames = 0;
 	urb->number_of_packets = 0;
 	spin_lock_irqsave(&subs->lock, flags);
+	subs->frame_limit += ep->max_urb_frames;
 	for (i = 0; i < ctx->packets; i++) {
 		if (ctx->packet_size[i])
 			counts = ctx->packet_size[i];
@@ -1344,6 +1351,7 @@ static void prepare_playback_urb(struct
 		subs->transfer_done += counts;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
+			subs->frame_limit = 0;
 			period_elapsed = 1;
 			if (subs->fmt_type == UAC_FORMAT_TYPE_II) {
 				if (subs->transfer_done > 0) {
@@ -1366,8 +1374,10 @@ static void prepare_playback_urb(struct
 				break;
 			}
 		}
-		if (period_elapsed &&
-		    !snd_usb_endpoint_implicit_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
+		/* finish at the period boundary or after enough frames */
+		if ((period_elapsed ||
+				subs->transfer_done >= subs->frame_limit) &&
+		    !snd_usb_endpoint_implicit_feedback_sink(ep))
 			break;
 	}
 	bytes = frames * ep->stride;
Index: usb-3.11/sound/usb/endpoint.c
===================================================================
--- usb-3.11.orig/sound/usb/endpoint.c
+++ usb-3.11/sound/usb/endpoint.c
@@ -571,11 +571,14 @@ static int data_ep_set_params(struct snd
 			      snd_pcm_format_t pcm_format,
 			      unsigned int channels,
 			      unsigned int period_bytes,
+			      unsigned int frames_per_period,
+			      unsigned int periods_per_buffer,
 			      struct audioformat *fmt,
 			      struct snd_usb_endpoint *sync_ep)
 {
-	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
-	int is_playback = usb_pipeout(ep->pipe);
+	unsigned int maxsize, minsize, packs_per_ms, max_packs_per_urb;
+	unsigned int max_packs_per_period, urbs_per_period, urb_packs;
+	unsigned int max_urbs, i;
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
 	if (pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE && fmt->dsd_dop) {
@@ -608,67 +611,47 @@ static int data_ep_set_params(struct snd
 	else
 		ep->curpacksize = maxsize;
 
-	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL)
+	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL) {
 		packs_per_ms = 8 >> ep->datainterval;
-	else
-		packs_per_ms = 1;
-
-	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
-		urb_packs = max(ep->chip->nrpacks, 1);
-		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
+		max_packs_per_urb = MAX_PACKS_HS;
 	} else {
-		urb_packs = 1;
+		packs_per_ms = 1;
+		max_packs_per_urb = MAX_PACKS;
 	}
-
-	urb_packs *= packs_per_ms;
-
 	if (sync_ep && !snd_usb_endpoint_implicit_feedback_sink(ep))
-		urb_packs = min(urb_packs, 1U << sync_ep->syncinterval);
-
-	/* decide how many packets to be used */
-	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
-		unsigned int minsize, maxpacks;
-		/* determine how small a packet can be */
-		minsize = (ep->freqn >> (16 - ep->datainterval))
-			  * (frame_bits >> 3);
-		/* with sync from device, assume it can be 12% lower */
-		if (sync_ep)
-			minsize -= minsize >> 3;
-		minsize = max(minsize, 1u);
-		total_packs = (period_bytes + minsize - 1) / minsize;
-		/* we need at least two URBs for queueing */
-		if (total_packs < 2) {
-			total_packs = 2;
-		} else {
-			/* and we don't want too long a queue either */
-			maxpacks = max(MAX_QUEUE * packs_per_ms, urb_packs * 2);
-			total_packs = min(total_packs, maxpacks);
-		}
-	} else {
-		while (urb_packs > 1 && urb_packs * maxsize >= period_bytes)
-			urb_packs >>= 1;
-		total_packs = MAX_URBS * urb_packs;
-	}
-
-	ep->nurbs = (total_packs + urb_packs - 1) / urb_packs;
-	if (ep->nurbs > MAX_URBS) {
-		/* too much... */
-		ep->nurbs = MAX_URBS;
-		total_packs = MAX_URBS * urb_packs;
-	} else if (ep->nurbs < 2) {
-		/* too little - we need at least two packets
-		 * to ensure contiguous playback/capture
-		 */
-		ep->nurbs = 2;
-	}
+		max_packs_per_urb = min(max_packs_per_urb,
+					1U << sync_ep->syncinterval);
+	max_packs_per_urb = max(1u, max_packs_per_urb >> ep->datainterval);
+
+	/* determine how small a packet can be */
+	minsize = (ep->freqn >> (16 - ep->datainterval)) * (frame_bits >> 3);
+	/* with sync from device, assume it can be 12% lower */
+	if (sync_ep)
+		minsize -= minsize >> 3;
+	minsize = max(minsize, 1u);
+
+	/* how many packets will contain an entire ALSA period? */
+	max_packs_per_period = DIV_ROUND_UP(period_bytes, minsize);
+
+	/* how many URBs contain a period, and how many packets in each? */
+	urbs_per_period = DIV_ROUND_UP(max_packs_per_period, max_packs_per_urb);
+	urb_packs = DIV_ROUND_UP(max_packs_per_period, urbs_per_period);
+
+	/* limit the number of frames in a single URB */
+	ep->max_urb_frames = DIV_ROUND_UP(frames_per_period,
+			urbs_per_period);
+
+	/* try to use enough URBs to contain an entire ALSA buffer */
+	max_urbs = min((unsigned) MAX_URBS,
+			MAX_QUEUE * packs_per_ms / urb_packs);
+	ep->nurbs = min(max_urbs, urbs_per_period * periods_per_buffer);
 
 	/* allocate and initialize data urbs */
 	for (i = 0; i < ep->nurbs; i++) {
 		struct snd_urb_ctx *u = &ep->urb[i];
 		u->index = i;
 		u->ep = ep;
-		u->packets = (i + 1) * total_packs / ep->nurbs
-			- i * total_packs / ep->nurbs;
+		u->packets = urb_packs;
 		u->buffer_size = maxsize * u->packets;
 
 		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
@@ -745,6 +728,8 @@ out_of_memory:
  * @pcm_format: the audio fomat.
  * @channels: the number of audio channels.
  * @period_bytes: the number of bytes in one alsa period.
+ * @period_frames: the number of frames in one alsa period.
+ * @buffer_periods: the number of periods in one alsa buffer.
  * @rate: the frame rate.
  * @fmt: the USB audio format information
  * @sync_ep: the sync endpoint to use, if any
@@ -757,6 +742,8 @@ int snd_usb_endpoint_set_params(struct s
 				snd_pcm_format_t pcm_format,
 				unsigned int channels,
 				unsigned int period_bytes,
+				unsigned int period_frames,
+				unsigned int buffer_periods,
 				unsigned int rate,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep)
@@ -790,7 +777,8 @@ int snd_usb_endpoint_set_params(struct s
 	switch (ep->type) {
 	case  SND_USB_ENDPOINT_TYPE_DATA:
 		err = data_ep_set_params(ep, pcm_format, channels,
-					 period_bytes, fmt, sync_ep);
+					 period_bytes, period_frames,
+					 buffer_periods, fmt, sync_ep);
 		break;
 	case  SND_USB_ENDPOINT_TYPE_SYNC:
 		err = sync_ep_set_params(ep, fmt);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
