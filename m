From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/20] ALSA: firewire-lib: code refactoring for
	AM824 data block processing layer
Date: Mon, 22 Jul 2019 12:37:04 +0900
Message-ID: <20190722033710.28107-15-o-takashi@sakamocchi.jp>
References: <20190722033710.28107-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66873F80507
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 05:37:38 +0200 (CEST)
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

This is code refactoring for AM824 data block processing layer so that
it can receive list of packet descriptor.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-am824.c | 51 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
index ff089ffa3374..5d2952a1a9b2 100644
--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -146,19 +146,24 @@ void amdtp_am824_set_midi_position(struct amdtp_stream *s,
 }
 EXPORT_SYMBOL_GPL(amdtp_am824_set_midi_position);
 
-static void write_pcm_s32(struct amdtp_stream *s,
-			  struct snd_pcm_substream *pcm,
-			  __be32 *buffer, unsigned int frames)
+static void write_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			  __be32 *buffer, unsigned int frames,
+			  unsigned int pcm_frames)
 {
 	struct amdtp_am824 *p = s->protocol;
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
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
@@ -172,19 +177,24 @@ static void write_pcm_s32(struct amdtp_stream *s,
 	}
 }
 
-static void read_pcm_s32(struct amdtp_stream *s,
-			 struct snd_pcm_substream *pcm,
-			 __be32 *buffer, unsigned int frames)
+static void read_pcm_s32(struct amdtp_stream *s, struct snd_pcm_substream *pcm,
+			 __be32 *buffer, unsigned int frames,
+			 unsigned int pcm_frames)
 {
 	struct amdtp_am824 *p = s->protocol;
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
 
 	for (i = 0; i < frames; ++i) {
 		for (c = 0; c < channels; ++c) {
@@ -340,14 +350,14 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 					   struct snd_pcm_substream *pcm)
 {
 	struct amdtp_am824 *p = s->protocol;
-	unsigned int pcm_frames;
+	unsigned int pcm_frames = 0;
 
 	if (pcm) {
-		write_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks);
+		write_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			      pcm_frames);
 		pcm_frames = desc->data_blocks * p->frame_multiplier;
 	} else {
 		write_pcm_silence(s, desc->ctx_payload, desc->data_blocks);
-		pcm_frames = 0;
 	}
 
 	if (p->midi_ports) {
@@ -363,13 +373,12 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   struct snd_pcm_substream *pcm)
 {
 	struct amdtp_am824 *p = s->protocol;
-	unsigned int pcm_frames;
+	unsigned int pcm_frames = 0;
 
 	if (pcm) {
-		read_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks);
+		read_pcm_s32(s, pcm, desc->ctx_payload, desc->data_blocks,
+			     pcm_frames);
 		pcm_frames = desc->data_blocks * p->frame_multiplier;
-	} else {
-		pcm_frames = 0;
 	}
 
 	if (p->midi_ports) {
-- 
2.20.1
