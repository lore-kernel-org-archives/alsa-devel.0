From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] firewire-lib: remove unused members and functions
Date: Wed, 17 Jul 2013 20:50:47 +0900
Message-ID: <1374061848-5851-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: sakamocchi <o-takashi@sakamocchi.jp>

With my previous two patches, some member of amdtp_out_stream structure and
some related functions are obsoleted.

I note that amdtp_out structure losts pcm_channels and midi_ports then each
driver must keep the number of channels in itself.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 amdtp.c |  109 ---------------------------------------------------------------
 amdtp.h |   38 ----------------------
 2 files changed, 147 deletions(-)

diff --git a/amdtp.c b/amdtp.c
index e3e055d..1e0e84c 100644
--- a/amdtp.c
+++ b/amdtp.c
@@ -129,41 +129,6 @@ unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 }
 EXPORT_SYMBOL(amdtp_out_stream_get_max_payload);
 
-static void amdtp_write_s16(struct amdtp_out_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames);
-static void amdtp_write_s32(struct amdtp_out_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames);
-
-/**
- * amdtp_out_stream_set_pcm_format - set the PCM format
- * @s: the AMDTP output stream to configure
- * @format: the format of the ALSA PCM device
- *
- * The sample format must be set before the stream is started, and must not be
- * changed while the stream is running.
- */
-void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
-				     snd_pcm_format_t format)
-{
-	if (WARN_ON(!IS_ERR(s->context)))
-		return;
-
-	switch (format) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S16:
-		s->transfer_samples = amdtp_write_s16;
-		break;
-	case SNDRV_PCM_FORMAT_S32:
-		s->transfer_samples = amdtp_write_s32;
-		break;
-	}
-}
-EXPORT_SYMBOL(amdtp_out_stream_set_pcm_format);
-
 /**
  * amdtp_out_stream_pcm_prepare - prepare PCM device for running
  * @s: the AMDTP output stream
@@ -255,80 +220,6 @@ static unsigned int calculate_syt(struct amdtp_out_stream *s,
 	}
 }
 
-static void amdtp_write_s32(struct amdtp_out_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, frame_step, i, c;
-	const u32 *src;
-
-	channels = s->pcm_channels;
-	src = (void *)runtime->dma_area +
-			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	frame_step = s->data_block_quadlets - channels;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
-			src++;
-			buffer++;
-		}
-		buffer += frame_step;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
-static void amdtp_write_s16(struct amdtp_out_stream *s,
-			    struct snd_pcm_substream *pcm,
-			    __be32 *buffer, unsigned int frames)
-{
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, frame_step, i, c;
-	const u16 *src;
-
-	channels = s->pcm_channels;
-	src = (void *)runtime->dma_area +
-			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-	frame_step = s->data_block_quadlets - channels;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
-			src++;
-			buffer++;
-		}
-		buffer += frame_step;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
-static void amdtp_fill_pcm_silence(struct amdtp_out_stream *s,
-				   __be32 *buffer, unsigned int frames)
-{
-	unsigned int i, c;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < s->pcm_channels; ++c)
-			buffer[c] = cpu_to_be32(0x40000000);
-		buffer += s->data_block_quadlets;
-	}
-}
-
-static void amdtp_fill_midi(struct amdtp_out_stream *s,
-			    __be32 *buffer, unsigned int frames)
-{
-	unsigned int i;
-
-	for (i = 0; i < frames; ++i)
-		buffer[s->pcm_channels + i * s->data_block_quadlets] =
-						cpu_to_be32(0x80000000);
-}
-
 static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
diff --git a/amdtp.h b/amdtp.h
index 8172ce9..b8b5281 100644
--- a/amdtp.h
+++ b/amdtp.h
@@ -29,9 +29,6 @@ enum cip_sfc {
 	CIP_SFC_192000 = 6,
 };
 
-#define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
-					 SNDRV_PCM_FMTBIT_S32)
-
 struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
@@ -52,12 +49,6 @@ struct amdtp_out_stream {
 	unsigned int data_block_quadlets;
 	amdtp_payload_cb_t payload_cb;
 
-	unsigned int pcm_channels;
-	unsigned int midi_ports;
-	void (*transfer_samples)(struct amdtp_out_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
-
 	unsigned int syt_interval;
 	unsigned int source_node_id_field;
 	struct iso_packets_buffer buffer;
@@ -90,8 +81,6 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed,
 void amdtp_out_stream_update(struct amdtp_out_stream *s);
 void amdtp_out_stream_stop(struct amdtp_out_stream *s);
 
-void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
-				     snd_pcm_format_t format);
 void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s);
 unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
 void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);
@@ -111,33 +100,6 @@ amdtp_out_stream_set_data_block_quadlets(struct amdtp_out_stream *s,
 }
 
 /**
- * amdtp_out_stream_set_pcm - configure format of PCM samples
- * @s: the AMDTP output stream to be configured
- * @pcm_channels: the number of PCM samples in each data block, to be encoded
- *                as AM824 multi-bit linear audio
- *
- * This function must not be called while the stream is running.
- */
-static inline void amdtp_out_stream_set_pcm(struct amdtp_out_stream *s,
-					    unsigned int pcm_channels)
-{
-	s->pcm_channels = pcm_channels;
-}
-
-/**
- * amdtp_out_stream_set_midi - configure format of MIDI data
- * @s: the AMDTP output stream to be configured
- * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
- *
- * This function must not be called while the stream is running.
- */
-static inline void amdtp_out_stream_set_midi(struct amdtp_out_stream *s,
-					     unsigned int midi_ports)
-{
-	s->midi_ports = midi_ports;
-}
-
-/**
  * amdtp_out_streaming_error - check for streaming error
  * @s: the AMDTP output stream
  *
-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
