From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/38] firewire-lib: Add support for duplex streams
	synchronization in blocking mode
Date: Fri, 20 Dec 2013 22:13:59 +0900
Message-ID: <1387545269-3875-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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

Generally, the devices can synchronize to handle 'presentation timestamp'
in CIP packets. This commit adds the functionality to pick up this timestamp
from in-packets transmitted by the device, then use it for out packets.

In previous implementation, this module generated the timestamp by itself. This
is 'SYT Match' mode. Then this drive acts as synchronization master. This
commit allows this module to act as synchronization slave.

This commit restricts this mechanism is only available in blocking mode because
handling the timestamp in non-blocking mode is more complicated than in
blocking mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++----
 sound/firewire/amdtp.h | 32 +++++++++++++++++++--
 2 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 9ffc3bf..03dd9b3 100644
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
@@ -48,6 +49,7 @@
 /* TODO: make these configurable */
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
+#define CALLBACK_TIMEOUT_MS	100
 
 #define IN_PACKET_HEADER_SIZE	4
 #define OUT_PACKET_HEADER_SIZE	0
@@ -72,6 +74,10 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
 	s->packet_index = 0;
 
+	init_waitqueue_head(&s->callback_wait);
+	s->callbacked = false;
+	s->sync_slave = ERR_PTR(-1);
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -626,7 +632,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int data_blocks, payload_length;
-	struct snd_pcm_substream *pcm;
+	struct snd_pcm_substream *pcm = NULL;
 
 	if (s->packet_index < 0)
 		return;
@@ -756,7 +762,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int p, packets, data_quadlets;
+	unsigned int p, packets, syt, data_quadlets;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
@@ -768,6 +774,15 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
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
 
@@ -777,9 +792,43 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
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
+	if (s->direction == AMDTP_IN_STREAM)
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
  * amdtp_stream_start - start transferring packets
  * @s: the AMDTP stream to start
@@ -806,7 +855,6 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	};
 	unsigned int header_size;
 	enum dma_data_direction dir;
-	fw_iso_callback_t cb;
 	int type, err;
 
 	mutex_lock(&s->mutex);
@@ -826,12 +874,10 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 		dir = DMA_FROM_DEVICE;
 		type = FW_ISO_CONTEXT_RECEIVE;
 		header_size = IN_PACKET_HEADER_SIZE;
-		cb = in_stream_callback;
 	} else {
 		dir = DMA_TO_DEVICE;
 		type = FW_ISO_CONTEXT_TRANSMIT;
 		header_size = OUT_PACKET_HEADER_SIZE;
-		cb = out_stream_callback;
 	}
 	err = iso_packets_buffer_init(&s->buffer, s->unit, QUEUE_LENGTH,
 				      amdtp_stream_get_max_payload(s), dir);
@@ -840,7 +886,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   type, channel, speed, header_size,
-					   cb, s);
+					   amdtp_stream_callback, s);
 	if (IS_ERR(s->context)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -863,6 +909,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream */
 	s->data_block_counter = 0;
+	s->callbacked = false;
 	err = fw_iso_context_start(s->context, -1, 0,
 				   FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
@@ -935,6 +982,8 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 	s->context = ERR_PTR(-1);
 	iso_packets_buffer_destroy(&s->buffer, s->unit);
 
+	s->callbacked = false;
+
 	mutex_unlock(&s->mutex);
 }
 EXPORT_SYMBOL(amdtp_stream_stop);
@@ -961,6 +1010,21 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
 
 /**
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
  * amdtp_stream_midi_running - check any MIDI streams are running or not
  * @s: the AMDTP stream
  *
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 6e8081c..e5d5999 100644
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
@@ -102,6 +105,10 @@ struct amdtp_stream {
 	bool pointer_flush;
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+
+	bool callbacked;
+	wait_queue_head_t callback_wait;
+	struct amdtp_stream *sync_slave;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -124,6 +131,7 @@ void amdtp_stream_set_pcm_format(struct amdtp_stream *s,
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
+bool amdtp_stream_wait_callback(struct amdtp_stream *s);
 
 extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
 
@@ -201,4 +209,22 @@ static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
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


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
