From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [12/29] ALSA: dice: support dual-wire stream format at 192 kHz
Date: Mon, 21 Oct 2013 21:27:28 +0200
Message-ID: <52658020.1030306@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Change the AMDTP streaming code to handle the non-standard stream format
that DICE devices use at sample rates greater than 96 kHz.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/amdtp.c    |  155 +++++++++++++++++++++++++++++++++++++--------
 sound/firewire/amdtp.h    |   41 ++++--------
 sound/firewire/dice.c     |   29 ++++++--
 sound/firewire/speakers.c |    6 +-
 4 files changed, 164 insertions(+), 67 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d56b8e7..a09c3b3 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -65,42 +65,66 @@ void amdtp_out_stream_destroy(struct amdtp_out_stream *s)
 }
 EXPORT_SYMBOL(amdtp_out_stream_destroy);

+unsigned int amdtp_syt_intervals[CIP_SFC_COUNT] = {
+	[CIP_SFC_32000]  =  8,
+	[CIP_SFC_44100]  =  8,
+	[CIP_SFC_48000]  =  8,
+	[CIP_SFC_88200]  = 16,
+	[CIP_SFC_96000]  = 16,
+	[CIP_SFC_176400] = 32,
+	[CIP_SFC_192000] = 32,
+};
+EXPORT_SYMBOL(amdtp_syt_intervals);
+
 /**
- * amdtp_out_stream_set_rate - set the sample rate
+ * amdtp_out_stream_set_parameters - set stream parameters
  * @s: the AMDTP output stream to configure
  * @rate: the sample rate
+ * @pcm_channels: the number of PCM samples in each data block, to be encoded
+ *                as AM824 multi-bit linear audio
+ * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
  *
- * The sample rate must be set before the stream is started, and must not be
+ * The parameters must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate)
+void amdtp_out_stream_set_parameters(struct amdtp_out_stream *s,
+				     unsigned int rate,
+				     unsigned int pcm_channels,
+				     unsigned int midi_ports)
 {
-	static const struct {
-		unsigned int rate;
-		unsigned int syt_interval;
-	} rate_info[] = {
-		[CIP_SFC_32000]  = {  32000,  8, },
-		[CIP_SFC_44100]  = {  44100,  8, },
-		[CIP_SFC_48000]  = {  48000,  8, },
-		[CIP_SFC_88200]  = {  88200, 16, },
-		[CIP_SFC_96000]  = {  96000, 16, },
-		[CIP_SFC_176400] = { 176400, 32, },
-		[CIP_SFC_192000] = { 192000, 32, },
+	static const unsigned int rates[] = {
+		[CIP_SFC_32000]  =  32000,
+		[CIP_SFC_44100]  =  44100,
+		[CIP_SFC_48000]  =  48000,
+		[CIP_SFC_88200]  =  88200,
+		[CIP_SFC_96000]  =  96000,
+		[CIP_SFC_176400] = 176400,
+		[CIP_SFC_192000] = 192000,
 	};
 	unsigned int sfc;

 	if (WARN_ON(amdtp_out_stream_running(s)))
 		return;

-	for (sfc = 0; sfc < ARRAY_SIZE(rate_info); ++sfc)
-		if (rate_info[sfc].rate == rate)
+	for (sfc = 0; sfc < CIP_SFC_COUNT; ++sfc)
+		if (rates[sfc] == rate)
 			goto sfc_found;
 	WARN_ON(1);
 	return;

 sfc_found:
+	s->dual_wire = (s->flags & CIP_HI_DUALWIRE) && sfc > CIP_SFC_96000;
+	if (s->dual_wire) {
+		sfc -= 2;
+		rate /= 2;
+		pcm_channels *= 2;
+	}
 	s->sfc = sfc;
-	s->syt_interval = rate_info[sfc].syt_interval;
+	s->data_block_quadlets = pcm_channels + DIV_ROUND_UP(midi_ports, 8);
+	s->pcm_channels = pcm_channels;
+	s->midi_ports = midi_ports;
+
+	s->syt_interval = amdtp_syt_intervals[sfc];

 	/* default buffering in the device */
 	s->transfer_delay = TRANSFER_DELAY_TICKS - TICKS_PER_CYCLE;
@@ -108,21 +132,17 @@ sfc_found:
 		/* additional buffering needed to adjust for no-data packets */
 		s->transfer_delay += TICKS_PER_SECOND * s->syt_interval / rate;
 }
-EXPORT_SYMBOL(amdtp_out_stream_set_rate);
+EXPORT_SYMBOL(amdtp_out_stream_set_parameters);

 /**
  * amdtp_out_stream_get_max_payload - get the stream's packet size
  * @s: the AMDTP output stream
  *
  * This function must not be called before the stream has been configured
- * with amdtp_out_stream_set_rate(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi().
+ * with amdtp_out_stream_set_parameters().
  */
 unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 {
-	s->data_block_quadlets = s->pcm_channels;
-	s->data_block_quadlets += DIV_ROUND_UP(s->midi_ports, 8);
-
 	return 8 + s->syt_interval * s->data_block_quadlets * 4;
 }
 EXPORT_SYMBOL(amdtp_out_stream_get_max_payload);
@@ -133,14 +153,21 @@ static void amdtp_write_s16(struct amdtp_out_stream *s,
 static void amdtp_write_s32(struct amdtp_out_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames);
+static void amdtp_write_s16_dualwire(struct amdtp_out_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames);
+static void amdtp_write_s32_dualwire(struct amdtp_out_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames);

 /**
  * amdtp_out_stream_set_pcm_format - set the PCM format
  * @s: the AMDTP output stream to configure
  * @format: the format of the ALSA PCM device
  *
- * The sample format must be set before the stream is started, and must not be
- * changed while the stream is running.
+ * The sample format must be set after the other paramters (rate/PCM channels/
+ * MIDI) and before the stream is started, and must not be changed while the
+ * stream is running.
  */
 void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
 				     snd_pcm_format_t format)
@@ -153,10 +180,16 @@ void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
 		WARN_ON(1);
 		/* fall through */
 	case SNDRV_PCM_FORMAT_S16:
-		s->transfer_samples = amdtp_write_s16;
+		if (s->dual_wire)
+			s->transfer_samples = amdtp_write_s16_dualwire;
+		else
+			s->transfer_samples = amdtp_write_s16;
 		break;
 	case SNDRV_PCM_FORMAT_S32:
-		s->transfer_samples = amdtp_write_s32;
+		if (s->dual_wire)
+			s->transfer_samples = amdtp_write_s32_dualwire;
+		else
+			s->transfer_samples = amdtp_write_s32;
 		break;
 	}
 }
@@ -305,6 +338,68 @@ static void amdtp_write_s16(struct amdtp_out_stream *s,
 	}
 }

+static void amdtp_write_s32_dualwire(struct amdtp_out_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, frame_adjust_1, frame_adjust_2, i, c;
+	const u32 *src;
+
+	channels = s->pcm_channels;
+	src = (void *)runtime->dma_area +
+			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
+	frame_adjust_1 = channels - 1;
+	frame_adjust_2 = 1 - (s->data_block_quadlets - channels);
+
+	channels /= 2;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
+			src++;
+			buffer += 2;
+		}
+		buffer -= frame_adjust_1;
+		for (c = 0; c < channels; ++c) {
+			*buffer = cpu_to_be32((*src >> 8) | 0x40000000);
+			src++;
+			buffer += 2;
+		}
+		buffer -= frame_adjust_2;
+	}
+}
+
+static void amdtp_write_s16_dualwire(struct amdtp_out_stream *s,
+				     struct snd_pcm_substream *pcm,
+				     __be32 *buffer, unsigned int frames)
+{
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int channels, frame_adjust_1, frame_adjust_2, i, c;
+	const u16 *src;
+
+	channels = s->pcm_channels;
+	src = (void *)runtime->dma_area +
+			s->pcm_buffer_pointer * (runtime->frame_bits / 8);
+	frame_adjust_1 = channels - 1;
+	frame_adjust_2 = 1 - (s->data_block_quadlets - channels);
+
+	channels /= 2;
+	for (i = 0; i < frames; ++i) {
+		for (c = 0; c < channels; ++c) {
+			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
+			src++;
+			buffer += 2;
+		}
+		buffer -= frame_adjust_1;
+		for (c = 0; c < channels; ++c) {
+			*buffer = cpu_to_be32((*src << 8) | 0x40000000);
+			src++;
+			buffer += 2;
+		}
+		buffer -= frame_adjust_2;
+	}
+}
+
 static void amdtp_fill_pcm_silence(struct amdtp_out_stream *s,
 				   __be32 *buffer, unsigned int frames)
 {
@@ -390,6 +485,9 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 	s->packet_index = index;

 	if (pcm) {
+		if (s->dual_wire)
+			data_blocks *= 2;
+
 		ptr = s->pcm_buffer_pointer + data_blocks;
 		if (ptr >= pcm->runtime->buffer_size)
 			ptr -= pcm->runtime->buffer_size;
@@ -459,8 +557,7 @@ static int queue_initial_skip_packets(struct amdtp_out_stream *s)
  * @speed: firewire speed code
  *
  * The stream cannot be started until it has been configured with
- * amdtp_out_stream_set_rate(), amdtp_out_stream_set_pcm(),
- * amdtp_out_stream_set_midi(), and amdtp_out_stream_set_format();
+ * amdtp_out_stream_set_parameters() and amdtp_out_stream_set_pcm_format(),
  * and it must be started before any PCM or MIDI device can be started.
  */
 int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 28b1bf5..f3d03dd 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -15,10 +15,15 @@
  * @CIP_BLOCKING: In blocking mode, each packet contains either zero or
  *	SYT_INTERVAL samples, with these two types alternating so that
  *	the overall sample rate comes out right.
+ * @CIP_HI_DUALWIRE: At rates above 96 kHz, pretend that the stream runs
+ *	at half the actual sample rate with twice the number of channels;
+ *	two samples of a channel are stored consecutively in the packet.
+ *	Requires blocking mode and SYT_INTERVAL-aligned PCM buffer size.
  */
 enum cip_out_flags {
 	CIP_NONBLOCKING	= 0x00,
 	CIP_BLOCKING	= 0x01,
+	CIP_HI_DUALWIRE	= 0x02,
 };

 /**
@@ -32,6 +37,7 @@ enum cip_sfc {
 	CIP_SFC_96000  = 4,
 	CIP_SFC_176400 = 5,
 	CIP_SFC_192000 = 6,
+	CIP_SFC_COUNT
 };

 #define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
@@ -48,6 +54,7 @@ struct amdtp_out_stream {
 	struct mutex mutex;

 	enum cip_sfc sfc;
+	bool dual_wire;
 	unsigned int data_block_quadlets;
 	unsigned int pcm_channels;
 	unsigned int midi_ports;
@@ -80,7 +87,10 @@ int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
 			  enum cip_out_flags flags);
 void amdtp_out_stream_destroy(struct amdtp_out_stream *s);

-void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate);
+void amdtp_out_stream_set_parameters(struct amdtp_out_stream *s,
+				     unsigned int rate,
+				     unsigned int pcm_channels,
+				     unsigned int midi_ports);
 unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s);

 int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed);
@@ -93,39 +103,14 @@ void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s);
 unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
 void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);

+extern unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
+
 static inline bool amdtp_out_stream_running(struct amdtp_out_stream *s)
 {
 	return !IS_ERR(s->context);
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
diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index b4827ff..8804e42 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -375,7 +375,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 	struct dice *dice = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	__be32 clock_sel, number_audio, number_midi;
-	unsigned int rate;
+	unsigned int rate_index, rate;
 	int err;

 	err = dice_try_lock(dice);
@@ -387,12 +387,13 @@ static int dice_open(struct snd_pcm_substream *substream)
 				 &clock_sel, 4);
 	if (err < 0)
 		goto err_lock;
-	rate = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
-	if (rate >= ARRAY_SIZE(dice_rates)) {
+	rate_index = (be32_to_cpu(clock_sel) & CLOCK_RATE_MASK)
+							>> CLOCK_RATE_SHIFT;
+	if (rate_index >= ARRAY_SIZE(dice_rates)) {
 		err = -ENXIO;
 		goto err_lock;
 	}
-	rate = dice_rates[rate];
+	rate = dice_rates[rate_index];

 	err = snd_fw_transaction(dice->unit, TCODE_READ_QUADLET_REQUEST,
 				 rx_address(dice, RX_NUMBER_AUDIO),
@@ -413,9 +414,20 @@ static int dice_open(struct snd_pcm_substream *substream)
 	runtime->hw.channels_min = be32_to_cpu(number_audio);
 	runtime->hw.channels_max = be32_to_cpu(number_audio);

-	amdtp_out_stream_set_rate(&dice->stream, rate);
-	amdtp_out_stream_set_pcm(&dice->stream, be32_to_cpu(number_audio));
-	amdtp_out_stream_set_midi(&dice->stream, be32_to_cpu(number_midi));
+	amdtp_out_stream_set_parameters(&dice->stream, rate,
+					be32_to_cpu(number_audio),
+					be32_to_cpu(number_midi));
+
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					 amdtp_syt_intervals[rate_index]);
+	if (err < 0)
+		goto err_lock;
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					 amdtp_syt_intervals[rate_index]);
+	if (err < 0)
+		goto err_lock;

 	err = snd_pcm_hw_constraint_minmax(runtime,
 					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
@@ -993,7 +1005,8 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 		goto err_notification_handler;
 	dice->resources.channels_mask = 0x00000000ffffffffuLL;

-	err = amdtp_out_stream_init(&dice->stream, unit, CIP_BLOCKING);
+	err = amdtp_out_stream_init(&dice->stream, unit,
+				    CIP_BLOCKING | CIP_HI_DUALWIRE);
 	if (err < 0)
 		goto err_resources;

diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 0ac5630..6a68caf 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -245,8 +245,10 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto error;

-	amdtp_out_stream_set_rate(&fwspk->stream, params_rate(hw_params));
-	amdtp_out_stream_set_pcm(&fwspk->stream, params_channels(hw_params));
+	amdtp_out_stream_set_parameters(&fwspk->stream,
+					params_rate(hw_params),
+					params_channels(hw_params),
+					0);

 	amdtp_out_stream_set_pcm_format(&fwspk->stream,
 					params_format(hw_params));

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
