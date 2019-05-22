From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/6] ALSA: firewire-lib: compute pointer to
	payload buffer in context handler
Date: Wed, 22 May 2019 23:17:05 +0900
Message-ID: <20190522141708.29159-4-o-takashi@sakamocchi.jp>
References: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5AA3F89630
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:17:18 +0200 (CEST)
In-Reply-To: <20190522141708.29159-1-o-takashi@sakamocchi.jp>
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

The value of pointer to payload buffer is computed in each packet
handler, however the pointer can be decided before call of packet
handler.

This commit adds an argument for the pointer to the packet handler to
reduce codes to compute for the pointer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 28 +++++++++++++---------------
 sound/firewire/amdtp-stream.h |  3 ++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 4584525a7f30..ab9dc7e9ffa4 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -475,16 +475,15 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 }
 
 static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
-			     const __be32 *ctx_header, unsigned int index)
+			     const __be32 *ctx_header, __be32 *buffer,
+			     unsigned int index)
 {
-	__be32 *buffer;
 	unsigned int syt;
 	unsigned int data_blocks;
 	unsigned int pcm_frames;
 	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
-	buffer = s->buffer.packets[s->packet_index].buffer;
 	syt = calculate_syt(s, cycle);
 	data_blocks = calculate_data_blocks(s, syt);
 	pcm_frames = s->process_data_blocks(s, buffer + 2, data_blocks, &syt);
@@ -522,16 +521,14 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int cycle,
 
 static int handle_out_packet_without_header(struct amdtp_stream *s,
 				unsigned int cycle, const __be32 *ctx_header,
-				unsigned int index)
+				__be32 *buffer, unsigned int index)
 {
-	__be32 *buffer;
 	unsigned int syt;
 	unsigned int data_blocks;
 	unsigned int pcm_frames;
 	unsigned int payload_length;
 	struct snd_pcm_substream *pcm;
 
-	buffer = s->buffer.packets[s->packet_index].buffer;
 	syt = calculate_syt(s, cycle);
 	data_blocks = calculate_data_blocks(s, syt);
 	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
@@ -553,9 +550,9 @@ static int handle_out_packet_without_header(struct amdtp_stream *s,
 }
 
 static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
-			    const __be32 *ctx_header, unsigned int index)
+			    const __be32 *ctx_header, __be32 *buffer,
+			    unsigned int index)
 {
-	__be32 *buffer;
 	unsigned int payload_length;
 	u32 cip_header[2];
 	unsigned int sph, fmt, fdf, syt;
@@ -573,7 +570,6 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 		return -EIO;
 	}
 
-	buffer = s->buffer.packets[s->packet_index].buffer;
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
@@ -678,17 +674,15 @@ static int handle_in_packet(struct amdtp_stream *s, unsigned int cycle,
 
 static int handle_in_packet_without_header(struct amdtp_stream *s,
 				unsigned int cycle, const __be32 *ctx_header,
-				unsigned int index)
+				__be32 *buffer, unsigned int index)
 {
-	__be32 *buffer;
 	unsigned int payload_length;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
 	payload_length = be32_to_cpu(ctx_header[0]) >> ISO_DATA_LENGTH_SHIFT;
-	buffer = s->buffer.packets[s->packet_index].buffer;
-	data_blocks = payload_length / sizeof(__be32) / s->data_block_quadlets;
+	data_blocks = payload_length / 4 / s->data_block_quadlets;
 
 	trace_amdtp_packet(s, cycle, NULL, payload_length, data_blocks, index);
 
@@ -753,10 +747,12 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		u32 cycle;
+		__be32 *buffer;
 
 		cycle = compute_it_cycle(*ctx_header);
+		buffer = s->buffer.packets[s->packet_index].buffer;
 
-		if (s->handle_packet(s, cycle, ctx_header, i) < 0) {
+		if (s->handle_packet(s, cycle, ctx_header, buffer, i) < 0) {
 			cancel_stream(s);
 			return;
 		}
@@ -783,10 +779,12 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; i++) {
 		u32 cycle;
+		__be32 *buffer;
 
 		cycle = compute_cycle_count(ctx_header[1]);
+		buffer = s->buffer.packets[s->packet_index].buffer;
 
-		if (s->handle_packet(s, cycle, ctx_header, i) < 0)
+		if (s->handle_packet(s, cycle, ctx_header, buffer, i) < 0)
 			break;
 
 		ctx_header += s->ctx_data.tx.ctx_header_size / sizeof(*ctx_header);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index d317fdc6ab5f..5aa9683593d2 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -109,7 +109,8 @@ struct amdtp_stream {
 	int packet_index;
 	int tag;
 	int (*handle_packet)(struct amdtp_stream *s, unsigned int cycle,
-			     const __be32 *ctx_header, unsigned int index);
+			     const __be32 *ctx_header, __be32 *buffer,
+			     unsigned int index);
 	union {
 		struct {
 			unsigned int ctx_header_size;
-- 
2.20.1
