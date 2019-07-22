From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/20] ALSA: firewire-motu: code refactoring
	for MOTU data block processing layer
Date: Mon, 22 Jul 2019 12:37:07 +0900
Message-ID: <20190722033710.28107-18-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 045AEF80507
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:43 +0200 (CEST)
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

This is code refactoring for MOTU data block processing layer so that
it can receive list of packet descriptor.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu.c | 57 ++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 36ee2c1dd667..21c6bfdf47c0 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -117,19 +117,25 @@ int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
 	return 0;
 }
 
-static void read_pcm_s32(struct amdtp_stream *s,
-			 struct snd_pcm_runtime *runtime,
-			 __be32 *buffer, unsigned int data_blocks)
+static void read_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int data_blocks,
+			 unsigned int pcm_frames)
 {
 	struct amdtp_motu *p = s->protocol;
-	unsigned int channels, remaining_frames, i, c;
+	unsigned int channels = p->pcm_chunks;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int pcm_buffer_pointer;
+	int remaining_frames;
 	u8 *byte;
 	u32 *dst;
+	int i, c;
+
+	pcm_buffer_pointer = s->pcm_buffer_pointer + pcm_frames;
+	pcm_buffer_pointer %= runtime->buffer_size;
 
-	channels = p->pcm_chunks;
 	dst = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+				frames_to_bytes(runtime, pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - pcm_buffer_pointer;
 
 	for (i = 0; i < data_blocks; ++i) {
 		byte = (u8 *)buffer + p->pcm_byte_offset;
@@ -147,19 +153,25 @@ static void read_pcm_s32(struct amdtp_stream *s,
 	}
 }
 
-static void write_pcm_s32(struct amdtp_stream *s,
-			  struct snd_pcm_runtime *runtime,
-			  __be32 *buffer, unsigned int data_blocks)
+static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int data_blocks,
+			  unsigned int pcm_frames)
 {
 	struct amdtp_motu *p = s->protocol;
-	unsigned int channels, remaining_frames, i, c;
+	unsigned int channels = p->pcm_chunks;
+	struct snd_pcm_runtime *runtime = pcm->runtime;
+	unsigned int pcm_buffer_pointer;
+	int remaining_frames;
 	u8 *byte;
 	const u32 *src;
+	int i, c;
+
+	pcm_buffer_pointer = s->pcm_buffer_pointer + pcm_frames;
+	pcm_buffer_pointer %= runtime->buffer_size;
 
-	channels = p->pcm_chunks;
 	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+				frames_to_bytes(runtime, pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - pcm_buffer_pointer;
 
 	for (i = 0; i < data_blocks; ++i) {
 		byte = (u8 *)buffer + p->pcm_byte_offset;
@@ -303,7 +315,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   struct snd_pcm_substream *pcm)
 {
 	struct amdtp_motu *p = s->protocol;
-	unsigned int pcm_frames;
+	unsigned int pcm_frames = 0;
 
 	trace_data_block_sph(s, desc->data_blocks, desc->ctx_payload);
 	trace_data_block_message(s, desc->data_blocks, desc->ctx_payload);
@@ -312,11 +324,9 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 		read_midi_messages(s, desc->ctx_payload, desc->data_blocks);
 
 	if (pcm) {
-		read_pcm_s32(s, pcm->runtime, desc->ctx_payload,
-			     desc->data_blocks);
+		read_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			     pcm_frames);
 		pcm_frames = desc->data_blocks;
-	} else {
-		pcm_frames = 0;
 	}
 
 	return pcm_frames;
@@ -368,8 +378,8 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   const struct pkt_desc *desc,
 					   struct snd_pcm_substream *pcm)
 {
-	struct amdtp_motu *p = (struct amdtp_motu *)s->protocol;
-	unsigned int pcm_frames;
+	struct amdtp_motu *p = s->protocol;
+	unsigned int pcm_frames = 0;
 
 	/* TODO: how to interact control messages between userspace? */
 
@@ -377,12 +387,11 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 		write_midi_messages(s, desc->ctx_payload, desc->data_blocks);
 
 	if (pcm) {
-		write_pcm_s32(s, pcm->runtime, desc->ctx_payload,
-			      desc->data_blocks);
+		write_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			      pcm_frames);
 		pcm_frames = desc->data_blocks;
 	} else {
 		write_pcm_silence(s, desc->ctx_payload, desc->data_blocks);
-		pcm_frames = 0;
 	}
 
 	write_sph(s, desc->ctx_payload, desc->data_blocks);
-- 
2.20.1
