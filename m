From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/49] firewire-lib: Add support for duplex streams
	synchronization in blocking mode
Date: Fri, 25 Apr 2014 22:44:49 +0900
Message-ID: <1398433530-13136-9-git-send-email-o-takashi@sakamocchi.jp>
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

Generally, the devices can synchronize to handle 'presentation timestamp'
in CIP packets. This commit adds functionality to pick up this timestamp from
in-packets transmitted by the device, then use it for out packets.

In current implementation, this module generated the timestamp by itself. This
is 'SYT Match' mode. Then drivers with this module acts as synchronization
master. This commit allows this module to act as synchronization slave.

This commit restricts this mechanism is only available in blocking mode because
handling the timestamp in non-blocking mode is more complicated than in
blocking mode.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 75 +++++++++++++++++++++++++++++++++++++++++++++-----
 sound/firewire/amdtp.h | 45 ++++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 24e9a96..8498155 100644
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
@@ -72,6 +73,10 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
 	s->packet_index = 0;
 
+	init_waitqueue_head(&s->callback_wait);
+	s->callbacked = false;
+	s->sync_slave = NULL;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -585,7 +590,10 @@ static int queue_packet(struct amdtp_stream *s,
 			unsigned int payload_length, bool skip)
 {
 	struct fw_iso_packet p = {0};
-	int err;
+	int err = 0;
+
+	if (IS_ERR(s->context))
+		goto end;
 
 	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
 	p.tag = TAG_CIP;
@@ -765,7 +773,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int p, packets, payload_quadlets;
+	unsigned int p, syt, packets, payload_quadlets;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
@@ -773,18 +781,71 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 	for (p = 0; p < packets; p++) {
 		if (s->packet_index < 0)
-			return;
+			break;
+
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
+		/* Process sync slave stream */
+		if (s->sync_slave && s->sync_slave->callbacked) {
+			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+			handle_out_packet(s->sync_slave, syt);
+		}
+
 		/* The number of quadlets in this packet */
 		payload_quadlets =
 			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
 		handle_in_packet(s, payload_quadlets, buffer);
 	}
 
+	/* Queueing error or detecting discontinuity */
+	if (s->packet_index < 0) {
+		/* Abort sync slave. */
+		if (s->sync_slave) {
+			s->sync_slave->packet_index = -1;
+			amdtp_stream_pcm_abort(s->sync_slave);
+		}
+		return;
+	}
+
+	/* when sync to device, flush the packets for slave stream */
+	if (s->sync_slave && s->sync_slave->callbacked)
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
+static void amdtp_stream_first_callback(struct fw_iso_context *context,
+					u32 cycle, size_t header_length,
+					void *header, void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+
+	/*
+	 * For in-stream, first packet has come.
+	 * For out-stream, prepared to transmit first packet
+	 */
+	s->callbacked = true;
+	wake_up(&s->callback_wait);
+
+	if (s->direction == AMDTP_IN_STREAM)
+		context->callback.sc = in_stream_callback;
+	else if ((s->flags & CIP_BLOCKING) && (s->flags & CIP_SYNC_TO_DEVICE))
+		context->callback.sc = slave_stream_callback;
+	else
+		context->callback.sc = out_stream_callback;
+
+	context->callback.sc(context, cycle, header_length, header, s);
+}
+
 /**
  * amdtp_stream_start - start transferring packets
  * @s: the AMDTP stream to start
@@ -811,7 +872,6 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	};
 	unsigned int header_size;
 	enum dma_data_direction dir;
-	fw_iso_callback_t cb;
 	int type, err;
 
 	mutex_lock(&s->mutex);
@@ -832,12 +892,10 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
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
@@ -846,7 +904,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   type, channel, speed, header_size,
-					   cb, s);
+					   amdtp_stream_first_callback, s);
 	if (IS_ERR(s->context)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
@@ -868,6 +926,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	} while (s->packet_index > 0);
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream. */
+	s->callbacked = false;
 	err = fw_iso_context_start(s->context, -1, 0,
 				   FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
@@ -940,6 +999,8 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 	s->context = ERR_PTR(-1);
 	iso_packets_buffer_destroy(&s->buffer, s->unit);
 
+	s->callbacked = false;
+
 	mutex_unlock(&s->mutex);
 }
 EXPORT_SYMBOL(amdtp_stream_stop);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 098187d..2bd3b27 100644
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
+	CIP_SYNC_TO_DEVICE	= 0x04,
 };
 
 /**
@@ -104,6 +107,10 @@ struct amdtp_stream {
 	bool pointer_flush;
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+
+	bool callbacked;
+	wait_queue_head_t callback_wait;
+	struct amdtp_stream *sync_slave;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -201,4 +208,36 @@ static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 	return sfc & 1;
 }
 
+static inline void amdtp_stream_set_sync(enum cip_flags sync_mode,
+					 struct amdtp_stream *master,
+					 struct amdtp_stream *slave)
+{
+	if (sync_mode == CIP_SYNC_TO_DEVICE) {
+		master->flags |= CIP_SYNC_TO_DEVICE;
+		slave->flags |= CIP_SYNC_TO_DEVICE;
+		master->sync_slave = slave;
+	} else {
+		master->flags &= ~CIP_SYNC_TO_DEVICE;
+		slave->flags &= ~CIP_SYNC_TO_DEVICE;
+		master->sync_slave = NULL;
+	}
+
+	slave->sync_slave = NULL;
+}
+
+/**
+ * amdtp_stream_wait_callback - sleep till callbacked or timeout
+ * @s: the AMDTP stream
+ * @timeout: msec till timeout
+ *
+ * If this function return false, the AMDTP stream should be stopped.
+ */
+static inline bool amdtp_stream_wait_callback(struct amdtp_stream *s,
+					      unsigned int timeout)
+{
+	return wait_event_timeout(s->callback_wait,
+				  s->callbacked == true,
+				  msecs_to_jiffies(timeout)) > 0;
+}
+
 #endif
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
