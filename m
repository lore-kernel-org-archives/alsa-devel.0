From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: allocate additional
	entries for list of packet descriptor to avoid out-of-bounds access
Date: Sun, 25 Aug 2019 15:52:47 +0900
Message-ID: <20190825065247.26840-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 253C6F801ED
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2019 08:52:54 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch is for Linux v5.3-rc7.

In a case of delay to execute scheduled tasklet for isoc context, it's
possible to handle queued packets than 16 (=INTERRUPT_INTERVAL). In the
case, out-of-bounds access occurs because the list of packet descriptor
is allocated just for 16 packets. This causes any negative effects in
kernel memory or software IRQ context.

It's quite rare because current implementation allows user processes to
flush the queued packet in process context by executing several PCM
ioctl(2) commands. However, it's good to prevent.

This commit is a prevention against this bug. For safe, the allocation is
done for 16 plus 12 packets, equivalent to 1.5 msec plus. Furthermore,
when detecting the case, packet streaming is cancelled and kernel log is
printed to notice to users and developers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 1a92855c7647..f03321888997 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -56,6 +56,11 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
+// For jitter of software IRQ execution, keep more entries for the list
+// of packet descriptor equivalent to 1.5 msec to avoid out-of-bounds
+// access to process queued packets.
+#define DESC_COUNT	(INTERRUPT_INTERVAL + 12)
+
 // For iso header, tstamp and 2 CIP header.
 #define IR_CTX_HEADER_SIZE_CIP		16
 // For iso header and tstamp.
@@ -779,12 +784,22 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 {
 	struct amdtp_stream *s = private_data;
 	const __be32 *ctx_header = header;
-	unsigned int packets = header_length / sizeof(*ctx_header);
+	unsigned int packets;
 	int i;
 
 	if (s->packet_index < 0)
 		return;
 
+	// The number of packets in buffer.
+	packets = header_length / sizeof(*ctx_header);
+	if (packets > DESC_COUNT) {
+		cancel_stream(s);
+		dev_info(&s->unit->device,
+			 "out-stream: Unexpected count of packet: %d\n",
+			 packets);
+		return;
+	}
+
 	generate_ideal_pkt_descs(s, s->pkt_descs, ctx_header, packets);
 
 	process_ctx_payloads(s, s->pkt_descs, packets);
@@ -830,6 +845,13 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	// The number of packets in buffer.
 	packets = header_length / s->ctx_data.tx.ctx_header_size;
+	if (packets > DESC_COUNT) {
+		cancel_stream(s);
+		dev_info(&s->unit->device,
+			 "in-stream: Unexpected count of packet: %d\n",
+			 packets);
+		return;
+	}
 
 	err = generate_device_pkt_descs(s, s->pkt_descs, ctx_header, packets);
 	if (err < 0) {
@@ -981,8 +1003,7 @@ static int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	else
 		s->tag = TAG_CIP;
 
-	s->pkt_descs = kcalloc(INTERRUPT_INTERVAL, sizeof(*s->pkt_descs),
-			       GFP_KERNEL);
+	s->pkt_descs = kcalloc(DESC_COUNT, sizeof(*s->pkt_descs), GFP_KERNEL);
 	if (!s->pkt_descs) {
 		err = -ENOMEM;
 		goto err_context;
-- 
2.20.1
