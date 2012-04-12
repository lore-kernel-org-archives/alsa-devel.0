From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/6] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Thu, 12 Apr 2012 13:51:11 +0200
Message-ID: <1334231475-20980-3-git-send-email-zonque@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 50CC72433D
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:25 +0200 (CEST)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
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
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds a new generic streaming logic for audio over USB.

It defines a model (snd_usb_endpoint) that handles everything that
is related to an USB endpoint and its streaming. There are functions to
activate and deactivate an endpoint (which call usb_set_interface()),
and to start and stop its URBs. It also has function pointers to be
called when data was received or is about to be sent, and pointer to
a sync slave (another snd_usb_endpoint) that is informed when data has
been received.

A snd_usb_endpoint knows about its state and implements a refcounting,
so only the first user will actually start the URBs and only the last
one to stop it will tear them down again.

With this sort of abstraction, the actual streaming is decoupled from
the pcm handling, which makes the "implicit feedback" mechanisms easy to
implement.

In order to split changes properly, this patch only adds the new
implementation but leaves the old one around, so the the driver doesn't
change its behaviour. The switch to actually use the new code is
submitted separately.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.h     |   58 ++++
 sound/usb/endpoint.c |  929 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/endpoint.h |   26 ++
 sound/usb/usbaudio.h |    1 +
 4 files changed, 1003 insertions(+), 11 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index da5fa1a..9acbd4a 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -30,13 +30,17 @@ struct audioformat {
 };
 
 struct snd_usb_substream;
+struct snd_usb_endpoint;
 
 struct snd_urb_ctx {
 	struct urb *urb;
 	unsigned int buffer_size;	/* size of data buffer, if data URB */
 	struct snd_usb_substream *subs;
+	struct snd_usb_endpoint *ep;
 	int index;	/* index for urb array */
 	int packets;	/* number of packets per urb */
+	int packet_size[MAX_PACKS_HS]; /* size of packets for next submission */
+	struct list_head ready_list;
 };
 
 struct snd_urb_ops {
@@ -46,6 +50,60 @@ struct snd_urb_ops {
 	int (*retire_sync)(struct snd_usb_substream *subs, struct snd_pcm_runtime *runtime, struct urb *u);
 };
 
+struct snd_usb_endpoint {
+	struct snd_usb_audio *chip;
+
+	int use_count;
+	int ep_num;		/* the referenced endpoint number */
+	int type;		/* SND_USB_ENDPOINT_TYPE_* */
+	unsigned long flags;
+
+	void (*prepare_data_urb) (struct snd_usb_substream *subs,
+				  struct urb *urb);
+	void (*retire_data_urb) (struct snd_usb_substream *subs,
+				 struct urb *urb);
+
+	struct snd_usb_substream *data_subs;
+	struct snd_usb_endpoint *sync_master;
+	struct snd_usb_endpoint *sync_slave;
+
+	struct snd_urb_ctx urb[MAX_URBS];
+
+	struct snd_usb_packet_info {
+		uint32_t packet_size[MAX_PACKS_HS];
+		int packets;
+	} next_packet[MAX_URBS];
+	int next_packet_read_pos, next_packet_write_pos;
+	struct list_head ready_playback_urbs;
+
+	unsigned int nurbs;		/* # urbs */
+	unsigned long active_mask;	/* bitmask of active urbs */
+	unsigned long unlink_mask;	/* bitmask of unlinked urbs */
+	char *syncbuf;			/* sync buffer for all sync URBs */
+	dma_addr_t sync_dma;		/* DMA address of syncbuf */
+
+	unsigned int pipe;		/* the data i/o pipe */
+	unsigned int freqn;		/* nominal sampling rate in fs/fps in Q16.16 format */
+	unsigned int freqm;		/* momentary sampling rate in fs/fps in Q16.16 format */
+	int	   freqshift;		/* how much to shift the feedback value to get Q16.16 */
+	unsigned int freqmax;		/* maximum sampling rate, used for buffer management */
+	unsigned int phase;		/* phase accumulator */
+	unsigned int maxpacksize;	/* max packet size in bytes */
+	unsigned int maxframesize;      /* max packet size in frames */
+	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
+	unsigned int curframesize;      /* current packet size in frames (for capture) */
+	unsigned int syncmaxsize;	/* sync endpoint packet size */
+	unsigned int fill_max:1;	/* fill max packet size always */
+	unsigned int datainterval;      /* log_2 of data packet interval */
+	unsigned int syncinterval;	/* P for adaptive mode, 0 otherwise */
+	unsigned char silence_value;
+	unsigned int stride;
+	int iface, alt_idx;
+
+	spinlock_t lock;
+	struct list_head list;
+};
+
 struct snd_usb_substream {
 	struct snd_usb_stream *stream;
 	struct usb_device *dev;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 08dcce5..56f1810 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -20,9 +20,11 @@
 #include <linux/ratelimit.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/slab.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "usbaudio.h"
 #include "helper.h"
@@ -30,6 +32,9 @@
 #include "endpoint.h"
 #include "pcm.h"
 
+#define EP_FLAG_ACTIVATED	0
+#define EP_FLAG_RUNNING		1
+
 /*
  * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
  * this will overflow at approx 524 kHz
@@ -51,7 +56,7 @@ static inline unsigned get_usb_high_speed_rate(unsigned int rate)
 /*
  * unlink active urbs.
  */
-static int deactivate_urbs(struct snd_usb_substream *subs, int force, int can_sleep)
+static int deactivate_urbs_old(struct snd_usb_substream *subs, int force, int can_sleep)
 {
 	struct snd_usb_audio *chip = subs->stream->chip;
 	unsigned int i;
@@ -113,7 +118,7 @@ static void release_urb_ctx(struct snd_urb_ctx *u)
 /*
  *  wait until all urbs are processed.
  */
-static int wait_clear_urbs(struct snd_usb_substream *subs)
+static int wait_clear_urbs_old(struct snd_usb_substream *subs)
 {
 	unsigned long end_time = jiffies + msecs_to_jiffies(1000);
 	unsigned int i;
@@ -148,8 +153,8 @@ void snd_usb_release_substream_urbs(struct snd_usb_substream *subs, int force)
 	int i;
 
 	/* stop urbs (to be sure) */
-	deactivate_urbs(subs, force, 1);
-	wait_clear_urbs(subs);
+	deactivate_urbs_old(subs, force, 1);
+	wait_clear_urbs_old(subs);
 
 	for (i = 0; i < MAX_URBS; i++)
 		release_urb_ctx(&subs->dataurb[i]);
@@ -164,7 +169,7 @@ void snd_usb_release_substream_urbs(struct snd_usb_substream *subs, int force)
 /*
  * complete callback from data urb
  */
-static void snd_complete_urb(struct urb *urb)
+static void snd_complete_urb_old(struct urb *urb)
 {
 	struct snd_urb_ctx *ctx = urb->context;
 	struct snd_usb_substream *subs = ctx->subs;
@@ -318,7 +323,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 		u->urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
 		u->urb->interval = 1 << subs->datainterval;
 		u->urb->context = u;
-		u->urb->complete = snd_complete_urb;
+		u->urb->complete = snd_complete_urb_old;
 	}
 
 	if (subs->syncpipe) {
@@ -856,7 +861,7 @@ static int start_urbs(struct snd_usb_substream *subs, struct snd_pcm_runtime *ru
 
  __error:
 	// snd_pcm_stop(subs->pcm_substream, SNDRV_PCM_STATE_XRUN);
-	deactivate_urbs(subs, 0, 0);
+	deactivate_urbs_old(subs, 0, 0);
 	return -EPIPE;
 }
 
@@ -917,7 +922,7 @@ int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int
 		subs->ops.prepare = prepare_playback_urb;
 		return 0;
 	case SNDRV_PCM_TRIGGER_STOP:
-		return deactivate_urbs(subs, 0, 0);
+		return deactivate_urbs_old(subs, 0, 0);
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		subs->ops.prepare = prepare_nodata_playback_urb;
 		return 0;
@@ -935,7 +940,7 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int c
 		subs->ops.retire = retire_capture_urb;
 		return start_urbs(subs, substream->runtime);
 	case SNDRV_PCM_TRIGGER_STOP:
-		return deactivate_urbs(subs, 0, 0);
+		return deactivate_urbs_old(subs, 0, 0);
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		subs->ops.retire = retire_paused_capture_urb;
 		return 0;
@@ -951,8 +956,8 @@ int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 			      struct snd_pcm_runtime *runtime)
 {
 	/* clear urbs (to be sure) */
-	deactivate_urbs(subs, 0, 1);
-	wait_clear_urbs(subs);
+	deactivate_urbs_old(subs, 0, 1);
+	wait_clear_urbs_old(subs);
 
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
@@ -964,3 +969,905 @@ int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 	return 0;
 }
 
+int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep)
+{
+	return  ep->sync_master &&
+		ep->sync_master->type == SND_USB_ENDPOINT_TYPE_DATA &&
+		ep->type == SND_USB_ENDPOINT_TYPE_DATA &&
+		usb_pipeout(ep->pipe);
+}
+
+/* determine the number of frames in the next packet */
+static int next_packet_size(struct snd_usb_endpoint *ep)
+{
+	unsigned long flags;
+	int ret;
+
+	if (ep->fill_max)
+		return ep->maxframesize;
+
+	spin_lock_irqsave(&ep->lock, flags);
+	ep->phase = (ep->phase & 0xffff)
+		+ (ep->freqm << ep->datainterval);
+	ret = min(ep->phase >> 16, ep->maxframesize);
+	spin_unlock_irqrestore(&ep->lock, flags);
+
+	return ret;
+}
+
+static void retire_outbound_urb(struct snd_usb_endpoint *ep,
+				struct snd_urb_ctx *urb_ctx)
+{
+	if (ep->retire_data_urb)
+		ep->retire_data_urb(ep->data_subs, urb_ctx->urb);
+}
+
+static void retire_inbound_urb(struct snd_usb_endpoint *ep,
+			       struct snd_urb_ctx *urb_ctx)
+{
+	struct urb *urb = urb_ctx->urb;
+
+	if (ep->sync_slave)
+		snd_usb_handle_sync_urb(ep->sync_slave, ep, urb);
+
+	if (ep->retire_data_urb)
+		ep->retire_data_urb(ep->data_subs, urb);
+}
+
+static void prepare_outbound_urb_sizes(struct snd_usb_endpoint *ep,
+				       struct snd_urb_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < ctx->packets; ++i)
+		ctx->packet_size[i] = next_packet_size(ep);
+}
+
+/*
+ * Prepare a PLAYBACK urb for submission to the bus.
+ */
+static void prepare_outbound_urb(struct snd_usb_endpoint *ep,
+				 struct snd_urb_ctx *ctx)
+{
+	int i;
+	struct urb *urb = ctx->urb;
+	unsigned char *cp = urb->transfer_buffer;
+
+	urb->dev = ep->chip->dev; /* we need to set this at each time */
+
+	switch (ep->type) {
+	case SND_USB_ENDPOINT_TYPE_DATA:
+		if (ep->prepare_data_urb) {
+			ep->prepare_data_urb(ep->data_subs, urb);
+		} else {
+			/* no data provider, so send silence */
+			unsigned int offs = 0;
+			for (i = 0; i < ctx->packets; ++i) {
+				int counts = ctx->packet_size[i];
+				urb->iso_frame_desc[i].offset = offs * ep->stride;
+				urb->iso_frame_desc[i].length = counts * ep->stride;
+				offs += counts;
+			}
+
+			urb->number_of_packets = ctx->packets;
+			urb->transfer_buffer_length = offs * ep->stride;
+			memset(urb->transfer_buffer, ep->silence_value,
+			       offs * ep->stride);
+		}
+		break;
+
+	case SND_USB_ENDPOINT_TYPE_SYNC:
+		if (snd_usb_get_speed(ep->chip->dev) >= USB_SPEED_HIGH) {
+			/*
+			 * fill the length and offset of each urb descriptor.
+			 * the fixed 12.13 frequency is passed as 16.16 through the pipe.
+			 */
+			urb->iso_frame_desc[0].length = 4;
+			urb->iso_frame_desc[0].offset = 0;
+			cp[0] = ep->freqn;
+			cp[1] = ep->freqn >> 8;
+			cp[2] = ep->freqn >> 16;
+			cp[3] = ep->freqn >> 24;
+		} else {
+			/*
+			 * fill the length and offset of each urb descriptor.
+			 * the fixed 10.14 frequency is passed through the pipe.
+			 */
+			urb->iso_frame_desc[0].length = 3;
+			urb->iso_frame_desc[0].offset = 0;
+			cp[0] = ep->freqn >> 2;
+			cp[1] = ep->freqn >> 10;
+			cp[2] = ep->freqn >> 18;
+		}
+
+		break;
+	}
+}
+
+/*
+ * Prepare a CAPTURE or SYNC urb for submission to the bus.
+ */
+static inline void prepare_inbound_urb(struct snd_usb_endpoint *ep,
+				       struct snd_urb_ctx *urb_ctx)
+{
+	int i, offs;
+	struct urb *urb = urb_ctx->urb;
+
+	urb->dev = ep->chip->dev; /* we need to set this at each time */
+
+	switch (ep->type) {
+	case SND_USB_ENDPOINT_TYPE_DATA:
+		offs = 0;
+		for (i = 0; i < urb_ctx->packets; i++) {
+			urb->iso_frame_desc[i].offset = offs;
+			urb->iso_frame_desc[i].length = ep->curpacksize;
+			offs += ep->curpacksize;
+		}
+
+		urb->transfer_buffer_length = offs;
+		urb->number_of_packets = urb_ctx->packets;
+		break;
+
+	case SND_USB_ENDPOINT_TYPE_SYNC:
+		urb->iso_frame_desc[0].length = min(4u, ep->syncmaxsize);
+		urb->iso_frame_desc[0].offset = 0;
+		break;
+	}
+}
+
+static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
+{
+	while (test_bit(EP_FLAG_RUNNING, &ep->flags)) {
+
+		unsigned long flags;
+		struct snd_usb_packet_info *packet;
+		struct snd_urb_ctx *ctx = NULL;
+		struct urb *urb;
+		int err, i;
+
+		spin_lock_irqsave(&ep->lock, flags);
+		if (ep->next_packet_read_pos != ep->next_packet_write_pos) {
+			packet = ep->next_packet + ep->next_packet_read_pos;
+			ep->next_packet_read_pos++;
+			ep->next_packet_read_pos %= MAX_URBS;
+
+			/* take URB out of FIFO */
+			if (!list_empty(&ep->ready_playback_urbs))
+				ctx = list_first_entry(&ep->ready_playback_urbs,
+					       struct snd_urb_ctx, ready_list);
+		}
+		spin_unlock_irqrestore(&ep->lock, flags);
+
+		if (ctx == NULL)
+			return;
+
+		list_del_init(&ctx->ready_list);
+		urb = ctx->urb;
+
+		/* copy over the length information */
+		for (i = 0; i < packet->packets; i++)
+			ctx->packet_size[i] = packet->packet_size[i];
+
+		prepare_outbound_urb(ep, ctx);
+
+		err = usb_submit_urb(ctx->urb, GFP_ATOMIC);
+		if (err < 0)
+			snd_printk(KERN_ERR "Unable to submit urb #%d: %d (urb %p)\n",
+				   ctx->index, err, ctx->urb);
+		else
+			set_bit(ctx->index, &ep->active_mask);
+	}
+}
+
+/*
+ * complete callback for urbs
+ */
+static void snd_complete_urb(struct urb *urb)
+{
+	struct snd_urb_ctx *ctx = urb->context;
+	struct snd_usb_endpoint *ep = ctx->ep;
+	int err;
+
+	if (unlikely(urb->status == -ENOENT ||		/* unlinked */
+		     urb->status == -ENODEV ||		/* device removed */
+		     urb->status == -ECONNRESET ||	/* unlinked */
+		     urb->status == -ESHUTDOWN ||	/* device disabled */
+		     ep->chip->shutdown))		/* device disconnected */
+		goto exit_clear;
+
+	if (usb_pipeout(ep->pipe)) {
+		retire_outbound_urb(ep, ctx);
+		/* can be stopped during retire callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
+
+		if (snd_usb_endpoint_implict_feedback_sink(ep)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&ep->lock, flags);
+			list_add_tail(&ctx->ready_list, &ep->ready_playback_urbs);
+			spin_unlock_irqrestore(&ep->lock, flags);
+			queue_pending_output_urbs(ep);
+
+			goto exit_clear;
+		}
+
+		prepare_outbound_urb_sizes(ep, ctx);
+		prepare_outbound_urb(ep, ctx);
+	} else {
+		retire_inbound_urb(ep, ctx);
+		/* can be stopped during retire callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
+
+		prepare_inbound_urb(ep, ctx);
+	}
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err == 0)
+		return;
+
+	snd_printk(KERN_ERR "cannot submit urb (err = %d)\n", err);
+	//snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+
+exit_clear:
+	clear_bit(ctx->index, &ep->active_mask);
+}
+
+struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
+					      struct usb_host_interface *alts,
+					      int ep_num, int direction, int type)
+{
+	struct list_head *p;
+	struct snd_usb_endpoint *ep;
+	int ret, is_playback = direction == SNDRV_PCM_STREAM_PLAYBACK;
+
+	mutex_lock(&chip->mutex);
+
+	list_for_each(p, &chip->ep_list) {
+		ep = list_entry(p, struct snd_usb_endpoint, list);
+		if (ep->ep_num == ep_num &&
+		    ep->iface == alts->desc.bInterfaceNumber &&
+		    ep->alt_idx == alts->desc.bAlternateSetting) {
+			snd_printdd(KERN_DEBUG "Re-using EP %x in iface %d,%d @%p\n",
+					ep_num, ep->iface, ep->alt_idx, ep);
+			goto __exit_unlock;
+		}
+	}
+
+	snd_printdd(KERN_DEBUG "Creating new %s %s endpoint #%x\n",
+		    is_playback ? "playback" : "capture",
+		    type == SND_USB_ENDPOINT_TYPE_DATA ? "data" : "sync",
+		    ep_num);
+
+	/* select the alt setting once so the endpoints become valid */
+	ret = usb_set_interface(chip->dev, alts->desc.bInterfaceNumber,
+				alts->desc.bAlternateSetting);
+	if (ret < 0) {
+		snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
+					__func__, ret);
+		ep = NULL;
+		goto __exit_unlock;
+	}
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		goto __exit_unlock;
+
+	ep->chip = chip;
+	spin_lock_init(&ep->lock);
+	ep->type = type;
+	ep->ep_num = ep_num;
+	ep->iface = alts->desc.bInterfaceNumber;
+	ep->alt_idx = alts->desc.bAlternateSetting;
+	INIT_LIST_HEAD(&ep->ready_playback_urbs);
+	ep_num &= USB_ENDPOINT_NUMBER_MASK;
+
+	if (is_playback)
+		ep->pipe = usb_sndisocpipe(chip->dev, ep_num);
+	else
+		ep->pipe = usb_rcvisocpipe(chip->dev, ep_num);
+
+	if (type == SND_USB_ENDPOINT_TYPE_SYNC) {
+		if (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+		    get_endpoint(alts, 1)->bRefresh >= 1 &&
+		    get_endpoint(alts, 1)->bRefresh <= 9)
+			ep->syncinterval = get_endpoint(alts, 1)->bRefresh;
+		else if (snd_usb_get_speed(chip->dev) == USB_SPEED_FULL)
+			ep->syncinterval = 1;
+		else if (get_endpoint(alts, 1)->bInterval >= 1 &&
+			 get_endpoint(alts, 1)->bInterval <= 16)
+			ep->syncinterval = get_endpoint(alts, 1)->bInterval - 1;
+		else
+			ep->syncinterval = 3;
+
+		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
+	}
+
+	list_add_tail(&ep->list, &chip->ep_list);
+
+__exit_unlock:
+	mutex_unlock(&chip->mutex);
+
+	return ep;
+}
+
+/*
+ *  wait until all urbs are processed.
+ */
+static int wait_clear_urbs(struct snd_usb_endpoint *ep)
+{
+	unsigned long end_time = jiffies + msecs_to_jiffies(1000);
+	unsigned int i;
+	int alive;
+
+	do {
+		alive = 0;
+		for (i = 0; i < ep->nurbs; i++)
+			if (test_bit(i, &ep->active_mask))
+				alive++;
+
+		if (!alive)
+			break;
+
+		schedule_timeout_uninterruptible(1);
+	} while (time_before(jiffies, end_time));
+
+	if (alive)
+		snd_printk(KERN_ERR "timeout: still %d active urbs on EP #%x\n",
+					alive, ep->ep_num);
+
+	return 0;
+}
+
+/*
+ * unlink active urbs.
+ */
+static int deactivate_urbs(struct snd_usb_endpoint *ep, int force, int can_sleep)
+{
+	unsigned long flags;
+	unsigned int i;
+	int async;
+
+	if (!force && ep->chip->shutdown) /* to be sure... */
+		return -EBADFD;
+
+	async = !can_sleep && ep->chip->async_unlink;
+
+	clear_bit(EP_FLAG_RUNNING, &ep->flags);
+
+	INIT_LIST_HEAD(&ep->ready_playback_urbs);
+	ep->next_packet_read_pos = 0;
+	ep->next_packet_write_pos = 0;
+
+	if (!async && in_interrupt())
+		return 0;
+
+	for (i = 0; i < ep->nurbs; i++) {
+		if (test_bit(i, &ep->active_mask)) {
+			if (!test_and_set_bit(i, &ep->unlink_mask)) {
+				struct urb *u = ep->urb[i].urb;
+				if (async)
+					usb_unlink_urb(u);
+				else
+					usb_kill_urb(u);
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * release an endpoint's urbs
+ */
+static void release_urbs(struct snd_usb_endpoint *ep, int force)
+{
+	int i;
+
+	/* route incoming urbs to nirvana */
+	ep->retire_data_urb = NULL;
+	ep->prepare_data_urb = NULL;
+
+	/* stop urbs */
+	deactivate_urbs(ep, force, 1);
+	wait_clear_urbs(ep);
+
+	for (i = 0; i < ep->nurbs; i++)
+		release_urb_ctx(&ep->urb[i]);
+
+	if (ep->syncbuf)
+		usb_free_coherent(ep->chip->dev, SYNC_URBS * 4,
+				  ep->syncbuf, ep->sync_dma);
+
+	ep->syncbuf = NULL;
+	ep->nurbs = 0;
+}
+
+static int data_ep_set_params(struct snd_usb_endpoint *ep,
+			      struct snd_pcm_hw_params *hw_params,
+			      struct audioformat *fmt,
+			      struct snd_usb_endpoint *sync_ep)
+{
+	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
+	int period_bytes = params_period_bytes(hw_params);
+	int format = params_format(hw_params);
+	int is_playback = usb_pipeout(ep->pipe);
+	int frame_bits = snd_pcm_format_physical_width(params_format(hw_params)) *
+							params_channels(hw_params);
+
+	ep->datainterval = fmt->datainterval;
+	ep->stride = frame_bits >> 3;
+	ep->silence_value = format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
+
+	/* calculate max. frequency */
+	if (ep->maxpacksize) {
+		/* whatever fits into a max. size packet */
+		maxsize = ep->maxpacksize;
+		ep->freqmax = (maxsize / (frame_bits >> 3))
+				<< (16 - ep->datainterval);
+	} else {
+		/* no max. packet size: just take 25% higher than nominal */
+		ep->freqmax = ep->freqn + (ep->freqn >> 2);
+		maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
+				>> (16 - ep->datainterval);
+	}
+
+	if (ep->fill_max)
+		ep->curpacksize = ep->maxpacksize;
+	else
+		ep->curpacksize = maxsize;
+
+	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL)
+		packs_per_ms = 8 >> ep->datainterval;
+	else
+		packs_per_ms = 1;
+
+	if (is_playback && !snd_usb_endpoint_implict_feedback_sink(ep)) {
+		urb_packs = max(ep->chip->nrpacks, 1);
+		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
+	} else {
+		urb_packs = 1;
+	}
+
+	urb_packs *= packs_per_ms;
+
+	if (sync_ep && !snd_usb_endpoint_implict_feedback_sink(ep))
+		urb_packs = min(urb_packs, 1U << sync_ep->syncinterval);
+
+	/* decide how many packets to be used */
+	if (is_playback && !snd_usb_endpoint_implict_feedback_sink(ep)) {
+		unsigned int minsize, maxpacks;
+		/* determine how small a packet can be */
+		minsize = (ep->freqn >> (16 - ep->datainterval))
+			  * (frame_bits >> 3);
+		/* with sync from device, assume it can be 12% lower */
+		if (sync_ep)
+			minsize -= minsize >> 3;
+		minsize = max(minsize, 1u);
+		total_packs = (period_bytes + minsize - 1) / minsize;
+		/* we need at least two URBs for queueing */
+		if (total_packs < 2) {
+			total_packs = 2;
+		} else {
+			/* and we don't want too long a queue either */
+			maxpacks = max(MAX_QUEUE * packs_per_ms, urb_packs * 2);
+			total_packs = min(total_packs, maxpacks);
+		}
+	} else {
+		while (urb_packs > 1 && urb_packs * maxsize >= period_bytes)
+			urb_packs >>= 1;
+		total_packs = MAX_URBS * urb_packs;
+	}
+
+	ep->nurbs = (total_packs + urb_packs - 1) / urb_packs;
+	if (ep->nurbs > MAX_URBS) {
+		/* too much... */
+		ep->nurbs = MAX_URBS;
+		total_packs = MAX_URBS * urb_packs;
+	} else if (ep->nurbs < 2) {
+		/* too little - we need at least two packets
+		 * to ensure contiguous playback/capture
+		 */
+		ep->nurbs = 2;
+	}
+
+	/* allocate and initialize data urbs */
+	for (i = 0; i < ep->nurbs; i++) {
+		struct snd_urb_ctx *u = &ep->urb[i];
+		u->index = i;
+		u->ep = ep;
+		u->packets = (i + 1) * total_packs / ep->nurbs
+			- i * total_packs / ep->nurbs;
+		u->buffer_size = maxsize * u->packets;
+
+		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
+			u->packets++; /* for transfer delimiter */
+		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
+		if (!u->urb)
+			goto out_of_memory;
+
+		u->urb->transfer_buffer =
+			usb_alloc_coherent(ep->chip->dev, u->buffer_size,
+					   GFP_KERNEL, &u->urb->transfer_dma);
+		if (!u->urb->transfer_buffer)
+			goto out_of_memory;
+		u->urb->pipe = ep->pipe;
+		u->urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+		u->urb->interval = 1 << ep->datainterval;
+		u->urb->context = u;
+		u->urb->complete = snd_complete_urb;
+		INIT_LIST_HEAD(&u->ready_list);
+	}
+
+	return 0;
+
+out_of_memory:
+	release_urbs(ep, 0);
+	return -ENOMEM;
+}
+
+static int sync_ep_set_params(struct snd_usb_endpoint *ep,
+			      struct snd_pcm_hw_params *hw_params,
+			      struct audioformat *fmt)
+{
+	int i;
+
+	ep->syncbuf = usb_alloc_coherent(ep->chip->dev, SYNC_URBS * 4,
+					 GFP_KERNEL, &ep->sync_dma);
+	if (!ep->syncbuf)
+		return -ENOMEM;
+
+	for (i = 0; i < SYNC_URBS; i++) {
+		struct snd_urb_ctx *u = &ep->urb[i];
+		u->index = i;
+		u->ep = ep;
+		u->packets = 1;
+		u->urb = usb_alloc_urb(1, GFP_KERNEL);
+		if (!u->urb)
+			goto out_of_memory;
+		u->urb->transfer_buffer = ep->syncbuf + i * 4;
+		u->urb->transfer_dma = ep->sync_dma + i * 4;
+		u->urb->transfer_buffer_length = 4;
+		u->urb->pipe = ep->pipe;
+		u->urb->transfer_flags = URB_ISO_ASAP |
+					 URB_NO_TRANSFER_DMA_MAP;
+		u->urb->number_of_packets = 1;
+		u->urb->interval = 1 << ep->syncinterval;
+		u->urb->context = u;
+		u->urb->complete = snd_complete_urb;
+	}
+
+	ep->nurbs = SYNC_URBS;
+
+	return 0;
+
+out_of_memory:
+	release_urbs(ep, 0);
+	return -ENOMEM;
+}
+
+int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
+				struct snd_pcm_hw_params *hw_params,
+				struct audioformat *fmt,
+				struct snd_usb_endpoint *sync_ep)
+{
+	int err;
+
+	if (ep->use_count != 0) {
+		snd_printk(KERN_WARNING "Unable to change format on ep #%x: already in use\n",
+			   ep->ep_num);
+		return -EBUSY;
+	}
+
+	/* release old buffers, if any */
+	release_urbs(ep, 0);
+
+	ep->datainterval = fmt->datainterval;
+	ep->maxpacksize = fmt->maxpacksize;
+	ep->fill_max = fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX;
+
+	if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_FULL)
+		ep->freqn = get_usb_full_speed_rate(params_rate(hw_params));
+	else
+		ep->freqn = get_usb_high_speed_rate(params_rate(hw_params));
+
+	/* calculate the frequency in 16.16 format */
+	ep->freqm = ep->freqn;
+	ep->freqshift = INT_MIN;
+
+	ep->phase = 0;
+
+	switch (ep->type) {
+	case  SND_USB_ENDPOINT_TYPE_DATA:
+		err = data_ep_set_params(ep, hw_params, fmt, sync_ep);
+		break;
+	case  SND_USB_ENDPOINT_TYPE_SYNC:
+		err = sync_ep_set_params(ep, hw_params, fmt);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	snd_printdd(KERN_DEBUG "Setting params for ep #%x (type %d, %d urbs), ret=%d\n",
+		   ep->ep_num, ep->type, ep->nurbs, err);
+
+	return err;
+}
+
+int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
+{
+	int err;
+	unsigned int i;
+
+	if (ep->chip->shutdown)
+		return -EBADFD;
+
+	/* already running? */
+	if (++ep->use_count != 1)
+		return 0;
+
+	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
+		return -EINVAL;
+
+	/* just to be sure */
+	deactivate_urbs(ep, 0, 1);
+	wait_clear_urbs(ep);
+
+	ep->active_mask = 0;
+	ep->unlink_mask = 0;
+	ep->phase = 0;
+
+	/*
+	 * If this endpoint has a data endpoint as implicit feedback source,
+	 * don't start the urbs here. Instead, mark them all as available,
+	 * wait for the record urbs to arrive and queue from that context.
+	 */
+
+	set_bit(EP_FLAG_RUNNING, &ep->flags);
+
+	if (snd_usb_endpoint_implict_feedback_sink(ep)) {
+		for (i = 0; i < ep->nurbs; i++) {
+			struct snd_urb_ctx *ctx = ep->urb + i;
+			list_add_tail(&ctx->ready_list, &ep->ready_playback_urbs);
+		}
+
+		return 0;
+	}
+
+	for (i = 0; i < ep->nurbs; i++) {
+		struct urb *urb = ep->urb[i].urb;
+
+		if (snd_BUG_ON(!urb))
+			goto __error;
+
+		if (usb_pipeout(ep->pipe)) {
+			prepare_outbound_urb_sizes(ep, urb->context);
+			prepare_outbound_urb(ep, urb->context);
+		} else {
+			prepare_inbound_urb(ep, urb->context);
+		}
+
+		err = usb_submit_urb(urb, GFP_ATOMIC);
+		if (err < 0) {
+			snd_printk(KERN_ERR "cannot submit urb %d, error %d: %s\n",
+				   i, err, usb_error_string(err));
+			goto __error;
+		}
+		set_bit(i, &ep->active_mask);
+	}
+
+	return 0;
+
+__error:
+	clear_bit(EP_FLAG_RUNNING, &ep->flags);
+	ep->use_count--;
+	deactivate_urbs(ep, 0, 0);
+	return -EPIPE;
+}
+
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
+			   int force, int can_sleep, int wait)
+{
+	if (!ep)
+		return;
+
+	if (snd_BUG_ON(ep->use_count == 0))
+		return;
+
+	if (snd_BUG_ON(!test_bit(EP_FLAG_ACTIVATED, &ep->flags)))
+		return;
+
+	if (--ep->use_count == 0) {
+		deactivate_urbs(ep, force, can_sleep);
+		ep->data_subs = NULL;
+		ep->sync_slave = NULL;
+		ep->retire_data_urb = NULL;
+		ep->prepare_data_urb = NULL;
+
+		if (wait)
+			wait_clear_urbs(ep);
+	}
+}
+
+int snd_usb_endpoint_activate(struct snd_usb_endpoint *ep)
+{
+	if (ep->use_count != 0)
+		return 0;
+
+	if (!ep->chip->shutdown &&
+	    !test_and_set_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
+		int ret;
+
+		ret = usb_set_interface(ep->chip->dev, ep->iface, ep->alt_idx);
+		if (ret < 0) {
+			snd_printk(KERN_ERR "%s() usb_set_interface() failed, ret = %d\n",
+						__func__, ret);
+			clear_bit(EP_FLAG_ACTIVATED, &ep->flags);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	return -EBUSY;
+}
+
+int snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep)
+{
+	if (!ep)
+		return -EINVAL;
+
+	if (ep->use_count != 0)
+		return 0;
+
+	if (!ep->chip->shutdown &&
+	    test_and_clear_bit(EP_FLAG_ACTIVATED, &ep->flags)) {
+		int ret;
+
+		ret = usb_set_interface(ep->chip->dev, ep->iface, 0);
+		if (ret < 0) {
+			snd_printk(KERN_ERR "%s(): usb_set_interface() failed, ret = %d\n",
+						__func__, ret);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	return -EBUSY;
+}
+
+void snd_usb_endpoint_free(struct list_head *head)
+{
+	struct snd_usb_endpoint *ep;
+
+	ep = list_entry(head, struct snd_usb_endpoint, list);
+	release_urbs(ep, 1);
+	kfree(ep);
+}
+
+/*
+ * process after playback sync complete
+ *
+ * Full speed devices report feedback values in 10.14 format as samples per
+ * frame, high speed devices in 16.16 format as samples per microframe.
+ * Because the Audio Class 1 spec was written before USB 2.0, many high speed
+ * devices use a wrong interpretation, some others use an entirely different
+ * format.  Therefore, we cannot predict what format any particular device uses
+ * and must detect it automatically.
+ */
+void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
+			     struct snd_usb_endpoint *sender,
+			     const struct urb *urb)
+{
+	int shift;
+	unsigned int f;
+	unsigned long flags;
+
+	snd_BUG_ON(ep == sender);
+
+	if (snd_usb_endpoint_implict_feedback_sink(ep) &&
+	    ep->use_count != 0) {
+
+		/* implicit feedback case */
+		int i, bytes = 0;
+		struct snd_urb_ctx *in_ctx;
+		struct snd_usb_packet_info *out_packet;
+
+		in_ctx = urb->context;
+
+		/* Count overall packet size */
+		for (i = 0; i < in_ctx->packets; i++)
+			if (urb->iso_frame_desc[i].status == 0)
+				bytes += urb->iso_frame_desc[i].actual_length;
+
+		/*
+		 * skip empty packets. At least M-Audio's Fast Track Ultra stops
+		 * streaming once it received a 0-byte OUT URB
+		 */
+		if (bytes == 0)
+			return;
+
+		spin_lock_irqsave(&ep->lock, flags);
+		out_packet = ep->next_packet + ep->next_packet_write_pos;
+
+		/*
+		 * Iterate through the inbound packet and prepare the lengths
+		 * for the output packet. The OUT packet we are about to send
+		 * will have the same amount of payload than the IN packet we
+		 * just received.
+		 */
+
+		out_packet->packets = in_ctx->packets;
+		for (i = 0; i < in_ctx->packets; i++) {
+			if (urb->iso_frame_desc[i].status == 0)
+				out_packet->packet_size[i] =
+					urb->iso_frame_desc[i].actual_length / ep->stride;
+			else
+				out_packet->packet_size[i] = 0;
+		}
+
+		ep->next_packet_write_pos++;
+		ep->next_packet_write_pos %= MAX_URBS;
+		spin_unlock_irqrestore(&ep->lock, flags);
+		queue_pending_output_urbs(ep);
+
+		return;
+	}
+
+	/* parse sync endpoint packet */
+
+	if (urb->iso_frame_desc[0].status != 0 ||
+	    urb->iso_frame_desc[0].actual_length < 3)
+		return;
+
+	f = le32_to_cpup(urb->transfer_buffer);
+	if (urb->iso_frame_desc[0].actual_length == 3)
+		f &= 0x00ffffff;
+	else
+		f &= 0x0fffffff;
+
+	if (f == 0)
+		return;
+
+	if (unlikely(ep->freqshift == INT_MIN)) {
+		/*
+		 * The first time we see a feedback value, determine its format
+		 * by shifting it left or right until it matches the nominal
+		 * frequency value.  This assumes that the feedback does not
+		 * differ from the nominal value more than +50% or -25%.
+		 */
+		shift = 0;
+		while (f < ep->freqn - ep->freqn / 4) {
+			f <<= 1;
+			shift++;
+		}
+		while (f > ep->freqn + ep->freqn / 2) {
+			f >>= 1;
+			shift--;
+		}
+		ep->freqshift = shift;
+	}
+	else if (ep->freqshift >= 0)
+		f <<= ep->freqshift;
+	else
+		f >>= -ep->freqshift;
+
+	if (likely(f >= ep->freqn - ep->freqn / 8 && f <= ep->freqmax)) {
+		/*
+		 * If the frequency looks valid, set it.
+		 * This value is referred to in prepare_playback_urb().
+		 */
+		spin_lock_irqsave(&ep->lock, flags);
+		ep->freqm = f;
+		spin_unlock_irqrestore(&ep->lock, flags);
+	} else {
+		/*
+		 * Out of range; maybe the shift value is wrong.
+		 * Reset it so that we autodetect again the next time.
+		 */
+		ep->freqshift = INT_MIN;
+	}
+}
+
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 88eb63a..9f083d7 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -18,4 +18,30 @@ int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int cmd);
 int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd);
 
+
+#define SND_USB_ENDPOINT_TYPE_DATA     0
+#define SND_USB_ENDPOINT_TYPE_SYNC     1
+
+struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
+					      struct usb_host_interface *alts,
+					      int ep_num, int direction, int type);
+
+int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
+				struct snd_pcm_hw_params *hw_params,
+				struct audioformat *fmt,
+				struct snd_usb_endpoint *sync_ep);
+
+int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
+void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep,
+			   int force, int can_sleep, int wait);
+int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
+int  snd_usb_endpoint_deactivate(struct snd_usb_endpoint *ep);
+void snd_usb_endpoint_free(struct list_head *head);
+
+int snd_usb_endpoint_implict_feedback_sink(struct snd_usb_endpoint *ep);
+
+void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
+			     struct snd_usb_endpoint *sender,
+			     const struct urb *urb);
+
 #endif /* __USBAUDIO_ENDPOINT_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index a16c21d..b8233eb 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -47,6 +47,7 @@ struct snd_usb_audio {
 	int num_suspended_intf;
 
 	struct list_head pcm_list;	/* list of pcm streams */
+	struct list_head ep_list;	/* list of audio-related endpoints */
 	int pcm_devs;
 
 	struct list_head midi_list;	/* list of midi interfaces */
-- 
1.7.7.6
