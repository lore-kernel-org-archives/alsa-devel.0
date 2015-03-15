From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
	algorism to multiplex PCM samples
Date: Mon, 16 Mar 2015 01:01:09 +0900
Message-ID: <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF3E2608AB
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 17:01:21 +0100 (CET)
In-Reply-To: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, robin@gareus.org, damien@zamaudio.com
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses own way to multiplex PCM samples into data
blocks in CIP payload for received stream, thus AMDTP-conformant
implementation causes noisy sound.

This commit applies double-oh-three algorism, which discovered by Robin
Gareus and Damien Zammit in 2012.

As long as I tested, this patch still has disorder that:
 * 1st PCM channel still causes noise in 2nd PCM channel.
 * At 88.2/96.0kHz, any PCM channels still causes noise in the other PCM
   channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-protocol.c | 113 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x-stream.c   |   2 +
 sound/firewire/digi00x/digi00x.h          |   3 +
 3 files changed, 118 insertions(+)

diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
index 4dd373d..ac092cb 100644
--- a/sound/firewire/digi00x/digi00x-protocol.c
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -2,12 +2,125 @@
  * digi00x-protocol.c - a part of driver for Digidesign Digi 002/003 family
  *
  * Copyright (c) 2014-2015 Takashi Sakamoto
+ * Copyright (C) 2012 Robin Gareus <robin@gareus.org>
+ * Copyright (C) 2012 Damien Zammit <damien@zamaudio.com>
  *
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
 #include "digi00x.h"
 
+/*
+ * The double-oh-three algorism is invented by Robin Gareus and Damien Zammit
+ * in 2012, with reverse-engineering for Digi 003 Rack.
+ */
+
+struct dot_state {
+	__u8 carry;
+	__u8 idx;
+	unsigned int off;
+};
+
+#define BYTE_PER_SAMPLE (4)
+#define MAGIC_DOT_BYTE (2)
+
+#define MAGIC_BYTE_OFF(x) (((x) * BYTE_PER_SAMPLE) + MAGIC_DOT_BYTE)
+
+/*
+ * double-oh-three look up table
+ *
+ * @param idx index byte (audio-sample data) 0x00..0xff
+ * @param off channel offset shift
+ * @return salt to XOR with given data
+ */
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
+static inline void dot_state_reset(struct dot_state *state)
+{
+	state->carry = 0x00;
+	state->idx   = 0x00;
+	state->off   = 0;
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
+void snd_dg00x_protocol_write_s32(struct amdtp_stream *s,
+				  struct snd_pcm_substream *pcm,
+				  __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u32 *src;
+	static struct dot_state state;
+
+	channels = s->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		dot_state_reset(&state);
+
+		for (c = 0; c < channels; ++c) {
+			buffer[s->pcm_positions[c]] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
+			dot_encode_step(&state, &buffer[s->pcm_positions[c]]);
+			src++;
+		}
+
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
 void snd_dg00x_protocol_fill_midi(struct amdtp_stream *s,
 				  __be32 *buffer, unsigned int frames)
 {
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 410b971..bc4c88c 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -204,6 +204,8 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 	dg00x->rx_stream.midi_position = 0;
 	dg00x->tx_stream.midi_position = 0;
 
+	/* Apply doubleOhThree algorism. */
+	dg00x->rx_stream.transfer_samples = snd_dg00x_protocol_write_s32;
 	dg00x->rx_stream.transfer_midi = snd_dg00x_protocol_fill_midi;
 	dg00x->tx_stream.transfer_midi = snd_dg00x_protocol_pull_midi;
 
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index a658f44..07e54fc 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -84,6 +84,9 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPTICAL_MODE_SPDIF,
 };
 
+void snd_dg00x_protocol_write_s32(struct amdtp_stream *s,
+				  struct snd_pcm_substream *pcm,
+				  __be32 *buffer, unsigned int frames);
 void snd_dg00x_protocol_fill_midi(struct amdtp_stream *s,
 				  __be32 *buffer, unsigned int frames);
 void snd_dg00x_protocol_pull_midi(struct amdtp_stream *s,
-- 
2.1.0
