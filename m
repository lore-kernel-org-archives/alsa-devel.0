From: Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 2/3] snd-bcd2000: add playback and capture
	support
Date: Sat, 31 Jan 2015 22:34:24 +0100
Message-ID: <1422740065-20196-3-git-send-email-dev@kicherer.org>
References: <1422740065-20196-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 648B4260529
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 22:34:31 +0100 (CET)
In-Reply-To: <1422740065-20196-1-git-send-email-dev@kicherer.org>
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
Cc: Mario Kicherer <dev@kicherer.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 sound/usb/bcd2000/Makefile  |   2 +-
 sound/usb/bcd2000/audio.c   | 632 ++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/bcd2000/audio.h   |  58 ++++
 sound/usb/bcd2000/bcd2000.c |   6 +
 sound/usb/bcd2000/bcd2000.h |   2 +
 5 files changed, 699 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/bcd2000/audio.c
 create mode 100644 sound/usb/bcd2000/audio.h

diff --git a/sound/usb/bcd2000/Makefile b/sound/usb/bcd2000/Makefile
index bc64a21..d424dff 100644
--- a/sound/usb/bcd2000/Makefile
+++ b/sound/usb/bcd2000/Makefile
@@ -1,3 +1,3 @@
-snd-bcd2000-y := bcd2000.o midi.o
+snd-bcd2000-y := bcd2000.o audio.o midi.o
 
 obj-$(CONFIG_SND_BCD2000) += snd-bcd2000.o
\ No newline at end of file
diff --git a/sound/usb/bcd2000/audio.c b/sound/usb/bcd2000/audio.c
new file mode 100644
index 0000000..26f958a
--- /dev/null
+++ b/sound/usb/bcd2000/audio.c
@@ -0,0 +1,632 @@
+/*
+ * Behringer BCD2000 driver
+ *
+ *   Copyright (C) 2014 Mario Kicherer (dev@kicherer.org)
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "audio.h"
+#include "bcd2000.h"
+
+static struct snd_pcm_hardware bcd2000_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BATCH |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+	.rates		= SNDRV_PCM_RATE_44100,
+	.rate_min	= 44100,
+	.rate_max	= 44100,
+	.channels_min	= 4,
+	.channels_max	= 4,
+	.buffer_bytes_max = ALSA_BUFFER_SIZE,
+	.period_bytes_min = BYTES_PER_PERIOD,
+	.period_bytes_max = ALSA_BUFFER_SIZE,
+	.periods_min	= 1,
+	.periods_max	= PERIODS_MAX,
+};
+
+enum {
+	STREAM_DISABLED, /* no pcm streaming */
+	STREAM_STARTING, /* pcm streaming requested, waiting to become ready */
+	STREAM_RUNNING,  /* pcm streaming running */
+	STREAM_STOPPING
+};
+
+/* copy the audio frames from the URB packets into the ALSA buffer */
+static void bcd2000_pcm_capture(struct bcd2000_substream *sub,
+				struct bcd2000_urb *urb)
+{
+	int i, frame, frame_count, bytes_per_frame;
+	void *src, *dest, *dest_end;
+	struct bcd2000_pcm *rt;
+	struct snd_pcm_runtime *alsa_rt;
+
+	rt = snd_pcm_substream_chip(sub->instance);
+	alsa_rt = sub->instance->runtime;
+
+	dest = (alsa_rt->dma_area + sub->dma_off);
+	dest_end = alsa_rt->dma_area +
+				frames_to_bytes(alsa_rt, alsa_rt->buffer_size);
+
+	bytes_per_frame = alsa_rt->frame_bits / 8;
+	src = urb->buffer;
+
+	for (i = 0; i < USB_N_PACKETS_PER_URB; i++) {
+		frame_count = urb->packets[i].actual_length / bytes_per_frame;
+
+		for (frame = 0; frame < frame_count; frame++) {
+			memcpy(dest, src, bytes_per_frame);
+
+			dest += bytes_per_frame;
+			src += bytes_per_frame;
+			sub->dma_off += bytes_per_frame;
+			sub->period_off += bytes_per_frame;
+
+			if (dest >= dest_end) {
+				sub->dma_off = 0;
+				dest = alsa_rt->dma_area;
+			}
+		}
+
+		/*
+		 * if packet was not full, make src point to the
+		 * data of the next packet
+		 */
+		src += urb->packets[i].length - urb->packets[i].actual_length;
+	}
+}
+
+/* handle incoming URB with captured data */
+static void bcd2000_pcm_in_urb_handler(struct urb *usb_urb)
+{
+	struct bcd2000_urb *bcd2k_urb = usb_urb->context;
+	struct bcd2000_pcm *pcm = &bcd2k_urb->bcd2k->pcm;
+	struct bcd2000_substream *stream = bcd2k_urb->stream;
+	unsigned long flags;
+	int ret, k, period_bytes;
+	struct usb_iso_packet_descriptor *packet;
+
+	if (pcm->panic || stream->state == STREAM_STOPPING)
+		return;
+
+	if (unlikely(usb_urb->status == -ENOENT ||	/* unlinked */
+		usb_urb->status == -ENODEV ||		/* device removed */
+		usb_urb->status == -ECONNRESET ||	/* unlinked */
+		usb_urb->status == -ESHUTDOWN))		/* device disabled */
+	{
+		goto out_fail;
+	}
+
+	if (stream->state == STREAM_STARTING) {
+		stream->wait_cond = true;
+		wake_up(&stream->wait_queue);
+	}
+
+	if (stream->active) {
+		spin_lock_irqsave(&stream->lock, flags);
+
+		/* copy captured data into ALSA buffer */
+		bcd2000_pcm_capture(stream, bcd2k_urb);
+
+		period_bytes = snd_pcm_lib_period_bytes(stream->instance);
+
+		/* do we have enough data for one period? */
+		if (stream->period_off > period_bytes) {
+			stream->period_off %= period_bytes;
+
+			spin_unlock_irqrestore(&stream->lock, flags);
+
+			/*
+			 * call this only once even if multiple periods
+			 * are ready
+			 */
+			snd_pcm_period_elapsed(stream->instance);
+
+			memset(bcd2k_urb->buffer, 0, USB_BUFFER_SIZE);
+		} else {
+			spin_unlock_irqrestore(&stream->lock, flags);
+			memset(bcd2k_urb->buffer, 0, USB_BUFFER_SIZE);
+		}
+	} else {
+		memset(bcd2k_urb->buffer, 0, USB_BUFFER_SIZE);
+	}
+
+	/* reset URB data */
+	for (k = 0; k < USB_N_PACKETS_PER_URB; k++) {
+		packet = &bcd2k_urb->packets[k];
+		packet->offset = k * USB_PACKET_SIZE;
+		packet->length = USB_PACKET_SIZE;
+		packet->actual_length = 0;
+		packet->status = 0;
+	}
+	bcd2k_urb->instance.number_of_packets = USB_N_PACKETS_PER_URB;
+
+	/* send the URB back to the BCD2000 */
+	ret = usb_submit_urb(&bcd2k_urb->instance, GFP_ATOMIC);
+	if (ret < 0)
+		goto out_fail;
+
+	return;
+
+out_fail:
+	dev_info(&bcd2k_urb->bcd2k->dev->dev, PREFIX "error in in_urb handler");
+	pcm->panic = true;
+}
+
+/* copy audio frame from ALSA buffer into the URB packet */
+static void bcd2000_pcm_playback(struct bcd2000_substream *sub,
+				 struct bcd2000_urb *urb)
+{
+	int i, frame, frame_count, bytes_per_frame;
+	void *src, *src_end, *dest;
+	struct bcd2000_pcm *rt;
+	struct snd_pcm_runtime *alsa_rt;
+
+	rt = snd_pcm_substream_chip(sub->instance);
+	alsa_rt = sub->instance->runtime;
+
+	src = (alsa_rt->dma_area + sub->dma_off);
+	src_end = alsa_rt->dma_area +
+				frames_to_bytes(alsa_rt, alsa_rt->buffer_size);
+
+	bytes_per_frame = alsa_rt->frame_bits / 8;
+	dest = urb->buffer;
+
+	for (i = 0; i < USB_N_PACKETS_PER_URB; i++) {
+		frame_count = urb->packets[i].length / bytes_per_frame;
+
+		for (frame = 0; frame < frame_count; frame++) {
+			memcpy(dest, src, bytes_per_frame);
+
+			src += bytes_per_frame;
+			dest += bytes_per_frame;
+			sub->dma_off += bytes_per_frame;
+			sub->period_off += bytes_per_frame;
+
+			if (src >= src_end) {
+				sub->dma_off = 0;
+				src = alsa_rt->dma_area;
+			}
+		}
+	}
+}
+
+/* refill empty URB that comes back from the BCD2000 */
+static void bcd2000_pcm_out_urb_handler(struct urb *usb_urb)
+{
+	struct bcd2000_urb *bcd2k_urb = usb_urb->context;
+	struct bcd2000_pcm *pcm = &bcd2k_urb->bcd2k->pcm;
+	struct bcd2000_substream *stream = bcd2k_urb->stream;
+	unsigned long flags;
+	int ret, k, period_bytes;
+	struct usb_iso_packet_descriptor *packet;
+
+
+	if (pcm->panic || stream->state == STREAM_STOPPING)
+		return;
+
+	if (unlikely(usb_urb->status == -ENOENT ||	/* unlinked */
+		usb_urb->status == -ENODEV ||		/* device removed */
+		usb_urb->status == -ECONNRESET ||	/* unlinked */
+		usb_urb->status == -ESHUTDOWN))		/* device disabled */
+	{
+		goto out_fail;
+	}
+
+	if (stream->state == STREAM_STARTING) {
+		stream->wait_cond = true;
+		wake_up(&stream->wait_queue);
+	}
+
+	if (stream->active) {
+		spin_lock_irqsave(&stream->lock, flags);
+
+		memset(bcd2k_urb->buffer, 0, USB_BUFFER_SIZE);
+
+		/* fill URB with data from ALSA */
+		bcd2000_pcm_playback(stream, bcd2k_urb);
+
+		period_bytes = snd_pcm_lib_period_bytes(stream->instance);
+
+		/* check if a complete period was written into the URB */
+		if (stream->period_off > period_bytes) {
+			stream->period_off %= period_bytes;
+
+			spin_unlock_irqrestore(&stream->lock, flags);
+
+			snd_pcm_period_elapsed(stream->instance);
+		} else {
+			spin_unlock_irqrestore(&stream->lock, flags);
+		}
+
+		for (k = 0; k < USB_N_PACKETS_PER_URB; k++) {
+			packet = &bcd2k_urb->packets[k];
+			packet->offset = k * USB_PACKET_SIZE;
+			packet->length = USB_PACKET_SIZE;
+			packet->actual_length = 0;
+			packet->status = 0;
+		}
+		bcd2k_urb->instance.number_of_packets = USB_N_PACKETS_PER_URB;
+
+		ret = usb_submit_urb(&bcd2k_urb->instance, GFP_ATOMIC);
+		if (ret < 0)
+			goto out_fail;
+	}
+
+	return;
+
+out_fail:
+	dev_info(&bcd2k_urb->bcd2k->dev->dev, PREFIX
+		"error in out_urb handler");
+	pcm->panic = true;
+}
+
+static void bcd2000_pcm_stream_stop(struct bcd2000_pcm *pcm,
+				    struct bcd2000_substream *stream)
+{
+	int i;
+
+	if (stream->state != STREAM_DISABLED) {
+		stream->state = STREAM_STOPPING;
+
+		for (i = 0; i < USB_N_URBS; i++)
+			usb_kill_urb(&stream->urbs[i].instance);
+
+		stream->state = STREAM_DISABLED;
+	}
+}
+
+static int bcd2000_substream_open(struct snd_pcm_substream *substream)
+{
+	struct bcd2000_substream *stream = NULL;
+	struct bcd2000_pcm *pcm = snd_pcm_substream_chip(substream);
+
+	substream->runtime->hw = pcm->pcm_info;
+
+	if (pcm->panic)
+		return -EPIPE;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &pcm->playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		stream = &pcm->capture;
+
+	if (!stream) {
+		dev_err(&pcm->bcd2k->dev->dev, PREFIX "invalid stream type\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&stream->mutex);
+	stream->instance = substream;
+	stream->active = false;
+	mutex_unlock(&stream->mutex);
+
+	return 0;
+}
+
+static int bcd2000_substream_close(struct snd_pcm_substream *substream)
+{
+	unsigned long flags;
+	struct bcd2000_pcm *pcm = snd_pcm_substream_chip(substream);
+	struct bcd2000_substream *stream = NULL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &pcm->playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		stream = &pcm->capture;
+
+	if (pcm->panic)
+		return 0;
+
+	mutex_lock(&stream->mutex);
+	if (stream) {
+		bcd2000_pcm_stream_stop(pcm, stream);
+
+		spin_lock_irqsave(&stream->lock, flags);
+		stream->instance = NULL;
+		stream->active = false;
+		spin_unlock_irqrestore(&stream->lock, flags);
+	}
+	mutex_unlock(&stream->mutex);
+
+	return 0;
+}
+
+static int bcd2000_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params)
+{
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					params_buffer_bytes(hw_params));
+}
+
+static int bcd2000_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int bcd2000_pcm_stream_start(struct bcd2000_pcm *pcm,
+				    struct bcd2000_substream *stream)
+{
+	int ret;
+	int i, k;
+	struct usb_iso_packet_descriptor *packet;
+
+	if (stream->state == STREAM_DISABLED) {
+		/* reset panic state when starting a new stream */
+		pcm->panic = false;
+
+		stream->state = STREAM_STARTING;
+
+		/* initialize data of each URB */
+		for (i = 0; i < USB_N_URBS; i++) {
+			for (k = 0; k < USB_N_PACKETS_PER_URB; k++) {
+				packet = &stream->urbs[i].packets[k];
+				packet->offset = k * USB_PACKET_SIZE;
+				packet->length = USB_PACKET_SIZE;
+				packet->actual_length = 0;
+				packet->status = 0;
+			}
+
+			/* immediately send data with the first audio out URB */
+			if (stream->instance == SNDRV_PCM_STREAM_PLAYBACK)
+				bcd2000_pcm_playback(stream, &stream->urbs[i]);
+
+			ret = usb_submit_urb(&stream->urbs[i].instance,
+					     GFP_ATOMIC);
+			if (ret) {
+				bcd2000_pcm_stream_stop(pcm, stream);
+				return ret;
+			}
+		}
+
+		/* wait for first out urb to return (sent in in urb handler) */
+		wait_event_timeout(stream->wait_queue,
+						   stream->wait_cond, HZ);
+		if (stream->wait_cond) {
+			dev_dbg(&pcm->bcd2k->dev->dev, PREFIX
+				"%s: stream is running wakeup event\n",
+				__func__);
+			stream->state = STREAM_RUNNING;
+		} else {
+			bcd2000_pcm_stream_stop(pcm, stream);
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int bcd2000_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct bcd2000_pcm *pcm = snd_pcm_substream_chip(substream);
+	int ret;
+	struct bcd2000_substream *stream = NULL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &pcm->playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		stream = &pcm->capture;
+
+	if (pcm->panic)
+		return -EPIPE;
+
+	if (!stream)
+		return -ENODEV;
+
+	mutex_lock(&stream->mutex);
+	stream->dma_off = 0;
+	stream->period_off = 0;
+
+	if (stream->state == STREAM_DISABLED) {
+		ret = bcd2000_pcm_stream_start(pcm, stream);
+		if (ret) {
+			mutex_unlock(&stream->mutex);
+			dev_err(&pcm->bcd2k->dev->dev, PREFIX
+					"could not start pcm stream\n");
+			return ret;
+		}
+	}
+	mutex_unlock(&stream->mutex);
+	return 0;
+}
+
+static int bcd2000_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct bcd2000_pcm *pcm = snd_pcm_substream_chip(substream);
+	struct bcd2000_substream *stream = NULL;
+	unsigned long flags;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &pcm->playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		stream = &pcm->capture;
+
+	if (pcm->panic)
+		return -EPIPE;
+
+	if (!stream)
+		return -ENODEV;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock_irqsave(&stream->lock, flags);
+		stream->active = true;
+		spin_unlock_irqrestore(&stream->lock, flags);
+
+		return 0;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock_irqsave(&stream->lock, flags);
+		stream->active = false;
+		spin_unlock_irqrestore(&stream->lock, flags);
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static snd_pcm_uframes_t
+bcd2000_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct bcd2000_pcm *pcm = snd_pcm_substream_chip(substream);
+	unsigned long flags;
+	snd_pcm_uframes_t ret;
+	struct bcd2000_substream *stream = NULL;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		stream = &pcm->playback;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		stream = &pcm->capture;
+
+	if (pcm->panic || !stream)
+		return SNDRV_PCM_POS_XRUN;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	/*
+	 * return the number of the last written period in the
+	 * ALSA ring buffer
+	 */
+	ret = bytes_to_frames(stream->instance->runtime, stream->dma_off);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return ret;
+}
+
+static struct snd_pcm_ops bcd2000_ops = {
+	.open = bcd2000_substream_open,
+	.close = bcd2000_substream_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = bcd2000_pcm_hw_params,
+	.hw_free = bcd2000_pcm_hw_free,
+	.prepare = bcd2000_pcm_prepare,
+	.trigger = bcd2000_pcm_trigger,
+	.pointer = bcd2000_pcm_pointer,
+	.page = snd_pcm_lib_get_vmalloc_page,
+	.mmap = snd_pcm_lib_mmap_vmalloc,
+};
+
+static int bcd2000_pcm_init_urb(struct bcd2000_urb *urb,
+				struct bcd2000 *bcd2k,
+				char in, unsigned int ep,
+				void (*handler)(struct urb *))
+{
+	urb->bcd2k = bcd2k;
+	usb_init_urb(&urb->instance);
+
+	urb->buffer = kzalloc(USB_BUFFER_SIZE, GFP_KERNEL);
+	if (!urb->buffer)
+		return -ENOMEM;
+
+	urb->instance.transfer_buffer = urb->buffer;
+	urb->instance.transfer_buffer_length = USB_BUFFER_SIZE;
+	urb->instance.dev = bcd2k->dev;
+	urb->instance.pipe = in ? usb_rcvisocpipe(bcd2k->dev, ep)
+				: usb_sndisocpipe(bcd2k->dev, ep);
+	urb->instance.interval = 1;
+	urb->instance.complete = handler;
+	urb->instance.context = urb;
+	urb->instance.number_of_packets = USB_N_PACKETS_PER_URB;
+
+	return 0;
+}
+
+static void bcd2000_pcm_destroy(struct bcd2000 *bcd2k)
+{
+	int i;
+
+	for (i = 0; i < USB_N_URBS; i++) {
+		kfree(bcd2k->pcm.playback.urbs[i].buffer);
+		kfree(bcd2k->pcm.capture.urbs[i].buffer);
+	}
+}
+
+static void bcd2000_pcm_free(struct snd_pcm *pcm)
+{
+	struct bcd2000_pcm *bcd2k_pcm = pcm->private_data;
+
+	if (bcd2k_pcm)
+		bcd2000_pcm_destroy(bcd2k_pcm->bcd2k);
+}
+
+int bcd2000_init_stream(struct bcd2000 *bcd2k,
+			struct bcd2000_substream *stream, bool in)
+{
+	int i, ret;
+
+	stream->state = STREAM_DISABLED;
+
+	init_waitqueue_head(&stream->wait_queue);
+	mutex_init(&stream->mutex);
+
+	for (i = 0; i < USB_N_URBS; i++) {
+		ret = bcd2000_pcm_init_urb(&stream->urbs[i], bcd2k, in,
+					in ? 0x83 : 0x2,
+					in ? bcd2000_pcm_in_urb_handler
+					  : bcd2000_pcm_out_urb_handler);
+		if (ret) {
+			dev_err(&bcd2k->dev->dev, PREFIX
+					"%s: urb init failed, ret=%d: ",
+					__func__, ret);
+			return ret;
+		}
+		stream->urbs[i].stream = stream;
+	}
+
+	return 0;
+}
+
+int bcd2000_init_audio(struct bcd2000 *bcd2k)
+{
+	int ret;
+	struct bcd2000_pcm *pcm;
+
+	pcm = &bcd2k->pcm;
+	pcm->bcd2k = bcd2k;
+
+	spin_lock_init(&pcm->playback.lock);
+	spin_lock_init(&pcm->capture.lock);
+
+	bcd2000_init_stream(bcd2k, &pcm->playback, 0);
+	bcd2000_init_stream(bcd2k, &pcm->capture, 1);
+
+	ret = snd_pcm_new(bcd2k->card, DEVICENAME, 0, 1, 1, &pcm->instance);
+	if (ret < 0) {
+		dev_err(&bcd2k->dev->dev, PREFIX
+			"%s: snd_pcm_new() failed, ret=%d: ",
+			__func__, ret);
+		return ret;
+	}
+	pcm->instance->private_data = pcm;
+	pcm->instance->private_free = bcd2000_pcm_free;
+
+	strlcpy(pcm->instance->name, DEVICENAME, sizeof(pcm->instance->name));
+
+	memcpy(&pcm->pcm_info, &bcd2000_pcm_hardware,
+		sizeof(bcd2000_pcm_hardware));
+
+	snd_pcm_set_ops(pcm->instance, SNDRV_PCM_STREAM_PLAYBACK, &bcd2000_ops);
+	snd_pcm_set_ops(pcm->instance, SNDRV_PCM_STREAM_CAPTURE, &bcd2000_ops);
+
+	return 0;
+}
+
+void bcd2000_free_audio(struct bcd2000 *bcd2k)
+{
+}
diff --git a/sound/usb/bcd2000/audio.h b/sound/usb/bcd2000/audio.h
new file mode 100644
index 0000000..912e8df
--- /dev/null
+++ b/sound/usb/bcd2000/audio.h
@@ -0,0 +1,58 @@
+#ifndef AUDIO_H
+#define AUDIO_H
+
+#include <sound/pcm.h>
+
+#define USB_N_URBS 4
+#define USB_N_PACKETS_PER_URB 16
+#define USB_PACKET_SIZE 360
+#define USB_BUFFER_SIZE (USB_PACKET_SIZE * USB_N_PACKETS_PER_URB)
+
+#define BYTES_PER_PERIOD 3528
+#define PERIODS_MAX 128
+#define ALSA_BUFFER_SIZE (BYTES_PER_PERIOD * PERIODS_MAX)
+
+struct bcd2000;
+
+struct bcd2000_urb {
+	struct bcd2000 *bcd2k;
+	struct bcd2000_substream *stream;
+
+	/* BEGIN DO NOT SEPARATE */
+	struct urb instance;
+	struct usb_iso_packet_descriptor packets[USB_N_PACKETS_PER_URB];
+	/* END DO NOT SEPARATE */
+	u8 *buffer;
+};
+
+struct bcd2000_substream {
+	struct snd_pcm_substream *instance;
+
+	u8 state;
+	bool active;
+	snd_pcm_uframes_t dma_off; /* current position in alsa dma_area */
+	snd_pcm_uframes_t period_off; /* current position in current period */
+
+	struct bcd2000_urb urbs[USB_N_URBS];
+
+	spinlock_t lock;
+	struct mutex mutex;
+	wait_queue_head_t wait_queue;
+	bool wait_cond;
+};
+
+struct bcd2000_pcm {
+	struct bcd2000 *bcd2k;
+
+	struct snd_pcm *instance;
+	struct snd_pcm_hardware pcm_info;
+
+	struct bcd2000_substream playback;
+	struct bcd2000_substream capture;
+	bool panic; /* if set driver won't do anymore pcm on device */
+};
+
+int bcd2000_init_audio(struct bcd2000 *bcd2k);
+void bcd2000_free_audio(struct bcd2000 *bcd2k);
+
+#endif
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 0f22bd9..f7ba9ad 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -59,6 +59,8 @@ static void bcd2000_disconnect(struct usb_interface *interface)
 	/* make sure that userspace cannot create new requests */
 	snd_card_disconnect(bcd2k->card);
 
+	bcd2000_free_audio(bcd2k);
+
 	bcd2000_free_midi(bcd2k);
 
 	if (bcd2k->intf) {
@@ -120,6 +122,10 @@ static int bcd2000_probe(struct usb_interface *interface,
 	if (err < 0)
 		goto probe_error;
 
+	err = bcd2000_init_audio(bcd2k);
+	if (err < 0)
+		goto probe_error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto probe_error;
diff --git a/sound/usb/bcd2000/bcd2000.h b/sound/usb/bcd2000/bcd2000.h
index a0e27c9..802685b 100644
--- a/sound/usb/bcd2000/bcd2000.h
+++ b/sound/usb/bcd2000/bcd2000.h
@@ -9,6 +9,7 @@
 #define DEVICENAME "BCD2000"
 #define PREFIX "snd-bcd2000: "
 
+#include "audio.h"
 #include "midi.h"
 
 struct bcd2000 {
@@ -18,6 +19,7 @@ struct bcd2000 {
 	int card_index;
 
 	struct bcd2000_midi midi;
+	struct bcd2000_pcm pcm;
 };
 
 void bcd2000_dump_buffer(const char *prefix, const char *buf, int len);
-- 
2.0.5
