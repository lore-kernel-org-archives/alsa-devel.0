From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/17] firewire-lib: Add support for duplex
	streams with synchronization
Date: Sat, 23 Nov 2013 15:07:55 +0900
Message-ID: <1385186884-8259-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id E4EE6261A2B
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:12 +0100 (CET)
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

Generally, the devices can synchronize to handle 'presentation timestamp'
in CIP packets. This commit adds the functionality to pick up this timestamp
in packets transmitted by the device, then use it for out packets.

In previous implementation, this module generated the timestamp by itself. Then
it acts as synchronization master. This commit allows this module to act as
synchronization slave.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++---
 sound/firewire/amdtp.h |  32 +++++++++++--
 2 files changed, 148 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 292403d..6830dd8 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -11,6 +11,7 @@
 #include <linux/firewire.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
 #include "amdtp.h"
@@ -47,6 +48,7 @@
 /* TODO: make these configurable */
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
+#define CALLBACK_TIMEOUT_MS	100
 
 #define TRANSMIT_PACKET_HEADER_SIZE	4
 #define RECEIVE_PACKET_HEADER_SIZE	0
@@ -71,6 +73,10 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
 	s->packet_index = 0;
 
+	init_waitqueue_head(&s->callback_wait);
+	s->callbacked = false;
+	s->sync_slave = ERR_PTR(-1);
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -698,7 +704,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int data_blocks, payload_length;
-	struct snd_pcm_substream *pcm;
+	struct snd_pcm_substream *pcm = NULL;
 
 	if (s->packet_index < 0)
 		return;
@@ -817,7 +823,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 	for (i = 0; i < packets; ++i) {
 		syt = calculate_syt(s, ++cycle);
-		handle_out_packet(s, ++cycle);
+		handle_out_packet(s, syt);
 	}
 	fw_iso_context_queue_flush(s->context);
 }
@@ -827,7 +833,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int p, packets, data_quadlets;
+	unsigned int p, packets, syt, data_quadlets;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
@@ -839,6 +845,15 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 		/* The number of quadlets in this packet */
 		data_quadlets =
 			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+
+		/* Process sync slave stream */
+		if ((s->flags & CIP_BLOCKING) &&
+		    (s->flags & CIP_SYNC_TO_DEVICE) &&
+		    s->sync_slave->callbacked) {
+			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+			handle_out_packet(s->sync_slave, syt);
+		}
+
 		/* handle each packet data */
 		handle_in_packet(s, data_quadlets, buffer);
 
@@ -848,9 +863,43 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 		}
 	}
 
+	/* when sync to device, flush the packets for slave stream */
+	if ((s->flags & CIP_BLOCKING) &&
+	    (s->flags & CIP_SYNC_TO_DEVICE) && s->sync_slave->callbacked)
+		fw_iso_context_queue_flush(s->sync_slave->context);
+
 	fw_iso_context_queue_flush(s->context);
 }
 
+/* processing is done by master callback */
+static void slave_stream_callback(struct fw_iso_context *context, u32 cycle,
+				  size_t header_length, void *header,
+				  void *private_data)
+{
+	return;
+}
+
+/* this is executed one time */
+static void amdtp_stream_callback(struct fw_iso_context *context, u32 cycle,
+				  size_t header_length, void *header,
+				  void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+
+	s->callbacked = true;
+
+	if (s->direction == AMDTP_TRANSMIT_STREAM)
+		context->callback.sc = in_stream_callback;
+	else if (!(s->flags & CIP_SYNC_TO_DEVICE))
+		context->callback.sc = out_stream_callback;
+	else
+		context->callback.sc = slave_stream_callback;
+
+	context->callback.sc(context, cycle, header_length, header, s);
+
+	return;
+}
+
 /**
  * amdtp_stream_start - start sending packets
  * @s: the AMDTP stream to start
@@ -877,7 +926,6 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	};
 	unsigned int header_size;
 	enum dma_data_direction dir;
-	fw_iso_callback_t cb;
 	int type, err;
 
 	mutex_lock(&s->mutex);
@@ -897,12 +945,10 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		dir = DMA_FROM_DEVICE;
 		type = FW_ISO_CONTEXT_RECEIVE;
 		header_size = TRANSMIT_PACKET_HEADER_SIZE;
-		cb = in_stream_callback;
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
 		header_size = RECEIVE_PACKET_HEADER_SIZE;
-		cb = out_stream_callback;
 	}
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
 				      amdtp_stream_get_max_payload(s), dir);
@@ -911,7 +957,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   type, channel, speed, header_size,
-					   cb, s);
+					   amdtp_stream_callback, s);
 	if (!amdtp_stream_running(s)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -934,6 +980,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream */
 	s->data_block_counter = 0;
+	s->callbacked = false;
 	err = fw_iso_context_start(s->context, -1, 0, FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
@@ -1005,6 +1052,8 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 	s->context = ERR_PTR(-1);
 	iso_packets_buffer_destroy(&s->buffer, s->unit);
 
+	s->callbacked = false;
+
 	mutex_unlock(&s->mutex);
 }
 EXPORT_SYMBOL(amdtp_stream_stop);
@@ -1029,3 +1078,66 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 	}
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
+
+/**
+ * amdtp_stream_wait_callback - block till callbacked or timeout
+ * @s: the AMDTP stream
+ *
+ * If this function return false, the AMDTP stream should be stopped.
+ */
+bool amdtp_stream_wait_callback(struct amdtp_stream *s)
+{
+	wait_event_timeout(s->callback_wait,
+			   s->callbacked == true,
+			   msecs_to_jiffies(CALLBACK_TIMEOUT_MS));
+	return s->callbacked;
+}
+EXPORT_SYMBOL(amdtp_stream_wait_callback);
+
+/**
+ * amdtp_stream_midi_add - add MIDI stream
+ * @s: the AMDTP stream
+ * @substream: the MIDI stream to be added
+ *
+ * This function don't check the number of midi substream but it should be
+ * within AMDTP_MAX_MIDI_STREAMS.
+ */
+void amdtp_stream_midi_add(struct amdtp_stream *s,
+			   struct snd_rawmidi_substream *substream)
+{
+	ACCESS_ONCE(s->midi[substream->number]) = substream;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_add);
+
+/**
+ * amdtp_stream_midi_remove - remove MIDI stream
+ * @s: the AMDTP stream
+ * @substream: the MIDI stream to be removed
+ *
+ * This function should not be automatically called by amdtp_stream_stop
+ * because the AMDTP stream only with MIDI stream need to be restarted by
+ * PCM streams at requested sampling rate.
+ */
+void amdtp_stream_midi_remove(struct amdtp_stream *s,
+			      struct snd_rawmidi_substream *substream)
+{
+	ACCESS_ONCE(s->midi[substream->number]) = NULL;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_remove);
+
+/**
+ * amdtp_stream_midi_running - check any MIDI streams are running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, any MIDI streams are running.
+ */
+bool amdtp_stream_midi_running(struct amdtp_stream *s)
+{
+	int i;
+	for (i = 0; i < AMDTP_MAX_CHANNELS_FOR_MIDI * 8; i++)
+		if (!IS_ERR_OR_NULL(s->midi[i]))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_running);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 93489d8..a2a7818 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -20,11 +20,14 @@
  *	at half the actual sample rate with twice the number of channels;
  *	two samples of a channel are stored consecutively in the packet.
  *	Requires blocking mode and SYT_INTERVAL-aligned PCM buffer size.
+ * @CIP_SYNC_TO_DEVICE: In sync to device mode, time stamp in out packets is
+ *	generated by in packets. Defaultly this driver generates timestamp.
  */
 enum cip_flags {
-	CIP_NONBLOCKING	= 0x00,
-	CIP_BLOCKING	= 0x01,
-	CIP_HI_DUALWIRE	= 0x02,
+	CIP_NONBLOCKING		= 0x00,
+	CIP_BLOCKING		= 0x01,
+	CIP_HI_DUALWIRE		= 0x02,
+	CIP_SYNC_TO_DEVICE	= 0x04
 };
 
 /**
@@ -99,6 +102,10 @@ struct amdtp_stream {
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 	unsigned long midi_triggered;
+
+	bool callbacked;
+	wait_queue_head_t callback_wait;
+	struct amdtp_stream *sync_slave;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -121,6 +128,7 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
+bool amdtp_stream_wait_callback(struct amdtp_stream *s);
 
 extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
 
@@ -198,4 +206,22 @@ static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 	return sfc & 1;
 }
 
+static inline void amdtp_stream_set_sync(enum cip_flags sync_mode,
+					 struct amdtp_stream *master,
+					 struct amdtp_stream *slave)
+{
+	/* clear sync flag */
+	master->flags &= ~CIP_SYNC_TO_DEVICE;
+	slave->flags &= ~CIP_SYNC_TO_DEVICE;
+
+	if (sync_mode == CIP_SYNC_TO_DEVICE) {
+		master->flags |= CIP_SYNC_TO_DEVICE;
+		slave->flags |= CIP_SYNC_TO_DEVICE;
+		master->sync_slave = slave;
+	} else
+		master->sync_slave = ERR_PTR(-1);
+
+	slave->sync_slave = ERR_PTR(-1);
+}
+
 #endif
-- 
1.8.3.2
