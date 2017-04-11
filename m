From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: cache maximum length of
	payload to reduce function calls
Date: Tue, 11 Apr 2017 20:33:18 +0900
Message-ID: <20170411113318.10977-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D15B6266718
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 13:33:23 +0200 (CEST)
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

During packet streaming, maximum length of payload for isochronous packet
is invariable, therefore no need to recalculate. Current ALSA IEC 61883-1/6
engine calls a function to calculate it 8,000 or more times per second
for incoming packet processing.

This commit adds a member to have maximum length of payload into 'struct
amdtp_stream', to reduces the function calls. At first callback from
isochronous context, the length is calculated and stored for later
processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 9 +++++----
 sound/firewire/amdtp-stream.h | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f6af8e6..9e6f54f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -412,8 +412,7 @@ static inline int queue_out_packet(struct amdtp_stream *s,
 
 static inline int queue_in_packet(struct amdtp_stream *s)
 {
-	return queue_packet(s, IN_PACKET_HEADER_SIZE,
-			    amdtp_stream_get_max_payload(s));
+	return queue_packet(s, IN_PACKET_HEADER_SIZE, s->max_payload_length);
 }
 
 static int handle_out_packet(struct amdtp_stream *s,
@@ -713,12 +712,12 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	cycle = decrement_cycle_count(cycle, packets);
 
 	/* For buffer-over-run prevention. */
-	max_payload_length = amdtp_stream_get_max_payload(s);
+	max_payload_length = s->max_payload_length;
 
 	for (i = 0; i < packets; i++) {
 		cycle = increment_cycle_count(cycle, 1);
 
-		/* The number of quadlets in this packet */
+		/* The number of bytes in this packet */
 		payload_length =
 			(be32_to_cpu(headers[i]) >> ISO_DATA_LENGTH_SHIFT);
 		if (payload_length > max_payload_length) {
@@ -751,6 +750,8 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 	u32 cycle;
 	unsigned int packets;
 
+	s->max_payload_length = amdtp_stream_get_max_payload(s);
+
 	/*
 	 * For in-stream, first packet has come.
 	 * For out-stream, prepared to transmit first packet
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 2bd4de4..7e88317 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -110,6 +110,7 @@ struct amdtp_stream {
 	int (*handle_packet)(struct amdtp_stream *s,
 			unsigned int payload_quadlets, unsigned int cycle,
 			unsigned int index);
+	unsigned int max_payload_length;
 
 	/* For CIP headers. */
 	unsigned int source_node_id_field;
-- 
2.9.3
