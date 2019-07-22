From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/20] ALSA: firewire-lib: pass data block
	count as an argument to tracepoints event
Date: Mon, 22 Jul 2019 12:36:52 +0900
Message-ID: <20190722033710.28107-3-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AEDAF803D1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:19 +0200 (CEST)
In-Reply-To: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
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

This is a preparation for future commit that 'struct
amdtp_stream.data_block_count' does not represent the value of
data block count for current data block.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 6 +++---
 sound/firewire/amdtp-stream.c       | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index 4adbbf789cbe..16c7f6605511 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -14,8 +14,8 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(amdtp_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int index),
-	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int data_blocks, unsigned int data_block_counter, unsigned int index),
+	TP_ARGS(s, cycles, cip_header, payload_length, data_blocks, data_block_counter, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
 		__field(unsigned int, cycle)
@@ -47,7 +47,7 @@ TRACE_EVENT(amdtp_packet,
 		}
 		__entry->payload_quadlets = payload_length / sizeof(__be32);
 		__entry->data_blocks = data_blocks;
-		__entry->data_block_counter = s->data_block_counter,
+		__entry->data_block_counter = data_block_counter,
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
 		__entry->index = index;
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index fc1e8e5b9429..fe1512905a43 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -511,7 +511,7 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 	}
 
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
-			   index);
+			   s->data_block_counter, index);
 
 	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		s->data_block_counter =
@@ -653,7 +653,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	s->data_block_counter = dbc;
 
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
-			   index);
+			   s->data_block_counter, index);
 
 	return err;
 }
-- 
2.20.1
