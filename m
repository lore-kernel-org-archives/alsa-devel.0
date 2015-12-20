From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/11] firewire-lib: add no-header packet
	processing
Date: Sun, 20 Dec 2015 21:28:39 +0900
Message-ID: <1450614523-9367-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5479F260706
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 13:28:50 +0100 (CET)
In-Reply-To: <1450614523-9367-1-git-send-email-o-takashi@sakamocchi.jp>
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

RME Fireface series doesn't apply IEC 61883-1/6. Its packet includes
no CIP headers. 64,0 and 128,0 kHz are supported. The device doesn't
transmit 8,000 packets per second. 0, 2, 3 are used as tag of received
isochronous packets.

On the other hand, there's a common feature. The number of data blocks
transferred in a second is the same as sampling transfer frequency.
Current AMDTP stream layer already has a method to calculate it.

This commit adds support for the transferring protocol. CIP_NO_HEADERS
flag is newly added. When this flag is set:
 * 0 and 1 are used as the tag.
 * Skip header evaluation.
 * Use another way to calculate the quadlets of isochronous packet payload.

In ALSA userspace interface, 128.0 kHz is not supported. And the AMDTP
stream layer doesn't support 64.0 kHz. These modes are dropped.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 104 +++++++++++++++++++++++++++++++++++-------
 sound/firewire/amdtp-stream.h |   2 +
 2 files changed, 89 insertions(+), 17 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index ed29026..e2c13f0 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -225,11 +225,15 @@ EXPORT_SYMBOL(amdtp_stream_set_parameters);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 {
 	unsigned int multiplier = 1;
+	unsigned int header_size = 0;
 
 	if (s->flags & CIP_JUMBO_PAYLOAD)
 		multiplier = 5;
+	if (!(s->flags & CIP_NO_HEADERS))
+		header_size = 8;
 
-	return 8 + s->syt_interval * s->data_block_quadlets * 4 * multiplier;
+	return header_size +
+		s->syt_interval * s->data_block_quadlets * 4 * multiplier;
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
@@ -374,7 +378,10 @@ static int queue_packet(struct amdtp_stream *s,
 		goto end;
 
 	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
-	p.tag = TAG_CIP;
+	if (s->flags & CIP_NO_HEADERS)
+		p.tag = 0;
+	else
+		p.tag = TAG_CIP;
 	p.header_length = header_length;
 	p.payload_length = (!skip) ? payload_length : 0;
 	p.skip = skip;
@@ -404,6 +411,52 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 			    amdtp_stream_get_max_payload(s), false);
 }
 
+static int handle_out_packet_without_header(struct amdtp_stream *s,
+					    unsigned int data_blocks)
+{
+	__be32 *buffer;
+	unsigned int payload_length;
+	unsigned int pcm_frames;
+	struct snd_pcm_substream *pcm;
+
+	buffer = s->buffer.packets[s->packet_index].buffer;
+	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, 0);
+
+	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+
+	payload_length = data_blocks * 4 * s->data_block_quadlets;
+	if (queue_out_packet(s, payload_length, false) < 0)
+		return -EIO;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
+
+	/* No need to return the number of handled data blocks. */
+	return 0;
+}
+
+static int handle_in_packet_without_header(struct amdtp_stream *s,
+				unsigned int payload_quadlets, __be32 *buffer,
+				unsigned int *data_blocks)
+{
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	*data_blocks = payload_quadlets / s->data_block_quadlets;
+
+	pcm_frames = s->process_data_blocks(s, buffer, *data_blocks, 0);
+
+	if (queue_in_packet(s) < 0)
+		return -EIO;
+
+	pcm = ACCESS_ONCE(s->pcm);
+	if (pcm && pcm_frames > 0)
+		update_pcm_pointers(s, pcm, pcm_frames);
+
+	return 0;
+}
+
 static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 			     unsigned int syt)
 {
@@ -566,10 +619,19 @@ static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 		syt = calculate_syt(s, ++cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 
-		if (handle_out_packet(s, data_blocks, syt) < 0) {
-			s->packet_index = -1;
-			amdtp_stream_pcm_abort(s);
-			return;
+		if (s->flags & CIP_NO_HEADERS) {
+			if (handle_out_packet_without_header(s,
+							data_blocks) < 0) {
+				s->packet_index = -1;
+				amdtp_stream_pcm_abort(s);
+				return;
+			}
+		} else {
+			if (handle_out_packet(s, data_blocks, syt) < 0) {
+				s->packet_index = -1;
+				amdtp_stream_pcm_abort(s);
+				return;
+			}
 		}
 	}
 
@@ -609,20 +671,28 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			break;
 		}
 
-		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-		if (handle_in_packet(s, payload_quadlets, buffer,
+		if (s->flags & CIP_NO_HEADERS) {
+			if (handle_in_packet_without_header(s, payload_quadlets,
+						buffer, &data_blocks) < 0) {
+				s->packet_index = -1;
+				break;
+			}
+		} else {
+			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+			if (handle_in_packet(s, payload_quadlets, buffer,
 						&data_blocks, syt) < 0) {
-			s->packet_index = -1;
-			break;
-		}
-
-		/* Process sync slave stream */
-		if (s->sync_slave && s->sync_slave->callbacked) {
-			if (handle_out_packet(s->sync_slave,
-					      data_blocks, syt) < 0) {
 				s->packet_index = -1;
 				break;
 			}
+
+			/* Process sync slave stream */
+			if (s->sync_slave && s->sync_slave->callbacked) {
+				if (handle_out_packet(s->sync_slave,
+						      data_blocks, syt) < 0) {
+					s->packet_index = -1;
+					break;
+				}
+			}
 		}
 	}
 
@@ -762,7 +832,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream. */
 	tag = FW_ISO_CONTEXT_MATCH_TAG1;
-	if (s->flags & CIP_EMPTY_WITH_TAG0)
+	if ((s->flags & CIP_EMPTY_WITH_TAG0) || (s->flags & CIP_NO_HEADERS))
 		tag |= FW_ISO_CONTEXT_MATCH_TAG0;
 
 	s->callbacked = false;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 8775704..5a3a613 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -33,6 +33,7 @@
  * @CIP_JUMBO_PAYLOAD: Only for in-stream. The number of data blocks in an
  *	packet is larger than IEC 61883-6 defines. Current implementation
  *	allows 5 times as large as IEC 61883-6 defines.
+ * @CIP_NO_HEADERS: a lack of headers in packets
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -45,6 +46,7 @@ enum cip_flags {
 	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
 	CIP_EMPTY_HAS_WRONG_DBC	= 0x80,
 	CIP_JUMBO_PAYLOAD	= 0x100,
+	CIP_NO_HEADERS		= 0x200,
 };
 
 /**
-- 
2.5.0
