From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/20] ALSA: firewire-lib: code refactoring to
	process context payloads
Date: Mon, 22 Jul 2019 12:37:02 +0900
Message-ID: <20190722033710.28107-13-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19D35F803F4
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:35 +0200 (CEST)
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

This is code refactoring for common processing for payloads of
ishocornous context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 47 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 99b89bd70bc5..573265113a6f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -760,22 +760,14 @@ static inline void cancel_stream(struct amdtp_stream *s)
 	WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
 }
 
-static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
-				size_t header_length, void *header,
-				void *private_data)
+static void process_ctx_payloads(struct amdtp_stream *s,
+				 const struct pkt_desc *descs,
+				 unsigned int packets)
 {
-	struct amdtp_stream *s = private_data;
-	const __be32 *ctx_header = header;
-	unsigned int packets = header_length / sizeof(*ctx_header);
 	int i;
 
-	if (s->packet_index < 0)
-		return;
-
-	generate_ideal_pkt_descs(s, s->pkt_descs, ctx_header, packets);
-
 	for (i = 0; i < packets; ++i) {
-		const struct pkt_desc *desc = s->pkt_descs + i;
+		const struct pkt_desc *desc = descs + i;
 		struct snd_pcm_substream *pcm;
 		unsigned int pcm_frames;
 
@@ -786,6 +778,23 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		if (pcm && pcm_frames > 0)
 			update_pcm_pointers(s, pcm, pcm_frames);
 	}
+}
+
+static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
+				size_t header_length, void *header,
+				void *private_data)
+{
+	struct amdtp_stream *s = private_data;
+	const __be32 *ctx_header = header;
+	unsigned int packets = header_length / sizeof(*ctx_header);
+	int i;
+
+	if (s->packet_index < 0)
+		return;
+
+	generate_ideal_pkt_descs(s, s->pkt_descs, ctx_header, packets);
+
+	process_ctx_payloads(s, s->pkt_descs, packets);
 
 	for (i = 0; i < packets; ++i) {
 		const struct pkt_desc *desc = s->pkt_descs + i;
@@ -836,19 +845,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			return;
 		}
 	} else {
-		for (i = 0; i < packets; ++i) {
-			const struct pkt_desc *desc = s->pkt_descs;
-			struct snd_pcm_substream *pcm;
-			unsigned int pcm_frames;
-
-			pcm_frames = s->process_data_blocks(s,
-					desc->ctx_payload, desc->data_blocks,
-					desc->data_block_counter);
-
-			pcm = READ_ONCE(s->pcm);
-			if (pcm && pcm_frames > 0)
-				update_pcm_pointers(s, pcm, pcm_frames);
-		}
+		process_ctx_payloads(s, s->pkt_descs, packets);
 	}
 
 	for (i = 0; i < packets; ++i) {
-- 
2.20.1
