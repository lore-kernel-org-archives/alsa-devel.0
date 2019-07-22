From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/20] ALSA: firewire-lib: code refactoring to
	process PCM substream
Date: Mon, 22 Jul 2019 12:37:01 +0900
Message-ID: <20190722033710.28107-12-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94005F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:33 +0200 (CEST)
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

This is code refactoring to separate PCM substream processing from packet
queueing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 45 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 68502a8864b9..99b89bd70bc5 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -776,16 +776,24 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		const struct pkt_desc *desc = s->pkt_descs + i;
+		struct snd_pcm_substream *pcm;
 		unsigned int pcm_frames;
+
+		pcm_frames = s->process_data_blocks(s, desc->ctx_payload,
+				desc->data_blocks, desc->data_block_counter);
+
+		pcm = READ_ONCE(s->pcm);
+		if (pcm && pcm_frames > 0)
+			update_pcm_pointers(s, pcm, pcm_frames);
+	}
+
+	for (i = 0; i < packets; ++i) {
+		const struct pkt_desc *desc = s->pkt_descs + i;
 		unsigned int syt;
 		struct {
 			struct fw_iso_packet params;
 			__be32 header[IT_PKT_HEADER_SIZE_CIP / sizeof(__be32)];
 		} template = { {0}, {0} };
-		struct snd_pcm_substream *pcm;
-
-		pcm_frames = s->process_data_blocks(s, desc->ctx_payload,
-				desc->data_blocks, desc->data_block_counter);
 
 		if (s->ctx_data.rx.syt_override < 0)
 			syt = desc->syt;
@@ -800,10 +808,6 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			cancel_stream(s);
 			return;
 		}
-
-		pcm = READ_ONCE(s->pcm);
-		if (pcm && pcm_frames > 0)
-			update_pcm_pointers(s, pcm, pcm_frames);
 	}
 
 	fw_iso_context_queue_flush(s->context);
@@ -831,28 +835,29 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			cancel_stream(s);
 			return;
 		}
-	}
-
-	for (i = 0; i < packets; i++) {
-		const struct pkt_desc *desc = s->pkt_descs;
-		unsigned int pcm_frames = 0;
-		struct fw_iso_packet params = {0};
-		struct snd_pcm_substream *pcm;
+	} else {
+		for (i = 0; i < packets; ++i) {
+			const struct pkt_desc *desc = s->pkt_descs;
+			struct snd_pcm_substream *pcm;
+			unsigned int pcm_frames;
 
-		if (err >= 0) {
 			pcm_frames = s->process_data_blocks(s,
 					desc->ctx_payload, desc->data_blocks,
 					desc->data_block_counter);
+
+			pcm = READ_ONCE(s->pcm);
+			if (pcm && pcm_frames > 0)
+				update_pcm_pointers(s, pcm, pcm_frames);
 		}
+	}
+
+	for (i = 0; i < packets; ++i) {
+		struct fw_iso_packet params = {0};
 
 		if (queue_in_packet(s, &params) < 0) {
 			cancel_stream(s);
 			return;
 		}
-
-		pcm = READ_ONCE(s->pcm);
-		if (pcm && pcm_frames > 0)
-			update_pcm_pointers(s, pcm, pcm_frames);
 	}
 
 	fw_iso_context_queue_flush(s->context);
-- 
2.20.1
