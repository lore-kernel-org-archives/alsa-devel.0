From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/20] ALSA: firewire-motu: more code
	refactoring for MOTU data block processing layer
Date: Mon, 22 Jul 2019 12:37:10 +0900
Message-ID: <20190722033710.28107-21-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CAEEDF805A1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:47 +0200 (CEST)
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

MOTU data block processing layer has some tracepoints events. This
commit is code refactoring to split probing the events from processing
data blocks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu.c | 50 +++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 05a6e218b0ad..0fd36e469ad0 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -310,6 +310,22 @@ static void __maybe_unused copy_message(u64 *frames, __be32 *buffer,
 	}
 }
 
+static void probe_tracepoints_events(struct amdtp_stream *s,
+				     const struct pkt_desc *descs,
+				     unsigned int packets)
+{
+	int i;
+
+	for (i = 0; i < packets; ++i) {
+		const struct pkt_desc *desc = descs + i;
+		__be32 *buf = desc->ctx_payload;
+		unsigned int data_blocks = desc->data_blocks;
+
+		trace_data_block_sph(s, data_blocks, buf);
+		trace_data_block_message(s, data_blocks, buf);
+	}
+}
+
 static unsigned int process_ir_ctx_payloads(struct amdtp_stream *s,
 					    const struct pkt_desc *descs,
 					    unsigned int packets,
@@ -319,23 +335,26 @@ static unsigned int process_ir_ctx_payloads(struct amdtp_stream *s,
 	unsigned int pcm_frames = 0;
 	int i;
 
+	// For data block processing.
 	for (i = 0; i < packets; ++i) {
 		const struct pkt_desc *desc = descs + i;
 		__be32 *buf = desc->ctx_payload;
 		unsigned int data_blocks = desc->data_blocks;
 
-		trace_data_block_sph(s, data_blocks, buf);
-		trace_data_block_message(s, data_blocks, buf);
-
-		if (p->midi_ports)
-			read_midi_messages(s, buf, data_blocks);
-
 		if (pcm) {
 			read_pcm_s32(s, pcm, buf, data_blocks, pcm_frames);
 			pcm_frames += data_blocks;
 		}
+
+		if (p->midi_ports)
+			read_midi_messages(s, buf, data_blocks);
 	}
 
+	// For tracepoints.
+	if (trace_data_block_sph_enabled() ||
+	    trace_data_block_message_enabled())
+		probe_tracepoints_events(s, descs, packets);
+
 	return pcm_frames;
 }
 
@@ -390,16 +409,12 @@ static unsigned int process_it_ctx_payloads(struct amdtp_stream *s,
 	unsigned int pcm_frames = 0;
 	int i;
 
+	// For data block processing.
 	for (i = 0; i < packets; ++i) {
 		const struct pkt_desc *desc = descs + i;
 		__be32 *buf = desc->ctx_payload;
 		unsigned int data_blocks = desc->data_blocks;
 
-		// TODO: how to interact control messages between userspace?
-
-		if (p->midi_ports)
-			write_midi_messages(s, buf, data_blocks);
-
 		if (pcm) {
 			write_pcm_s32(s, pcm, buf, data_blocks, pcm_frames);
 			pcm_frames += data_blocks;
@@ -407,12 +422,19 @@ static unsigned int process_it_ctx_payloads(struct amdtp_stream *s,
 			write_pcm_silence(s, buf, data_blocks);
 		}
 
-		write_sph(s, buf, data_blocks);
+		if (p->midi_ports)
+			write_midi_messages(s, buf, data_blocks);
 
-		trace_data_block_sph(s, data_blocks, buf);
-		trace_data_block_message(s, data_blocks, buf);
+		// TODO: how to interact control messages between userspace?
+
+		write_sph(s, buf, data_blocks);
 	}
 
+	// For tracepoints.
+	if (trace_data_block_sph_enabled() ||
+	    trace_data_block_message_enabled())
+		probe_tracepoints_events(s, descs, packets);
+
 	return pcm_frames;
 }
 
-- 
2.20.1
