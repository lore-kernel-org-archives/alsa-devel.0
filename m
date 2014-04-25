From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/49] dice/firewire-lib: Keep dualwire mode but obsolete
	CIP_HI_DUALWIRE
Date: Fri, 25 Apr 2014 22:44:51 +0900
Message-ID: <1398433530-13136-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, AMDTP functionality in firewire-lib supports mapping
for PCM data channels. With this mapping, firewire-lib can obsolete
a flag, CIP_HI_DUALWIRE, but Dice driver still keeps dual wire mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 151 ++-----------------------------------------------
 sound/firewire/amdtp.h |   8 +--
 sound/firewire/dice.c  |  33 +++++++++--
 3 files changed, 34 insertions(+), 158 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 9cf81b2..3475b76 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -145,14 +145,7 @@ void amdtp_stream_set_parameters(struct amdtp_stream *s,
 	return;
 
 sfc_found:
-	s->dual_wire = (s->flags & CIP_HI_DUALWIRE) && sfc > CIP_SFC_96000;
-	if (s->dual_wire) {
-		sfc -= 2;
-		rate /= 2;
-		s->pcm_channels = pcm_channels * 2;
-	} else {
-		s->pcm_channels = pcm_channels;
-	}
+	s->pcm_channels = pcm_channels;
 	s->sfc = sfc;
 	s->data_block_quadlets = s->pcm_channels + midi_channels;
 	s->midi_ports = midi_ports;
@@ -191,18 +184,9 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 static void amdtp_write_s32(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames);
-static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
-				     struct snd_pcm_substream *pcm,
-				     __be32 *buffer, unsigned int frames);
-static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
-				     struct snd_pcm_substream *pcm,
-				     __be32 *buffer, unsigned int frames);
 static void amdtp_read_s32(struct amdtp_stream *s,
 			   struct snd_pcm_substream *pcm,
 			   __be32 *buffer, unsigned int frames);
-static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
-				    struct snd_pcm_substream *pcm,
-				    __be32 *buffer, unsigned int frames);
 
 /**
  * amdtp_stream_set_pcm_format - set the PCM format
@@ -225,26 +209,16 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
 		if (s->direction == AMDTP_OUT_STREAM) {
-			if (s->dual_wire)
-				s->transfer_samples = amdtp_write_s16_dualwire;
-			else
-				s->transfer_samples = amdtp_write_s16;
+			s->transfer_samples = amdtp_write_s16;
 			break;
 		}
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S32:
-		if (s->direction == AMDTP_OUT_STREAM) {
-			if (s->dual_wire)
-				s->transfer_samples = amdtp_write_s32_dualwire;
-			else
-				s->transfer_samples = amdtp_write_s32;
-		} else {
-			if (s->dual_wire)
-				s->transfer_samples = amdtp_read_s32_dualwire;
-			else
-				s->transfer_samples = amdtp_read_s32;
-		}
+		if (s->direction == AMDTP_OUT_STREAM)
+			s->transfer_samples = amdtp_write_s32;
+		else
+			s->transfer_samples = amdtp_read_s32;
 		break;
 	}
 }
@@ -393,68 +367,6 @@ static void amdtp_write_s16(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_write_s32_dualwire(struct amdtp_stream *s,
-				     struct snd_pcm_substream *pcm,
-				     __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u32 *src;
-
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	channels = s->pcm_channels / 2;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c] * 2] =
-					cpu_to_be32((*src >> 8) | 0x40000000);
-			src++;
-		}
-		buffer += 1;
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c] * 2] =
-					cpu_to_be32((*src >> 8) | 0x40000000);
-			src++;
-		}
-		buffer += s->data_block_quadlets - 1;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
-static void amdtp_write_s16_dualwire(struct amdtp_stream *s,
-				     struct snd_pcm_substream *pcm,
-				     __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u16 *src;
-
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	channels = s->pcm_channels / 2;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c] * 2] =
-					cpu_to_be32((*src << 8) | 0x40000000);
-			src++;
-		}
-		buffer += 1;
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c] * 2] =
-					cpu_to_be32((*src << 8) | 0x40000000);
-			src++;
-		}
-		buffer += s->data_block_quadlets - 1;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
 static void amdtp_read_s32(struct amdtp_stream *s,
 			   struct snd_pcm_substream *pcm,
 			   __be32 *buffer, unsigned int frames)
@@ -479,37 +391,6 @@ static void amdtp_read_s32(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_read_s32_dualwire(struct amdtp_stream *s,
-				    struct snd_pcm_substream *pcm,
-				    __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	u32 *dst;
-
-	dst = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	channels = s->pcm_channels / 2;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*dst =
-			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
-			dst++;
-		}
-		buffer += 1;
-		for (c = 0; c < channels; ++c) {
-			*dst =
-			     be32_to_cpu(buffer[s->pcm_positions[c] * 2]) << 8;
-			dst++;
-		}
-		buffer += s->data_block_quadlets - 1;
-		if (--remaining_frames == 0)
-			dst = (void *)runtime->dma_area;
-	}
-}
-
 static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 				   __be32 *buffer, unsigned int frames)
 {
@@ -522,21 +403,6 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 	}
 }
 
-static void amdtp_fill_pcm_silence_dualwire(struct amdtp_stream *s,
-					   __be32 *buffer, unsigned int frames)
-{
-	unsigned int i, c, channels;
-
-	channels = s->pcm_channels / 2;
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[s->pcm_positions[c] * 2] =
-			buffer[s->pcm_positions[c] * 2 + 1] =
-						cpu_to_be32(0x40000000);
-		}
-		buffer += s->data_block_quadlets;
-	}
-}
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
@@ -582,9 +448,6 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 				unsigned int frames)
 {	unsigned int ptr;
 
-	if (s->dual_wire)
-		frames *= 2;
-
 	ptr = s->pcm_buffer_pointer + frames;
 	if (ptr >= pcm->runtime->buffer_size)
 		ptr -= pcm->runtime->buffer_size;
@@ -674,8 +537,6 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm)
 		s->transfer_samples(s, pcm, buffer, data_blocks);
-	else if (s->dual_wire)
-		amdtp_fill_pcm_silence_dualwire(s, buffer, data_blocks);
 	else
 		amdtp_fill_pcm_silence(s, buffer, data_blocks);
 	if (s->midi_ports)
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index e8d62ac..db60425 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -16,18 +16,13 @@
  * @CIP_BLOCKING: In blocking mode, each packet contains either zero or
  *	SYT_INTERVAL samples, with these two types alternating so that
  *	the overall sample rate comes out right.
- * @CIP_HI_DUALWIRE: At rates above 96 kHz, pretend that the stream runs
- *	at half the actual sample rate with twice the number of channels;
- *	two samples of a channel are stored consecutively in the packet.
- *	Requires blocking mode and SYT_INTERVAL-aligned PCM buffer size.
  * @CIP_SYNC_TO_DEVICE: In sync to device mode, time stamp in out packets is
  *	generated by in packets. Defaultly this driver generates timestamp.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
 	CIP_BLOCKING		= 0x01,
-	CIP_HI_DUALWIRE		= 0x02,
-	CIP_SYNC_TO_DEVICE	= 0x04,
+	CIP_SYNC_TO_DEVICE	= 0x02,
 };
 
 /**
@@ -84,7 +79,6 @@ struct amdtp_stream {
 	struct mutex mutex;
 
 	enum cip_sfc sfc;
-	bool dual_wire;
 	unsigned int data_block_quadlets;
 	unsigned int pcm_channels;
 	unsigned int midi_ports;
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 26b2158..cd4c6b6 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -563,7 +563,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
 	struct dice *dice = substream->private_data;
-	unsigned int rate_index, mode;
+	unsigned int rate_index, mode, rate, channels, i;
 	int err;
 
 	mutex_lock(&dice->mutex);
@@ -575,15 +575,36 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
-	rate_index = rate_to_index(params_rate(hw_params));
+	rate = params_rate(hw_params);
+	rate_index = rate_to_index(rate);
 	err = dice_change_rate(dice, rate_index << CLOCK_RATE_SHIFT);
 	if (err < 0)
 		return err;
 
+	/*
+	 * At rates above 96 kHz, pretend that the stream runs at half the
+	 * actual sample rate with twice the number of channels; two samples
+	 * of a channel are stored consecutively in the packet. Requires
+	 * blocking mode and PCM buffer size should be aligned to SYT_INTERVAL.
+	 */
+	channels = params_channels(hw_params);
+	if (rate_index > 4) {
+		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
+			err = -ENOSYS;
+			return err;
+		}
+
+		for (i = 0; i < channels; i++) {
+			dice->stream.pcm_positions[i * 2] = i;
+			dice->stream.pcm_positions[i * 2 + 1] = i + channels;
+		}
+
+		rate /= 2;
+		channels *= 2;
+	}
+
 	mode = rate_index_to_mode(rate_index);
-	amdtp_stream_set_parameters(&dice->stream,
-				    params_rate(hw_params),
-				    params_channels(hw_params),
+	amdtp_stream_set_parameters(&dice->stream, rate, channels,
 				    dice->rx_midi_ports[mode]);
 	amdtp_stream_set_pcm_format(&dice->stream,
 				    params_format(hw_params));
@@ -1361,7 +1382,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;
 
 	err = amdtp_stream_init(&dice->stream, unit, AMDTP_OUT_STREAM,
-				CIP_BLOCKING | CIP_HI_DUALWIRE);
+				CIP_BLOCKING);
 	if (err < 0)
 		goto err_resources;
 
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
