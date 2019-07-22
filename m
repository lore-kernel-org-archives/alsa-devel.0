From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/20] ALSA: firewire-lib: operate data block
	counter in top level of processing for IT context
Date: Mon, 22 Jul 2019 12:36:54 +0900
Message-ID: <20190722033710.28107-5-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E41BF8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:23 +0200 (CEST)
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

In ALSA IEC 61883-1/6 packet streaming engine, two types of data block
counter are supported. This commit applies code refactoring to make it
explicitly for IT context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 39 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 40de9fc9d751..c89083ccd729 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -473,12 +473,12 @@ static inline int queue_in_packet(struct amdtp_stream *s,
 }
 
 static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
-				unsigned int syt)
+			unsigned int data_block_counter, unsigned int syt)
 {
 	cip_header[0] = cpu_to_be32(READ_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				((s->sph << CIP_SPH_SHIFT) & CIP_SPH_MASK) |
-				s->data_block_counter);
+				data_block_counter);
 	cip_header[1] = cpu_to_be32(CIP_EOH |
 			((s->fmt << CIP_FMT_SHIFT) & CIP_FMT_MASK) |
 			((s->ctx_data.rx.fdf << CIP_FDF_SHIFT) & CIP_FDF_MASK) |
@@ -487,8 +487,9 @@ static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
 
 static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 				struct fw_iso_packet *params,
-				unsigned int data_blocks, unsigned int syt,
-				unsigned int index)
+				unsigned int data_blocks,
+				unsigned int data_block_counter,
+				unsigned int syt, unsigned int index)
 {
 	unsigned int payload_length;
 	__be32 *cip_header;
@@ -496,14 +497,9 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 	payload_length = data_blocks * sizeof(__be32) * s->data_block_quadlets;
 	params->payload_length = payload_length;
 
-	if (s->flags & CIP_DBC_IS_END_EVENT) {
-		s->data_block_counter =
-				(s->data_block_counter + data_blocks) & 0xff;
-	}
-
 	if (!(s->flags & CIP_NO_HEADER)) {
 		cip_header = (__be32 *)params->header;
-		generate_cip_header(s, cip_header, syt);
+		generate_cip_header(s, cip_header, data_block_counter, syt);
 		params->header_length = 2 * sizeof(__be32);
 		payload_length += params->header_length;
 	} else {
@@ -511,12 +507,7 @@ static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
 	}
 
 	trace_amdtp_packet(s, cycle, cip_header, payload_length, data_blocks,
-			   s->data_block_counter, index);
-
-	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
-		s->data_block_counter =
-				(s->data_block_counter + data_blocks) & 0xff;
-	}
+			   data_block_counter, index);
 }
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
@@ -709,6 +700,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		u32 cycle;
 		unsigned int syt;
 		unsigned int data_blocks;
+		unsigned int dbc;
 		__be32 *buffer;
 		unsigned int pcm_frames;
 		struct {
@@ -721,11 +713,20 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		syt = calculate_syt(s, cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 		buffer = s->buffer.packets[s->packet_index].buffer;
-		pcm_frames = s->process_data_blocks(s, buffer, data_blocks,
-						s->data_block_counter, &syt);
+		dbc = s->data_block_counter;
+		pcm_frames = s->process_data_blocks(s, buffer, data_blocks, dbc,
+						    &syt);
+
+		if (s->flags & CIP_DBC_IS_END_EVENT)
+			dbc = (dbc + data_blocks) & 0xff;
 
 		build_it_pkt_header(s, cycle, &template.params, data_blocks,
-				    syt, i);
+				    dbc, syt, i);
+
+		if (!(s->flags & CIP_DBC_IS_END_EVENT))
+			dbc = (dbc + data_blocks) & 0xff;
+
+		s->data_block_counter = dbc;
 
 		if (queue_out_packet(s, &template.params) < 0) {
 			cancel_stream(s);
-- 
2.20.1
