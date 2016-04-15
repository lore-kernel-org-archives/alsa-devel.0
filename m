From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] firewire-lib: compute the value of second
	field in cycle count for IR context
Date: Sat, 16 Apr 2016 01:23:23 +0900
Message-ID: <1460737404-19699-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id E1C87265162
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

In callback function of isochronous context, modules can queue packets to
certain isochronous cycles. Although the cycle to queue a packet is
deterministic by calculation, this module don't implement the calculation
because it's useless for processing.

In future, the cycle count is going to be printed with Linux tracing
framework to help developers.

This commit is the preparation. The cycle count is computed by cycle unit,
and correctly arranged for corresponding packets.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 46f1167..4d86da0 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -566,6 +566,13 @@ static inline u32 increment_cycle_count(u32 cycle, unsigned int addend)
 	return cycle;
 }
 
+static inline u32 decrement_cycle_count(u32 cycle, unsigned int subtrahend)
+{
+	if (cycle < subtrahend)
+		cycle += 8 * CYCLES_PER_SECOND;
+	return cycle - subtrahend;
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 				size_t header_length, void *header,
 				void *private_data)
@@ -607,6 +614,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	unsigned int payload_quadlets, max_payload_quadlets;
 	unsigned int data_blocks;
 	__be32 *buffer, *headers = header;
+	u32 cycle;
 
 	if (s->packet_index < 0)
 		return;
@@ -614,10 +622,16 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	/* The number of packets in buffer */
 	packets = header_length / IN_PACKET_HEADER_SIZE;
 
+	cycle = compute_cycle_count(tstamp);
+
+	/* Align to actual cycle count for the last packet. */
+	cycle = decrement_cycle_count(cycle, packets);
+
 	/* For buffer-over-run prevention. */
 	max_payload_quadlets = amdtp_stream_get_max_payload(s) / 4;
 
 	for (p = 0; p < packets; p++) {
+		cycle = increment_cycle_count(cycle, 1);
 		buffer = s->buffer.packets[s->packet_index].buffer;
 
 		/* The number of quadlets in this packet */
-- 
2.7.4
