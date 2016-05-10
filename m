From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: add context information to
	tracepoints
Date: Wed, 11 May 2016 07:33:27 +0900
Message-ID: <1462919607-8574-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id E69C226640F
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 00:33:32 +0200 (CEST)
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

In current implementation, packet processing is done in both of software
IRQ contexts of IR/IT contexts and process contexts.

This is usual interrupt handling of IR/IT context for 1394 OHCI.
(in hardware IRQ context)
irq_handler() (drivers/firewire/ohci.c)
->tasklet_schedule()
(in software IRQ context)
handle_it_packet() or handle_ir_packet_per_buffer() (drivers/firewire/ohci.c)
->flush_iso_completions()
  ->struct fw_iso_context.callback.sc()
  = out_stream_callback() or in_stream_callback()

However, we have another chance for packet processing. It's done in PCM
frame handling via ALSA PCM interfaces.
(in process context)
ioctl(i.e. SNDRV_PCM_IOCTL_HWSYNC)
->snd_pcm_hwsync() (sound/core/pcm_native.c)
  ->snd_pcm_update_hw_ptr() (sound/core/pcm_lib.c)
    ->snd_pcm_update_hw_ptr0()
      ->struct snd_pcm_ops.pointer()
      = amdtp_stream_pcm_pointer()
        ->fw_iso_context_flush_completions() (drivers/firewire/core-iso.c)
          ->struct fw_card_driver.flush_iso_completions()
          = ohci_flush_iso_completions() (drivers/firewire/ohci.c)
            ->flush_iso_completions()
              ->struct fw_iso_context.callback.sc()
              = out_stream_callback() or in_stream_callback()

This design is for a better granularity of PCM pointer. When ioctl(2) is
executed with some commands for ALSA PCM interface, queued packets are
handled at first. Then, the latest number of handled PCM frames is
reported. The number can represent PCM frames transferred in most near
isochronous cycle.

Current tracepoints include no information to distinguish running contexts.
When tracing the interval of software IRQ context, this is not good.

This commit adds more information for current context. Additionally, the
index of packet processed in one context is added in a case that packet
processing is executed in continuous context of the same kind,

As a result, the output includes 11 fields with additional two fields
to commit 0c95c1d6197f ("ALSA: firewire-lib: add tracepoints to dump a part
of isochronous packet data"):
17131.9186: out_packet: 07 7494 ffc0 ffc1 00 000700c0 9001a496 058 45 1 13
17131.9186: out_packet: 07 7495 ffc0 ffc1 00 000700c8 9001ba00 058 46 1 14
17131.9186: out_packet: 07 7496 ffc0 ffc1 00 000700d0 9001ffff 002 47 1 15
17131.9189: out_packet: 07 7497 ffc0 ffc1 00 000700d0 9001d36a 058 00 0 00
17131.9189: out_packet: 07 7498 ffc0 ffc1 00 000700d8 9001e8d4 058 01 0 01
17131.9189: out_packet: 07 7499 ffc0 ffc1 00 000700e0 9001023e 058 02 0 00
17131.9206: in_packet:  07 7447 ffc1 ffc0 01 3f070072 9001783d 058 32 1 00
17131.9206: in_packet:  07 7448 ffc1 ffc0 01 3f070072 90ffffff 002 33 1 01
17131.9206: in_packet:  07 7449 ffc1 ffc0 01 3f07007a 900191a8 058 34 1 02
(Here, some common fields are omitted so that a line is within 80
characters.)

The legend is:
 - The second of cycle scheduled for the packet
 - The count of cycle scheduled for the packet
 - The ID of node as source (hex)
 - The ID of node as destination (hex)
 - The value of isochronous channel
 - The first quadlet of CIP header (hex)
 - The second quadlet of CIP header (hex)
 - The number of included quadlets
 - The index of packet in a buffer maintained by this module
 - 0 in process context, 1 in IRQ context
 - The index of packet processed in the context

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 28 ++++++++++++++++++++--------
 sound/firewire/amdtp-stream.c       | 14 ++++++++------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 425d1d7..1622579 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -14,8 +14,8 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(in_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 cip_header[2], unsigned int payload_quadlets),
-	TP_ARGS(s, cycles, cip_header, payload_quadlets),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 cip_header[2], unsigned int payload_quadlets, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_quadlets, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -25,6 +25,8 @@ TRACE_EVENT(in_packet,
 		__field(u32, cip_header0)
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, packet_index)
+		__field(bool, irq)
 		__field(unsigned int, index)
 	),
 	TP_fast_assign(
@@ -36,10 +38,12 @@ TRACE_EVENT(in_packet,
 		__entry->cip_header0 = cip_header[0];
 		__entry->cip_header1 = cip_header[1];
 		__entry->payload_quadlets = payload_quadlets;
-		__entry->index = s->packet_index;
+		__entry->packet_index = s->packet_index;
+		__entry->irq = in_interrupt();
+		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u",
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
@@ -48,12 +52,14 @@ TRACE_EVENT(in_packet,
 		__entry->cip_header0,
 		__entry->cip_header1,
 		__entry->payload_quadlets,
+		__entry->packet_index,
+		__entry->irq,
 		__entry->index)
 );
 
 TRACE_EVENT(out_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, __be32 *cip_header, unsigned int payload_length),
-	TP_ARGS(s, cycles, cip_header, payload_length),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, __be32 *cip_header, unsigned int payload_length, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_length, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -63,6 +69,8 @@ TRACE_EVENT(out_packet,
 		__field(u32, cip_header0)
 		__field(u32, cip_header1)
 		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, packet_index)
+		__field(bool, irq)
 		__field(unsigned int, index)
 	),
 	TP_fast_assign(
@@ -74,10 +82,12 @@ TRACE_EVENT(out_packet,
 		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
 		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
 		__entry->payload_quadlets = payload_length / 4;
-		__entry->index = s->packet_index;
+		__entry->packet_index = s->packet_index;
+		__entry->irq = in_interrupt();
+		__entry->index = index;
 	),
 	TP_printk(
-		"%02u %04u %04x %04x %02d %08x %08x %03u %02u",
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u %01u %02u",
 		__entry->second,
 		__entry->cycle,
 		__entry->src,
@@ -86,6 +96,8 @@ TRACE_EVENT(out_packet,
 		__entry->cip_header0,
 		__entry->cip_header1,
 		__entry->payload_quadlets,
+		__entry->packet_index,
+		__entry->irq,
 		__entry->index)
 );
 
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index e7163bd..db30fac4 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -411,7 +411,8 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s));
 }
 
-static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
+static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
+			     unsigned int index)
 {
 	__be32 *buffer;
 	unsigned int syt;
@@ -436,7 +437,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 
-	trace_out_packet(s, cycle, buffer, payload_length);
+	trace_out_packet(s, cycle, buffer, payload_length, index);
 
 	if (queue_out_packet(s, payload_length) < 0)
 		return -EIO;
@@ -450,7 +451,8 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 }
 
 static int handle_in_packet(struct amdtp_stream *s,
-			    unsigned int payload_quadlets, unsigned int cycle)
+			    unsigned int payload_quadlets, unsigned int cycle,
+			    unsigned int index)
 {
 	__be32 *buffer;
 	u32 cip_header[2];
@@ -465,7 +467,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
-	trace_in_packet(s, cycle, cip_header, payload_quadlets);
+	trace_in_packet(s, cycle, cip_header, payload_quadlets, index);
 
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
@@ -604,7 +606,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		cycle = increment_cycle_count(cycle, 1);
-		if (handle_out_packet(s, cycle) < 0) {
+		if (handle_out_packet(s, cycle, i) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
@@ -651,7 +653,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			break;
 		}
 
-		if (handle_in_packet(s, payload_quadlets, cycle) < 0)
+		if (handle_in_packet(s, payload_quadlets, cycle, i) < 0)
 			break;
 	}
 
-- 
2.7.4
