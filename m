From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
	algorithm to multiplex PCM samples
Date: Mon, 30 Mar 2015 00:05:31 +0900
Message-ID: <1427641531-9047-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A2D3260487
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:49 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family uses own way to multiplex PCM samples into data
blocks of CIP payload for received stream, thus AMDTP-conformant
implementation causes noisy sound.

This commit applies double-oh-three algorithm, which discovered by Robin
Gareus and Damien Zammit in 2012.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-pcm.c      |   9 +-
 sound/firewire/digi00x/digi00x-protocol.c | 143 ++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.h          |  21 +++++
 3 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index a050d67..9b54ab7 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -179,8 +179,9 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		dg00x->playback_substreams++;
 		mutex_unlock(&dg00x->mutex);
 	}
-	amdtp_stream_set_pcm_format(&dg00x->rx_stream,
-				    params_format(hw_params));
+	/* Apply double-oh-three algorism. */
+	snd_dg00x_protocol_set_pcm_function(&dg00x->rx_stream,
+					    params_format(hw_params));
 	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
 						params_buffer_bytes(hw_params));
 }
@@ -241,8 +242,10 @@ static int pcm_playback_prepare(struct snd_pcm_substream *substream)
 	mutex_lock(&dg00x->mutex);
 
 	err = snd_dg00x_stream_start_duplex(dg00x, runtime->rate);
-	if (err >= 0)
+	if (err >= 0) {
 		amdtp_stream_pcm_prepare(&dg00x->rx_stream);
+		snd_dg00x_protocol_init_state(&dg00x->state);
+	}
 
 	mutex_unlock(&dg00x->mutex);
 
diff --git a/sound/firewire/digi00x/digi00x-protocol.c b/sound/firewire/digi00x/digi00x-protocol.c
index 9104691..19c4d8b 100644
--- a/sound/firewire/digi00x/digi00x-protocol.c
+++ b/sound/firewire/digi00x/digi00x-protocol.c
@@ -2,12 +2,136 @@
  * digi00x-protocol.c - a part of driver for Digidesign Digi 002/003 family
  *
  * Copyright (c) 2014-2015 Takashi Sakamoto
+ * Copyright (C) 2012 Robin Gareus <robin@gareus.org>
+ * Copyright (C) 2012 Damien Zammit <damien@zamaudio.com>
  *
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
+#include <sound/asound.h>
 #include "digi00x.h"
 
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
+static void write_pcm_s16(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct snd_dg00x *dg00x =
+			container_of(s, struct snd_dg00x, rx_stream);
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u16 *src;
+
+	channels = s->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[s->pcm_positions[c]] =
+					cpu_to_be32((*src << 8) | 0x40000000);
+			dot_encode_step(&dg00x->state,
+					&buffer[s->pcm_positions[c]]);
+			src++;
+		}
+
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
+static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames)
+{
+	struct snd_dg00x *dg00x =
+			container_of(s, struct snd_dg00x, rx_stream);
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, remaining_frames, i, c;
+	const u32 *src;
+
+	channels = s->pcm_channels;
+	src = (void *)runtime->dma_area +
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[s->pcm_positions[c]] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
+			dot_encode_step(&dg00x->state,
+					&buffer[s->pcm_positions[c]]);
+			src++;
+		}
+
+		buffer += s->data_block_quadlets;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
+	}
+}
+
 static void fill_midi(struct amdtp_stream *s, __be32 *buffer,
 		      unsigned int frames)
 {
@@ -56,6 +180,25 @@ static void pull_midi(struct amdtp_stream *s, __be32 *buffer,
 	}
 }
 
+void snd_dg00x_protocol_set_pcm_function(struct amdtp_stream *s,
+					 snd_pcm_format_t format)
+{
+	if (WARN_ON(amdtp_stream_pcm_running(s)))
+		return;
+
+	switch (format) {
+	default:
+		WARN_ON(1);
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S16:
+		s->transfer_samples = write_pcm_s16;
+		break;
+	case SNDRV_PCM_FORMAT_S32:
+		s->transfer_samples = write_pcm_s32;
+		break;
+	}
+}
+
 /* Use own way to multiplex MIDI messages for data channels. */
 void snd_dg00x_protocol_set_midi_function(struct snd_dg00x *dg00x)
 {
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index b9d072c..96f9dea 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -33,6 +33,16 @@
 #include "../iso-resources.h"
 #include "../amdtp.h"
 
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
 struct snd_dg00x {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -44,6 +54,7 @@ struct snd_dg00x {
 	struct amdtp_stream tx_stream;
 	struct fw_iso_resources tx_resources;
 
+	struct dot_state state;
 	struct amdtp_stream rx_stream;
 	struct fw_iso_resources rx_resources;
 
@@ -112,6 +123,16 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
+/* Initialize dot status. */
+static inline void snd_dg00x_protocol_init_state(struct dot_state *state)
+{
+	state->carry = 0x00;
+	state->idx = 0x00;
+	state->off = 0;
+}
+
+void snd_dg00x_protocol_set_pcm_function(struct amdtp_stream *s,
+					 snd_pcm_format_t format);
 void snd_dg00x_protocol_set_midi_function(struct snd_dg00x *dg00x);
 void snd_dg00x_protocol_queue_midi_message(struct snd_dg00x *dg00x);
 int snd_dg00x_protocol_add_instance(struct snd_dg00x *dg00x);
-- 
2.1.0
