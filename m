From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/17] firewire-lib: Split some codes into
	functions to reuse in future
Date: Sat, 23 Nov 2013 15:07:51 +0900
Message-ID: <1385186884-8259-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 2003C2618EE
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:10 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some codes can be reused in handling transmitted stream. This commit adds new
functions. This commit also renames some functions to keep naming consistency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 158 ++++++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 75 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 5d94252..c32d75d 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -47,6 +47,8 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
+#define TRANSMIT_PACKET_HEADER_SIZE	4
+
 static void pcm_period_tasklet(unsigned long data);
 
 /**
@@ -440,13 +442,74 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 						cpu_to_be32(0x80000000);
 }
 
-static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
+static void check_pcm_pointer(struct amdtp_stream *s,
+			      struct snd_pcm_substream *pcm,
+			      unsigned int frames)
+{	unsigned int ptr;
+
+	if (s->dual_wire)
+		frames *= 2;
+
+	ptr = s->pcm_buffer_pointer + frames;
+	if (ptr >= pcm->runtime->buffer_size)
+		ptr -= pcm->runtime->buffer_size;
+	ACCESS_ONCE(s->pcm_buffer_pointer) = ptr;
+
+	s->pcm_period_pointer += frames;
+	if (s->pcm_period_pointer >= pcm->runtime->period_size) {
+		s->pcm_period_pointer -= pcm->runtime->period_size;
+		s->pointer_flush = false;
+		tasklet_hi_schedule(&s->period_tasklet);
+	}
+}
+
+static void pcm_period_tasklet(unsigned long data)
+{
+	struct amdtp_stream *s = (void *)data;
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+
+	if (pcm)
+		snd_pcm_period_elapsed(pcm);
+}
+
+static int queue_packet(struct amdtp_stream *s,
+			unsigned int header_length,
+			unsigned int payload_length, bool skip)
+{
+	struct fw_iso_packet p = {0};
+	int err;
+
+	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
+	p.tag = TAG_CIP;
+	p.header_length = header_length;
+	p.payload_length = (!skip) ? payload_length : 0;
+	p.skip = (!skip) ? 0: 1;
+	err = fw_iso_context_queue(s->context, &p, &s->buffer.iso_buffer,
+				   s->buffer.packets[s->packet_index].offset);
+	if (err < 0) {
+		dev_err(&s->unit->device, "queueing error: %d\n", err);
+		s->packet_index = -1;
+		goto end;
+	}
+
+	if (++s->packet_index >= QUEUE_LENGTH)
+		s->packet_index = 0;
+end:
+	return err;
+}
+
+static inline int queue_out_packet(struct amdtp_stream *s,
+				   unsigned int payload_length, bool skip)
+{
+	return queue_packet(s, RECEIVE_PACKET_HEADER_SIZE,
+			    payload_length, skip);
+}
+
+static void handle_out_packet(struct amdtp_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
-	unsigned int index, data_blocks, syt, ptr;
+	unsigned int index, data_blocks, syt, payload_length;
 	struct snd_pcm_substream *pcm;
-	struct fw_iso_packet packet;
-	int err;
 
 	if (s->packet_index < 0)
 		return;
@@ -479,55 +542,19 @@ static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
-	packet.payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
-	packet.interrupt = IS_ALIGNED(index + 1, INTERRUPT_INTERVAL);
-	packet.skip = 0;
-	packet.tag = TAG_CIP;
-	packet.sy = 0;
-	packet.header_length = 0;
-
-	err = fw_iso_context_queue(s->context, &packet, &s->buffer.iso_buffer,
-				   s->buffer.packets[index].offset);
-	if (err < 0) {
-		dev_err(&s->unit->device, "queueing error: %d\n", err);
-		s->packet_index = -1;
+	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
+	if (queue_out_packet(s, payload_length, false) < 0) {
 		amdtp_stream_pcm_abort(s);
 		return;
 	}
 
-	if (++index >= QUEUE_LENGTH)
-		index = 0;
-	s->packet_index = index;
-
-	if (pcm) {
-		if (s->dual_wire)
-			data_blocks *= 2;
-
-		ptr = s->pcm_buffer_pointer + data_blocks;
-		if (ptr >= pcm->runtime->buffer_size)
-			ptr -= pcm->runtime->buffer_size;
-		ACCESS_ONCE(s->pcm_buffer_pointer) = ptr;
-
-		s->pcm_period_pointer += data_blocks;
-		if (s->pcm_period_pointer >= pcm->runtime->period_size) {
-			s->pcm_period_pointer -= pcm->runtime->period_size;
-			s->pointer_flush = false;
-			tasklet_hi_schedule(&s->period_tasklet);
-		}
-	}
-}
-
-static void pcm_period_tasklet(unsigned long data)
-{
-	struct amdtp_stream *s = (void *)data;
-	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
-
 	if (pcm)
-		snd_pcm_period_elapsed(pcm);
+		check_pcm_pointer(s, pcm, data_blocks);
 }
 
-static void out_packet_callback(struct fw_iso_context *context, u32 cycle,
-			size_t header_length, void *header, void *private_data)
+static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
+				size_t header_length, void *header,
+				void *private_data)
 {
 	struct amdtp_stream *s = private_data;
 	unsigned int i, packets = header_length / 4;
@@ -540,31 +567,10 @@ static void out_packet_callback(struct fw_iso_context *context, u32 cycle,
 	cycle += QUEUE_LENGTH - packets;
 
 	for (i = 0; i < packets; ++i)
-		queue_out_packet(s, ++cycle);
+		handle_out_packet(s, ++cycle);
 	fw_iso_context_queue_flush(s->context);
 }
 
-static int queue_initial_skip_packets(struct amdtp_stream *s)
-{
-	struct fw_iso_packet skip_packet = {
-		.skip = 1,
-	};
-	unsigned int i;
-	int err;
-
-	for (i = 0; i < QUEUE_LENGTH; ++i) {
-		skip_packet.interrupt = IS_ALIGNED(s->packet_index + 1,
-						   INTERRUPT_INTERVAL);
-		err = fw_iso_context_queue(s->context, &skip_packet, NULL, 0);
-		if (err < 0)
-			return err;
-		if (++s->packet_index >= QUEUE_LENGTH)
-			s->packet_index = 0;
-	}
-
-	return 0;
-}
-
 /**
  * amdtp_stream_start - start sending packets
  * @s: the AMDTP stream to start
@@ -594,7 +600,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	mutex_lock(&s->mutex);
 
 	if (WARN_ON(amdtp_stream_running(s) ||
-		    (!s->pcm_channels && !s->midi_ports))) {
+		    (s->data_block_quadlets < 1))) {
 		err = -EBADFD;
 		goto err_unlock;
 	}
@@ -612,8 +618,8 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   FW_ISO_CONTEXT_TRANSMIT,
 					   channel, speed, 0,
-					   out_packet_callback, s);
-	if (IS_ERR(s->context)) {
+					   out_stream_callback, s);
+	if (!amdtp_stream_running(s)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
 			dev_err(&s->unit->device,
@@ -624,11 +630,13 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	amdtp_stream_update(s);
 
 	s->packet_index = 0;
-	s->data_block_counter = 0;
-	err = queue_initial_skip_packets(s);
-	if (err < 0)
-		goto err_context;
+	do {
+		err = queue_out_packet(s, 0, true);
+		if (err < 0)
+			goto err_context;
+	} while (s->packet_index > 0);
 
+	s->data_block_counter = 0;
 	err = fw_iso_context_start(s->context, -1, 0, 0);
 	if (err < 0)
 		goto err_context;
-- 
1.8.3.2
