From: Juan Pablo Bouza <jpbouza@hotmail.com>
Subject: Re: M-Audio FTU issues
Date: Thu, 21 Jul 2011 02:08:47 -0300
Message-ID: <BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>,
	<4E045058.6000405@showlabor.de>,
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>,
	<4E04B42E.2080906@ladisch.de>,
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>,
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>,
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>,
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s15.bay0.hotmail.com (bay0-omc3-s15.bay0.hotmail.com
	[65.54.190.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1538A10387A
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 07:08:53 +0200 (CEST)
In-Reply-To: <CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gdiffey@gmail.com, zonque@gmail.com
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org


Hi! I've patched kernel 3 rc7 and playback does not work...

Capture works perfectly fine.

Playback does not work with alsa apps  or with jack. 

 This is my /proc/asound/cards output

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xf9ff4000 irq 16
 1 [Ultra          ]: USB-Audio - Fast Track Ultra
                      M-Audio Fast Track Ultra at usb-0000:00:13.5-1, high speed


This is what happens when trying to playback a sound file with aplay -D plughw:Ultra /media/Edipo/Triangulo/Hadas\ por\ ahora.mp3 

Playing raw data '/media/Edipo/Triangulo/Hadas por ahora.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono
aplay: set_params:1137: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 1000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 4000
TICK_TIME: 0

Is there any extra option I need to activate in the kernel in order to make playback work?

I compiled the kernel without the patch and I do have playback, so my conclusion is that the problem is with the patch applied

Thanks!

PS: just to make sure, this is the patch I applied:

diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 0fd3fbd..0f138de 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -377,6 +377,11 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_NUMBER_MASK    0x0f    /* in bEndpointAddress */
 #define USB_ENDPOINT_DIR_MASK        0x80
 
+#define USB_ENDPOINT_USAGE_MASK        0x30
+#define USB_ENDPOINT_USAGE_DATA        0x00
+#define USB_ENDPOINT_USAGE_FEEDBACK    0x10
+#define USB_ENDPOINT_USAGE_IMPLICIT_FB    0x20    /* Implicit feedback Data endpoint */
+
 #define USB_ENDPOINT_SYNCTYPE        0x0c
 #define USB_ENDPOINT_SYNC_NONE        (0 << 2)
 #define USB_ENDPOINT_SYNC_ASYNC        (1 << 2)
diff --git a/sound/usb/card.h b/sound/usb/card.h
index ae4251d..b9ba132 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -3,7 +3,7 @@
 
 #define MAX_PACKS    20
 #define MAX_PACKS_HS    (MAX_PACKS * 8)    /* in high speed mode */
-#define MAX_URBS    8
+#define MAX_URBS    16
 #define SYNC_URBS    4    /* always four urbs for sync */
 #define MAX_QUEUE    24    /* try not to exceed this queue length, in ms */
 
@@ -36,9 +36,11 @@ struct snd_urb_ctx {
     struct snd_usb_substream *subs;
     int index;    /* index for urb array */
     int packets;    /* number of packets per urb */
+    int packet_size[MAX_PACKS_HS]; /* size of packets for next submission */
 };
 
 struct snd_urb_ops {
+    int (*prepare_size)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
     int (*prepare)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
     int (*retire)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
     int (*prepare_sync)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
@@ -73,6 +75,8 @@ struct snd_usb_substream {
     unsigned int fill_max: 1;    /* fill max packet size always */
     unsigned int txfr_quirk:1;    /* allow sub-frame alignment */
     unsigned int fmt_type;        /* USB audio format type (1-3) */
+    unsigned int next_out_urb;    /* index of next URB to use for output
+                       (implicit feedback mode only) */
 
     unsigned int running: 1;    /* running status */
 
@@ -103,6 +107,8 @@ struct snd_usb_stream {
     unsigned int fmt_type;        /* USB audio format type (1-3) */
     struct snd_usb_substream substream[2];
     struct list_head list;
+    unsigned int implicit_feedback: 1;     /* stream uses its capture data
+                           substream to clock its playback substream */
 };
 
 #endif /* __USBAUDIO_CARD_H */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b8dcbf4..1cd1db2 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -185,7 +185,8 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 /*
  * find a matching format and set up the interface
  */
-static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
+int snd_usb_set_pcm_format(struct snd_usb_substream *subs,
+               struct audioformat *fmt)
 {
     struct usb_device *dev = subs->dev;
     struct usb_host_interface *alts;
@@ -206,6 +207,8 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
     if (fmt == subs->cur_audiofmt)
         return 0;
 
+printk(KERN_ERR "%s() :%d\n", __func__, __LINE__);
+
     /* close the old interface */
     if (subs->interface >= 0 && subs->interface != fmt->iface) {
         if (usb_set_interface(subs->dev, subs->interface, 0) < 0) {
@@ -292,6 +295,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
     if (fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX)
         subs->fill_max = 1;
 
+    if (!is_playback &&
+        (fmt->ep_attr & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_ISOC &&
+        (fmt->ep_attr & USB_ENDPOINT_USAGE_MASK) == USB_ENDPOINT_USAGE_IMPLICIT_FB)
+        subs->stream->implicit_feedback = 1;
+
     if ((err = snd_usb_init_pitch(subs->stream->chip, subs->interface, alts, fmt)) < 0)
         return err;
 
@@ -299,6 +307,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 
     snd_usb_set_format_quirk(subs, fmt);
 
+    if (subs->stream->implicit_feedback)
+        snd_printk(KERN_INFO "operating in implicit feedback mode\n");
+
 #if 0
     printk(KERN_DEBUG
            "setting done: format = %d, rate = %d..%d, channels = %d\n",
@@ -347,7 +358,16 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
     changed = subs->cur_audiofmt != fmt ||
         subs->period_bytes != params_period_bytes(hw_params) ||
         subs->cur_rate != rate;
-    if ((ret = set_format(subs, fmt)) < 0)
+
+    if (subs->stream->implicit_feedback) {
+        struct snd_usb_substream *other =
+            &subs->stream->substream[!subs->direction];
+
+        if (other && other->running && changed)
+            return -EBUSY;
+    }
+
+    if ((ret = snd_usb_set_pcm_format(subs, fmt)) < 0)
         return ret;
 
     if (subs->cur_rate != rate) {
@@ -815,6 +835,9 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
     struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
     struct snd_usb_substream *subs = &as->substream[direction];
 
+    if (snd_usb_capture_subs_used_by_playback(subs))
+        return 0;
+
     if (!as->chip->shutdown && subs->interface >= 0) {
         usb_set_interface(subs->dev, subs->interface, 0);
         subs->interface = -1;
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index ed3e283..9e02cf8 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -3,6 +3,9 @@
 
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream);
 
+int snd_usb_set_pcm_format(struct snd_usb_substream *subs,
+               struct audioformat *fmt);
+
 int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
                struct usb_host_interface *alts,
                struct audioformat *fmt);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 090e193..1353663 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -644,6 +644,10 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
     case USB_ID(0x041e, 0x3f19): /* E-Mu 0204 USB */
         set_format_emu_quirk(subs, fmt);
         break;
+    case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
+    case USB_ID(0x0763, 0x2081):
+        subs->stream->implicit_feedback = 1;
+        break;
     }
 }
 
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index e184349..3b7a81b 100644
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -29,6 +29,25 @@
 #include "urb.h"
 #include "pcm.h"
 
+/* Streaming modes
+ *
+ * This driver can operate in different streaming modes which use the internal
+ * functions of this file differently.
+ *
+ * One is independent input and output streaming which is the default and most
+ * usual for USB audio devices. IN endpoints (device sinks) can either take any
+ * amount of data that is sent or provide a sync endpoint to tell the host at
+ * which data rate the stream runs at. This streaming model allows playback and
+ * capture streams to be started independently.
+ *
+ * The other is an 'implicit feedback mode' in which the device does not tell
+ * the host its speed through an sync endpoint but expects the driver to always
+ * receive the record stream and use the data rate to determine the actual
+ * device speed. For the USB side, this means that the driver has to queue
+ * capture URBs even if the userspace is not interested in actual capture data.
+ *
+ */
+
 /*
  * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
  * this will overflow at approx 524 kHz
@@ -135,10 +154,26 @@ static int wait_clear_urbs(struct snd_usb_substream *subs)
         schedule_timeout_uninterruptible(1);
     } while (time_before(jiffies, end_time));
     if (alive)
-        snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
+        snd_printk(KERN_ERR "timeout: still %d active urbs (%s)\n",
+               alive, subs->direction == SNDRV_PCM_STREAM_CAPTURE ?
+                        "capture" : "playback");
     return 0;
 }
 
+int snd_usb_capture_subs_used_by_playback(struct snd_usb_substream *capture)
+{
+    struct snd_usb_stream *stream = capture->stream;
+    struct snd_usb_substream *playback = &stream->substream[SNDRV_PCM_STREAM_PLAYBACK];
+
+    if (!playback)
+        return 0;
+
+    if (capture->direction != SNDRV_PCM_STREAM_CAPTURE)
+        return 0;
+
+    return stream->implicit_feedback && playback->running;
+}
+
 /*
  * release a substream
  */
@@ -146,6 +181,9 @@ void snd_usb_release_substream_urbs(struct snd_usb_substream *subs, int force)
 {
     int i;
 
+    if (snd_usb_capture_subs_used_by_playback(subs))
+        return;
+
     /* stop urbs (to be sure) */
     deactivate_urbs(subs, force, 1);
     wait_clear_urbs(subs);
@@ -168,17 +206,34 @@ static void snd_complete_urb(struct urb *urb)
     struct snd_urb_ctx *ctx = urb->context;
     struct snd_usb_substream *subs = ctx->subs;
     struct snd_pcm_substream *substream = ctx->subs->pcm_substream;
+    int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
     int err = 0;
 
     if ((subs->running && subs->ops.retire(subs, substream->runtime, urb)) ||
-        !subs->running || /* can be stopped during retire callback */
-        (err = subs->ops.prepare(subs, substream->runtime, urb)) < 0 ||
-        (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
-        clear_bit(ctx->index, &subs->active_mask);
-        if (err < 0) {
-            snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
-            snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-        }
+        !subs->running /* can be stopped during retire callback */)
+        goto exit_clear_bit;
+
+    /*
+     * For devices that operate in implicit feedback mode, we won't requeue
+     * the URB at this point. Instead, we will wait for the next record
+     * input packet to arrive and queue a packet from the corresponding
+     * retire callback.
+     */
+    if (is_playback && subs->stream->implicit_feedback)
+        goto exit_clear_bit;
+
+    if ((err = subs->ops.prepare(subs, substream->runtime, urb)) == 0 &&
+        (err = subs->ops.prepare_size(subs, substream->runtime, urb)) == 0 &&
+        (err = usb_submit_urb(urb, GFP_ATOMIC)) < 0)
+        return;
+
+    /* fall through */
+
+exit_clear_bit:
+    clear_bit(ctx->index, &subs->active_mask);
+    if (err < 0) {
+        snd_printd(KERN_ERR "cannot submit urb (err = %d)\n", err);
+        snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
     }
 }
 
@@ -250,7 +305,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
     else
         packs_per_ms = 1;
 
-    if (is_playback) {
+    if (is_playback && !subs->stream->implicit_feedback) {
         urb_packs = max(chip->nrpacks, 1);
         urb_packs = min(urb_packs, (unsigned int)MAX_PACKS);
     } else
@@ -260,7 +315,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
         urb_packs = min(urb_packs, 1U << subs->syncinterval);
 
     /* decide how many packets to be used */
-    if (is_playback) {
+    if (is_playback && !subs->stream->implicit_feedback) {
         unsigned int minsize, maxpacks;
         /* determine how small a packet can be */
         minsize = (subs->freqn >> (16 - subs->datainterval))
@@ -320,6 +375,9 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
         u->urb->complete = snd_complete_urb;
     }
 
+    if (subs->stream->implicit_feedback)
+        subs->syncpipe = 0;
+
     if (subs->syncpipe) {
         /* allocate and initialize sync urbs */
         subs->syncbuf = usb_alloc_coherent(subs->dev, SYNC_URBS * 4,
@@ -410,6 +468,15 @@ static int retire_capture_sync_urb(struct snd_usb_substream *subs,
 }
 
 /*
+ * prepare data sizes for caputure urbs. nothing to do. */
+static int prepare_capture_size_urb(struct snd_usb_substream *subs,
+                    struct snd_pcm_runtime *runtime,
+                    struct urb *urb)
+{
+    return 0;
+}
+
+/*
  * prepare urb for capture data pipe
  *
  * fill the offset and length of each descriptor.
@@ -438,11 +505,93 @@ static int prepare_capture_urb(struct snd_usb_substream *subs,
     return 0;
 }
 
+static int queue_next_playback_urb(struct snd_usb_substream *capture,
+                   struct snd_pcm_runtime *runtime,
+                   struct urb *in_urb)
+{
+    unsigned int stride = runtime->frame_bits >> 3;
+    unsigned int bytes = 0, i;
+    unsigned long flags;
+    struct snd_urb_ctx *in_ctx = in_urb->context;
+    struct snd_usb_substream *playback =
+        &capture->stream->substream[SNDRV_PCM_STREAM_PLAYBACK];
+    struct snd_urb_ctx *out_ctx;
+    struct urb *out_urb;
+    int err;
+
+    /* this may happen during substream transitions */
+    if (stride == 0)
+        return 0;
+
+    if (!playback->running)
+        return 0;
+
+    /* Count overall packet size */
+    for (i = 0; i < in_ctx->packets; i++)
+        if (in_urb->iso_frame_desc[i].status == 0)
+            bytes += in_urb->iso_frame_desc[i].actual_length;
+
+    /* skip empty packets. At least M-Audio's Fast Track Ultra stops
+     * streaming once it received a 0-byte OUT URB */
+    if (bytes == 0)
+        return 0;
+
+    spin_lock_irqsave(&capture->lock, flags);
+    out_ctx = &playback->dataurb[playback->next_out_urb];
+    spin_unlock_irqrestore(&capture->lock, flags);
+
+    out_urb = out_ctx->urb;
+
+    /* If the output urb is still in use, we have to drop this packet.
+     * This usually only occurs when the stream is starting */
+    if (test_bit(out_ctx->index, &playback->active_mask))
+        return 0;
+
+    /*
+     * Iterate through the inbound packet and prepare the lengths
+     * for output packets. The OUT packet we are about to send will
+     * have the same amount of payload than the IN packet we just
+     * received.
+     */
+
+    out_ctx->packets = in_ctx->packets;
+    for (i = 0; i < in_ctx->packets; i++) {
+        if (in_urb->iso_frame_desc[i].status == 0)
+            out_ctx->packet_size[i] =
+                in_urb->iso_frame_desc[i].actual_length / stride;
+        else
+            out_ctx->packet_size[i] = 0;
+    }
+
+    err = playback->ops.prepare(playback, playback->pcm_substream->runtime, out_urb);
+    if (err < 0)
+        return err;
+
+    err = usb_submit_urb(out_urb, GFP_ATOMIC);
+    if (err < 0) {
+        snd_printk(KERN_ERR "%s(): Unable to submit urb #%d: %d\n",
+                __func__, out_ctx->index, err);
+        snd_pcm_stop(capture->pcm_substream, SNDRV_PCM_STATE_XRUN);
+        snd_pcm_stop(playback->pcm_substream, SNDRV_PCM_STATE_XRUN);
+        return err;
+    } else {
+        spin_lock_irqsave(&capture->lock, flags);
+        set_bit(out_ctx->index, &playback->active_mask);
+        playback->next_out_urb++;
+        playback->next_out_urb %= playback->nurbs;
+        spin_unlock_irqrestore(&capture->lock, flags);
+    }
+
+    return 0;
+}
+
 /*
  * process after capture complete
  *
  * copy the data from each desctiptor to the pcm buffer, and
  * update the current position.
+ *
+ * For implicit feedback mode, eventually call queue_next_playback_urb().
  */
 static int retire_capture_urb(struct snd_usb_substream *subs,
                   struct snd_pcm_runtime *runtime,
@@ -499,16 +648,24 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
     }
     if (period_elapsed)
         snd_pcm_period_elapsed(subs->pcm_substream);
+
+    if (subs->stream->implicit_feedback)
+        return queue_next_playback_urb(subs, runtime, urb);
+
     return 0;
 }
 
 /*
- * Process after capture complete when paused.  Nothing to do.
+ * Process after capture complete when paused.
+ * For implicit feedback mode, eventually call queue_next_playback_urb().
  */
 static int retire_paused_capture_urb(struct snd_usb_substream *subs,
                      struct snd_pcm_runtime *runtime,
                      struct urb *urb)
 {
+    if (subs->stream->implicit_feedback)
+        return queue_next_playback_urb(subs, runtime, urb);
+
     return 0;
 }
 
@@ -615,6 +772,25 @@ static int snd_usb_audio_next_packet_size(struct snd_usb_substream *subs)
 }
 
 /*
+ * Prepare urb data sizes for asynchronous output streaming.
+ * This is seperated from the code that fills the data because syncronous
+ * streaming (in implicit feedback mode) uses a different method to determine
+ * the output data packet sizes.
+ */
+static int prepare_playback_size_urb(struct snd_usb_substream *subs,
+                     struct snd_pcm_runtime *runtime,
+                     struct urb *urb)
+{
+    int i;
+    struct snd_urb_ctx *ctx = urb->context;
+
+    for (i = 0; i < ctx->packets; ++i)
+        ctx->packet_size[i] = snd_usb_audio_next_packet_size(subs);
+
+    return 0;
+}
+
+/*
  * Prepare urb for streaming before playback starts or when paused.
  *
  * We don't have any data, so we send silence.
@@ -630,7 +806,7 @@ static int prepare_nodata_playback_urb(struct snd_usb_substream *subs,
     offs = 0;
     urb->dev = ctx->subs->dev;
     for (i = 0; i < ctx->packets; ++i) {
-        counts = snd_usb_audio_next_packet_size(subs);
+        counts = ctx->packet_size[i];
         urb->iso_frame_desc[i].offset = offs * stride;
         urb->iso_frame_desc[i].length = counts * stride;
         offs += counts;
@@ -668,7 +844,7 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
     urb->number_of_packets = 0;
     spin_lock_irqsave(&subs->lock, flags);
     for (i = 0; i < ctx->packets; i++) {
-        counts = snd_usb_audio_next_packet_size(subs);
+        counts = ctx->packet_size[i];
         /* set up descriptor */
         urb->iso_frame_desc[i].offset = frames * stride;
         urb->iso_frame_desc[i].length = counts * stride;
@@ -786,6 +962,10 @@ static int start_urbs(struct snd_usb_substream *subs, struct snd_pcm_runtime *ru
     for (i = 0; i < subs->nurbs; i++) {
         if (snd_BUG_ON(!subs->dataurb[i].urb))
             return -EINVAL;
+        if (subs->ops.prepare_size(subs, runtime, subs->dataurb[i].urb) < 0) {
+            snd_printk(KERN_ERR "cannot prepare datapipe for urb %d\n", i);
+            goto __error;
+        }
         if (subs->ops.prepare(subs, runtime, subs->dataurb[i].urb) < 0) {
             snd_printk(KERN_ERR "cannot prepare datapipe for urb %d\n", i);
             goto __error;
@@ -805,6 +985,7 @@ static int start_urbs(struct snd_usb_substream *subs, struct snd_pcm_runtime *ru
     subs->active_mask = 0;
     subs->unlink_mask = 0;
     subs->running = 1;
+
     for (i = 0; i < subs->nurbs; i++) {
         err = usb_submit_urb(subs->dataurb[i].urb, GFP_ATOMIC);
         if (err < 0) {
@@ -840,12 +1021,14 @@ static int start_urbs(struct snd_usb_substream *subs, struct snd_pcm_runtime *ru
  */
 static struct snd_urb_ops audio_urb_ops[2] = {
     {
+        .prepare_size =    prepare_playback_size_urb,
         .prepare =    prepare_nodata_playback_urb,
         .retire =    retire_playback_urb,
         .prepare_sync =    prepare_playback_sync_urb,
         .retire_sync =    retire_playback_sync_urb,
     },
     {
+        .prepare_size =    prepare_capture_size_urb,
         .prepare =    prepare_capture_urb,
         .retire =    retire_capture_urb,
         .prepare_sync =    prepare_capture_sync_urb,
@@ -892,6 +1075,18 @@ int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int
         subs->ops.prepare = prepare_playback_urb;
         return 0;
     case SNDRV_PCM_TRIGGER_STOP:
+        if (subs->stream->implicit_feedback) {
+            struct snd_usb_substream *capture =
+                &subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE];
+            if (capture &&
+                capture->pcm_substream &&
+                capture->pcm_substream->runtime) {
+                struct snd_pcm_runtime *runtime =
+                    capture->pcm_substream->runtime;
+                if (runtime->status->state != SNDRV_PCM_STATE_OPEN)
+                    deactivate_urbs(capture, 0, 0);
+            }
+        }
         return deactivate_urbs(subs, 0, 0);
     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
         subs->ops.prepare = prepare_nodata_playback_urb;
@@ -908,8 +1103,15 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int c
     switch (cmd) {
     case SNDRV_PCM_TRIGGER_START:
         subs->ops.retire = retire_capture_urb;
-        return start_urbs(subs, substream->runtime);
+        if (!subs->running)
+            return start_urbs(subs, substream->runtime);
+
+        return 0;
     case SNDRV_PCM_TRIGGER_STOP:
+        if (snd_usb_capture_subs_used_by_playback(subs)) {
+            subs->ops.retire = retire_paused_capture_urb;
+            return 0;
+        }
         return deactivate_urbs(subs, 0, 0);
     case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
         subs->ops.retire = retire_paused_capture_urb;
@@ -922,18 +1124,90 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int c
     return -EINVAL;
 }
 
+/*
+ * Fake a start for the capture stream.
+ * Only used for implicit feedback mode.
+ */
+static int start_capture_stream(struct snd_usb_substream *playback,
+                struct snd_usb_substream *capture,
+                struct snd_pcm_runtime *runtime)
+{
+    int err;
+
+
+usb_set_interface(capture->dev, 2, 1);
+
+    capture->ops.prepare = prepare_capture_urb;
+    capture->ops.retire = retire_paused_capture_urb;
+    capture->pcm_substream = playback->pcm_substream;
+    err = snd_usb_set_pcm_format(capture, playback->cur_audiofmt);
+    if (err)
+        return err;
+
+    err = snd_usb_init_substream_urbs(capture, playback->period_bytes,
+                      playback->cur_rate,
+                      (playback->curpacksize /
+                       playback->curframesize) * 8);
+    if (err)
+        return err;
+
+    return start_urbs(capture, runtime);
+}
+
 int snd_usb_substream_prepare(struct snd_usb_substream *subs,
                   struct snd_pcm_runtime *runtime)
 {
     /* clear urbs (to be sure) */
-    deactivate_urbs(subs, 0, 1);
-    wait_clear_urbs(subs);
+    if (!snd_usb_capture_subs_used_by_playback(subs)) {
+        deactivate_urbs(subs, 0, 1);
+        wait_clear_urbs(subs);
+    }
 
-    /* for playback, submit the URBs now; otherwise, the first hwptr_done
-     * updates for all URBs would happen at the same time when starting */
     if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
         subs->ops.prepare = prepare_nodata_playback_urb;
-        return start_urbs(subs, runtime);
+
+        if (subs->stream->implicit_feedback) {
+            struct snd_usb_substream *capture =
+                &subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE];
+
+            if (!capture) {
+                snd_printk(KERN_ERR "Unable to start implicit feedback mode "
+                       "without capture stream\n");
+                return -EINVAL;
+            }
+
+            /*
+             * Mark the stream running without calling start_urbs().
+             * We don't want to queue any URBs yet at this point
+             */
+            subs->active_mask = 0;
+            subs->unlink_mask = 0;
+            subs->running = 1;
+
+            /*
+             * if this stream is in implicit feedback mode, start the
+             * capture stream now as the playback stream relies on the
+             * amount of data we see on the capture IN endpoint.
+             */
+            if (!capture->running) {
+                int err = start_capture_stream(subs, capture, runtime);
+                if (err < 0) {
+                    deactivate_urbs(subs, 0, 0);
+                    return err;
+                }
+            }
+        } else {
+            /*
+             * For playback, submit the URBs now; otherwise, the
+             * first hwptr_done updates for all URBs would happen
+             * at the same time when starting.
+             * However, don't start the stream here if we are in
+             * implicit feedback stream mode - all OUT URBs will
+             * be queued once data is received on the IN endpooint
+             * in this case.
+             */
+            return start_urbs(subs, runtime);
+        }
     }
 
     return 0;
diff --git a/sound/usb/urb.h b/sound/usb/urb.h
index 888da38..593a9e1 100644
--- a/sound/usb/urb.h
+++ b/sound/usb/urb.h
@@ -17,5 +17,6 @@ int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 
 int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int cmd);
 int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd);
+int snd_usb_capture_subs_used_by_playback(struct snd_usb_substream *substream);
 
 #endif /* __USBAUDIO_URB_H */

 		 	   		  
