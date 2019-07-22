From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/20] ALSA: firewire-lib: use packet
	descriptor for IT context
Date: Mon, 22 Jul 2019 12:36:59 +0900
Message-ID: <20190722033710.28107-10-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91CC1F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:30 +0200 (CEST)
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

This commit uses packet descriptor to parse headers of IT context and
generate timing information for ideal sequence.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 68 ++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 2bea15151d4a..463c7a340a45 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -676,6 +676,38 @@ static inline u32 compute_it_cycle(const __be32 ctx_header_tstamp)
 	return increment_cycle_count(cycle, QUEUE_LENGTH);
 }
 
+static void generate_ideal_pkt_descs(struct amdtp_stream *s,
+				     struct pkt_desc *descs,
+				     const __be32 *ctx_header,
+				     unsigned int packets)
+{
+	unsigned int dbc = s->data_block_counter;
+	int i;
+
+	for (i = 0; i < packets; ++i) {
+		struct pkt_desc *desc = descs + i;
+		unsigned int index = (s->packet_index + i) % QUEUE_LENGTH;
+
+		desc->cycle = compute_cycle_count(*ctx_header);
+		desc->syt = calculate_syt(s, desc->cycle);
+		desc->data_blocks = calculate_data_blocks(s, desc->syt);
+
+		if (s->flags & CIP_DBC_IS_END_EVENT)
+			dbc = (dbc + desc->data_blocks) & 0xff;
+
+		desc->data_block_counter = dbc;
+
+		if (!(s->flags & CIP_DBC_IS_END_EVENT))
+			dbc = (dbc + desc->data_blocks) & 0xff;
+
+		desc->ctx_payload = s->buffer.packets[index].buffer;
+
+		++ctx_header;
+	}
+
+	s->data_block_counter = dbc;
+}
+
 static inline void cancel_stream(struct amdtp_stream *s)
 {
 	s->packet_index = -1;
@@ -696,39 +728,29 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	if (s->packet_index < 0)
 		return;
 
+	generate_ideal_pkt_descs(s, s->pkt_descs, ctx_header, packets);
+
 	for (i = 0; i < packets; ++i) {
-		u32 cycle;
-		unsigned int syt;
-		unsigned int data_blocks;
-		unsigned int dbc;
-		__be32 *buffer;
+		const struct pkt_desc *desc = s->pkt_descs + i;
 		unsigned int pcm_frames;
+		unsigned int syt;
 		struct {
 			struct fw_iso_packet params;
 			__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
 		} template = { {0}, {0} };
 		struct snd_pcm_substream *pcm;
 
-		cycle = compute_it_cycle(*ctx_header);
-		syt = calculate_syt(s, cycle);
-		data_blocks = calculate_data_blocks(s, syt);
-		buffer = s->buffer.packets[s->packet_index].buffer;
-		dbc = s->data_block_counter;
-		pcm_frames = s->process_data_blocks(s, buffer, data_blocks, dbc);
+		pcm_frames = s->process_data_blocks(s, desc->ctx_payload,
+				desc->data_blocks, desc->data_block_counter);
 
-		if (s->flags & CIP_DBC_IS_END_EVENT)
-			dbc = (dbc + data_blocks) & 0xff;
-
-		if (s->ctx_data.rx.syt_override >= 0)
+		if (s->ctx_data.rx.syt_override < 0)
+			syt = desc->syt;
+		else
 			syt = s->ctx_data.rx.syt_override;
 
-		build_it_pkt_header(s, cycle, &template.params, data_blocks,
-				    dbc, syt, i);
-
-		if (!(s->flags & CIP_DBC_IS_END_EVENT))
-			dbc = (dbc + data_blocks) & 0xff;
-
-		s->data_block_counter = dbc;
+		build_it_pkt_header(s, desc->cycle, &template.params,
+				    desc->data_blocks, desc->data_block_counter,
+				    syt, i);
 
 		if (queue_out_packet(s, &template.params) < 0) {
 			cancel_stream(s);
@@ -738,8 +760,6 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		pcm = READ_ONCE(s->pcm);
 		if (pcm && pcm_frames > 0)
 			update_pcm_pointers(s, pcm, pcm_frames);
-
-		++ctx_header;
 	}
 
 	fw_iso_context_queue_flush(s->context);
-- 
2.20.1
