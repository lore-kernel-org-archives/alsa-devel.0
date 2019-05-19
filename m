From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] firewire-lib: use the same type of
	argument for CIP header for tracing event
Date: Sun, 19 May 2019 19:01:05 +0900
Message-ID: <20190519100109.14167-2-o-takashi@sakamocchi.jp>
References: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F762F8962F
 for <alsa-devel@alsa-project.org>; Sun, 19 May 2019 12:01:17 +0200 (CEST)
In-Reply-To: <20190519100109.14167-1-o-takashi@sakamocchi.jp>
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

An argument for CIP header in 'in_packet' event is not the same type in
'out_packet' event. This is not good to unify these events.

This commit uses the same type of argument for these events.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream-trace.h | 6 +++---
 sound/firewire/amdtp-stream.c       | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
index ac20acf48fc6..a86a827eab90 100644
--- a/sound/firewire/amdtp-stream-trace.h
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -14,7 +14,7 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(in_packet,
-	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 *cip_header, unsigned int payload_length, unsigned int index),
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, const __be32 *cip_header, unsigned int payload_length, unsigned int index),
 	TP_ARGS(s, cycles, cip_header, payload_length, index),
 	TP_STRUCT__entry(
 		__field(unsigned int, second)
@@ -35,8 +35,8 @@ TRACE_EVENT(in_packet,
 		__entry->channel = s->context->channel;
 		__entry->src = fw_parent_device(s->unit)->node_id;
 		__entry->dest = fw_parent_device(s->unit)->card->node_id;
-		__entry->cip_header0 = cip_header[0];
-		__entry->cip_header1 = cip_header[1];
+		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
+		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
 		__entry->payload_quadlets = payload_length / 4;
 		__entry->packet_index = s->packet_index;
 		__entry->irq = !!in_interrupt();
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 43f28b813386..2614fa551e24 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -555,7 +555,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
-	trace_in_packet(s, cycle, cip_header, payload_length, index);
+	trace_in_packet(s, cycle, buffer, payload_length, index);
 
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
-- 
2.20.1
