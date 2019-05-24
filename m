From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: firewire-lib: refactoring to
	obsolete IT packet handler
Date: Fri, 24 May 2019 18:03:41 +0900
Message-ID: <20190524090342.15619-4-o-takashi@sakamocchi.jp>
References: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75D8AF80C0F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 11:03:53 +0200 (CEST)
In-Reply-To: <20190524090342.15619-1-o-takashi@sakamocchi.jp>
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

As a result of heavy refactoring based on IT packet header, the packet
handler becomes simpler.

This commit merges the packet handler into function for IT context
callback. The logic to build IT packet header and tracepoints event is
split to a function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 62 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 8a7da86650ea..03ed2757dfc8 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -485,54 +485,36 @@ static void generate_cip_header(struct amdtp_stream *s, __be32 cip_header[2],
 			(syt & CIP_SYT_MASK));
 }
 
-static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
-			     const __be32 *ctx_header, __be32 *buffer,
-			     unsigned int index)
+static void build_it_pkt_header(struct amdtp_stream *s, unsigned int cycle,
+				struct fw_iso_packet *params,
+				unsigned int data_blocks, unsigned int syt,
+				unsigned int index)
 {
-	unsigned int syt;
-	unsigned int data_blocks;
 	__be32 *cip_header;
-	unsigned int pcm_frames;
-	struct snd_pcm_substream *pcm;
-	struct {
-		struct fw_iso_packet params;
-		__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
-	} template = { {0}, {0} };
 
-	syt = calculate_syt(s, cycle);
-	data_blocks = calculate_data_blocks(s, syt);
-	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
-
-	if (s->flags & CIP_DBC_IS_END_EVENT)
+	if (s->flags & CIP_DBC_IS_END_EVENT) {
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
+	}
 
 	if (!(s->flags & CIP_NO_HEADER)) {
-		cip_header = (__be32 *)template.params.header;
+		cip_header = (__be32 *)params->header;
 		generate_cip_header(s, cip_header, syt);
-		template.params.header_length = 2 * sizeof(__be32);
+		params->header_length = 2 * sizeof(__be32);
 	} else {
 		cip_header = NULL;
 	}
 
-	if (!(s->flags & CIP_DBC_IS_END_EVENT))
+	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		s->data_block_counter =
 				(s->data_block_counter + data_blocks) & 0xff;
+	}
 
-	template.params.payload_length =
+	params->payload_length =
 			data_blocks * sizeof(__be32) * s->data_block_quadlets;
 
-	trace_amdtp_packet(s, cycle, cip_header, template.params.payload_length,
+	trace_amdtp_packet(s, cycle, cip_header, params->payload_length,
 			   data_blocks, index);
-
-	if (queue_out_packet(s, &template.params) < 0)
-		return -EIO;
-
-	pcm = READ_ONCE(s->pcm);
-	if (pcm && pcm_frames > 0)
-		update_pcm_pointers(s, pcm, pcm_frames);
-
-	return 0;
 }
 
 static int check_cip_header(struct amdtp_stream *s, const __be32 *buf,
@@ -741,16 +723,34 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		u32 cycle;
+		unsigned int syt;
+		unsigned int data_block;
 		__be32 *buffer;
+		unsigned int pcm_frames;
+		struct {
+			struct fw_iso_packet params;
+			__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
+		} template = { {0}, {0} };
+		struct snd_pcm_substream *pcm;
 
 		cycle = compute_it_cycle(*ctx_header);
+		syt = calculate_syt(s, cycle);
+		data_block = calculate_data_blocks(s, syt);
 		buffer = s->buffer.packets[s->packet_index].buffer;
+		pcm_frames = s->process_data_blocks(s, buffer, data_block, &syt);
 
-		if (handle_out_packet(s, cycle, ctx_header, buffer, i) < 0) {
+		build_it_pkt_header(s, cycle, &template.params, data_block, syt,
+				    i);
+
+		if (queue_out_packet(s, &template.params) < 0) {
 			cancel_stream(s);
 			return;
 		}
 
+		pcm = READ_ONCE(s->pcm);
+		if (pcm && pcm_frames > 0)
+			update_pcm_pointers(s, pcm, pcm_frames);
+
 		++ctx_header;
 	}
 
-- 
2.20.1
