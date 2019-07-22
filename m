From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/20] ALSA: firewire-digi00x: code refactoring
	for DOT data block processing layer
Date: Mon, 22 Jul 2019 12:37:05 +0900
Message-ID: <20190722033710.28107-16-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E58AFF8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:39 +0200 (CEST)
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

This is code refactoring for DOT data block processing layer so that
it can receive list of packet descriptor.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/amdtp-dot.c | 45 +++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index 83ac4b37f26d..cef5caf97236 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -143,17 +143,23 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
 }
 
 static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
+			  __be32 *buffer, unsigned int frames,
+			  unsigned int pcm_frames)
 {
 	struct amdtp_dot *p = s->protocol;
+	unsigned int channels = p->pcm_channels;
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
+	unsigned int pcm_buffer_pointer;
+	int remaining_frames;
 	const u32 *src;
+	int i, c;
+
+	pcm_buffer_pointer = s->pcm_buffer_pointer + pcm_frames;
+	pcm_buffer_pointer %= runtime->buffer_size;
 
-	channels = p->pcm_channels;
 	src = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+				frames_to_bytes(runtime, pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - pcm_buffer_pointer;
 
 	buffer++;
 	for (i = 0; i < frames; ++i) {
@@ -169,17 +175,23 @@ static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
 }
 
 static void read_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
-			 __be32 *buffer, unsigned int frames)
+			 __be32 *buffer, unsigned int frames,
+			 unsigned int pcm_frames)
 {
 	struct amdtp_dot *p = s->protocol;
+	unsigned int channels = p->pcm_channels;
 	struct snd_pcm_runtime *runtime = pcm->runtime;
-	unsigned int channels, remaining_frames, i, c;
+	unsigned int pcm_buffer_pointer;
+	int remaining_frames;
 	u32 *dst;
+	int i, c;
+
+	pcm_buffer_pointer = s->pcm_buffer_pointer + pcm_frames;
+	pcm_buffer_pointer %= runtime->buffer_size;
 
-	channels = p->pcm_channels;
 	dst  = (void *)runtime->dma_area +
-			frames_to_bytes(runtime, s->pcm_buffer_pointer);
-	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
+				frames_to_bytes(runtime, pcm_buffer_pointer);
+	remaining_frames = runtime->buffer_size - pcm_buffer_pointer;
 
 	buffer++;
 	for (i = 0; i < frames; ++i) {
@@ -333,13 +345,12 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   const struct pkt_desc *desc,
 					   struct snd_pcm_substream *pcm)
 {
-	unsigned int pcm_frames;
+	unsigned int pcm_frames = 0;
 
 	if (pcm) {
-		read_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks);
+		read_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			     pcm_frames);
 		pcm_frames = desc->data_blocks;
-	} else {
-		pcm_frames = 0;
 	}
 
 	read_midi_messages(s, desc->ctx_payload, desc->data_blocks);
@@ -351,14 +362,14 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   const struct pkt_desc *desc,
 					   struct snd_pcm_substream *pcm)
 {
-	unsigned int pcm_frames;
+	unsigned int pcm_frames = 0;
 
 	if (pcm) {
-		write_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks);
+		write_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			      pcm_frames);
 		pcm_frames = desc->data_blocks;
 	} else {
 		write_pcm_silence(s, desc->ctx_payload, desc->data_blocks);
-		pcm_frames = 0;
 	}
 
 	write_midi_messages(s, desc->ctx_payload, desc->data_blocks,
-- 
2.20.1
