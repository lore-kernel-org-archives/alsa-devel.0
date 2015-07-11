From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 31/37] ALSA: firewire-motu: add MOTU
	specific protocol layer
Date: Sat, 11 Jul 2015 23:12:42 +0900
Message-ID: <1436623968-10780-32-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B797E2605B8
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
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

MOTU FireWire series uses blocking transmission for AMDTP packet
streaming, while the format of data blocks is unique.

The CIP headers includes 0x82 in FMT field and 0x22ffff in FDF field.

The first data channel in each data block is used for source packet
header, thus the lower 25 bits show timestamp.

The rest of data channels are used to transfer PCM samples, MIDI data
and status/control information. Each data is in 24 bits data chunk. This
is similar to '24-bit * 4 Audio Pack' in IEC 61883-6.

The first two data chunks have MIDI messages and status/control
information. The rest has PCM samples up to 24 bits.

Currently, this protocol layer causes noise like rectanglar wave, due to
timestampling perhaps. The theory to implement timestamping is:

 * Using pre-computed table for the number of ticks per event:
  *  44,1kHz: (557 + 123/441)
  *  48.0kHz: (512 +   0/441)
  *  88.2kHz: (278 + 282/441)
  *  96.0kHz: (256 +   0/441)
  * 176.4kHz: (139 + 141/441)
  * 192.0kHz: (128 +   0/441)
 * Accumulate the ticks and set the value to SPH for every events.
 * This way makes sence for blocking transmission because this mode
   transfers fixed number or none of events.

The reason is not clear.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile     |   2 +-
 sound/firewire/motu/amdtp-motu.c | 442 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.h       |  12 ++
 3 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/amdtp-motu.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index f4cfd14..5c35d77 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-motu-objs := motu.o
+snd-firewire-motu-objs := amdtp-motu.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
new file mode 100644
index 0000000..a10e57c
--- /dev/null
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -0,0 +1,442 @@
+/*
+ * amdtp-motu.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include "motu.h"
+
+/*
+ * Nominally 3125 bytes/second, but the MIDI port's clock might be
+ * 1% too slow, and the bus clock 100 ppm too fast.
+ */
+#define MIDI_BYTES_PER_SECOND	3093
+
+struct amdtp_motu {
+	/* For timestamp processing.  */
+	unsigned int quotient_ticks_per_event;
+	unsigned int remainder_ticks_per_event;
+	unsigned int next_offsets;
+	unsigned int next_accumulated;
+
+	unsigned int pcm_channels;
+
+	unsigned int midi_ports;
+	struct snd_rawmidi_substream *midi[8];
+	int midi_fifo_limit;
+	int midi_fifo_used[8];
+
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_runtime *runtime,
+				 __be32 *buffer, unsigned int data_blocks);
+};
+
+int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			      unsigned int pcm_channels,
+			      unsigned int midi_ports)
+{
+	static const struct {
+		unsigned int quotient_ticks_per_event;
+		unsigned int remainder_ticks_per_event;
+	} params[] = {
+		[CIP_SFC_44100]  = { 557, 123 },
+		[CIP_SFC_48000]  = { 512,   0 },
+		[CIP_SFC_88200]  = { 278, 282 },
+		[CIP_SFC_96000]  = { 256,   0 },
+		[CIP_SFC_176400] = { 139, 141 },
+		[CIP_SFC_192000] = { 128,   0 },
+	};
+	struct amdtp_motu *p = s->protocol;
+	unsigned int data_block_quadlets;
+	int err;
+
+	if (amdtp_stream_running(s))
+		return -EBUSY;
+
+	/* Use 24-bit audio pack in IEC 61883-6, and SPH in IEC 61883-1. */
+	data_block_quadlets = DIV_ROUND_UP((pcm_channels + 2) * 3, 4) + 1;
+
+	err = amdtp_stream_set_parameters(s, rate, data_block_quadlets);
+	if (err < 0)
+		return err;
+
+	p->pcm_channels = pcm_channels;
+	p->midi_ports = midi_ports;
+
+	/*
+	 * We do not know the actual MIDI FIFO size of most devices.  Just
+	 * assume two bytes, i.e., one byte can be received over the bus while
+	 * the previous one is transmitted over MIDI.
+	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 */
+	p->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
+
+	p->quotient_ticks_per_event = params[s->sfc].quotient_ticks_per_event;
+	p->remainder_ticks_per_event = params[s->sfc].remainder_ticks_per_event;
+	p->next_offsets = 0;
+	p->next_accumulated = 0;
+
+	return 0;
+}
+
+static void write_pcm_s32(struct amdtp_stream *s,
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	u8 *byte;
+	const u32 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	/* Skip SPH. */
+	buffer++;
+	for (i = 0; i < data_blocks; ++i) {
+		byte = (u8 *)buffer;
+
+		/* Skip MIDI and control messages. */
+		byte += 6;
+
+		for (c = 0; c < channels; ++c) {
+			byte[0] = ((*src) >> 8) & 0xff;
+			byte[1] = ((*src) >> 16) & 0xff;
+			byte[2] = ((*src) >> 24) & 0xff;
+			byte += 3;
+			src++;
+		}
+
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s16(struct amdtp_stream *s,
+			  struct snd_pcm_runtime *runtime,
+			  __be32 *buffer, unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	u8 *byte;
+	const u16 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	/* Skip SPH. */
+	buffer++;
+	for (i = 0; i < data_blocks; ++i) {
+		byte = (u8 *)buffer;
+
+		/* Skip MIDI and control messages. */
+		byte += 6;
+
+		for (c = 0; c < channels; ++c) {
+			byte[0] = ((*src) >> 8) & 0xff;
+			byte[1] = (*src) & 0xff;
+			byte[2] = 0;
+			byte += 3;
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
+			 __be32 *buffer, unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	unsigned int channels, remaining_frames, i, c;
+	u8 *byte;
+	u32 *dst;
+
+	channels = p->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	/* Skip SPH. */
+	buffer++;
+	for (i = 0; i < data_blocks; ++i) {
+		byte = (u8 *)buffer;
+
+		/* Skip MIDI and control message. */
+		byte += 6;
+
+		for (c = 0; c < channels; ++c) {
+			*dst = (byte[0] << 24) | (byte[1] << 16) | byte[2];
+			byte += 3;
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
+	struct amdtp_motu *p = s->protocol;
+	unsigned int channels, i, c;
+	u8 *byte;
+
+	channels = p->pcm_channels;
+
+	/* Skip SPH. */
+	buffer++;
+	for (i = 0; i < data_blocks; ++i) {
+		byte = (u8 *)buffer;
+
+		/* Skip MIDI and control messages. */
+		byte += 6;
+
+		for (c = 0; c < channels; ++c) {
+			byte[0] = 0;
+			byte[1] = 0;
+			byte[2] = 0;
+			byte += 3;
+		}
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+void amdtp_motu_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
+{
+	struct amdtp_motu *p = s->protocol;
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
+	struct amdtp_motu *p = s->protocol;
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
+	struct amdtp_motu *p = s->protocol;
+
+	p->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
+}
+
+static void write_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+				unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	unsigned int f;
+	u8 *b;
+
+	/* Skip SPH. */
+	buffer++;
+	for (f = 0; f < data_blocks; f++) {
+		b = (u8 *)buffer;
+
+		if (p->midi[0] &&
+		    midi_ratelimit_per_packet(s, 0) &&
+		    snd_rawmidi_transmit(p->midi[0], b + 2, 1) == 1) {
+			midi_rate_use_one_byte(s, 0);
+			b[0] |= 0x01;
+		} else {
+			b[2] = 0x00;
+		}
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+			       unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	unsigned int f;
+	u8 *b;
+
+	/* Skip SPH. */
+	buffer++;
+	for (f = 0; f < data_blocks; f++) {
+		b = (u8 *)buffer;
+
+		if ((b[0] & 0x01) && p->midi[0])
+			snd_rawmidi_receive(p->midi[0], b + 2, 1);
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+void amdtp_motu_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			     struct snd_rawmidi_substream *midi)
+{
+	struct amdtp_motu *p = s->protocol;
+
+	if (port < p->midi_ports)
+		ACCESS_ONCE(p->midi[port]) = midi;
+}
+
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int cycle,
+					   unsigned int *syt)
+{
+	struct amdtp_motu *p = (struct amdtp_motu *)s->protocol;
+	struct snd_pcm_substream *pcm;
+
+	/*
+	 * NOTE: The gap of data in two successive SPH fields has jitters. For
+	 * example, at 44.1kHz:
+	 * 022d, 022f, 022d, 022d, 022d, 022e, 022c, 022d, 022d, 022e, 022d
+	 *
+	 * Therefore, it's better not to reuse it.,
+	 */
+
+	/* TODO: how to interact control messages between userspace? */
+
+	if (p->midi_ports)
+		read_midi_messages(s, buffer, data_blocks);
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (data_blocks > 0 && pcm)
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+
+	return data_blocks;
+}
+
+static void write_sph(struct amdtp_motu *p, u32 *buffer, unsigned int cycle,
+		      unsigned int data_blocks)
+{
+	unsigned int seconds;
+	unsigned int counts;
+	__u32 sph;
+	unsigned int i;
+
+	seconds = cycle >> 13;
+	counts = cycle % 8000;
+
+	for (i = 0; i < data_blocks; i++) {
+		sph = (seconds << 25) | (counts << 12) | p->next_offsets;
+		buffer[2] = cpu_to_be32(sph);
+
+		p->next_accumulated += p->remainder_ticks_per_event;
+		if (p->next_accumulated >= 441) {
+			p->next_accumulated -= 441;
+			p->next_offsets++;
+		}
+
+		p->next_offsets += p->quotient_ticks_per_event;
+		if (p->next_offsets >= 3072) {
+			p->next_offsets -= 3072;
+			if (++counts >= 8000) {
+				counts -= 8000;
+				seconds = (seconds + 1) % 8;
+			}
+		}
+	}
+}
+
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int cycle,
+					   unsigned int *syt)
+{
+	struct amdtp_motu *p = (struct amdtp_motu *)s->protocol;
+	struct snd_pcm_substream *pcm;
+
+	/* Not used. */
+	*syt = 0xffff;
+
+	/* TODO: how to interact control messages between userspace? */
+
+	write_sph(p, buffer, cycle, data_blocks);
+
+	if (p->midi_ports)
+		write_midi_messages(s, buffer, data_blocks);
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm)
+		p->transfer_samples(s, pcm->runtime, buffer, data_blocks);
+	else
+		write_pcm_silence(s, buffer, data_blocks);
+
+	return data_blocks;
+}
+
+int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
+		   enum amdtp_stream_direction dir)
+{
+	struct amdtp_motu *p;
+	int err;
+
+	err = amdtp_stream_init(s, unit, dir, CIP_BLOCKING,
+				sizeof(struct amdtp_motu));
+	if (err < 0)
+		return err;
+	p = s->protocol;
+
+	if (dir == AMDTP_IN_STREAM)
+		s->process_data_blocks = process_tx_data_blocks;
+	else
+		s->process_data_blocks = process_rx_data_blocks;
+
+	s->sph = 0x1;
+	s->fmt = 0x02;
+	s->fdf = 0x22;
+
+	return 0;
+}
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index d5dddbd..690818f 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -19,6 +19,10 @@
 
 #include <sound/control.h>
 #include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/rawmidi.h>
 
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
@@ -47,4 +51,12 @@ struct snd_motu {
 	struct snd_motu_spec *spec;
 };
 
+int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
+		    enum amdtp_stream_direction dir);
+int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			      unsigned int pcm_channels,
+			      unsigned int midi_ports);
+void amdtp_motu_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
+void amdtp_motu_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			     struct snd_rawmidi_substream *midi);
 #endif
-- 
2.1.4
