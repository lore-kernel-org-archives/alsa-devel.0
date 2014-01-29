From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/52] firewire-lib: Add support for channel mapping
Date: Wed, 29 Jan 2014 22:44:18 +0900
Message-ID: <1391003099-7109-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some devices arrange the position of PCM/MIDI data channel in AMDTP packet.
This commit allows drivers to set channel mapping.

To be simple, the mapping table is an array with fixed length. Then the number
of channels for PCM is restricted by 64 channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 122 +++++++++++++++++++++++++++++--------------------
 sound/firewire/amdtp.h |   8 ++++
 2 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 881d610..73f36fb 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -140,11 +140,12 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
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
 
@@ -159,11 +160,12 @@ sfc_found:
 	if (s->dual_wire) {
 		sfc -= 2;
 		rate /= 2;
-		pcm_channels *= 2;
+		s->pcm_channels = pcm_channels * 2;
+	} else {
+		s->pcm_channels = pcm_channels;
 	}
 	s->sfc = sfc;
-	s->data_block_quadlets = pcm_channels + midi_channels;
-	s->pcm_channels = pcm_channels;
+	s->data_block_quadlets = s->pcm_channels + midi_channels;
 	s->midi_ports = midi_ports;
 
 	s->syt_interval = amdtp_syt_intervals[sfc];
@@ -173,6 +175,11 @@ sfc_found:
 	if (s->flags & CIP_BLOCKING)
 		/* additional buffering needed to adjust for no-data packets */
 		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
+
+	/* init the position map for PCM and MIDI channels */
+	for (i = 0; i < pcm_channels; i++)
+		s->pcm_positions[i] = i;
+	s->midi_position = s->pcm_channels;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);
 
@@ -351,22 +358,20 @@ static void amdtp_write_s32(struct amdtp_stream *s,
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
@@ -377,22 +382,20 @@ static void amdtp_write_s16(struct amdtp_stream *s,
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
@@ -403,29 +406,29 @@ static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
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
 
@@ -434,29 +437,29 @@ static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
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
 
@@ -474,7 +477,7 @@ static void amdtp_read_s32(struct amdtp_stream *s,
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < s->pcm_channels; ++c) {
-			*dst = be32_to_cpu(buffer[c]) << 8;
+			*dst = be32_to_cpu(buffer[s->pcm_positions[c]]) << 8;
 			dst++;
 		}
 		buffer += s->data_block_quadlets;
@@ -498,12 +501,14 @@ static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
-			*dst = be32_to_cpu(buffer[c * 2]) << 8;
+			*dst =
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += 1;
 		for (c = 0; c < channels; ++c) {
-			*dst = be32_to_cpu(buffer[c * 2]) << 8;
+			*dst =
+			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
 			dst++;
 		}
 		buffer += s->data_block_quadlets - 1;
@@ -519,11 +524,26 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 
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
+	channels = s->pcm_channels / 2;
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
@@ -531,8 +551,8 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 	u8 *b;
 
 	for (f = 0; f < frames; f++) {
-		buffer[s->pcm_channels + 1] = 0x00;
-		b = (u8 *)&buffer[s->pcm_channels + 1];
+		buffer[s->midi_position] = 0x00;
+		b = (u8 *)&buffer[s->midi_position];
 
 		port = (s->data_block_counter + f) % 8;
 		if ((s->midi[port] == NULL) ||
@@ -555,7 +575,7 @@ static void amdtp_pull_midi(struct amdtp_stream *s,
 
 	for (f = 0; f < frames; f++) {
 		port = (s->data_block_counter + f) % 8;
-		b = (u8 *)&buffer[s->pcm_channels + 1];
+		b = (u8 *)&buffer[s->midi_position];
 
 		len = b[0] - 0x80;
 		if (len < 1 || 3 < len)
@@ -664,6 +684,8 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
+	else if (s->dual_wire)
+		amdtp_fill_pcm_silence_dualwire(s, buffer, data_blocks);
 	else
 		amdtp_fill_pcm_silence(s, buffer, data_blocks);
 	if (s->midi_ports)
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 4cf7a7e..d7bd81a 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -49,6 +49,12 @@ enum cip_sfc {
 
 
 /*
+ * This module supports maximum 64 PCM channels for one PCM stream
+ * This is for our convinience.
+ */
+#define AMDTP_MAX_CHANNELS_FOR_PCM	64
+
+/*
  * AMDTP packet can include channels for MIDI conformant data.
  * Each MIDI conformant data channel includes 8 MPX-MIDI data stream.
  * Each MPX-MIDI data stream includes one data stream from/to MIDI ports.
@@ -83,6 +89,8 @@ struct amdtp_stream {
 	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
+	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
+	u8 midi_position;
 
 	unsigned int syt_interval;
 	unsigned int transfer_delay;
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
