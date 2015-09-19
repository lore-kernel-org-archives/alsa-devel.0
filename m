From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/15] ALSA: firewire-lib: add helper functions
	as interfaces between packet streaming layer and data block
	processing layer
Date: Sat, 19 Sep 2015 11:21:52 +0900
Message-ID: <1442629322-15457-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 1691B2604FF
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

ALSA PCM framework uses PCM buffer with a concept of 'period' to
synchronize userspace operations to hardware for nearly-realtime
processing. Each driver implements snd_pcm_period_elapsed() to tell across
of the period boundary to ALSA PCM middleware. To call the function, some
drivers utilize hardware interrupt handlers, the others count handled PCM
frames.

Drivers for sound units on IEEE 1394 bus are the latter. They use two
buffers; PCM buffer and DMA buffer for IEEE 1394 isochronous packet. PCM
frames are copied between these two buffers and 'amdtp_stream' structure
counts the handled PCM frames. Then, snd_pcm_period_elapsed() is called if
required.

Essentially, packet streaming layer should not be responsible for PCM
frame processing. The PCM frame processing should be handled in each data
block processing layer as a result of handling data blocks. Although, PCM
frame counting is a common work for all of protocols which ALSA firewire
stack is going to support.

This commit adds two new helper functions as interfaces between packet
streaming layer to data block processing layer. In future, each data block
processing layer implements these functions. The packet streaming layer
calls data block processing layer per packet by calling the functions. The
data block processing layer processes data blocks and PCM frames, and
returns the number of processed PCM frames. Then the packet streaming layer
calculates handled PCM frames and calls snd_pcm_period_elapsed().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 82 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 0bb5e14..5a3a452 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -657,28 +657,42 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
+unsigned int process_rx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+				    unsigned int data_blocks, unsigned int *syt)
+{
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		s->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks * s->frame_multiplier;
+	} else {
+		write_pcm_silence(s, buffer, data_blocks);
+		pcm_frames = 0;
+	}
+
+	if (s->midi_ports)
+		write_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames;
+}
+
 static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 			     unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int payload_length;
+	unsigned int pcm_frames;
 	struct snd_pcm_substream *pcm;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
+	pcm_frames = process_rx_data_blocks(s, buffer + 2, data_blocks, &syt);
+
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << CIP_DBS_SHIFT) |
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
 				(s->sfc << CIP_FDF_SHIFT) | syt);
-	buffer += 2;
-
-	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm)
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-	else
-		write_pcm_silence(s, buffer, data_blocks);
-	if (s->midi_ports)
-		write_midi_messages(s, buffer, data_blocks);
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
@@ -686,20 +700,41 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	if (queue_out_packet(s, payload_length, false) < 0)
 		return -EIO;
 
-	if (pcm)
-		update_pcm_pointers(s, pcm, data_blocks * s->frame_multiplier);
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
 
 	/* No need to return the number of handled data blocks. */
 	return 0;
 }
 
+unsigned int process_tx_data_blocks(struct amdtp_stream *s, __be32 *buffer,
+				    unsigned int data_blocks, unsigned int *syt)
+{
+	struct snd_pcm_substream *pcm = ACCESS_ONCE(s->pcm);
+	unsigned int pcm_frames;
+
+	if (pcm) {
+		s->transfer_samples(s, pcm, buffer, data_blocks);
+		pcm_frames = data_blocks * s->frame_multiplier;
+	} else {
+		pcm_frames = 0;
+	}
+
+	if (s->midi_ports)
+		read_midi_messages(s, buffer, data_blocks);
+
+	return pcm_frames;
+}
+
 static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int payload_quadlets, __be32 *buffer,
-			    unsigned int *data_blocks)
+			    unsigned int *data_blocks, unsigned int syt)
 {
 	u32 cip_header[2];
 	unsigned int data_block_quadlets, data_block_counter, dbc_interval;
-	struct snd_pcm_substream *pcm = NULL;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
 	bool lost;
 
 	cip_header[0] = be32_to_cpu(buffer[0]);
@@ -716,6 +751,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 				"Invalid CIP header for AMDTP: %08X:%08X\n",
 				cip_header[0], cip_header[1]);
 		*data_blocks = 0;
+		pcm_frames = 0;
 		goto end;
 	}
 
@@ -769,16 +805,7 @@ static int handle_in_packet(struct amdtp_stream *s,
 		return -EIO;
 	}
 
-	if (*data_blocks > 0) {
-		buffer += 2;
-
-		pcm = ACCESS_ONCE(s->pcm);
-		if (pcm)
-			s->transfer_samples(s, pcm, buffer, *data_blocks);
-
-		if (s->midi_ports)
-			read_midi_messages(s, buffer, *data_blocks);
-	}
+	pcm_frames = process_tx_data_blocks(s, buffer + 2, *data_blocks, &syt);
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
 		s->data_block_counter = data_block_counter;
@@ -789,8 +816,9 @@ end:
 	if (queue_in_packet(s) < 0)
 		return -EIO;
 
-	if (pcm)
-		update_pcm_pointers(s, pcm, *data_blocks * s->frame_multiplier);
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
 
 	return 0;
 }
@@ -860,15 +888,15 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			break;
 		}
 
+		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 		if (handle_in_packet(s, payload_quadlets, buffer,
-							&data_blocks) < 0) {
+						&data_blocks, syt) < 0) {
 			s->packet_index = -1;
 			break;
 		}
 
 		/* Process sync slave stream */
 		if (s->sync_slave && s->sync_slave->callbacked) {
-			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 			if (handle_out_packet(s->sync_slave,
 					      data_blocks, syt) < 0) {
 				s->packet_index = -1;
-- 
2.1.4
