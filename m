From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/7] ALSA: firewire-lib: code refactoring for
	post operation to data block counter
Date: Sun,  7 Jul 2019 21:07:58 +0900
Message-ID: <20190707120759.16371-7-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6824F8026F
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:15 +0200 (CEST)
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

As a result of former commits, post operation to data block count for
cases without CIP_DBC_IS_END_EVENT can be done just with
data_block_counter member of amdtp_stream structure.

This commit adds code refactoring to obsolete local variable for
data block counter.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 8c4564a560f6..81af191627db 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -616,9 +616,10 @@ static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
 static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 			       const __be32 *ctx_header,
 			       unsigned int *payload_length,
-			       unsigned int *data_blocks, unsigned int *dbc,
-			       unsigned int *syt, unsigned int index)
+			       unsigned int *data_blocks, unsigned int *syt,
+			       unsigned int index)
 {
+	unsigned int dbc;
 	const __be32 *cip_header;
 	int err;
 
@@ -634,7 +635,7 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 	if (!(s->flags & CIP_NO_HEADER)) {
 		cip_header = ctx_header + 2;
 		err = check_cip_header(s, cip_header, *payload_length,
-				       data_blocks, dbc, syt);
+				       data_blocks, &dbc, syt);
 		if (err < 0)
 			return err;
 	} else {
@@ -645,12 +646,12 @@ static int parse_ir_ctx_header(struct amdtp_stream *s, unsigned int cycle,
 		*syt = 0;
 
 		if (s->data_block_counter != UINT_MAX)
-			*dbc = s->data_block_counter;
+			dbc = s->data_block_counter;
 		else
-			*dbc = 0;
+			dbc = 0;
 	}
 
-	s->data_block_counter = *dbc;
+	s->data_block_counter = dbc;
 
 	trace_amdtp_packet(s, cycle, cip_header, *payload_length, *data_blocks,
 			   index);
@@ -758,7 +759,6 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		u32 cycle;
 		unsigned int payload_length;
 		unsigned int data_blocks;
-		unsigned int dbc;
 		unsigned int syt;
 		__be32 *buffer;
 		unsigned int pcm_frames = 0;
@@ -768,7 +768,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		cycle = compute_cycle_count(ctx_header[1]);
 		err = parse_ir_ctx_header(s, cycle, ctx_header, &payload_length,
-					  &data_blocks, &dbc, &syt, i);
+					  &data_blocks, &syt, i);
 		if (err < 0 && err != -EAGAIN)
 			break;
 
@@ -778,8 +778,8 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 							    data_blocks, &syt);
 
 			if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
-				s->data_block_counter =
-						(dbc + data_blocks) & 0xff;
+				s->data_block_counter += data_blocks;
+				s->data_block_counter &= 0xff;
 			}
 		}
 
-- 
2.20.1
