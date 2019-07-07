From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/7] ALSA: firewire-lib: code refactoring for
	local variables
Date: Sun,  7 Jul 2019 21:07:59 +0900
Message-ID: <20190707120759.16371-8-o-takashi@sakamocchi.jp>
References: <20190707120759.16371-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C35CF80290
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 14:08:17 +0200 (CEST)
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

It's better to use int type for loop index. For consistency, the name
of local variable for the number of data block should be plural.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 81af191627db..51f97df81dbf 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -700,7 +700,8 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 {
 	struct amdtp_stream *s = private_data;
 	const __be32 *ctx_header = header;
-	unsigned int i, packets = header_length / sizeof(*ctx_header);
+	unsigned int packets = header_length / sizeof(*ctx_header);
+	int i;
 
 	if (s->packet_index < 0)
 		return;
@@ -708,7 +709,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	for (i = 0; i < packets; ++i) {
 		u32 cycle;
 		unsigned int syt;
-		unsigned int data_block;
+		unsigned int data_blocks;
 		__be32 *buffer;
 		unsigned int pcm_frames;
 		struct {
@@ -719,12 +720,13 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		cycle = compute_it_cycle(*ctx_header);
 		syt = calculate_syt(s, cycle);
-		data_block = calculate_data_blocks(s, syt);
+		data_blocks = calculate_data_blocks(s, syt);
 		buffer = s->buffer.packets[s->packet_index].buffer;
-		pcm_frames = s->process_data_blocks(s, buffer, data_block, &syt);
+		pcm_frames = s->process_data_blocks(s, buffer, data_blocks,
+						    &syt);
 
-		build_it_pkt_header(s, cycle, &template.params, data_block, syt,
-				    i);
+		build_it_pkt_header(s, cycle, &template.params, data_blocks,
+				    syt, i);
 
 		if (queue_out_packet(s, &template.params) < 0) {
 			cancel_stream(s);
-- 
2.20.1
