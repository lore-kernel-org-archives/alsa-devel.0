From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/17] firewire-lib: Add support for channel
	mapping
Date: Sat, 23 Nov 2013 15:07:58 +0900
Message-ID: <1385186884-8259-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF082651B2
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:13 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some devices arrange the position of PCM/MIDI data. This commit allows drivers
to set channel mapping.

To be simple, the mapping table is an array with fixed length. Then the number
of channels for PCM is restricted by 64 channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 131 +++++++++++++++++++++++++++++--------------------
 sound/firewire/amdtp.h |   7 +++
 2 files changed, 84 insertions(+), 54 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index bc21276..9c7aee4 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -140,14 +140,15 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 		[CIP_SFC_176400] = 176400,
 		[CIP_SFC_192000] = 192000,
 	};
-	unsigned int sfc, midi_channels;
+	unsigned int i, sfc, midi_channels;
 
 	midi_channels = DIV_ROUND_UP(midi_ports, 8);
-	if (WARN_ON(amdtp_stream_running(s)) ||
+	if (WARN_ON(amdtp_stream_running(s)) |
+	    WARN_ON(pcm_channels > AMDTP_MAX_CHANNELS_FOR_PCM) |
 	    WARN_ON(midi_channels > AMDTP_MAX_CHANNELS_FOR_MIDI))
 		return;
 
-	for (sfc = 0; sfc < CIP_SFC_COUNT; ++sfc)
+	for (sfc = 0; sfc < sizeof(rates); ++sfc)
 		if (rates[sfc] == rate)
 			goto sfc_found;
 	WARN_ON(1);
@@ -156,22 +157,31 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 sfc_found:
 	s->dual_wire = (s->flags & CIP_HI_DUALWIRE) && sfc > CIP_SFC_96000;
 	if (s->dual_wire) {
-		sfc -= 2;
+		s->sfc = sfc - 2;
+		s->pcm_channels = pcm_channels * 2;
 		rate /= 2;
-		pcm_channels *= 2;
+	} else {
+		s->sfc = sfc;
+		s->pcm_channels = pcm_channels;
 	}
 	s->sfc = sfc;
-	s->data_block_quadlets = pcm_channels + DIV_ROUND_UP(midi_ports, 8);
 	s->pcm_channels = pcm_channels;
 	s->midi_channels = midi_channels;
+	s->data_block_quadlets = s->pcm_channels + s->midi_channels;
 
-	s->syt_interval = amdtp_syt_intervals[sfc];
+	s->syt_interval = amdtp_syt_intervals[s->sfc];
 
 	/* default buffering in the device */
 	s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
 	if (s->flags & CIP_BLOCKING)
 		/* additional buffering needed to adjust for no-data packets */
 		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
+
+	/* init the position map for PCM and MIDI channels */
+	for (i = 0; i < pcm_channels; i++)
+		s->pcm_positions[i] = i;
+	for (i = 0; i < midi_channels; i++)
+		s->midi_positions[i] = s->pcm_channels + i;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);
 
@@ -356,22 +366,20 @@ static void amdtp_write_s32(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, frame_step, i, c;
+	unsigned int remaining_frames, i, c;
 	const u32 *src;
 
-	channels = s->pcm_channels;
 	src = (void *)runtime->dma_area +
 			frames_to_bytes(runtime, s->pcm_buffer_pointer);
 	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	frame_step = s->data_block_quadlets - channels;
 
 	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
+		for (c = 0; c < s->pcm_channels; ++c) {
+			buffer[s->pcm_positions[c]] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
 			src++;
-			buffer++;
 		}
-		buffer += frame_step;
+		buffer += s->data_block_quadlets;
 		if (--remaining_frames == 0)
 			src = (void *)runtime->dma_area;
 	}
@@ -382,22 +390,20 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, frame_step, i, c;
+	unsigned int remaining_frames, i, c;
 	const u16 *src;
 
-	channels = s->pcm_channels;
 	src = (void *)runtime->dma_area +
 			frames_to_bytes(runtime, s->pcm_buffer_pointer);
 	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	frame_step = s->data_block_quadlets - channels;
 
 	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
+		for (c = 0; c < s->pcm_channels; ++c) {
+			buffer[s->pcm_positions[c]] =
+					cpu_to_be32((*src << 8) | 0x40000000);
 			src++;
-			buffer++;
 		}
-		buffer += frame_step;
+		buffer += s->data_block_quadlets;
 		if (--remaining_frames == 0)
 			src = (void *)runtime->dma_area;
 	}
@@ -408,29 +414,29 @@ static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
 				     __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, frame_adjust_1, frame_adjust_2, i, c;
+	unsigned int channels, remaining_frames, i, c;
 	const u32 *src;
 
-	channels = s->pcm_channels;
 	src = (void *)runtime->dma_area +
-			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
-	frame_adjust_1 = channels - 1;
-	frame_adjust_2 = 1 - (s->data_block_quadlets - channels);
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	channels = s->pcm_channels / 2;
 
-	channels /= 2;
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
+			buffer[s->pcm_positions[c] * 2] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
 			src++;
-			buffer += 2;
 		}
-		buffer -= frame_adjust_1;
+		buffer += 1;
 		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
+			buffer[s->pcm_positions[c] * 2] =
+					cpu_to_be32((*src >> 8) | 0x40000000);
 			src++;
-			buffer += 2;
 		}
-		buffer -= frame_adjust_2;
+		buffer += s->data_block_quadlets - 1;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
 	}
 }
 
@@ -439,29 +445,29 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
 				     __be32 *buffer, unsigned int frames)
 {
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, frame_adjust_1, frame_adjust_2, i, c;
+	unsigned int channels, remaining_frames, i, c;
 	const u16 *src;
 
-	channels = s->pcm_channels;
 	src = (void *)runtime->dma_area +
-			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
-	frame_adjust_1 = channels - 1;
-	frame_adjust_2 = 1 - (s->data_block_quadlets - channels);
+			frames_to_bytes(runtime, s->pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+	channels = s->pcm_channels / 2;
 
-	channels /= 2;
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
+			buffer[s->pcm_positions[c] * 2] =
+					cpu_to_be32((*src << 8) | 0x40000000);
 			src++;
-			buffer += 2;
 		}
-		buffer -= frame_adjust_1;
+		buffer += 1;
 		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
+			buffer[s->pcm_positions[c] * 2] =
+					cpu_to_be32((*src << 8) | 0x40000000);
 			src++;
-			buffer += 2;
 		}
-		buffer -= frame_adjust_2;
+		buffer += s->data_block_quadlets - 1;
+		if (--remaining_frames == 0)
+			src = (void *)runtime->dma_area;
 	}
 }
 
@@ -479,7 +485,7 @@ static void amdtp_read_s32(struct amdtp_stream *s,
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < s->pcm_channels; ++c) {
-			*dst = be32_to_cpu(buffer[c]) << 8;
+			*dst = be32_to_cpu(buffer[s->pcm_positions[c]]) << 8;
 			dst++;
 		}
 		buffer += s->data_block_quadlets;
@@ -502,7 +508,7 @@ static void amdtp_read_s16(struct amdtp_stream *s,
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < s->pcm_channels; ++c) {
-			*dst = be32_to_cpu(buffer[c]) << 8;
+			*dst = be32_to_cpu(buffer[s->pcm_positions[c]]) << 8;
 			dst++;
 		}
 		buffer +=s->data_block_quadlets;
@@ -527,13 +533,13 @@ static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
 			*dst =
-			     be32_to_cpu(buffer[c]) << 8;
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += 1;
 		for (c = 0; c < channels; ++c) {
 			*dst =
-			     be32_to_cpu(buffer[c]) << 8;
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += s->data_block_quadlets - 1;
@@ -558,13 +564,13 @@ static void amdtp_read_s16_dualwire(struct amdtp_stream *s,
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
 			*dst =
-			     be32_to_cpu(buffer[c]) << 8;
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += 1;
 		for (c = 0; c < channels; ++c) {
 			*dst =
-			     be32_to_cpu(buffer[c]) << 8;
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += s->data_block_quadlets - 1;
@@ -580,11 +586,26 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < s->pcm_channels; ++c)
-			buffer[c] = cpu_to_be32(0x40000000);
+			buffer[s->pcm_positions[c]] = cpu_to_be32(0x40000000);
 		buffer += s->data_block_quadlets;
 	}
 }
 
+static void amdtp_fill_pcm_silence_dualwire(struct amdtp_stream *s,
+					   __be32 *buffer, unsigned int frames)
+{
+	unsigned int i, c, channels;
+
+	channels = s->pcm_channels /2;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			buffer[s->pcm_positions[c] * 2] =
+			buffer[s->pcm_positions[c] * 2 + 1] =
+						cpu_to_be32(0x40000000);
+		}
+		buffer += s->data_block_quadlets;
+	}
+}
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
@@ -609,7 +630,7 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 				else
 					b[0] = 0x81;
 			}
-			buffer[s->pcm_channels + c] =
+			buffer[s->midi_positions[c]] =
 				be32_to_cpu((b[0] << 24) | (b[1] << 16));
 		}
 		buffer += s->data_block_quadlets;
@@ -626,7 +647,7 @@ static void amdtp_pull_midi(struct amdtp_stream *s,
 	for (f = 0; f < frames; f++) {
 		m = (s->data_block_counter + f) % 8;
 		for (c = 0; c < s->midi_channels; c++) {
-			b = (u8 *)&buffer[s->pcm_channels + c];
+			b = (u8 *)&buffer[s->midi_positions[c]];
 			if (b[0] < 0x81 || 0x83 < b[0])
 				continue;
 
@@ -737,6 +758,8 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
+	else if (s->dual_wire)
+		amdtp_fill_pcm_silence_dualwire(s, buffer, data_blocks);
 	else
 		amdtp_fill_pcm_silence(s, buffer, data_blocks);
 	if (s->midi_channels)
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 0ba65bb..539c007 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -48,6 +48,11 @@ enum cip_sfc {
 					 SNDRV_PCM_FMTBIT_S32)
 
 /*
+ * This module supports maximum 16 PCM channel for one PCM stream
+ * This is for our convinience.
+ */
+#define AMDTP_MAX_CHANNELS_FOR_PCM	64
+/*
  * This module supports maximum 2 MIDI channels.
  * Then AMDTP packets include maximum 16 MIDI streams multiplexed.
  * This is for our convinience.
@@ -79,6 +84,8 @@ struct amdtp_stream {
 	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
+	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
+	u8 midi_positions[AMDTP_MAX_CHANNELS_FOR_MIDI];
 
 	unsigned int syt_interval;
 	unsigned int transfer_delay;
-- 
1.8.3.2
