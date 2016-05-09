From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/7] ALSA: firewire-lib: handle IT/IR contexts
	in each software interrupt context
Date: Mon,  9 May 2016 23:15:53 +0900
Message-ID: <1462803356-6229-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EE4A92607C8
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:16:01 +0200 (CEST)
In-Reply-To: <1462803356-6229-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In clause 6.3 of IEC 61883-6:2000, there's an explanation about processing
of presentation timestamp. In the clause, we can see "If a function block
receives a CIP, processes it and subsequently re-transmits it, then the
SYT of the outgoing CIP shall be the sum of the incoming SYT and the
processing delay." ALSA firewire stack has an implementation to partly
satisfy this specification. Developers assumed the stack to perform as an
Audio function block[1].

Following to the assumption, current implementation of ALSA firewire stack
use one software interrupt context to handle both of in/out packets. In
most case, this is processed in 1394 OHCI IR context independently of the
opposite context. Thus, this implementation uses longer CPU time in the
software interrupt context. This is not better for whole system.

Against the assumption, I confirmed that each ASIC for IEC 61883-1/6
doesn't necessarily expect it to the stack. Thus, current implementation
of ALSA firewire stack includes over-engineering.

This commit purges the implementation. As a result, packets of one
direction are handled in one software interrupt context and spends
minimum CPU time.

[1] [alsa-devel] [PATCH 0/8] [RFC] new driver for Echo Audio's Fireworks based devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-June/062660.html

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 40 ++++------------------------------------
 sound/firewire/amdtp-stream.h | 35 +++++++----------------------------
 2 files changed, 11 insertions(+), 64 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index a22e559..3468419 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -91,7 +91,6 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 
 	init_waitqueue_head(&s->callback_wait);
 	s->callbacked = false;
-	s->sync_slave = NULL;
 
 	s->fmt = fmt;
 	s->process_data_blocks = process_data_blocks;
@@ -650,54 +649,25 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			dev_err(&s->unit->device,
 				"Detect jumbo payload: %02x %02x\n",
 				payload_quadlets, max_payload_quadlets);
-			s->packet_index = -1;
 			break;
 		}
 
 		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 		if (handle_in_packet(s, payload_quadlets, buffer,
-						&data_blocks, cycle, syt) < 0) {
-			s->packet_index = -1;
+						&data_blocks, cycle, syt) < 0)
 			break;
-		}
-
-		/* Process sync slave stream */
-		if (s->sync_slave && s->sync_slave->callbacked) {
-			if (handle_out_packet(s->sync_slave,
-					      data_blocks, cycle, syt) < 0) {
-				s->packet_index = -1;
-				break;
-			}
-		}
 	}
 
-	/* Queueing error or detecting discontinuity */
-	if (s->packet_index < 0) {
+	/* Queueing error or detecting invalid payload. */
+	if (p < packets) {
+		s->packet_index = -1;
 		amdtp_stream_pcm_abort(s);
-
-		/* Abort sync slave. */
-		if (s->sync_slave) {
-			s->sync_slave->packet_index = -1;
-			amdtp_stream_pcm_abort(s->sync_slave);
-		}
 		return;
 	}
 
-	/* when sync to device, flush the packets for slave stream */
-	if (s->sync_slave && s->sync_slave->callbacked)
-		fw_iso_context_queue_flush(s->sync_slave->context);
-
 	fw_iso_context_queue_flush(s->context);
 }
 
-/* processing is done by master callback */
-static void slave_stream_callback(struct fw_iso_context *context, u32 tstamp,
-				  size_t header_length, void *header,
-				  void *private_data)
-{
-	return;
-}
-
 /* this is executed one time */
 static void amdtp_stream_first_callback(struct fw_iso_context *context,
 					u32 tstamp, size_t header_length,
@@ -714,8 +684,6 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 
 	if (s->direction == AMDTP_IN_STREAM)
 		context->callback.sc = in_stream_callback;
-	else if (s->flags & CIP_SYNC_TO_DEVICE)
-		context->callback.sc = slave_stream_callback;
 	else
 		context->callback.sc = out_stream_callback;
 
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 8775704..da028b0 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -17,8 +17,6 @@
  * @CIP_BLOCKING: In blocking mode, each packet contains either zero or
  *	SYT_INTERVAL samples, with these two types alternating so that
  *	the overall sample rate comes out right.
- * @CIP_SYNC_TO_DEVICE: In sync to device mode, time stamp in out packets is
- *	generated by in packets. Defaultly this driver generates timestamp.
  * @CIP_EMPTY_WITH_TAG0: Only for in-stream. Empty in-packets have TAG0.
  * @CIP_DBC_IS_END_EVENT: Only for in-stream. The value of dbc in an in-packet
  *	corresponds to the end of event in the packet. Out of IEC 61883.
@@ -37,14 +35,13 @@
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
 	CIP_BLOCKING		= 0x01,
-	CIP_SYNC_TO_DEVICE	= 0x02,
-	CIP_EMPTY_WITH_TAG0	= 0x04,
-	CIP_DBC_IS_END_EVENT	= 0x08,
-	CIP_WRONG_DBS		= 0x10,
-	CIP_SKIP_DBC_ZERO_CHECK	= 0x20,
-	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
-	CIP_EMPTY_HAS_WRONG_DBC	= 0x80,
-	CIP_JUMBO_PAYLOAD	= 0x100,
+	CIP_EMPTY_WITH_TAG0	= 0x02,
+	CIP_DBC_IS_END_EVENT	= 0x04,
+	CIP_WRONG_DBS		= 0x08,
+	CIP_SKIP_DBC_ZERO_CHECK	= 0x10,
+	CIP_SKIP_INIT_DBC_CHECK	= 0x20,
+	CIP_EMPTY_HAS_WRONG_DBC	= 0x40,
+	CIP_JUMBO_PAYLOAD	= 0x80,
 };
 
 /**
@@ -137,7 +134,6 @@ struct amdtp_stream {
 	/* To wait for first packet. */
 	bool callbacked;
 	wait_queue_head_t callback_wait;
-	struct amdtp_stream *sync_slave;
 
 	/* For backends to process data blocks. */
 	void *protocol;
@@ -223,23 +219,6 @@ static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 	return sfc & 1;
 }
 
-static inline void amdtp_stream_set_sync(enum cip_flags sync_mode,
-					 struct amdtp_stream *master,
-					 struct amdtp_stream *slave)
-{
-	if (sync_mode == CIP_SYNC_TO_DEVICE) {
-		master->flags |= CIP_SYNC_TO_DEVICE;
-		slave->flags |= CIP_SYNC_TO_DEVICE;
-		master->sync_slave = slave;
-	} else {
-		master->flags &= ~CIP_SYNC_TO_DEVICE;
-		slave->flags &= ~CIP_SYNC_TO_DEVICE;
-		master->sync_slave = NULL;
-	}
-
-	slave->sync_slave = NULL;
-}
-
 /**
  * amdtp_stream_wait_callback - sleep till callbacked or timeout
  * @s: the AMDTP stream
-- 
2.7.4
