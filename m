From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/52] firewire-lib: Split some codes into functions to reuse
	for both streams
Date: Wed, 29 Jan 2014 22:44:11 +0900
Message-ID: <1391003099-7109-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some codes can be reused to handle in stream. This commit adds new functions.
This commit also renames some functions to keep naming consistency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 156 ++++++++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 74 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 95c5a15..ca79cb4 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -47,6 +47,8 @@
 #define INTERRUPT_INTERVAL	16
 #define QUEUE_LENGTH		48
 
+#define OUT_PACKET_HEADER_SIZE	0
+
 static void pcm_period_tasklet(unsigned long data);
 
 /**
@@ -440,13 +442,74 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 						cpu_to_be32(0x80000000);
 }
 
-static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
+static void update_pcm_pointers(struct amdtp_stream *s,
+				struct snd_pcm_substream *pcm,
+				unsigned int frames)
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
+	p.skip = skip;
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
+	return queue_packet(s, OUT_PACKET_HEADER_SIZE,
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
+		update_pcm_pointers(s, pcm, data_blocks);
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
  * amdtp_stream_start - start transferring packets
  * @s: the AMDTP stream to start
@@ -594,7 +600,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	mutex_lock(&s->mutex);
 
 	if (WARN_ON(amdtp_stream_running(s) ||
-		    (!s->pcm_channels && !s->midi_ports))) {
+		    (s->data_block_quadlets < 1))) {
 		err = -EBADFD;
 		goto err_unlock;
 	}
@@ -612,7 +618,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   FW_ISO_CONTEXT_TRANSMIT,
 					   channel, speed, 0,
-					   out_packet_callback, s);
+					   out_stream_callback, s);
 	if (IS_ERR(s->context)) {
 		err = PTR_ERR(s->context);
 		if (err == -EBUSY)
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


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
