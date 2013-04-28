From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] Rename functions, structure and member name for AMDTP
Date: Sun, 28 Apr 2013 14:02:11 +0900
Message-ID: <1367125334-446-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patch rename some functions, structure and member name to reuse them
in both AMDTP receive and AMDTP transmit stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c    |  130 ++++++++++++++++++++++-----------------------
 sound/firewire/amdtp.h    |   58 ++++++++++----------
 sound/firewire/speakers.c |   32 +++++------
 3 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index ea995af..32ea650 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -34,13 +34,13 @@
 static void pcm_period_tasklet(unsigned long data);
 
 /**
- * amdtp_out_stream_init - initialize an AMDTP output stream structure
- * @s: the AMDTP output stream to initialize
+ * amdtp_stream_init - initialize an AMDTP stream structure
+ * @s: the AMDTP stream to initialize
  * @unit: the target of the stream
  * @flags: the packet transmission method to use
  */
-int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
-			  enum cip_out_flags flags)
+int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
+			  enum cip_flags flags)
 {
 	if (flags != CIP_NONBLOCKING)
 		return -EINVAL;
@@ -54,29 +54,29 @@ int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
 
 	return 0;
 }
-EXPORT_SYMBOL(amdtp_out_stream_init);
+EXPORT_SYMBOL(amdtp_stream_init);
 
 /**
- * amdtp_out_stream_destroy - free stream resources
- * @s: the AMDTP output stream to destroy
+ * amdtp_stream_destroy - free stream resources
+ * @s: the AMDTP stream to destroy
  */
-void amdtp_out_stream_destroy(struct amdtp_out_stream *s)
+void amdtp_stream_destroy(struct amdtp_stream *s)
 {
 	WARN_ON(!IS_ERR(s->context));
 	mutex_destroy(&s->mutex);
 	fw_unit_put(s->unit);
 }
-EXPORT_SYMBOL(amdtp_out_stream_destroy);
+EXPORT_SYMBOL(amdtp_stream_destroy);
 
 /**
- * amdtp_out_stream_set_rate - set the sample rate
- * @s: the AMDTP output stream to configure
+ * amdtp_stream_set_rate - set the sample rate
+ * @s: the AMDTP stream to configure
  * @rate: the sample rate
  *
  * The sample rate must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate)
+void amdtp_stream_set_rate(struct amdtp_stream *s, unsigned int rate)
 {
 	static const struct {
 		unsigned int rate;
@@ -103,17 +103,17 @@ void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate)
 		}
 	WARN_ON(1);
 }
-EXPORT_SYMBOL(amdtp_out_stream_set_rate);
+EXPORT_SYMBOL(amdtp_stream_set_rate);
 
 /**
- * amdtp_out_stream_get_max_payload - get the stream's packet size
- * @s: the AMDTP output stream
+ * amdtp_stream_get_max_payload - get the stream's packet size
+ * @s: the AMDTP stream
  *
  * This function must not be called before the stream has been configured
- * with amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi().
+ * with amdtp_stream_set_hw_params(), amdtp_stream_set_pcm(), and
+ * amdtp_stream_set_midi().
  */
-unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
+unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 {
 	static const unsigned int max_data_blocks[] = {
 		[CIP_SFC_32000]  =  4,
@@ -130,24 +130,24 @@ unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s)
 
 	return 8 + max_data_blocks[s->sfc] * 4 * s->data_block_quadlets;
 }
-EXPORT_SYMBOL(amdtp_out_stream_get_max_payload);
+EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
-static void amdtp_write_s16(struct amdtp_out_stream *s,
+static void amdtp_write_s16(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames);
-static void amdtp_write_s32(struct amdtp_out_stream *s,
+static void amdtp_write_s32(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames);
 
 /**
- * amdtp_out_stream_set_pcm_format - set the PCM format
- * @s: the AMDTP output stream to configure
+ * amdtp_stream_set_pcm_format - set the PCM format
+ * @s: the AMDTP stream to configure
  * @format: the format of the ALSA PCM device
  *
  * The sample format must be set before the stream is started, and must not be
  * changed while the stream is running.
  */
-void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
+void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				     snd_pcm_format_t format)
 {
 	if (WARN_ON(!IS_ERR(s->context)))
@@ -165,24 +165,24 @@ void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
 		break;
 	}
 }
-EXPORT_SYMBOL(amdtp_out_stream_set_pcm_format);
+EXPORT_SYMBOL(amdtp_stream_set_pcm_format);
 
 /**
- * amdtp_out_stream_pcm_prepare - prepare PCM device for running
- * @s: the AMDTP output stream
+ * amdtp_stream_pcm_prepare - prepare PCM device for running
+ * @s: the AMDTP stream
  *
  * This function should be called from the PCM device's .prepare callback.
  */
-void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s)
+void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
 	tasklet_kill(&s->period_tasklet);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
 	s->pointer_flush = true;
 }
-EXPORT_SYMBOL(amdtp_out_stream_pcm_prepare);
+EXPORT_SYMBOL(amdtp_stream_pcm_prepare);
 
-static unsigned int calculate_data_blocks(struct amdtp_out_stream *s)
+static unsigned int calculate_data_blocks(struct amdtp_stream *s)
 {
 	unsigned int phase, data_blocks;
 
@@ -215,7 +215,7 @@ static unsigned int calculate_data_blocks(struct amdtp_out_stream *s)
 	return data_blocks;
 }
 
-static unsigned int calculate_syt(struct amdtp_out_stream *s,
+static unsigned int calculate_syt(struct amdtp_stream *s,
 				  unsigned int cycle)
 {
 	unsigned int syt_offset, phase, index, syt;
@@ -258,7 +258,7 @@ static unsigned int calculate_syt(struct amdtp_out_stream *s,
 	}
 }
 
-static void amdtp_write_s32(struct amdtp_out_stream *s,
+static void amdtp_write_s32(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames)
 {
@@ -284,7 +284,7 @@ static void amdtp_write_s32(struct amdtp_out_stream *s,
 	}
 }
 
-static void amdtp_write_s16(struct amdtp_out_stream *s,
+static void amdtp_write_s16(struct amdtp_stream *s,
 			    struct snd_pcm_substream *pcm,
 			    __be32 *buffer, unsigned int frames)
 {
@@ -310,7 +310,7 @@ static void amdtp_write_s16(struct amdtp_out_stream *s,
 	}
 }
 
-static void amdtp_fill_pcm_silence(struct amdtp_out_stream *s,
+static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 				   __be32 *buffer, unsigned int frames)
 {
 	unsigned int i, c;
@@ -322,7 +322,7 @@ static void amdtp_fill_pcm_silence(struct amdtp_out_stream *s,
 	}
 }
 
-static void amdtp_fill_midi(struct amdtp_out_stream *s,
+static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
 	unsigned int i;
@@ -332,7 +332,7 @@ static void amdtp_fill_midi(struct amdtp_out_stream *s,
 						cpu_to_be32(0x80000000);
 }
 
-static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
+static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
 	unsigned int index, data_blocks, syt, ptr;
@@ -377,7 +377,7 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 	if (err < 0) {
 		dev_err(&s->unit->device, "queueing error: %d\n", err);
 		s->packet_index = -1;
-		amdtp_out_stream_pcm_abort(s);
+		amdtp_stream_pcm_abort(s);
 		return;
 	}
 
@@ -402,7 +402,7 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 
 static void pcm_period_tasklet(unsigned long data)
 {
-	struct amdtp_out_stream *s = (void *)data;
+	struct amdtp_stream *s = (void *)data;
 	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
 
 	if (pcm)
@@ -410,9 +410,9 @@ static void pcm_period_tasklet(unsigned long data)
 }
 
 static void out_packet_callback(struct fw_iso_context *context, u32 cycle,
-				size_t header_length, void *header, void *data)
+			size_t header_length, void *header, void *private_data)
 {
-	struct amdtp_out_stream *s = data;
+	struct amdtp_stream *s = private_data;
 	unsigned int i, packets = header_length / 4;
 
 	/*
@@ -427,7 +427,7 @@ static void out_packet_callback(struct fw_iso_context *context, u32 cycle,
 	fw_iso_context_queue_flush(s->context);
 }
 
-static int queue_initial_skip_packets(struct amdtp_out_stream *s)
+static int queue_initial_skip_packets(struct amdtp_stream *s)
 {
 	struct fw_iso_packet skip_packet = {
 		.skip = 1,
@@ -449,17 +449,17 @@ static int queue_initial_skip_packets(struct amdtp_out_stream *s)
 }
 
 /**
- * amdtp_out_stream_start - start sending packets
- * @s: the AMDTP output stream to start
+ * amdtp_stream_start - start sending packets
+ * @s: the AMDTP stream to start
  * @channel: the isochronous channel on the bus
  * @speed: firewire speed code
  *
  * The stream cannot be started until it has been configured with
- * amdtp_out_stream_set_hw_params(), amdtp_out_stream_set_pcm(), and
- * amdtp_out_stream_set_midi(); and it must be started before any
+ * amdtp_stream_set_hw_params(), amdtp_stream_set_pcm(), and
+ * amdtp_stream_set_midi(); and it must be started before any
  * PCM or MIDI device can be started.
  */
-int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
+int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 {
 	static const struct {
 		unsigned int data_block;
@@ -488,7 +488,7 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
 	s->last_syt_offset = TICKS_PER_CYCLE;
 
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
-				      amdtp_out_stream_get_max_payload(s),
+				      amdtp_stream_get_max_payload(s),
 				      DMA_TO_DEVICE);
 	if (err < 0)
 		goto err_unlock;
@@ -501,11 +501,11 @@ int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed)
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
 			dev_err(&s->unit->device,
-				"no free output stream on this controller\n");
+				"no free stream on this controller\n");
 		goto err_buffer;
 	}
 
-	amdtp_out_stream_update(s);
+	amdtp_stream_update(s);
 
 	s->packet_index = 0;
 	s->data_block_counter = 0;
@@ -531,15 +531,15 @@ err_unlock:
 
 	return err;
 }
-EXPORT_SYMBOL(amdtp_out_stream_start);
+EXPORT_SYMBOL(amdtp_stream_start);
 
 /**
- * amdtp_out_stream_pcm_pointer - get the PCM buffer position
- * @s: the AMDTP output stream that transports the PCM data
+ * amdtp_stream_pcm_pointer - get the PCM buffer position
+ * @s: the AMDTP stream that transports the PCM data
  *
  * Returns the current buffer position, in frames.
  */
-unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s)
+unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
 {
 	/* this optimization is allowed to be racy */
 	if (s->pointer_flush)
@@ -549,27 +549,27 @@ unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s)
 
 	return ACCESS_ONCE(s->pcm_buffer_pointer);
 }
-EXPORT_SYMBOL(amdtp_out_stream_pcm_pointer);
+EXPORT_SYMBOL(amdtp_stream_pcm_pointer);
 
 /**
- * amdtp_out_stream_update - update the stream after a bus reset
- * @s: the AMDTP output stream
+ * amdtp_stream_update - update the stream after a bus reset
+ * @s: the AMDTP stream
  */
-void amdtp_out_stream_update(struct amdtp_out_stream *s)
+void amdtp_stream_update(struct amdtp_stream *s)
 {
 	ACCESS_ONCE(s->source_node_id_field) =
 		(fw_parent_device(s->unit)->card->node_id & 0x3f) << 24;
 }
-EXPORT_SYMBOL(amdtp_out_stream_update);
+EXPORT_SYMBOL(amdtp_stream_update);
 
 /**
- * amdtp_out_stream_stop - stop sending packets
- * @s: the AMDTP output stream to stop
+ * amdtp_stream_stop - stop sending packets
+ * @s: the AMDTP stream to stop
  *
  * All PCM and MIDI devices of the stream must be stopped before the stream
  * itself can be stopped.
  */
-void amdtp_out_stream_stop(struct amdtp_out_stream *s)
+void amdtp_stream_stop(struct amdtp_stream *s)
 {
 	mutex_lock(&s->mutex);
 
@@ -586,16 +586,16 @@ void amdtp_out_stream_stop(struct amdtp_out_stream *s)
 
 	mutex_unlock(&s->mutex);
 }
-EXPORT_SYMBOL(amdtp_out_stream_stop);
+EXPORT_SYMBOL(amdtp_stream_stop);
 
 /**
- * amdtp_out_stream_pcm_abort - abort the running PCM device
+ * amdtp_stream_pcm_abort - abort the running PCM device
  * @s: the AMDTP stream about to be stopped
  *
  * If the isochronous stream needs to be stopped asynchronously, call this
  * function first to stop the PCM device.
  */
-void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s)
+void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 {
 	struct snd_pcm_substream *pcm;
 
@@ -607,4 +607,4 @@ void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s)
 		snd_pcm_stream_unlock_irq(pcm);
 	}
 }
-EXPORT_SYMBOL(amdtp_out_stream_pcm_abort);
+EXPORT_SYMBOL(amdtp_stream_pcm_abort);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index b680c5e..82392ea 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -7,13 +7,13 @@
 #include "packets-buffer.h"
 
 /**
- * enum cip_out_flags - describes details of the streaming protocol
+ * enum cip_flags - describes details of the streaming protocol
  * @CIP_NONBLOCKING: In non-blocking mode, each packet contains
  *	sample_rate/8000 samples, with rounding up or down to adjust
  *	for clock skew and left-over fractional samples.  This should
  *	be used if supported by the device.
  */
-enum cip_out_flags {
+enum cip_flags {
 	CIP_NONBLOCKING = 0,
 };
 
@@ -37,9 +37,9 @@ struct fw_unit;
 struct fw_iso_context;
 struct snd_pcm_substream;
 
-struct amdtp_out_stream {
+struct amdtp_stream {
 	struct fw_unit *unit;
-	enum cip_out_flags flags;
+	enum cip_flags flags;
 	struct fw_iso_context *context;
 	struct mutex mutex;
 
@@ -47,7 +47,7 @@ struct amdtp_out_stream {
 	unsigned int data_block_quadlets;
 	unsigned int pcm_channels;
 	unsigned int midi_ports;
-	void (*transfer_samples)(struct amdtp_out_stream *s,
+	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
 
@@ -71,72 +71,72 @@ struct amdtp_out_stream {
 	bool pointer_flush;
 };
 
-int amdtp_out_stream_init(struct amdtp_out_stream *s, struct fw_unit *unit,
-			  enum cip_out_flags flags);
-void amdtp_out_stream_destroy(struct amdtp_out_stream *s);
+int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
+			  enum cip_flags flags);
+void amdtp_stream_destroy(struct amdtp_stream *s);
 
-void amdtp_out_stream_set_rate(struct amdtp_out_stream *s, unsigned int rate);
-unsigned int amdtp_out_stream_get_max_payload(struct amdtp_out_stream *s);
+void amdtp_stream_set_rate(struct amdtp_stream *s, unsigned int rate);
+unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s);
 
-int amdtp_out_stream_start(struct amdtp_out_stream *s, int channel, int speed);
-void amdtp_out_stream_update(struct amdtp_out_stream *s);
-void amdtp_out_stream_stop(struct amdtp_out_stream *s);
+int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed);
+void amdtp_stream_update(struct amdtp_stream *s);
+void amdtp_stream_stop(struct amdtp_stream *s);
 
-void amdtp_out_stream_set_pcm_format(struct amdtp_out_stream *s,
+void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 				     snd_pcm_format_t format);
-void amdtp_out_stream_pcm_prepare(struct amdtp_out_stream *s);
-unsigned long amdtp_out_stream_pcm_pointer(struct amdtp_out_stream *s);
-void amdtp_out_stream_pcm_abort(struct amdtp_out_stream *s);
+void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
+unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
+void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 
 /**
- * amdtp_out_stream_set_pcm - configure format of PCM samples
- * @s: the AMDTP output stream to be configured
+ * amdtp_stream_set_pcm - configure format of PCM samples
+ * @s: the AMDTP stream to be configured
  * @pcm_channels: the number of PCM samples in each data block, to be encoded
  *                as AM824 multi-bit linear audio
  *
  * This function must not be called while the stream is running.
  */
-static inline void amdtp_out_stream_set_pcm(struct amdtp_out_stream *s,
+static inline void amdtp_stream_set_pcm(struct amdtp_stream *s,
 					    unsigned int pcm_channels)
 {
 	s->pcm_channels = pcm_channels;
 }
 
 /**
- * amdtp_out_stream_set_midi - configure format of MIDI data
- * @s: the AMDTP output stream to be configured
+ * amdtp_stream_set_midi - configure format of MIDI data
+ * @s: the AMDTP stream to be configured
  * @midi_ports: the number of MIDI ports (i.e., MPX-MIDI Data Channels)
  *
  * This function must not be called while the stream is running.
  */
-static inline void amdtp_out_stream_set_midi(struct amdtp_out_stream *s,
+static inline void amdtp_stream_set_midi(struct amdtp_stream *s,
 					     unsigned int midi_ports)
 {
 	s->midi_ports = midi_ports;
 }
 
 /**
- * amdtp_out_streaming_error - check for streaming error
- * @s: the AMDTP output stream
+ * amdtp_streaming_error - check for streaming error
+ * @s: the AMDTP stream
  *
  * If this function returns true, the stream's packet queue has stopped due to
  * an asynchronous error.
  */
-static inline bool amdtp_out_streaming_error(struct amdtp_out_stream *s)
+static inline bool amdtp_streaming_error(struct amdtp_stream *s)
 {
 	return s->packet_index < 0;
 }
 
 /**
- * amdtp_out_stream_pcm_trigger - start/stop playback from a PCM device
- * @s: the AMDTP output stream
+ * amdtp_stream_pcm_trigger - start/stop playback from a PCM device
+ * @s: the AMDTP stream
  * @pcm: the PCM device to be started, or %NULL to stop the current device
  *
  * Call this function on a running isochronous stream to enable the actual
  * transmission of PCM data.  This function should be called from the PCM
  * device's .trigger callback.
  */
-static inline void amdtp_out_stream_pcm_trigger(struct amdtp_out_stream *s,
+static inline void amdtp_stream_pcm_trigger(struct amdtp_stream *s,
 						struct snd_pcm_substream *pcm)
 {
 	ACCESS_ONCE(s->pcm) = pcm;
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 1e1f003..7df20ac 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -52,7 +52,7 @@ struct fwspk {
 	struct snd_pcm_substream *pcm;
 	struct mutex mutex;
 	struct cmp_connection connection;
-	struct amdtp_out_stream stream;
+	struct amdtp_stream stream;
 	bool stream_running;
 	bool mute;
 	s16 volume[6];
@@ -190,7 +190,7 @@ static int fwspk_close(struct snd_pcm_substream *substream)
 static void fwspk_stop_stream(struct fwspk *fwspk)
 {
 	if (fwspk->stream_running) {
-		amdtp_out_stream_stop(&fwspk->stream);
+		amdtp_stream_stop(&fwspk->stream);
 		cmp_connection_break(&fwspk->connection);
 		fwspk->stream_running = false;
 	}
@@ -247,10 +247,10 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto error;
 
-	amdtp_out_stream_set_rate(&fwspk->stream, params_rate(hw_params));
-	amdtp_out_stream_set_pcm(&fwspk->stream, params_channels(hw_params));
+	amdtp_stream_set_rate(&fwspk->stream, params_rate(hw_params));
+	amdtp_stream_set_pcm(&fwspk->stream, params_channels(hw_params));
 
-	amdtp_out_stream_set_pcm_format(&fwspk->stream,
+	amdtp_stream_set_pcm_format(&fwspk->stream,
 					params_format(hw_params));
 
 	err = fwspk_set_rate(fwspk, fwspk->stream.sfc);
@@ -283,16 +283,16 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock(&fwspk->mutex);
 
-	if (amdtp_out_streaming_error(&fwspk->stream))
+	if (amdtp_streaming_error(&fwspk->stream))
 		fwspk_stop_stream(fwspk);
 
 	if (!fwspk->stream_running) {
 		err = cmp_connection_establish(&fwspk->connection,
-			amdtp_out_stream_get_max_payload(&fwspk->stream));
+			amdtp_stream_get_max_payload(&fwspk->stream));
 		if (err < 0)
 			goto err_mutex;
 
-		err = amdtp_out_stream_start(&fwspk->stream,
+		err = amdtp_stream_start(&fwspk->stream,
 					fwspk->connection.resources.channel,
 					fwspk->connection.speed);
 		if (err < 0)
@@ -303,7 +303,7 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 
 	mutex_unlock(&fwspk->mutex);
 
-	amdtp_out_stream_pcm_prepare(&fwspk->stream);
+	amdtp_stream_pcm_prepare(&fwspk->stream);
 
 	return 0;
 
@@ -330,7 +330,7 @@ static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	amdtp_out_stream_pcm_trigger(&fwspk->stream, pcm);
+	amdtp_stream_pcm_trigger(&fwspk->stream, pcm);
 	return 0;
 }
 
@@ -338,7 +338,7 @@ static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
 
-	return amdtp_out_stream_pcm_pointer(&fwspk->stream);
+	return amdtp_stream_pcm_pointer(&fwspk->stream);
 }
 
 static int fwspk_create_pcm(struct fwspk *fwspk)
@@ -657,7 +657,7 @@ static void fwspk_card_free(struct snd_card *card)
 {
 	struct fwspk *fwspk = card->private_data;
 
-	amdtp_out_stream_destroy(&fwspk->stream);
+	amdtp_stream_destroy(&fwspk->stream);
 	cmp_connection_destroy(&fwspk->connection);
 	fw_unit_put(fwspk->unit);
 	mutex_destroy(&fwspk->mutex);
@@ -727,7 +727,7 @@ static int fwspk_probe(struct device *unit_dev)
 	if (err < 0)
 		goto err_unit;
 
-	err = amdtp_out_stream_init(&fwspk->stream, unit, CIP_NONBLOCKING);
+	err = amdtp_stream_init(&fwspk->stream, unit, CIP_NONBLOCKING);
 	if (err < 0)
 		goto err_connection;
 
@@ -774,7 +774,7 @@ static int fwspk_remove(struct device *dev)
 {
 	struct fwspk *fwspk = dev_get_drvdata(dev);
 
-	amdtp_out_stream_pcm_abort(&fwspk->stream);
+	amdtp_stream_pcm_abort(&fwspk->stream);
 	snd_card_disconnect(fwspk->card);
 
 	mutex_lock(&fwspk->mutex);
@@ -793,14 +793,14 @@ static void fwspk_bus_reset(struct fw_unit *unit)
 	fcp_bus_reset(fwspk->unit);
 
 	if (cmp_connection_update(&fwspk->connection) < 0) {
-		amdtp_out_stream_pcm_abort(&fwspk->stream);
+		amdtp_stream_pcm_abort(&fwspk->stream);
 		mutex_lock(&fwspk->mutex);
 		fwspk_stop_stream(fwspk);
 		mutex_unlock(&fwspk->mutex);
 		return;
 	}
 
-	amdtp_out_stream_update(&fwspk->stream);
+	amdtp_stream_update(&fwspk->stream);
 }
 
 static const struct ieee1394_device_id fwspk_id_table[] = {
-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
