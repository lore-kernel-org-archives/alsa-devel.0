From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/7] ALSA: firewire-digi00x: add data block
	processing layer
Date: Wed, 30 Sep 2015 09:39:17 +0900
Message-ID: <1443573562-24088-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1443573562-24088-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 908EC2659DD
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 02:39:31 +0200 (CEST)
In-Reply-To: <1443573562-24088-1-git-send-email-o-takashi@sakamocchi.jp>
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

Digi 002/003 family uses its own format for data blocks. The format is
quite similar to AM824 in IEC 61883-6, while there're some differences:

 * The Valid Bit Length (VBL) code is always 0x40 in Multi-bit Linear Audio
   (MBLA) data channel.
 * The first data channel includes MIDI messages, against IEC 61883-6
   recommendation.
 * The Counter field is always zero in MIDI conformant data channel.
 * Sequence multiplexing in IEC 61883-6 is not applied to the MIDI
   conformant data channel.
 * PCM samples are scrambled in received AMDTP packets. We call the way
   as Double-Oh-Three (DOT). The algorithm was discovered by
   Robin Gareus and Damien Zammit in 2012.

This commit adds data processing layer to satisfy these differences.

There's a quirk about transmission mode for received packets. When this
driver applies non-blocking mode to outgoing packets with isochronous
channel 2 or more, after 15 to 20 seconds since playbacking, any PCM
samples causes noisy sound on the device. With isochronous channel 0 or 1,
this doesn't occur. As long as I investigated, this quirk is not observed
when applying blocking mode to the received packets.

This driver applies blocking mode to outgoing packets, while non-blocking
mode to incoming packgets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/Makefile    |   2 +-
 sound/firewire/digi00x/amdtp-dot.c | 330 +++++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.h   |  14 ++
 3 files changed, 345 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/digi00x/amdtp-dot.c

diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
index 13fec5b..87c4cfd 100644
--- a/sound/firewire/digi00x/Makefile
+++ b/sound/firewire/digi00x/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-digi00x-objs := digi00x.o
+snd-firewire-digi00x-objs := amdtp-dot.o digi00x.o
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += snd-firewire-digi00x.o
diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
new file mode 100644
index 0000000..e6731d3
--- /dev/null
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -0,0 +1,330 @@
+/*
+ * amdtp-dot.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ * Copyright (C) 2012 Robin Gareus <robin@gareus.org>
+ * Copyright (C) 2012 Damien Zammit <damien@zamaudio.com>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <sound/pcm.h>
+#include "digi00x.h"
+
+#define CIP_FMT_AM		0x10
+
+/* 'Clock-based rate control mode' is just supported. */
+#define AMDTP_FDF_AM824		0x00
+
+/*
+ * The double-oh-three algorithm was discovered by Robin Gareus and Damien
+ * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
+ */
+struct dot_state {
+	__u8 carry;
+	__u8 idx;
+	unsigned int off;
+};
+
+struct amdtp_dot {
+	unsigned int pcm_channels;
+	struct dot_state state;
+
+	unsigned int midi_ports;
+
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_substream *pcm,
+				 __be32 *buffer, unsigned int frames);
+};
+
+/*
+ * double-oh-three look up table
+ *
+ * @param idx index byte (audio-sample data) 0x00..0xff
+ * @param off channel offset shift
+ * @return salt to XOR with given data
+ */
+#define BYTE_PER_SAMPLE (4)
+#define MAGIC_DOT_BYTE (2)
+#define MAGIC_BYTE_OFF(x) (((x) * BYTE_PER_SAMPLE) + MAGIC_DOT_BYTE)
+static const __u8 dot_scrt(const __u8 idx, const unsigned int off)
+{
+	/*
+	 * the length of the added pattern only depends on the lower nibble
+	 * of the last non-zero data
+	 */
+	static const __u8 len[16] = {0, 1, 3, 5, 7, 9, 11, 13, 14,
+				     12, 10, 8, 6, 4, 2, 0};
+
+	/*
+	 * the lower nibble of the salt. Interleaved sequence.
+	 * this is walked backwards according to len[]
+	 */
+	static const __u8 nib[15] = {0x8, 0x7, 0x9, 0x6, 0xa, 0x5, 0xb, 0x4,
+				     0xc, 0x3, 0xd, 0x2, 0xe, 0x1, 0xf};
+
+	/* circular list for the salt's hi nibble. */
+	static const __u8 hir[15] = {0x0, 0x6, 0xf, 0x8, 0x7, 0x5, 0x3, 0x4,
+				     0xc, 0xd, 0xe, 0x1, 0x2, 0xb, 0xa};
+
+	/*
+	 * start offset for upper nibble mapping.
+	 * note: 9 is /special/. In the case where the high nibble == 0x9,
+	 * hir[] is not used and - coincidentally - the salt's hi nibble is
+	 * 0x09 regardless of the offset.
+	 */
+	static const __u8 hio[16] = {0, 11, 12, 6, 7, 5, 1, 4,
+				     3, 0x00, 14, 13, 8, 9, 10, 2};
+
+	const __u8 ln = idx & 0xf;
+	const __u8 hn = (idx >> 4) & 0xf;
+	const __u8 hr = (hn == 0x9) ? 0x9 : hir[(hio[hn] + off) % 15];
+
+	if (len[ln] < off)
+		return 0x00;
+
+	return ((nib[14 + off - len[ln]]) | (hr << 4));
+}
+
+static void dot_encode_step(struct dot_state *state, __be32 *const buffer)
+{
+	__u8 * const data = (__u8 *) buffer;
+
+	if (data[MAGIC_DOT_BYTE] != 0x00) {
+		state->off = 0;
+		state->idx = data[MAGIC_DOT_BYTE] ^ state->carry;
+	}
+	data[MAGIC_DOT_BYTE] ^= state->carry;
+	state->carry = dot_scrt(state->idx, ++(state->off));
+}
+
+int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			     unsigned int pcm_channels, unsigned int midi_ports)
+{
+	struct amdtp_dot *p = s->protocol;
+	int err;
+
+	if (amdtp_stream_running(s))
+		return -EBUSY;
+
+	/*
+	 * A first data channel is for MIDI conformant data channel, the rest is
+	 * Multi Bit Linear Audio data channel.
+	 */
+	err = amdtp_stream_set_parameters(s, rate, pcm_channels + 1);
+	if (err < 0)
+		return err;
+
+	s->fdf = AMDTP_FDF_AM824 | s->sfc;
+
+	p->pcm_channels = pcm_channels;
+	p->midi_ports = midi_ports;
+
+	return 0;
+}
+
+static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_dot *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u32 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	buffer++;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[c] = cpu_to_be32((*src >> 8) | 0x40000000);
+			dot_encode_step(&p->state, &buffer[c]);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s16(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_dot *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u16 *src;
+
+	channels = p->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	buffer++;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[c] = cpu_to_be32((*src << 8) | 0x40000000);
+			dot_encode_step(&p->state, &buffer[c]);
+			src++;
+		}
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void read_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames)
+{
+	struct amdtp_dot *p = s->protocol;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	u32 *dst;
+
+	channels = p->pcm_channels;
+	dst  = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	buffer++;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*dst = be32_to_cpu(buffer[c]) << 8;
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
+	struct amdtp_dot *p = s->protocol;
+	unsigned int channels, i, c;
+
+	channels = p->pcm_channels;
+
+	buffer++;
+	for (i = 0; i < data_blocks; ++i) {
+		for (c = 0; c < channels; ++c)
+			buffer[c] = cpu_to_be32(0x40000000);
+		buffer += s->data_block_quadlets;
+	}
+}
+
+int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
+				     struct snd_pcm_runtime *runtime)
+{
+	int err;
+
+	/* This protocol delivers 24 bit data in 32bit data channel. */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (err < 0)
+		return err;
+
+	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
+}
+
+void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
+{
+	struct amdtp_dot *p = s->protocol;
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
+static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		pcm_frames = 0;
+	}
+
+	/* A place holder for MIDI processing. */
+
+	return pcm_frames;
+}
+
+static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
+					   __be32 *buffer,
+					   unsigned int data_blocks,
+					   unsigned int *syt)
+{
+	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm) {
+		p->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks;
+	} else {
+		write_pcm_silence(s, buffer, data_blocks);
+		pcm_frames = 0;
+	}
+
+	/* A place holder for MIDI processing. */
+
+	return pcm_frames;
+}
+
+int amdtp_dot_init(struct amdtp_stream *s, struct fw_unit *unit,
+		 enum amdtp_stream_direction dir)
+{
+	amdtp_stream_process_data_blocks_t process_data_blocks;
+	enum cip_flags flags;
+
+	/* Use different mode between incoming/outgoing. */
+	if (dir == AMDTP_IN_STREAM) {
+		flags = CIP_NONBLOCKING | CIP_SKIP_INIT_DBC_CHECK;
+		process_data_blocks = process_tx_data_blocks;
+	} else {
+		flags = CIP_BLOCKING;
+		process_data_blocks = process_rx_data_blocks;
+	}
+
+	return amdtp_stream_init(s, unit, dir, flags, CIP_FMT_AM,
+				 process_data_blocks, sizeof(struct amdtp_dot));
+}
+
+void amdtp_dot_reset(struct amdtp_stream *s)
+{
+	struct amdtp_dot *p = s->protocol;
+
+	p->state.carry = 0x00;
+	p->state.idx = 0x00;
+	p->state.off = 0;
+}
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 0bb2ca3..fe21d77 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -19,8 +19,12 @@
 
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
 
 #include "../lib.h"
+#include "../iso-resources.h"
+#include "../amdtp-stream.h"
 
 struct snd_dg00x {
 	struct snd_card *card;
@@ -29,4 +33,14 @@ struct snd_dg00x {
 	struct mutex mutex;
 };
 
+int amdtp_dot_init(struct amdtp_stream *s, struct fw_unit *unit,
+		   enum amdtp_stream_direction dir);
+int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			     unsigned int pcm_channels,
+			     unsigned int midi_ports);
+void amdtp_dot_reset(struct amdtp_stream *s);
+int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
+				     struct snd_pcm_runtime *runtime);
+void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
+
 #endif
-- 
2.1.4
