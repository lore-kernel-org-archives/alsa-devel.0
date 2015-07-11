From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 02/37] ALSA: firewire-lib: functional
	separation between packet stream and data block format
Date: Sat, 11 Jul 2015 23:12:13 +0900
Message-ID: <1436623968-10780-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E9D6260541
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:02 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

There're some models which is not compliant to IEC 61883-6. Such devices
use its own data format, while they're applications of Audio. This means
that they use the same way for data transmission rate as IEC 61883-6,
especially one data block represents one event and the number of
transferred data blocks in a second is the same as sampling frequency.
On the other hand, these models don't use AM824 format for its data
blocks.

Supporting these models requires transmittion layer and packetization
layer. This commit implements this idea to split current amdtp layer
to 'stream' and 'am824' layer, and allows each driver to implement own
packetization layer.

I note about the overhead which this commit takes. The streaming layer
calls protocol layer every packetization. Therefore, the frequency is
8,000 times per second. This makes additional 8,000 function calls for
AMDTP/AM824 processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile                     |   2 +-
 sound/firewire/amdtp-am824.c                | 430 ++++++++++++++++++++++++++++
 sound/firewire/amdtp-am824.h                |  45 +++
 sound/firewire/amdtp-stream.c               | 373 ++++--------------------
 sound/firewire/amdtp-stream.h               | 105 ++-----
 sound/firewire/bebob/bebob.h                |   2 +-
 sound/firewire/bebob/bebob_midi.c           |  16 +-
 sound/firewire/bebob/bebob_pcm.c            |  10 +-
 sound/firewire/bebob/bebob_stream.c         |  34 ++-
 sound/firewire/dice/dice-midi.c             |  16 +-
 sound/firewire/dice/dice-pcm.c              |  10 +-
 sound/firewire/dice/dice-stream.c           |  41 +--
 sound/firewire/dice/dice.h                  |   2 +-
 sound/firewire/fireworks/fireworks.c        |  12 +-
 sound/firewire/fireworks/fireworks.h        |   2 +-
 sound/firewire/fireworks/fireworks_midi.c   |  16 +-
 sound/firewire/fireworks/fireworks_pcm.c    |   8 +-
 sound/firewire/fireworks/fireworks_stream.c |   8 +-
 sound/firewire/oxfw/oxfw-midi.c             |  16 +-
 sound/firewire/oxfw/oxfw-pcm.c              |   8 +-
 sound/firewire/oxfw/oxfw-stream.c           |  11 +-
 sound/firewire/oxfw/oxfw.h                  |   2 +-
 22 files changed, 682 insertions(+), 487 deletions(-)
 create mode 100644 sound/firewire/amdtp-am824.c
 create mode 100644 sound/firewire/amdtp-am824.h

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 102e342..6a8a713 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,5 +1,5 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
-			 fcp.o cmp.o amdtp-stream.o
+			 fcp.o cmp.o amdtp-stream.o amdtp-am824.o
 snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
new file mode 100644
index 0000000..37541bd
--- /dev/null
+++ b/sound/firewire/amdtp-am824.c
@@ -0,0 +1,430 @@
+/*
+ * AM824 format in Audio and Music Data Transmission Protocol (IEC 61883-6)
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+#include "amdtp-am824.h"
+
+#define CIP_FMT_AM		0x10
+#define AMDTP_FDF_AM824		0x00
+
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
+				 struct snd_pcm_runtime *pcm,
+				 __be32 *buffer, unsigned int frames);
+
+	/*
+	 * In IEC 61883-6, one data block represents one event. In ALSA, one
+	 * event equals to one PCM frame. But Dice has a quirk to transfer
+	 * two PCM frames in one data block.
+	 */
+	unsigned int frame_multiplier;
+};
+
+/**
+ * amdtp_am824_set_parameters - set stream parameters
+ * @s: the CIP stream to configure
+ * @rate: the sample rate
+ * @pcm_channels: the number of PCM samples in each data block, to be encoded
+ *                as AM824 multi-bit linear audio
+ * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
+ *
+ * The parameters must be set before the stream is started, and must not be
+ * changed while the stream is running.
+ */
+int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			       unsigned int pcm_channels,
+			       unsigned int midi_ports,
+			       bool double_pcm_frames)
+{
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int midi_channels;
+	unsigned int i;
+	int err;
+
+	if (amdtp_stream_running(s))
+		return -EBUSY;
+
+	if (double_pcm_frames)
+		p->frame_multiplier = 2;
+	else
+		p->frame_multiplier = 1;
+
+	if (pcm_channels > AM824_MAX_CHANNELS_FOR_PCM)
+		return -EINVAL;
+
+	midi_channels = DIV_ROUND_UP(midi_ports, 8);
+	if (midi_channels > AM824_MAX_CHANNELS_FOR_MIDI)
+		return -EINVAL;
+
+	err = amdtp_stream_set_parameters(s, rate,
+					  pcm_channels + midi_channels);
+	if (err < 0)
+		return err;
+
+	s->fdf = AMDTP_FDF_AM824 | s->sfc;
+
+	p->pcm_channels = pcm_channels;
+	p->midi_ports = midi_ports;
+
+	/* init the position map for PCM and MIDI channels */
+	for (i = 0; i < pcm_channels; i++)
+		p->pcm_positions[i] = i;
+	p->midi_position = pcm_channels;
+
+	/*
+	 * We do not know the actual MIDI FIFO size of most devices.  Just
+	 * assume two bytes, i.e., one byte can be received over the bus while
+	 * the previous one is transmitted over MIDI.
+	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 */
+	p->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(amdtp_am824_set_parameters);
+
+void amdtp_am824_set_pcm_position(struct amdtp_stream *s, unsigned int index,
+				 unsigned int position)
+{
+	struct amdtp_am824 *p = s->protocol;
+
+	if (index < p->pcm_channels)
+		p->pcm_positions[index] = position;
+}
+EXPORT_SYMBOL(amdtp_am824_set_pcm_position);
+
+void amdtp_am824_set_midi_position(struct amdtp_stream *s,
+				   unsigned int position)
+{
+	struct amdtp_am824 *p = s->protocol;
+
+	p->midi_position = position;
+}
+EXPORT_SYMBOL(amdtp_am824_set_midi_position);
+
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
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
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
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
+			 struct snd_pcm_runtime *runtime,
+			 __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_am824 *p = s->protocol;
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
+static void write_pcm_silence(struct amdtp_stream *s, __be32 *buffer,
+			      unsigned int data_blocks)
+{
+	struct amdtp_am824 *p = s->protocol;
+	unsigned int channels, i, c;
+
+	channels = p->pcm_channels;
+
+	for (i = 0; i < data_blocks; ++i) {
+		for (c = 0; c < channels; ++c)
+			buffer[p->pcm_positions[c]] = cpu_to_be32(0x40000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
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
+static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+			       unsigned int frames)
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
+/**
+ * amdtp_am824_set_pcm_format - set the PCM format
+ * @s: the CIP stream to configure
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
+EXPORT_SYMBOL(amdtp_am824_set_pcm_format);
+
+/**
+ * amdtp_am824_midi_trigger - start/stop playback/capture with a MIDI device
+ * @s: the CIP stream
+ * @port: index of MIDI port
+ * @midi: the MIDI device to be started, or %NULL to stop the current device
+ *
+ * Call this function on a running isochronous stream to enable the actual
+ * transmission of MIDI data.  This function should be called from the MIDI
+ * device's .trigger callback.
+ */
+void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			      struct snd_rawmidi_substream *midi)
+{
+	struct amdtp_am824 *p = s->protocol;
+
+	if (port < p->midi_ports)
+		ACCESS_ONCE(p->midi[port]) = midi;
+}
+EXPORT_SYMBOL(amdtp_am824_midi_trigger);
+
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_am824 *p = (struct amdtp_am824 *)s->protocol;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (data_blocks > 0 && pcm) {
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		pcm_frames = 0;
+	}
+
+	if (p->midi_ports)
+		read_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames * p->frame_multiplier;
+}
+
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_am824 *p = (struct amdtp_am824 *)s->protocol;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm) {
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		write_pcm_silence(s, buffer, data_blocks);
+		pcm_frames = 0;
+	}
+
+	if (p->midi_ports)
+		write_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames * p->frame_multiplier;
+}
+
+int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
+		     enum amdtp_stream_direction dir, enum cip_flags flags)
+{
+	struct amdtp_am824 *p;
+	int err;
+
+	err = amdtp_stream_init(s, unit, dir, flags,
+				sizeof(struct amdtp_am824));
+	if (err < 0)
+		return err;
+
+	s->fmt = CIP_FMT_AM;
+
+	if (dir == AMDTP_IN_STREAM)
+		s->process_data_blocks = process_tx_data_blocks;
+	else
+		s->process_data_blocks = process_rx_data_blocks;
+
+	p = s->protocol;
+	p->frame_multiplier = 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(amdtp_am824_init);
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
new file mode 100644
index 0000000..70c6d71
--- /dev/null
+++ b/sound/firewire/amdtp-am824.h
@@ -0,0 +1,45 @@
+#ifndef SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
+#define SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
+
+#include "amdtp-stream.h"
+
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
+ * AM824 packet can include channels for MIDI conformant data.
+ * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
+ * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
+ *
+ * This module supports maximum 1 MIDI conformant data channels.
+ * Then this AM824 packets can transfer maximum 8 MIDI data streams.
+ */
+#define AM824_MAX_CHANNELS_FOR_MIDI	1
+
+int amdtp_am824_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			       unsigned int pcm_channels,
+			       unsigned int midi_ports,
+			       bool double_pcm_frames);
+
+void amdtp_am824_set_pcm_position(struct amdtp_stream *s, unsigned int index,
+				  unsigned int position);
+void amdtp_am824_set_midi_position(struct amdtp_stream *s,
+				   unsigned int position);
+
+void amdtp_am824_set_pcm_format(struct amdtp_stream *s,
+				snd_pcm_format_t format);
+
+void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			      struct snd_rawmidi_substream *midi);
+
+int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
+		     enum amdtp_stream_direction dir, enum cip_flags flags);
+#endif
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 9965984..c7fbdd3 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -11,7 +11,6 @@
 #include <linux/firewire.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
@@ -21,18 +20,6 @@
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
@@ -78,17 +65,23 @@ static void pcm_period_tasklet(unsigned long data);
  * @unit: the target of the stream
  * @dir: the direction of stream
  * @flags: the packet transmission method to use
+ * @protocol_size: the size to allocate newly for protocol
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, enum cip_flags flags)
+		    enum amdtp_stream_direction dir, enum cip_flags flags,
+		    unsigned int protocol_size)
 {
+	s->protocol = kzalloc(protocol_size, GFP_KERNEL);
+	if (!s->protocol)
+		return -ENOMEM;
+
 	s->unit = unit;
 	s->direction = dir;
 	s->flags = flags;
-	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
-	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
+	s->context = ERR_PTR(-1);
 	s->packet_index = 0;
+	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
 
 	init_waitqueue_head(&s->callback_wait);
 	s->callbacked = false;
@@ -106,6 +99,7 @@ void amdtp_stream_destroy(struct amdtp_stream *s)
 {
 	WARN_ON(amdtp_stream_running(s));
 	mutex_destroy(&s->mutex);
+	kfree(s->protocol);
 }
 EXPORT_SYMBOL(amdtp_stream_destroy);
 
@@ -141,11 +135,6 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 {
 	int err;
 
-	/* AM824 in IEC 61883-6 can deliver 24bit data */
-	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
-	if (err < 0)
-		goto end;
-
 	/*
 	 * Currently firewire-lib processes 16 packets in one software
 	 * interrupt callback. This equals to 2msec but actually the
@@ -190,59 +179,35 @@ EXPORT_SYMBOL(amdtp_stream_add_pcm_hw_constraints);
  * amdtp_stream_set_parameters - set stream parameters
  * @s: the AMDTP stream to configure
  * @rate: the sample rate
- * @pcm_channels: the number of PCM samples in each data block, to be encoded
- *                as AM824 multi-bit linear audio
- * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
+ * @data_block_quadlets: the number of quadlets in a data block
  *
  * The parameters must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-void amdtp_stream_set_parameters(struct amdtp_stream *s,
-				 unsigned int rate,
-				 unsigned int pcm_channels,
-				 unsigned int midi_ports)
+int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
+				unsigned int data_block_quadlets)
 {
-	unsigned int i, sfc, midi_channels;
+	unsigned int sfc;
 
-	midi_channels = DIV_ROUND_UP(midi_ports, 8);
-
-	if (WARN_ON(amdtp_stream_running(s)) |
-	    WARN_ON(pcm_channels > AMDTP_MAX_CHANNELS_FOR_PCM) |
-	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
-		return;
-
-	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc)
+	for (sfc = 0; sfc < ARRAY_SIZE(amdtp_rate_table); ++sfc) {
 		if (amdtp_rate_table[sfc] == rate)
-			goto sfc_found;
-	WARN_ON(1);
-	return;
+			break;
+	}
+	if (sfc == ARRAY_SIZE(amdtp_rate_table))
+		return -EINVAL;
 
-sfc_found:
-	s->pcm_channels = pcm_channels;
+	s->data_block_quadlets = data_block_quadlets;
 	s->sfc = sfc;
-	s->data_block_quadlets = s->pcm_channels + midi_channels;
-	s->midi_ports = midi_ports;
-
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
 	/* default buffering in the device */
 	s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
-	if (s->flags & CIP_BLOCKING)
+	if (s->flags & CIP_BLOCKING) {
 		/* additional buffering needed to adjust for no-data packets */
 		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
+	}
 
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
+	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);
 
@@ -264,52 +229,6 @@ unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
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
- * amdtp_stream_set_pcm_format - set the PCM format
- * @s: the AMDTP stream to configure
- * @format: the format of the ALSA PCM device
- *
- * The sample format must be set after the other parameters (rate/PCM channels/
- * MIDI) and before the stream is started, and must not be changed while the
- * stream is running.
- */
-void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
-				 snd_pcm_format_t format)
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
-EXPORT_SYMBOL(amdtp_stream_set_pcm_format);
-
 /**
  * amdtp_stream_pcm_prepare - prepare PCM device for running
  * @s: the AMDTP stream
@@ -412,182 +331,12 @@ static unsigned int calculate_syt(struct amdtp_stream *s,
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
 {
 	unsigned int ptr;
 
-	/*
-	 * In IEC 61883-6, one data block represents one event. In ALSA, one
-	 * event equals to one PCM frame. But Dice has a quirk to transfer
-	 * two PCM frames in one data block.
-	 */
-	if (s->double_pcm_frames)
-		frames *= 2;
-
 	ptr = s->pcm_buffer_pointer + frames;
 	if (ptr >= pcm->runtime->buffer_size)
 		ptr -= pcm->runtime->buffer_size;
@@ -656,32 +405,31 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 {
 	__be32 *buffer;
 	unsigned int payload_length;
+	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
 
+	/* CIP processing. */
 	buffer = s->buffer.packets[s->packet_index].buffer;
+	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
+
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				s->data_block_counter);
-	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
-				(s->sfc << CIP_FDF_SHIFT) | syt);
-	buffer += 2;
-
-	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm)
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-	else
-		write_pcm_silence(s, buffer, data_blocks);
-	if (s->midi_ports)
-		write_midi_messages(s, buffer, data_blocks);
-
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+	buffer[1] = cpu_to_be32(CIP_EOH |
+				((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
+				((s->fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
+				(syt & CIP_SYT_MASK));
 
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 	if (queue_out_packet(s, payload_length, false) < 0)
 		return -EIO;
 
-	if (pcm)
-		update_pcm_pointers(s, pcm, data_blocks);
+	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+
+	/* PCM runtime processing. */
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
 
 	/* No need to return the number of handled data blocks. */
 	return 0;
@@ -692,31 +440,39 @@ static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int *data_blocks)
 {
 	u32 cip_header[2];
+	unsigned int fmt, fdf, syt;
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
-	struct snd_pcm_substream *pcm = NULL;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
 	bool lost;
 
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
-	/*
-	 * This module supports 'Two-quadlet CIP header with SYT field'.
-	 * For convenience, also check FMT field is AM824 or not.
-	 */
+	/* This module supports 'Two-quadlet CIP header with SYT field'. */
 	if (((cip_header[0] & CIP_EOH_MASK) == CIP_EOH) ||
-	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH) ||
-	    ((cip_header[1] & CIP_FMT_MASK) != CIP_FMT_AM)) {
+	    ((cip_header[1] & CIP_EOH_MASK) != CIP_EOH)) {
 		dev_info_ratelimited(&s->unit->device,
-				"Invalid CIP header for AMDTP: %08X:%08X\n",
+				"Invalid CIP header: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
 		*data_blocks = 0;
+		pcm_frames = 0;
 		goto end;
 	}
 
+	/* Check valid protocol or not. */
+	fmt = (cip_header[1] & CIP_FMT_MASK) >> CIP_FMT_SHIFT;
+	if (fmt != s->fmt) {
+		dev_err(&s->unit->device,
+			"Detect unexpected protocol: %08x %08x\n",
+			cip_header[0], cip_header[1]);
+		return -EIO;
+	}
+
 	/* Calculate data blocks */
+	fdf = (cip_header[1] & CIP_FDF_MASK) >> CIP_FDF_SHIFT;
 	if (payload_quadlets < 3 ||
-	    ((cip_header[1] & CIP_FDF_MASK) ==
-				(AMDTP_FDF_NO_DATA << CIP_FDF_SHIFT))) {
+	    (fmt == CIP_FMT_AM && fdf == AMDTP_FDF_NO_DATA)) {
 		*data_blocks = 0;
 	} else {
 		data_block_quadlets =
@@ -762,16 +518,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
-	if (*data_blocks > 0) {
-		buffer += 2;
-
-		pcm = ACCESS_ONCE(s->pcm);
-		if (pcm)
-			s->transfer_samples(s, pcm, buffer, *data_blocks);
-
-		if (s->midi_ports)
-			read_midi_messages(s, buffer, *data_blocks);
-	}
+	/* CIP processing. */
+	syt = cip_header[1] & CIP_SYT_MASK;
+	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter = data_block_counter;
@@ -782,8 +531,10 @@ end:
 	if (queue_in_packet(s) < 0)
 		return -EIO;
 
-	if (pcm)
-		update_pcm_pointers(s, pcm, *data_blocks);
+	/* PCM runtime processing. */
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
 
 	return 0;
 }
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index f7a6f5f..d2354f0 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
 #include <sound/asound.h>
 #include "packets-buffer.h"
 
@@ -80,28 +81,6 @@ enum cip_sfc {
 	CIP_SFC_COUNT
 };
 
-#define AMDTP_IN_PCM_FORMAT_BITS	SNDRV_PCM_FMTBIT_S32
-
-#define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
-					 SNDRV_PCM_FMTBIT_S32)
-
-
-/*
- * This module supports maximum 64 PCM channels for one PCM stream
- * This is for our convenience.
- */
-#define AMDTP_MAX_CHANNELS_FOR_PCM	64
-
-/*
- * AMDTP packet can include channels for MIDI conformant data.
- * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
- * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
- *
- * This module supports maximum 1 MIDI conformant data channels.
- * Then this AMDTP packets can transfer maximum 8 MIDI data streams.
- */
-#define AMDTP_MAX_CHANNELS_FOR_MIDI	1
-
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
@@ -117,61 +96,57 @@ struct amdtp_stream {
 	struct fw_unit *unit;
 	enum cip_flags flags;
 	enum amdtp_stream_direction direction;
-	struct fw_iso_context *context;
 	struct mutex mutex;
 
-	enum cip_sfc sfc;
-	unsigned int data_block_quadlets;
-	unsigned int pcm_channels;
-	unsigned int midi_ports;
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
-	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
-	u8 midi_position;
-
-	unsigned int syt_interval;
-	unsigned int transfer_delay;
-	unsigned int source_node_id_field;
+	/* For packet processing. */
+	struct fw_iso_context *context;
 	struct iso_packets_buffer buffer;
-
-	struct snd_pcm_substream *pcm;
-	struct tasklet_struct period_tasklet;
-
 	int packet_index;
+
+	/* For CIP headers. */
+	unsigned int source_node_id_field;
+	unsigned int data_block_quadlets;
 	unsigned int data_block_counter;
+	unsigned int fmt;
+	unsigned int fdf;
+	/* quirk: fixed interval of dbc between previos/current packets. */
+	unsigned int tx_dbc_interval;
 
+	/* Internal flags. */
+	enum cip_sfc sfc;
+	unsigned int syt_interval;
+	unsigned int transfer_delay;
 	unsigned int data_block_state;
-
 	unsigned int last_syt_offset;
 	unsigned int syt_offset_state;
 
+	/* For backends to process data blocks. */
+	void *protocol;
+	unsigned int (*process_data_blocks)(struct amdtp_stream *s,
+					    __be32 *buffer,
+					    unsigned int data_blocks,
+					    unsigned int *syt);
+
+	/* For one PCM runtime processing. */
+	struct snd_pcm_substream *pcm;
+	struct tasklet_struct period_tasklet;
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
-	bool double_pcm_frames;
-
-	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
-	int midi_fifo_limit;
-	int midi_fifo_used[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
-
-	/* quirk: fixed interval of dbc between previos/current packets. */
-	unsigned int tx_dbc_interval;
 
+	/* To wait for first packet. */
 	bool callbacked;
 	wait_queue_head_t callback_wait;
 	struct amdtp_stream *sync_slave;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir,
-		      enum cip_flags flags);
+		    enum amdtp_stream_direction dir, enum cip_flags flags,
+		    unsigned int protocol_size);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
-void amdtp_stream_set_parameters(struct amdtp_stream *s,
-				 unsigned int rate,
-				 unsigned int pcm_channels,
-				 unsigned int midi_ports);
+int amdtp_stream_set_parameters(struct amdtp_stream *s, unsigned int rate,
+				unsigned int data_block_quadlets);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
 int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
@@ -180,8 +155,6 @@ void amdtp_stream_stop(struct amdtp_stream *s);
 
 int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime);
-void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
-				 snd_pcm_format_t format);
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
@@ -238,24 +211,6 @@ static inline void amdtp_stream_pcm_trigger(struct amdtp_stream *s,
 	ACCESS_ONCE(s->pcm) = pcm;
 }
 
-/**
- * amdtp_stream_midi_trigger - start/stop playback/capture with a MIDI device
- * @s: the AMDTP stream
- * @port: index of MIDI port
- * @midi: the MIDI device to be started, or %NULL to stop the current device
- *
- * Call this function on a running isochronous stream to enable the actual
- * transmission of MIDI data.  This function should be called from the MIDI
- * device's .trigger callback.
- */
-static inline void amdtp_stream_midi_trigger(struct amdtp_stream *s,
-					     unsigned int port,
-					     struct snd_rawmidi_substream *midi)
-{
-	if (port < s->midi_ports)
-		ACCESS_ONCE(s->midi[port]) = midi;
-}
-
 static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 {
 	return sfc & 1;
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 72a1c5e..d3c9d8d 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -31,7 +31,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 
 /* basic register addresses on DM1000/DM1100/DM1500 */
diff --git a/sound/firewire/bebob/bebob_midi.c b/sound/firewire/bebob/bebob_midi.c
index 5681143..9444ad4 100644
--- a/sound/firewire/bebob/bebob_midi.c
+++ b/sound/firewire/bebob/bebob_midi.c
@@ -72,11 +72,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&bebob->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&bebob->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&bebob->tx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&bebob->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&bebob->tx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&bebob->lock, flags);
 }
@@ -89,11 +89,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&bebob->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&bebob->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&bebob->rx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&bebob->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&bebob->rx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&bebob->lock, flags);
 }
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 7a2c1f5..6c7c05f 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -122,11 +122,11 @@ pcm_init_hw_params(struct snd_bebob *bebob,
 			   SNDRV_PCM_INFO_MMAP_VALID;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		s = &bebob->tx_stream;
 		formations = bebob->tx_stream_formations;
 	} else {
-		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_OUT_PCM_FORMAT_BITS;
 		s = &bebob->rx_stream;
 		formations = bebob->rx_stream_formations;
 	}
@@ -214,8 +214,7 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
-	amdtp_stream_set_pcm_format(&bebob->tx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&bebob->tx_stream, params_format(hw_params));
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
 }
@@ -227,8 +226,7 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&bebob->substreams_counter);
-	amdtp_stream_set_pcm_format(&bebob->rx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&bebob->rx_stream, params_format(hw_params));
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
 }
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 5be5242..f3ab9e2 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -333,12 +333,12 @@ map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 			switch (type) {
 			/* for MIDI conformant data channel */
 			case 0x0a:
-				/* AMDTP_MAX_CHANNELS_FOR_MIDI is 1. */
+				/* AM824_MAX_CHANNELS_FOR_MIDI is 1. */
 				if ((midi > 0) && (stm_pos != midi)) {
 					err = -ENOSYS;
 					goto end;
 				}
-				s->midi_position = stm_pos;
+				amdtp_am824_set_midi_position(s, stm_pos);
 				midi = stm_pos;
 				break;
 			/* for PCM data channel */
@@ -354,11 +354,12 @@ map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 			case 0x09:	/* Digital */
 			default:
 				location = pcm + sec_loc;
-				if (location >= AMDTP_MAX_CHANNELS_FOR_PCM) {
+				if (location >= AM824_MAX_CHANNELS_FOR_PCM) {
 					err = -ENOSYS;
 					goto end;
 				}
-				s->pcm_positions[location] = stm_pos;
+				amdtp_am824_set_pcm_position(s,
+							location, stm_pos);
 				break;
 			}
 		}
@@ -427,12 +428,17 @@ make_both_connections(struct snd_bebob *bebob, unsigned int rate)
 	index = get_formation_index(rate);
 	pcm_channels = bebob->tx_stream_formations[index].pcm;
 	midi_channels = bebob->tx_stream_formations[index].midi;
-	amdtp_stream_set_parameters(&bebob->tx_stream,
-				    rate, pcm_channels, midi_channels * 8);
+	err = amdtp_am824_set_parameters(&bebob->tx_stream, rate,
+					pcm_channels, midi_channels * 8, false);
+	if (err < 0)
+		goto end;
+
 	pcm_channels = bebob->rx_stream_formations[index].pcm;
 	midi_channels = bebob->rx_stream_formations[index].midi;
-	amdtp_stream_set_parameters(&bebob->rx_stream,
-				    rate, pcm_channels, midi_channels * 8);
+	err = amdtp_am824_set_parameters(&bebob->rx_stream, rate,
+					pcm_channels, midi_channels * 8, false);
+	if (err < 0)
+		goto end;
 
 	/* establish connections for both streams */
 	err = cmp_connection_establish(&bebob->out_conn,
@@ -530,8 +536,8 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(&bebob->tx_stream, bebob->unit,
-				AMDTP_IN_STREAM, CIP_BLOCKING);
+	err = amdtp_am824_init(&bebob->tx_stream, bebob->unit, AMDTP_IN_STREAM,
+			       CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(&bebob->tx_stream);
 		destroy_both_connections(bebob);
@@ -559,8 +565,8 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	if (bebob->maudio_special_quirk)
 		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC;
 
-	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
-				AMDTP_OUT_STREAM, CIP_BLOCKING);
+	err = amdtp_am824_init(&bebob->rx_stream, bebob->unit, AMDTP_OUT_STREAM,
+			       CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(&bebob->tx_stream);
 		amdtp_stream_destroy(&bebob->rx_stream);
@@ -864,8 +870,8 @@ parse_stream_formation(u8 *buf, unsigned int len,
 		}
 	}
 
-	if (formation[i].pcm  > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    formation[i].midi > AMDTP_MAX_CHANNELS_FOR_MIDI)
+	if (formation[i].pcm  > AM824_MAX_CHANNELS_FOR_PCM ||
+	    formation[i].midi > AM824_MAX_CHANNELS_FOR_MIDI)
 		return -ENOSYS;
 
 	return 0;
diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index fe43ce7..5f97dda 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -52,11 +52,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&dice->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&dice->tx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&dice->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&dice->tx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
 }
@@ -69,11 +69,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&dice->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&dice->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&dice->rx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&dice->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&dice->rx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&dice->lock, flags);
 }
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index f7771451..fd0b7a3 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -133,11 +133,11 @@ static int init_hw_info(struct snd_dice *dice,
 		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		hw->formats = AMDTP_IN_PCM_FORMAT_BITS;
+		hw->formats = AM824_IN_PCM_FORMAT_BITS;
 		stream = &dice->tx_stream;
 		pcm_channels = dice->tx_channels;
 	} else {
-		hw->formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		hw->formats = AM824_OUT_PCM_FORMAT_BITS;
 		stream = &dice->rx_stream;
 		pcm_channels = dice->rx_channels;
 	}
@@ -237,8 +237,7 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&dice->tx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&dice->tx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
@@ -254,8 +253,7 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&dice->rx_stream,
-				    params_format(hw_params));
+	amdtp_am824_set_pcm_format(&dice->rx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 07dbd01..f366854 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -100,11 +100,12 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 {
 	struct fw_iso_resources *resources;
 	unsigned int i, mode, pcm_chs, midi_ports;
+	bool double_pcm_frames;
 	int err;
 
 	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
 	if (err < 0)
-		goto end;
+		return err;
 	if (stream == &dice->tx_stream) {
 		resources = &dice->tx_resources;
 		pcm_chs = dice->tx_channels[mode];
@@ -125,21 +126,23 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	 * For this quirk, blocking mode is required and PCM buffer size should
 	 * be aligned to SYT_INTERVAL.
 	 */
-	if (mode > 1) {
+	double_pcm_frames = mode > 1;
+	if (double_pcm_frames) {
 		rate /= 2;
 		pcm_chs *= 2;
-		stream->double_pcm_frames = true;
-	} else {
-		stream->double_pcm_frames = false;
 	}
 
-	amdtp_stream_set_parameters(stream, rate, pcm_chs, midi_ports);
-	if (mode > 1) {
-		pcm_chs /= 2;
+	err = amdtp_am824_set_parameters(stream, rate, pcm_chs, midi_ports,
+					 double_pcm_frames);
+	if (err < 0)
+		return err;
 
+	if (double_pcm_frames) {
+		pcm_chs /= 2;
 		for (i = 0; i < pcm_chs; i++) {
-			stream->pcm_positions[i] = i * 2;
-			stream->pcm_positions[i + pcm_chs] = i * 2 + 1;
+			amdtp_am824_set_pcm_position(stream, i, i * 2);
+			amdtp_am824_set_pcm_position(stream, i + pcm_chs,
+						     i * 2 + 1);
 		}
 	}
 
@@ -148,14 +151,14 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	if (err < 0) {
 		dev_err(&dice->unit->device,
 			"fail to keep isochronous resources\n");
-		goto end;
+		return err;
 	}
 
 	err = amdtp_stream_start(stream, resources->channel,
 				 fw_parent_device(dice->unit)->max_speed);
 	if (err < 0)
 		release_resources(dice, resources);
-end:
+
 	return err;
 }
 
@@ -208,8 +211,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	}
 
 	/* Some packet queueing errors. */
-	if (amdtp_streaming_error(master) || amdtp_streaming_error(slave))
+	if (amdtp_streaming_error(master) || amdtp_streaming_error(slave)) {
 		stop_stream(dice, master);
+		stop_stream(dice, slave);
+	}
 
 	/* Stop stream if rate is different. */
 	err = snd_dice_transaction_get_rate(dice, &curr_rate);
@@ -220,8 +225,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	}
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate)
+	if (rate != curr_rate) {
 		stop_stream(dice, master);
+		stop_stream(dice, slave);
+	}
 
 	if (!amdtp_stream_running(master)) {
 		stop_stream(dice, slave);
@@ -299,15 +306,15 @@ static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 
 	err = fw_iso_resources_init(resources, dice->unit);
 	if (err < 0)
-		goto end;
+		return err;
 	resources->channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(stream, dice->unit, dir, CIP_BLOCKING);
+	err = amdtp_am824_init(stream, dice->unit, dir, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		fw_iso_resources_destroy(resources);
 	}
-end:
+
 	return err;
 }
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 29578c1..101550ac 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -34,7 +34,7 @@
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
 
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../iso-resources.h"
 #include "../lib.h"
 #include "dice-interface.h"
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 2682e7e..5a48945 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -138,12 +138,12 @@ get_hardware_info(struct snd_efw *efw)
 	efw->midi_out_ports = hwinfo->midi_out_ports;
 	efw->midi_in_ports = hwinfo->midi_in_ports;
 
-	if (hwinfo->amdtp_tx_pcm_channels    > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    hwinfo->amdtp_tx_pcm_channels_2x > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    hwinfo->amdtp_tx_pcm_channels_4x > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    hwinfo->amdtp_rx_pcm_channels    > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    hwinfo->amdtp_rx_pcm_channels_2x > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    hwinfo->amdtp_rx_pcm_channels_4x > AMDTP_MAX_CHANNELS_FOR_PCM) {
+	if (hwinfo->amdtp_tx_pcm_channels    > AM824_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_tx_pcm_channels_2x > AM824_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_tx_pcm_channels_4x > AM824_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels    > AM824_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels_2x > AM824_MAX_CHANNELS_FOR_PCM ||
+	    hwinfo->amdtp_rx_pcm_channels_4x > AM824_MAX_CHANNELS_FOR_PCM) {
 		err = -ENOSYS;
 		goto end;
 	}
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index f6f9ae6..5fdb5f9 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -29,7 +29,7 @@
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 #include "../lib.h"
 
diff --git a/sound/firewire/fireworks/fireworks_midi.c b/sound/firewire/fireworks/fireworks_midi.c
index cf9c652..8134fa4 100644
--- a/sound/firewire/fireworks/fireworks_midi.c
+++ b/sound/firewire/fireworks/fireworks_midi.c
@@ -73,11 +73,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&efw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&efw->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&efw->tx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&efw->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&efw->tx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&efw->lock, flags);
 }
@@ -90,11 +90,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&efw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&efw->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&efw->rx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&efw->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&efw->rx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&efw->lock, flags);
 }
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 8a34753..9f75cf5 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -159,11 +159,11 @@ pcm_init_hw_params(struct snd_efw *efw,
 			   SNDRV_PCM_INFO_MMAP_VALID;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		s = &efw->tx_stream;
 		pcm_channels = efw->pcm_capture_channels;
 	} else {
-		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_OUT_PCM_FORMAT_BITS;
 		s = &efw->rx_stream;
 		pcm_channels = efw->pcm_playback_channels;
 	}
@@ -247,7 +247,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->capture_substreams);
-	amdtp_stream_set_pcm_format(&efw->tx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&efw->tx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
@@ -259,7 +259,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		atomic_inc(&efw->playback_substreams);
-	amdtp_stream_set_pcm_format(&efw->rx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&efw->rx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index c55db1b..7557fbd 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -31,7 +31,7 @@ init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_BLOCKING);
+	err = amdtp_am824_init(stream, efw->unit, s_dir, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		cmp_connection_destroy(conn);
@@ -73,8 +73,10 @@ start_stream(struct snd_efw *efw, struct amdtp_stream *stream,
 		midi_ports = efw->midi_in_ports;
 	}
 
-	amdtp_stream_set_parameters(stream, sampling_rate,
-				    pcm_channels, midi_ports);
+	err = amdtp_am824_set_parameters(stream, sampling_rate,
+					 pcm_channels, midi_ports, false);
+	if (err < 0)
+		goto end;
 
 	/*  establish connection via CMP */
 	err = cmp_connection_establish(conn,
diff --git a/sound/firewire/oxfw/oxfw-midi.c b/sound/firewire/oxfw/oxfw-midi.c
index 540a303..f8f442f 100644
--- a/sound/firewire/oxfw/oxfw-midi.c
+++ b/sound/firewire/oxfw/oxfw-midi.c
@@ -90,11 +90,11 @@ static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&oxfw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&oxfw->tx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&oxfw->tx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&oxfw->tx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&oxfw->tx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&oxfw->lock, flags);
 }
@@ -107,11 +107,11 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
 	spin_lock_irqsave(&oxfw->lock, flags);
 
 	if (up)
-		amdtp_stream_midi_trigger(&oxfw->rx_stream,
-					  substrm->number, substrm);
+		amdtp_am824_midi_trigger(&oxfw->rx_stream, substrm->number,
+					 substrm);
 	else
-		amdtp_stream_midi_trigger(&oxfw->rx_stream,
-					  substrm->number, NULL);
+		amdtp_am824_midi_trigger(&oxfw->rx_stream, substrm->number,
+					 NULL);
 
 	spin_unlock_irqrestore(&oxfw->lock, flags);
 }
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index 67ade07..b08b94a 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -134,11 +134,11 @@ static int init_hw_params(struct snd_oxfw *oxfw,
 			   SNDRV_PCM_INFO_MMAP_VALID;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		runtime->hw.formats = AMDTP_IN_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_IN_PCM_FORMAT_BITS;
 		stream = &oxfw->tx_stream;
 		formats = oxfw->tx_stream_formats;
 	} else {
-		runtime->hw.formats = AMDTP_OUT_PCM_FORMAT_BITS;
+		runtime->hw.formats = AM824_OUT_PCM_FORMAT_BITS;
 		stream = &oxfw->rx_stream;
 		formats = oxfw->rx_stream_formats;
 	}
@@ -239,7 +239,7 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
@@ -255,7 +255,7 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_stream_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
+	amdtp_am824_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
 
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 873d40f..9018e78 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -155,7 +155,10 @@ static int start_stream(struct snd_oxfw *oxfw, struct amdtp_stream *stream,
 		err = -EINVAL;
 		goto end;
 	}
-	amdtp_stream_set_parameters(stream, rate, pcm_channels, midi_ports);
+	err = amdtp_am824_set_parameters(stream, rate,
+					 pcm_channels, midi_ports, false);
+	if (err < 0)
+		goto end;
 
 	err = cmp_connection_establish(conn,
 				       amdtp_stream_get_max_payload(stream));
@@ -225,7 +228,7 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
+	err = amdtp_am824_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		cmp_connection_destroy(conn);
@@ -480,8 +483,8 @@ int snd_oxfw_stream_parse_format(u8 *format,
 		}
 	}
 
-	if (formation->pcm  > AMDTP_MAX_CHANNELS_FOR_PCM ||
-	    formation->midi > AMDTP_MAX_CHANNELS_FOR_MIDI)
+	if (formation->pcm  > AM824_MAX_CHANNELS_FOR_PCM ||
+	    formation->midi > AM824_MAX_CHANNELS_FOR_MIDI)
 		return -ENOSYS;
 
 	return 0;
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 2c3d20b..2441459 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,7 +28,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 
 struct device_info {
-- 
2.1.4
