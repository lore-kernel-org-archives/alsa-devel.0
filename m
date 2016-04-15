From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] firewire-lib: compute the value of second
	field in cycle count for IT context
Date: Sat, 16 Apr 2016 01:23:22 +0900
Message-ID: <1460737404-19699-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E0BF626510C
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 18:23:34 +0200 (CEST)
In-Reply-To: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In callback function of isochronous context, u32 variable is passed for
cycle count. The value of this variable comes from DMA descriptors of 1394
Open Host Controller Interface (1394 OHCI), therefore lower 16 bits have
meanings. The upper 4 bits represent second and the rest 12 bits represent
cycle. As a result, the value for second is modulo 8, and the value for
cycle is modulo 8,000.

Currently, ALSA firewire-lib module don't use the value of second field,
because the value is not useless to calculate something required. However,
the value may be useful for debugging. In later commit, it will be printed
with the other parameters for debugging.

This commit makes the module to handle the whole value including second.
The value is calculated by cycle unit. The existed code is already written
with ignoring the value of second, thus this commit can cause no issues.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 4484242..46f1167 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -548,26 +548,44 @@ end:
 	return 0;
 }
 
-static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
+/*
+ * In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
+ * the other hand, in DMA descriptors of 1394 OHCI, 3 bits are used to represent
+ * it. Thus, via Linux firewire subsystem, we can get the 3 bits for second.
+ */
+static inline u32 compute_cycle_count(u32 tstamp)
+{
+	return (((tstamp >> 13) & 0x07) * 8000) + (tstamp & 0x1fff);
+}
+
+static inline u32 increment_cycle_count(u32 cycle, unsigned int addend)
+{
+	cycle += addend;
+	if (cycle >= 8 * CYCLES_PER_SECOND)
+		cycle -= 8 * CYCLES_PER_SECOND;
+	return cycle;
+}
+
+static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				size_t header_length, void *header,
 				void *private_data)
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, syt, packets = header_length / 4;
 	unsigned int data_blocks;
+	u32 cycle;
 
 	if (s->packet_index < 0)
 		return;
 
-	/*
-	 * Compute the cycle of the last queued packet.
-	 * (We need only the four lowest bits for the SYT, so we can ignore
-	 * that bits 0-11 must wrap around at 3072.)
-	 */
-	cycle += QUEUE_LENGTH - packets;
+	cycle = compute_cycle_count(tstamp);
+
+	/* Align to actual cycle count for the last packet. */
+	cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
 
 	for (i = 0; i < packets; ++i) {
-		syt = calculate_syt(s, ++cycle);
+		cycle = increment_cycle_count(cycle, 1);
+		syt = calculate_syt(s, cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 
 		if (handle_out_packet(s, data_blocks, syt) < 0) {
@@ -580,7 +598,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 	fw_iso_context_queue_flush(s->context);
 }
 
-static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
+static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			       size_t header_length, void *header,
 			       void *private_data)
 {
@@ -650,7 +668,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 }
 
 /* processing is done by master callback */
-static void slave_stream_callback(struct fw_iso_context *context, u32 cycle,
+static void slave_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				  size_t header_length, void *header,
 				  void *private_data)
 {
@@ -659,7 +677,7 @@ static void slave_stream_callback(struct fw_iso_context *context, u32 cycle,
 
 /* this is executed one time */
 static void amdtp_stream_first_callback(struct fw_iso_context *context,
-					u32 cycle, size_t header_length,
+					u32 tstamp, size_t header_length,
 					void *header, void *private_data)
 {
 	struct amdtp_stream *s = private_data;
@@ -678,7 +696,7 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 	else
 		context->callback.sc = out_stream_callback;
 
-	context->callback.sc(context, cycle, header_length, header, s);
+	context->callback.sc(context, tstamp, header_length, header, s);
 }
 
 /**
-- 
2.7.4
