From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/15] ALSA: firewire-lib: complete AM824 data
	block processing layer
Date: Sat, 19 Sep 2015 11:22:02 +0900
Message-ID: <1442629322-15457-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 42D21260527
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:15 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit moves the codes related to data block processing from packet
streaming layer to AM824 layer.

Each driver initializes amdtp stream structure for AM824 data block by
calling amdtp_am824_init(). Then, a memory block is allocated for AM824
specific structure. This memory block is released by calling
amdtp_stream_destroy().

When setting streaming parameters, it calls amdtp_am824_set_parameters().
When starting packet streaming, it calls amdtp_stream_start(). When
stopping packet streaming, it calls amdtp_stream_stop().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c  | 349 ++++++++++++++++++++++++++++++++++++++++--
 sound/firewire/amdtp-am824.h  |  24 +++
 sound/firewire/amdtp-stream.c | 316 +++-----------------------------------
 sound/firewire/amdtp-stream.h |  62 ++------
 4 files changed, 401 insertions(+), 350 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index 540a101..945b471 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -1,11 +1,14 @@
 /*
  * AM824 format in Audio and Music Data Transmission Protocol (IEC 61883-6)
  *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
  * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
  *
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
+#include <linux/slab.h>
+
 #include "amdtp-am824.h"
 
 #define CIP_FMT_AM		0x10
@@ -13,6 +16,35 @@
 /* "Clock-based rate control mode" is just supported. */
 #define AMDTP_FDF_AM824		0x00
 
+/*
+ * Nominally 3125 bytes/second, but the MIDI port's clock might be
+ * 1% too slow, and the bus clock 100 ppm too fast.
+ */
+#define MIDI_BYTES_PER_SECOND	3093
+
+/*
+ * Several devices look only at the first eight data blocks.
+ * In any case, this is more than enough for the MIDI data rate.
+ */
+#define MAX_MIDI_RX_BLOCKS	8
+
+struct amdtp_am824 {
+	struct snd_rawmidi_substream *midi[AM824_MAX_CHANNELS_FOR_MIDI * 8];
+	int midi_fifo_limit;
+	int midi_fifo_used[AM824_MAX_CHANNELS_FOR_MIDI * 8];
+	unsigned int pcm_channels;
+	unsigned int midi_ports;
+
+	u8 pcm_positions[AM824_MAX_CHANNELS_FOR_PCM];
+	u8 midi_position;
+
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_substream *pcm,
+				 __be32 *buffer, unsigned int frames);
+
+	unsigned int frame_multiplier;
+};
+
 /**
  * amdtp_am824_set_parameters - set stream parameters
  * @s: the AMDTP stream to configure
@@ -30,23 +62,58 @@ int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 			       unsigned int midi_ports,
 			       bool double_pcm_frames)
 {
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int midi_channels;
+	unsigned int i;
 	int err;
 
-	err = amdtp_stream_set_parameters(s, rate, pcm_channels, midi_ports);
+	if (amdtp_stream_running(s))
+		return -EINVAL;
+
+	if (pcm_channels > AM824_MAX_CHANNELS_FOR_PCM)
+		return -EINVAL;
+
+	midi_channels = DIV_ROUND_UP(midi_ports, 8);
+	if (midi_channels > AM824_MAX_CHANNELS_FOR_MIDI)
+		return -EINVAL;
+
+	if (WARN_ON(amdtp_stream_running(s)) |
+	    WARN_ON(pcm_channels > AM824_MAX_CHANNELS_FOR_PCM) |
+	    WARN_ON(midi_channels > AM824_MAX_CHANNELS_FOR_MIDI))
+		return -EINVAL;
+
+	err = amdtp_stream_set_parameters(s, rate,
+					  pcm_channels + midi_channels);
 	if (err < 0)
 		return err;
 
 	s->fdf = AMDTP_FDF_AM824 | s->sfc;
 
+	p->pcm_channels = pcm_channels;
+	p->midi_ports = midi_ports;
+
 	/*
 	 * In IEC 61883-6, one data block represents one event. In ALSA, one
 	 * event equals to one PCM frame. But Dice has a quirk at higher
 	 * sampling rate to transfer two PCM frames in one data block.
 	 */
 	if (double_pcm_frames)
-		s->frame_multiplier = 2;
+		p->frame_multiplier = 2;
 	else
-		s->frame_multiplier = 1;
+		p->frame_multiplier = 1;
+
+	/* init the position map for PCM and MIDI channels */
+	for (i = 0; i < pcm_channels; i++)
+		p->pcm_positions[i] = i;
+	p->midi_position = p->pcm_channels;
+
+	/*
+	 * We do not know the actual MIDI FIFO size of most devices.  Just
+	 * assume two bytes, i.e., one byte can be received over the bus while
+	 * the previous one is transmitted over MIDI.
+	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 */
+	p->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
 
 	return 0;
 }
@@ -62,8 +129,10 @@ EXPORT_SYMBOL_GPL(amdtp_am824_set_parameters);
 void amdtp_am824_set_pcm_position(struct amdtp_stream *s, unsigned int index,
 				 unsigned int position)
 {
-	if (index < s->pcm_channels)
-		s->pcm_positions[index] = position;
+	struct amdtp_am824 *p = s->protocol;
+
+	if (index < p->pcm_channels)
+		p->pcm_positions[index] = position;
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_position);
 
@@ -76,10 +145,139 @@ EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_position);
 void amdtp_am824_set_midi_position(struct amdtp_stream *s,
 				   unsigned int position)
 {
-	s->midi_position = position;
+	struct amdtp_am824 *p = s->protocol;
+
+	p->midi_position = position;
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_set_midi_position);
 
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u32 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[p->pcm_positions[c]] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u16 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[p->pcm_positions[c]] =
+					cpu_to_be32((*src << 8) | 0x42000000);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void read_pcm_s32(struct amdtp_stream *s,
+			 struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	channels = p->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(buffer[p->pcm_positions[c]]) << 8;
+			dst++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			dst = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_silence(struct amdtp_stream *s,
+			      __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int i, c, channels = p->pcm_channels;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c)
+			buffer[p->pcm_positions[c]] = cpu_to_be32(0x40000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
+/**
+ * amdtp_am824_set_pcm_format - set the PCM format
+ * @s: the AMDTP stream to configure
+ * @format: the format of the ALSA PCM device
+ *
+ * The sample format must be set after the other parameters (rate/PCM channels/
+ * MIDI) and before the stream is started, and must not be changed while the
+ * stream is running.
+ */
+void amdtp_am824_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
+{
+	struct amdtp_am824 *p = s->protocol;
+
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
+		return;
+
+	switch (format) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S16:
+		if (s->direction == AMDTP_OUT_STREAM) {
+			p->transfer_samples = write_pcm_s16;
+			break;
+		}
+		WARN_ON(1);
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S32:
+		if (s->direction == AMDTP_OUT_STREAM)
+			p->transfer_samples = write_pcm_s32;
+		else
+			p->transfer_samples = read_pcm_s32;
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_format);
+
 /**
  * amdtp_am824_add_pcm_hw_constraints - add hw constraints for PCM substream
  * @s:		the AMDTP stream for AM824 data block, must be initialized.
@@ -113,11 +311,135 @@ EXPORT_SYMBOL_GPL(amdtp_am824_add_pcm_hw_constraints);
 void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			      struct snd_rawmidi_substream *midi)
 {
-	if (port < s->midi_ports)
-		ACCESS_ONCE(s->midi[port]) = midi;
+	struct amdtp_am824 *p = s->protocol;
+
+	if (port < p->midi_ports)
+		ACCESS_ONCE(p->midi[port]) = midi;
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_midi_trigger);
 
+/*
+ * To avoid sending MIDI bytes at too high a rate, assume that the receiving
+ * device has a FIFO, and track how much it is filled.  This values increases
+ * by one whenever we send one byte in a packet, but the FIFO empties at
+ * a constant rate independent of our packet rate.  One packet has syt_interval
+ * samples, so the number of bytes that empty out of the FIFO, per packet(!),
+ * is MIDI_BYTES_PER_SECOND * syt_interval / sample_rate.  To avoid storing
+ * fractional values, the values in midi_fifo_used[] are measured in bytes
+ * multiplied by the sample rate.
+ */
+static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
+{
+	struct amdtp_am824 *p = s->protocol;
+	int used;
+
+	used = p->midi_fifo_used[port];
+	if (used == 0) /* common shortcut */
+		return true;
+
+	used -= MIDI_BYTES_PER_SECOND * s->syt_interval;
+	used = max(used, 0);
+	p->midi_fifo_used[port] = used;
+
+	return used < p->midi_fifo_limit;
+}
+
+static void midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
+{
+	struct amdtp_am824 *p = s->protocol;
+
+	p->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
+}
+
+static void write_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+				unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int f, port;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		b = (u8 *)&buffer[p->midi_position];
+
+		port = (s->data_block_counter + f) % 8;
+		if (f < MAX_MIDI_RX_BLOCKS &&
+		    midi_ratelimit_per_packet(s, port) &&
+		    p->midi[port] != NULL &&
+		    snd_rawmidi_transmit(p->midi[port], &b[1], 1) == 1) {
+			midi_rate_use_one_byte(s, port);
+			b[0] = 0x81;
+		} else {
+			b[0] = 0x80;
+			b[1] = 0;
+		}
+		b[2] = 0;
+		b[3] = 0;
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static void read_midi_messages(struct amdtp_stream *s,
+			       __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int f, port;
+	int len;
+	u8 *b;
+
+	for (f = 0; f < frames; f++) {
+		port = (s->data_block_counter + f) % 8;
+		b = (u8 *)&buffer[p->midi_position];
+
+		len = b[0] - 0x80;
+		if ((1 <= len) &&  (len <= 3) && (p->midi[port]))
+			snd_rawmidi_receive(p->midi[port], b + 1, len);
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+				    unsigned int data_blocks, unsigned int *syt)
+{
+	struct amdtp_am824 *p = s->protocol;
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks * p->frame_multiplier;
+	} else {
+		write_pcm_silence(s, buffer, data_blocks);
+		pcm_frames = 0;
+	}
+
+	if (p->midi_ports)
+		write_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames;
+}
+
+unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+				    unsigned int data_blocks, unsigned int *syt)
+{
+	struct amdtp_am824 *p = s->protocol;
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks * p->frame_multiplier;
+	} else {
+		pcm_frames = 0;
+	}
+
+	if (p->midi_ports)
+		read_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames;
+}
+
 /**
  * amdtp_am824_init - initialize an AMDTP stream structure to handle AM824
  *		      data block
@@ -129,6 +451,15 @@ EXPORT_SYMBOL_GPL(amdtp_am824_midi_trigger);
 int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
 		     enum amdtp_stream_direction dir, enum cip_flags flags)
 {
-	return amdtp_stream_init(s, unit, dir, flags, CIP_FMT_AM);
+	amdtp_stream_process_data_blocks_t process_data_blocks;
+
+	if (dir == AMDTP_IN_STREAM)
+		process_data_blocks = process_tx_data_blocks;
+	else
+		process_data_blocks = process_rx_data_blocks;
+
+	return amdtp_stream_init(s, unit, dir, flags, CIP_FMT_AM,
+				 process_data_blocks,
+				 sizeof(struct amdtp_am824));
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_init);
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index 65e6093..73b07b3 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -6,6 +6,27 @@
 
 #include "amdtp-stream.h"
 
+#define AM824_IN_PCM_FORMAT_BITS	SNDRV_PCM_FMTBIT_S32
+
+#define AM824_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
+					 SNDRV_PCM_FMTBIT_S32)
+
+/*
+ * This module supports maximum 64 PCM channels for one PCM stream
+ * This is for our convenience.
+ */
+#define AM824_MAX_CHANNELS_FOR_PCM	64
+
+/*
+ * AMDTP packet can include channels for MIDI conformant data.
+ * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
+ * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
+ *
+ * This module supports maximum 1 MIDI conformant data channels.
+ * Then this AMDTP packets can transfer maximum 8 MIDI data streams.
+ */
+#define AM824_MAX_CHANNELS_FOR_MIDI	1
+
 int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
 			       unsigned int pcm_channels,
 			       unsigned int midi_ports,
@@ -20,6 +41,9 @@ void amdtp_am824_set_midi_position(struct amdtp_stream *s,
 int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
 				       struct snd_pcm_runtime *runtime);
 
+void amdtp_am824_set_pcm_format(struct amdtp_stream *s,
+				snd_pcm_format_t format);
+
 void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			      struct snd_rawmidi_substream *midi);
 
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e677b05..fa10b58 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -13,25 +13,12 @@
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/rawmidi.h>
 #include "amdtp-stream.h"
 
 #define TICKS_PER_CYCLE		3072
 #define CYCLES_PER_SECOND	8000
 #define TICKS_PER_SECOND	(TICKS_PER_CYCLE * CYCLES_PER_SECOND)
 
-/*
- * Nominally 3125 bytes/second, but the MIDI port's clock might be
- * 1% too slow, and the bus clock 100 ppm too fast.
- */
-#define MIDI_BYTES_PER_SECOND	3093
-
-/*
- * Several devices look only at the first eight data blocks.
- * In any case, this is more than enough for the MIDI data rate.
- */
-#define MAX_MIDI_RX_BLOCKS	8
-
 #define TRANSFER_DELAY_TICKS	0x2e00 /* 479.17 microseconds */
 
 /* isochronous header parameters */
@@ -74,11 +61,22 @@ static void pcm_period_tasklet(unsigned long data);
  * @dir: the direction of stream
  * @flags: the packet transmission method to use
  * @fmt: the value of fmt field in CIP header
+ * @process_data_blocks: callback handler to process data blocks
+ * @protocol_size: the size to allocate newly for protocol
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		      enum amdtp_stream_direction dir, enum cip_flags flags,
-		      unsigned int fmt)
+		      unsigned int fmt,
+		      amdtp_stream_process_data_blocks_t process_data_blocks,
+		      unsigned int protocol_size)
 {
+	if (process_data_blocks == NULL)
+		return -EINVAL;
+
+	s->protocol = kzalloc(protocol_size, GFP_KERNEL);
+	if (!s->protocol)
+		return -ENOMEM;
+
 	s->unit = unit;
 	s->direction = dir;
 	s->flags = flags;
@@ -92,6 +90,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->sync_slave = NULL;
 
 	s->fmt = fmt;
+	s->process_data_blocks = process_data_blocks;
 
 	return 0;
 }
@@ -104,6 +103,7 @@ EXPORT_SYMBOL(amdtp_stream_init);
 void amdtp_stream_destroy(struct amdtp_stream *s)
 {
 	WARN_ON(amdtp_stream_running(s));
+	kfree(s->protocol);
 	mutex_destroy(&s->mutex);
 }
 EXPORT_SYMBOL(amdtp_stream_destroy);
@@ -184,27 +184,15 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
  * amdtp_stream_set_parameters - set stream parameters
  * @s: the AMDTP stream to configure
  * @rate: the sample rate
- * @pcm_channels: the number of PCM samples in each data block, to be encoded
- *                as AM824 multi-bit linear audio
- * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
- * @double_pcm_frames: one data block transfers two PCM frames
+ * @data_block_quadlets: the size of a data block in quadlet unit
  *
  * The parameters must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-int amdtp_stream_set_parameters(struct amdtp_stream *s,
-				unsigned int rate,
-				unsigned int pcm_channels,
-				unsigned int midi_ports)
+int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
+				unsigned int data_block_quadlets)
 {
-	unsigned int i, sfc, midi_channels;
-
-	midi_channels = DIV_ROUND_UP(midi_ports, 8);
-
-	if (WARN_ON(amdtp_stream_running(s)) |
-	    WARN_ON(pcm_channels > AM824_MAX_CHANNELS_FOR_PCM) |
-	    WARN_ON(midi_channels > AM824_MAX_CHANNELS_FOR_MIDI))
-		return -EINVAL;
+	unsigned int sfc;
 
 	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc) {
 		if (amdtp_rate_table[sfc] == rate)
@@ -213,11 +201,8 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s,
 	if (sfc == ARRAY_SIZE(amdtp_rate_table))
 		return -EINVAL;
 
-	s->pcm_channels = pcm_channels;
 	s->sfc = sfc;
-	s->data_block_quadlets = s->pcm_channels + midi_channels;
-	s->midi_ports = midi_ports;
-
+	s->data_block_quadlets = data_block_quadlets;
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
 	/* default buffering in the device */
@@ -226,19 +211,6 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s,
 		/* additional buffering needed to adjust for no-data packets */
 		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
 
-	/* init the position map for PCM and MIDI channels */
-	for (i = 0; i < pcm_channels; i++)
-		s->pcm_positions[i] = i;
-	s->midi_position = s->pcm_channels;
-
-	/*
-	 * We do not know the actual MIDI FIFO size of most devices.  Just
-	 * assume two bytes, i.e., one byte can be received over the bus while
-	 * the previous one is transmitted over MIDI.
-	 * (The value here is adjusted for midi_ratelimit_per_packet().)
-	 */
-	s->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
-
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);
@@ -261,51 +233,6 @@ unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
-static void write_pcm_s16(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames);
-static void write_pcm_s32(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames);
-static void read_pcm_s32(struct amdtp_stream *s,
-			 struct snd_pcm_substream *pcm,
-			 __be32 *buffer, unsigned int frames);
-
-/**
- * amdtp_am824_set_pcm_format - set the PCM format
- * @s: the AMDTP stream to configure
- * @format: the format of the ALSA PCM device
- *
- * The sample format must be set after the other parameters (rate/PCM channels/
- * MIDI) and before the stream is started, and must not be changed while the
- * stream is running.
- */
-void amdtp_am824_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
-{
-	if (WARN_ON(amdtp_stream_pcm_running(s)))
-		return;
-
-	switch (format) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S16:
-		if (s->direction == AMDTP_OUT_STREAM) {
-			s->transfer_samples = write_pcm_s16;
-			break;
-		}
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S32:
-		if (s->direction == AMDTP_OUT_STREAM)
-			s->transfer_samples = write_pcm_s32;
-		else
-			s->transfer_samples = read_pcm_s32;
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_format);
-
 /**
  * amdtp_stream_pcm_prepare - prepare PCM device for running
  * @s: the AMDTP stream
@@ -408,168 +335,6 @@ static unsigned int calculate_syt(struct amdtp_stream *s,
 	}
 }
 
-static void write_pcm_s32(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u32 *src;
-
-	channels = s->pcm_channels;
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c]] =
-					cpu_to_be32((*src >> 8) | 0x40000000);
-			src++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
-static void write_pcm_s16(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u16 *src;
-
-	channels = s->pcm_channels;
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c]] =
-					cpu_to_be32((*src << 8) | 0x42000000);
-			src++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
-static void read_pcm_s32(struct amdtp_stream *s,
-			 struct snd_pcm_substream *pcm,
-			 __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	u32 *dst;
-
-	channels = s->pcm_channels;
-	dst  = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*dst = be32_to_cpu(buffer[s->pcm_positions[c]]) << 8;
-			dst++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			dst = (void *)runtime->dma_area;
-	}
-}
-
-static void write_pcm_silence(struct amdtp_stream *s,
-			      __be32 *buffer, unsigned int frames)
-{
-	unsigned int i, c;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < s->pcm_channels; ++c)
-			buffer[s->pcm_positions[c]] = cpu_to_be32(0x40000000);
-		buffer += s->data_block_quadlets;
-	}
-}
-
-/*
- * To avoid sending MIDI bytes at too high a rate, assume that the receiving
- * device has a FIFO, and track how much it is filled.  This values increases
- * by one whenever we send one byte in a packet, but the FIFO empties at
- * a constant rate independent of our packet rate.  One packet has syt_interval
- * samples, so the number of bytes that empty out of the FIFO, per packet(!),
- * is MIDI_BYTES_PER_SECOND * syt_interval / sample_rate.  To avoid storing
- * fractional values, the values in midi_fifo_used[] are measured in bytes
- * multiplied by the sample rate.
- */
-static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
-{
-	int used;
-
-	used = s->midi_fifo_used[port];
-	if (used == 0) /* common shortcut */
-		return true;
-
-	used -= MIDI_BYTES_PER_SECOND * s->syt_interval;
-	used = max(used, 0);
-	s->midi_fifo_used[port] = used;
-
-	return used < s->midi_fifo_limit;
-}
-
-static void midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
-{
-	s->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
-}
-
-static void write_midi_messages(struct amdtp_stream *s,
-				__be32 *buffer, unsigned int frames)
-{
-	unsigned int f, port;
-	u8 *b;
-
-	for (f = 0; f < frames; f++) {
-		b = (u8 *)&buffer[s->midi_position];
-
-		port = (s->data_block_counter + f) % 8;
-		if (f < MAX_MIDI_RX_BLOCKS &&
-		    midi_ratelimit_per_packet(s, port) &&
-		    s->midi[port] != NULL &&
-		    snd_rawmidi_transmit(s->midi[port], &b[1], 1) == 1) {
-			midi_rate_use_one_byte(s, port);
-			b[0] = 0x81;
-		} else {
-			b[0] = 0x80;
-			b[1] = 0;
-		}
-		b[2] = 0;
-		b[3] = 0;
-
-		buffer += s->data_block_quadlets;
-	}
-}
-
-static void read_midi_messages(struct amdtp_stream *s,
-			       __be32 *buffer, unsigned int frames)
-{
-	unsigned int f, port;
-	int len;
-	u8 *b;
-
-	for (f = 0; f < frames; f++) {
-		port = (s->data_block_counter + f) % 8;
-		b = (u8 *)&buffer[s->midi_position];
-
-		len = b[0] - 0x80;
-		if ((1 <= len) &&  (len <= 3) && (s->midi[port]))
-			snd_rawmidi_receive(s->midi[port], b + 1, len);
-
-		buffer += s->data_block_quadlets;
-	}
-}
-
 static void update_pcm_pointers(struct amdtp_stream *s,
 				struct snd_pcm_substream *pcm,
 				unsigned int frames)
@@ -639,26 +404,6 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
-unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
-				    unsigned int data_blocks, unsigned int *syt)
-{
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
-	unsigned int pcm_frames;
-
-	if (pcm) {
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-		pcm_frames = data_blocks * s->frame_multiplier;
-	} else {
-		write_pcm_silence(s, buffer, data_blocks);
-		pcm_frames = 0;
-	}
-
-	if (s->midi_ports)
-		write_midi_messages(s, buffer, data_blocks);
-
-	return pcm_frames;
-}
-
 static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 			     unsigned int syt)
 {
@@ -668,7 +413,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	struct snd_pcm_substream *pcm;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
-	pcm_frames = process_rx_data_blocks(s, buffer + 2, data_blocks, &syt);
+	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
 
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
@@ -692,25 +437,6 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	return 0;
 }
 
-unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
-				    unsigned int data_blocks, unsigned int *syt)
-{
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
-	unsigned int pcm_frames;
-
-	if (pcm) {
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-		pcm_frames = data_blocks * s->frame_multiplier;
-	} else {
-		pcm_frames = 0;
-	}
-
-	if (s->midi_ports)
-		read_midi_messages(s, buffer, data_blocks);
-
-	return pcm_frames;
-}
-
 static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int payload_quadlets, __be32 *buffer,
 			    unsigned int *data_blocks, unsigned int syt)
@@ -798,7 +524,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
-	pcm_frames = process_tx_data_blocks(s, buffer + 2, *data_blocks, &syt);
+	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter = data_block_counter;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 71f4f75..8775704 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -81,39 +81,22 @@ enum cip_sfc {
 	CIP_SFC_COUNT
 };
 
-#define AM824_IN_PCM_FORMAT_BITS	SNDRV_PCM_FMTBIT_S32
-
-#define AM824_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
-					 SNDRV_PCM_FMTBIT_S32)
-
-
-/*
- * This module supports maximum 64 PCM channels for one PCM stream
- * This is for our convenience.
- */
-#define AM824_MAX_CHANNELS_FOR_PCM	64
-
-/*
- * AMDTP packet can include channels for MIDI conformant data.
- * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
- * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
- *
- * This module supports maximum 1 MIDI conformant data channels.
- * Then this AMDTP packets can transfer maximum 8 MIDI data streams.
- */
-#define AM824_MAX_CHANNELS_FOR_MIDI	1
-
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
 struct snd_pcm_runtime;
-struct snd_rawmidi_substream;
 
 enum amdtp_stream_direction {
 	AMDTP_OUT_STREAM = 0,
 	AMDTP_IN_STREAM
 };
 
+struct amdtp_stream;
+typedef unsigned int (*amdtp_stream_process_data_blocks_t)(
+						struct amdtp_stream *s,
+						__be32 *buffer,
+						unsigned int data_blocks,
+						unsigned int *syt);
 struct amdtp_stream {
 	struct fw_unit *unit;
 	enum cip_flags flags;
@@ -156,32 +139,20 @@ struct amdtp_stream {
 	wait_queue_head_t callback_wait;
 	struct amdtp_stream *sync_slave;
 
-	/* For AM824 processing. */
-	struct snd_rawmidi_substream *midi[AM824_MAX_CHANNELS_FOR_MIDI * 8];
-	int midi_fifo_limit;
-	int midi_fifo_used[AM824_MAX_CHANNELS_FOR_MIDI * 8];
-	unsigned int pcm_channels;
-	unsigned int midi_ports;
-
-	u8 pcm_positions[AM824_MAX_CHANNELS_FOR_PCM];
-	u8 midi_position;
-
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
-
-	unsigned int frame_multiplier;
+	/* For backends to process data blocks. */
+	void *protocol;
+	amdtp_stream_process_data_blocks_t process_data_blocks;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir,
-		      enum cip_flags flags, unsigned int fmt);
+		      enum amdtp_stream_direction dir, enum cip_flags flags,
+		      unsigned int fmt,
+		      amdtp_stream_process_data_blocks_t process_data_blocks,
+		      unsigned int protocol_size);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
-int amdtp_stream_set_parameters(struct amdtp_stream *s,
-				unsigned int rate,
-				unsigned int pcm_channels,
-				unsigned int midi_ports);
+int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
+				unsigned int data_block_quadlets);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
 int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
@@ -190,8 +161,7 @@ void amdtp_stream_stop(struct amdtp_stream *s);
 
 int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime);
-void amdtp_am824_set_pcm_format(struct amdtp_stream *s,
-				snd_pcm_format_t format);
+
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
-- 
2.1.4
