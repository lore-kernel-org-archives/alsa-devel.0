From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/7] ALSA: firewire-lib: fix invalid length of
	rx packet payload for tracepoint events
Date: Sun,  7 Jul 2019 21:07:53 +0900
Message-ID: <20190707120759.16371-2-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67D8EF801A4
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:07 +0200 (CEST)
In-Reply-To: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
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

Although CIP header is handled as context header, the length of isochronous
packet includes two quadlets for its payload. In tracepoints event the
value of payload_quadlets should includes the two quadlets. But at present
it doesn't.

This commit fixes the bug.

Fixes: b18f0cfaf16b ("ALSA: firewire-lib: use 8 byte packet header for IT context to separate CIP header from CIP payload")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 91b890241840..6c9f4d026505 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -490,8 +490,12 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 				unsigned int data_blocks, unsigned int syt,
 				unsigned int index)
 {
+	unsigned int payload_length;
 	__be32 *cip_header;
 
+	payload_length = data_blocks * sizeof(__be32) * s->data_block_quadlets;
+	params->payload_length = payload_length;
+
 	if (s->flags & CIP_DBC_IS_END_EVENT) {
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
@@ -501,6 +505,7 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 		cip_header = (__be32 *)params->header;
 		generate_cip_header(s, cip_header, syt);
 		params->header_length = 2 * sizeof(__be32);
+		payload_length += params->header_length;
 	} else {
 		cip_header = NULL;
 	}
@@ -510,11 +515,8 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 				(s->data_block_counter + data_blocks) & 0xff;
 	}
 
-	params->payload_length =
-			data_blocks * sizeof(__be32) * s->data_block_quadlets;
-
-	trace_amdtp_packet(s, cycle, cip_header, params->payload_length,
-			   data_blocks, index);
+	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
+			   index);
 }
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
-- 
2.20.1
