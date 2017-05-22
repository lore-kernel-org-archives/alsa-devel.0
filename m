From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire: remove support for 16 bit PCM
	samples in playback substream
Date: Mon, 22 May 2017 22:22:21 +0900
Message-ID: <20170522132221.16733-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id AFFCF266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 15:22:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, ffado-devel@lists.sf.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, AM824 is described as format of data block. In this
format, one data block consists of several data channels, which is aligned
to 32 bit. One data channel has 8 bit label field and 24 bit data field.
PCM frames are transferred in Multi Bit Linear Audio (MBLA) data channel.
This channel can include 16/20/24 bit PCM sample.

As long as I know, models which support IEC 61883-1/6 doesn't allow to
switch bit length of PCM sample in MBLA data channel. They always
transmit/receive PCM frames of 24 bit length. This can be seen for the
other models which support protocols similar to IEC 61883-1/6.

On the other hand, current drivers for these protocols supports 16 bit
length PCM sample in playback substream. In this case, PCM sample is put
into the MBLA data channel with 8 bit padding in LSB side. Although 16
bit PCM sample is major because it's in CD format, this doesn't represent
device capability as is.

This commit removes support for 16 bit PCM samples in playback substream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c             | 71 +-------------------------------
 sound/firewire/amdtp-am824.h             |  6 +--
 sound/firewire/bebob/bebob_pcm.c         |  4 --
 sound/firewire/dice/dice-pcm.c           |  6 ---
 sound/firewire/digi00x/amdtp-dot.c       | 63 +---------------------------
 sound/firewire/digi00x/digi00x-pcm.c     |  7 +---
 sound/firewire/digi00x/digi00x.h         |  1 -
 sound/firewire/fireworks/fireworks_pcm.c |  4 --
 sound/firewire/oxfw/oxfw-pcm.c           |  4 --
 sound/firewire/tascam/amdtp-tascam.c     | 62 +---------------------------
 sound/firewire/tascam/tascam-pcm.c       |  7 +---
 sound/firewire/tascam/tascam.h           |  1 -
 12 files changed, 9 insertions(+), 227 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index bebddc60fde8..23ccddb20de1 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -38,10 +38,6 @@ struct amdtp_am824 {
 	u8 pcm_positions[AM824_MAX_CHANNELS_FOR_PCM];
 	u8 midi_position;
 
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
-
 	unsigned int frame_multiplier;
 };
 
@@ -177,32 +173,6 @@ static void write_pcm_s32(struct amdtp_stream *s,
 	}
 }
 
-static void write_pcm_s16(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
-{
-	struct amdtp_am824 *p = s->protocol;
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u16 *src;
-
-	channels = p->pcm_channels;
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[p->pcm_positions[c]] =
-					cpu_to_be32((*src << 8) | 0x42000000);
-			src++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
 static void read_pcm_s32(struct amdtp_stream *s,
 			 struct snd_pcm_substream *pcm,
 			 __be32 *buffer, unsigned int frames)
@@ -242,43 +212,6 @@ static void write_pcm_silence(struct amdtp_stream *s,
 }
 
 /**
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
-	struct amdtp_am824 *p = s->protocol;
-
-	if (WARN_ON(amdtp_stream_pcm_running(s)))
-		return;
-
-	switch (format) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S16:
-		if (s->direction == AMDTP_OUT_STREAM) {
-			p->transfer_samples = write_pcm_s16;
-			break;
-		}
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S32:
-		if (s->direction == AMDTP_OUT_STREAM)
-			p->transfer_samples = write_pcm_s32;
-		else
-			p->transfer_samples = read_pcm_s32;
-		break;
-	}
-}
-EXPORT_SYMBOL_GPL(amdtp_am824_set_pcm_format);
-
-/**
  * amdtp_am824_add_pcm_hw_constraints - add hw constraints for PCM substream
  * @s:		the AMDTP stream for AM824 data block, must be initialized.
  * @runtime:	the PCM substream runtime
@@ -407,7 +340,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffe
 	unsigned int pcm_frames;
 
 	if (pcm) {
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		write_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks * p->frame_multiplier;
 	} else {
 		write_pcm_silence(s, buffer, data_blocks);
@@ -428,7 +361,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffe
 	unsigned int pcm_frames;
 
 	if (pcm) {
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		read_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks * p->frame_multiplier;
 	} else {
 		pcm_frames = 0;
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
index 73b07b3109db..b56e61fc997d 100644
--- a/sound/firewire/amdtp-am824.h
+++ b/sound/firewire/amdtp-am824.h
@@ -8,8 +8,7 @@
 
 #define AM824_IN_PCM_FORMAT_BITS	SNDRV_PCM_FMTBIT_S32
 
-#define AM824_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
-					 SNDRV_PCM_FMTBIT_S32)
+#define AM824_OUT_PCM_FORMAT_BITS	SNDRV_PCM_FMTBIT_S32
 
 /*
  * This module supports maximum 64 PCM channels for one PCM stream
@@ -41,9 +40,6 @@ void amdtp_am824_set_midi_position(struct amdtp_stream *s,
 int amdtp_am824_add_pcm_hw_constraints(struct amdtp_stream *s,
 				       struct snd_pcm_runtime *runtime);
 
-void amdtp_am824_set_pcm_format(struct amdtp_stream *s,
-				snd_pcm_format_t format);
-
 void amdtp_am824_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			      struct snd_rawmidi_substream *midi);
 
diff --git a/sound/firewire/bebob/bebob_pcm.c b/sound/firewire/bebob/bebob_pcm.c
index 9e27eb8e1dd4..e2f023f3cd9f 100644
--- a/sound/firewire/bebob/bebob_pcm.c
+++ b/sound/firewire/bebob/bebob_pcm.c
@@ -224,8 +224,6 @@ pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&bebob->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&bebob->tx_stream, params_format(hw_params));
-
 	return 0;
 }
 static int
@@ -246,8 +244,6 @@ pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&bebob->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&bebob->rx_stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 6074fe1f00f7..b633805a885f 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -146,7 +146,6 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->tx_stream[substream->pcm->device];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -160,15 +159,12 @@ static int capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(stream, params_format(hw_params));
-
 	return 0;
 }
 static int playback_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	struct amdtp_stream *stream = &dice->rx_stream[substream->pcm->device];
 	int err;
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -182,8 +178,6 @@ static int playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dice->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index a4688545339c..1453c34ce99f 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -48,10 +48,6 @@ struct amdtp_dot {
 	struct snd_rawmidi_substream *midi[MAX_MIDI_PORTS];
 	int midi_fifo_used[MAX_MIDI_PORTS];
 	int midi_fifo_limit;
-
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
 };
 
 /*
@@ -173,32 +169,6 @@ static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
 	}
 }
 
-static void write_pcm_s16(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
-{
-	struct amdtp_dot *p = s->protocol;
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u16 *src;
-
-	channels = p->pcm_channels;
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	buffer++;
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[c] = cpu_to_be32((*src << 8) | 0x40000000);
-			dot_encode_step(&p->state, &buffer[c]);
-			src++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
 static void read_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
 			 __be32 *buffer, unsigned int frames)
 {
@@ -351,33 +321,6 @@ int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
 	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
 }
 
-void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
-{
-	struct amdtp_dot *p = s->protocol;
-
-	if (WARN_ON(amdtp_stream_pcm_running(s)))
-		return;
-
-	switch (format) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S16:
-		if (s->direction == AMDTP_OUT_STREAM) {
-			p->transfer_samples = write_pcm_s16;
-			break;
-		}
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S32:
-		if (s->direction == AMDTP_OUT_STREAM)
-			p->transfer_samples = write_pcm_s32;
-		else
-			p->transfer_samples = read_pcm_s32;
-		break;
-	}
-}
-
 void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			  struct snd_rawmidi_substream *midi)
 {
@@ -392,13 +335,12 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm) {
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		read_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks;
 	} else {
 		pcm_frames = 0;
@@ -414,13 +356,12 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct amdtp_dot *p = (struct amdtp_dot *)s->protocol;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm) {
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		write_pcm_s32(s, pcm, buffer, data_blocks);
 		pcm_frames = data_blocks;
 	} else {
 		write_pcm_silence(s, buffer, data_blocks);
diff --git a/sound/firewire/digi00x/digi00x-pcm.c b/sound/firewire/digi00x/digi00x-pcm.c
index 68d1c52db051..6379f67416d7 100644
--- a/sound/firewire/digi00x/digi00x-pcm.c
+++ b/sound/firewire/digi00x/digi00x-pcm.c
@@ -88,8 +88,7 @@ static int pcm_init_hw_params(struct snd_dg00x *dg00x,
 		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
 		s = &dg00x->tx_stream;
 	} else {
-		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16 |
-						 SNDRV_PCM_FMTBIT_S32;
+		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
 		s = &dg00x->rx_stream;
 	}
 
@@ -184,8 +183,6 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dg00x->mutex);
 	}
 
-	amdtp_dot_set_pcm_format(&dg00x->tx_stream, params_format(hw_params));
-
 	return 0;
 }
 
@@ -206,8 +203,6 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&dg00x->mutex);
 	}
 
-	amdtp_dot_set_pcm_format(&dg00x->rx_stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index 1275a50956c0..4dd1bbf2ed3c 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -121,7 +121,6 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
 void amdtp_dot_reset(struct amdtp_stream *s);
 int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
 				     struct snd_pcm_runtime *runtime);
-void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
 void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 			  struct snd_rawmidi_substream *midi);
 
diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
index 9171702f7d0b..f10aec117998 100644
--- a/sound/firewire/fireworks/fireworks_pcm.c
+++ b/sound/firewire/fireworks/fireworks_pcm.c
@@ -257,8 +257,6 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&efw->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&efw->tx_stream, params_format(hw_params));
-
 	return 0;
 }
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
@@ -278,8 +276,6 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&efw->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&efw->rx_stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/oxfw/oxfw-pcm.c b/sound/firewire/oxfw/oxfw-pcm.c
index f3530f89a025..d4594f7115ae 100644
--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -244,8 +244,6 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&oxfw->tx_stream, params_format(hw_params));
-
 	return 0;
 }
 static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
@@ -265,8 +263,6 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	amdtp_am824_set_pcm_format(&oxfw->rx_stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index 9dd0fccd5ccc..6aff1fc1c72d 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -14,10 +14,6 @@
 
 struct amdtp_tscm {
 	unsigned int pcm_channels;
-
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
 };
 
 int amdtp_tscm_set_parameters(struct amdtp_stream *s, unsigned int rate)
@@ -62,31 +58,6 @@ static void write_pcm_s32(struct amdtp_stream *s,
 	}
 }
 
-static void write_pcm_s16(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
-{
-	struct amdtp_tscm *p = s->protocol;
-	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
-	const u16 *src;
-
-	channels = p->pcm_channels;
-	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
-
-	for (i = 0; i < frames; ++i) {
-		for (c = 0; c < channels; ++c) {
-			buffer[c] = cpu_to_be32(*src << 16);
-			src++;
-		}
-		buffer += s->data_block_quadlets;
-		if (--remaining_frames == 0)
-			src = (void *)runtime->dma_area;
-	}
-}
-
 static void read_pcm_s32(struct amdtp_stream *s,
 			 struct snd_pcm_substream *pcm,
 			 __be32 *buffer, unsigned int frames)
@@ -146,44 +117,16 @@ int amdtp_tscm_add_pcm_hw_constraints(struct amdtp_stream *s,
 	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
 }
 
-void amdtp_tscm_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
-{
-	struct amdtp_tscm *p = s->protocol;
-
-	if (WARN_ON(amdtp_stream_pcm_running(s)))
-		return;
-
-	switch (format) {
-	default:
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S16:
-		if (s->direction == AMDTP_OUT_STREAM) {
-			p->transfer_samples = write_pcm_s16;
-			break;
-		}
-		WARN_ON(1);
-		/* fall through */
-	case SNDRV_PCM_FORMAT_S32:
-		if (s->direction == AMDTP_OUT_STREAM)
-			p->transfer_samples = write_pcm_s32;
-		else
-			p->transfer_samples = read_pcm_s32;
-		break;
-	}
-}
-
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
 	struct snd_pcm_substream *pcm;
 
 	pcm = ACCESS_ONCE(s->pcm);
 	if (data_blocks > 0 && pcm)
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		read_pcm_s32(s, pcm, buffer, data_blocks);
 
 	/* A place holder for control messages. */
 
@@ -195,7 +138,6 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   unsigned int data_blocks,
 					   unsigned int *syt)
 {
-	struct amdtp_tscm *p = (struct amdtp_tscm *)s->protocol;
 	struct snd_pcm_substream *pcm;
 
 	/* This field is not used. */
@@ -203,7 +145,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm)
-		p->transfer_samples(s, pcm, buffer, data_blocks);
+		write_pcm_s32(s, pcm, buffer, data_blocks);
 	else
 		write_pcm_silence(s, buffer, data_blocks);
 
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
index f5dd6ce6b6f1..6207588d7c73 100644
--- a/sound/firewire/tascam/tascam-pcm.c
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -48,8 +48,7 @@ static int pcm_init_hw_params(struct snd_tscm *tscm,
 		stream = &tscm->tx_stream;
 		pcm_channels = tscm->spec->pcm_capture_analog_channels;
 	} else {
-		runtime->hw.formats =
-				SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S32;
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
 		stream = &tscm->rx_stream;
 		pcm_channels = tscm->spec->pcm_playback_analog_channels;
 	}
@@ -125,8 +124,6 @@ static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&tscm->mutex);
 	}
 
-	amdtp_tscm_set_pcm_format(&tscm->tx_stream, params_format(hw_params));
-
 	return 0;
 }
 
@@ -147,8 +144,6 @@ static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
 		mutex_unlock(&tscm->mutex);
 	}
 
-	amdtp_tscm_set_pcm_format(&tscm->rx_stream, params_format(hw_params));
-
 	return 0;
 }
 
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 08ecfae5c584..a5bd167eb5d9 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -131,7 +131,6 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 int amdtp_tscm_set_parameters(struct amdtp_stream *s, unsigned int rate);
 int amdtp_tscm_add_pcm_hw_constraints(struct amdtp_stream *s,
 				      struct snd_pcm_runtime *runtime);
-void amdtp_tscm_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
 
 int snd_tscm_stream_get_rate(struct snd_tscm *tscm, unsigned int *rate);
 int snd_tscm_stream_get_clock(struct snd_tscm *tscm,
-- 
2.11.0
