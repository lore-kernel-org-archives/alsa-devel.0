From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/14] ALSA: firewire-lib: add no-header packet
	processing
Date: Fri, 31 Mar 2017 22:06:07 +0900
Message-ID: <20170331130612.18331-10-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 406A6267233
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:25 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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

As long as investigating Fireface 400, IEC 61883-1/6 is not applied to
its packet streaming protocol. Remarks of the specific protocol are:
 * Each packet doesn't include CIP headers.
 * 64,0 and 128,0 kHz are supported.
 * The device doesn't necessarily transmit 8,000 packets per second.
 * 0, 1, 2, 3 are used as tag for rx isochronous packets, however 0 is
   used for tx isochronous packets.

On the other hand, there's a common feature. The number of data blocks
transferred in a second is the same as sampling transmission frequency.
Current ALSA IEC 61883-1/6 engine already has a method to calculate it and
this driver can utilize it for rx packets, as well as tx packets.

This commit adds support for the transferring protocol. CIP_NO_HEADERS
flag is newly added. When this flag is set:
 * Both of 0 (without CIP header) and 1 (with CIP header) are used as tag
   to handle incoming isochronous packet.
 * 0 (without CIP header) is used as tag to transfer outgoing isochronous
   packet.
 * Skip CIP header evaluation.
 * Use unique way to calculate the quadlets of isochronous packet payload.

In ALSA PCM interface, 128.0 kHz is not supported, and the ALSA
IEC 61883-1/6 engine doesn't support 64.0 kHz. These modes are dropped.

The sequence of rx packet has a remarkable quirk about tag. This will be
described in later commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 80 ++++++++++++++++++++++++++++++++++++++++---
 sound/firewire/amdtp-stream.h |  6 ++++
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 646e8e3..a03b37b 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -27,6 +27,7 @@
 
 /* isochronous header parameters */
 #define ISO_DATA_LENGTH_SHIFT	16
+#define TAG_NO_CIP_HEADER	0
 #define TAG_CIP			1
 
 /* common isochronous packet header parameters */
@@ -234,11 +235,15 @@ EXPORT_SYMBOL(amdtp_stream_set_parameters);
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 {
 	unsigned int multiplier = 1;
+	unsigned int header_size = 0;
 
 	if (s->flags & CIP_JUMBO_PAYLOAD)
 		multiplier = 5;
+	if (!(s->flags & CIP_NO_HEADER))
+		header_size = 8;
 
-	return 8 + s->syt_interval * s->data_block_quadlets * 4 * multiplier;
+	return header_size +
+		s->syt_interval * s->data_block_quadlets * 4 * multiplier;
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
@@ -380,7 +385,7 @@ static int queue_packet(struct amdtp_stream *s, unsigned int header_length,
 		goto end;
 
 	p.interrupt = IS_ALIGNED(s->packet_index + 1, INTERRUPT_INTERVAL);
-	p.tag = TAG_CIP;
+	p.tag = s->tag;
 	p.header_length = header_length;
 	if (payload_length > 0)
 		p.payload_length = payload_length;
@@ -457,6 +462,34 @@ static int handle_out_packet(struct amdtp_stream *s,
 	return 0;
 }
 
+static int handle_out_packet_without_header(struct amdtp_stream *s,
+			unsigned int payload_length, unsigned int cycle,
+			unsigned int index)
+{
+	__be32 *buffer;
+	unsigned int syt;
+	unsigned int data_blocks;
+	unsigned int pcm_frames;
+	struct snd_pcm_substream *pcm;
+
+	buffer = s->buffer.packets[s->packet_index].buffer;
+	syt = calculate_syt(s, cycle);
+	data_blocks = calculate_data_blocks(s, syt);
+	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, &syt);
+	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+
+	payload_length = data_blocks * 4 * s->data_block_quadlets;
+	if (queue_out_packet(s, payload_length) < 0)
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
 static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int payload_length, unsigned int cycle,
 			    unsigned int index)
@@ -573,6 +606,30 @@ static int handle_in_packet(struct amdtp_stream *s,
 	return 0;
 }
 
+static int handle_in_packet_without_header(struct amdtp_stream *s,
+			unsigned int payload_quadlets, unsigned int cycle,
+			unsigned int index)
+{
+	__be32 *buffer;
+	unsigned int data_blocks;
+	struct snd_pcm_substream *pcm;
+	unsigned int pcm_frames;
+
+	buffer = s->buffer.packets[s->packet_index].buffer;
+	data_blocks = payload_quadlets / s->data_block_quadlets;
+	pcm_frames = s->process_data_blocks(s, buffer, data_blocks, NULL);
+	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
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
 /*
  * In CYCLE_TIMER register of IEEE 1394, 7 bits are used to represent second. On
  * the other hand, in DMA descriptors of 1394 OHCI, 3 bits are used to represent
@@ -616,7 +673,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 	for (i = 0; i < packets; ++i) {
 		cycle = increment_cycle_count(cycle, 1);
-		if (handle_out_packet(s, 0, cycle, i) < 0) {
+		if (s->handle_packet(s, 0, cycle, i) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
@@ -663,7 +720,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 			break;
 		}
 
-		if (handle_in_packet(s, payload_length, cycle, i) < 0)
+		if (s->handle_packet(s, payload_length, cycle, i) < 0)
 			break;
 	}
 
@@ -699,10 +756,18 @@ static void amdtp_stream_first_callback(struct fw_iso_context *context,
 		packets = header_length / IN_PACKET_HEADER_SIZE;
 		cycle = decrement_cycle_count(cycle, packets);
 		context->callback.sc = in_stream_callback;
+		if (s->flags & CIP_NO_HEADER)
+			s->handle_packet = handle_in_packet_without_header;
+		else
+			s->handle_packet = handle_in_packet;
 	} else {
 		packets = header_length / 4;
 		cycle = increment_cycle_count(cycle, QUEUE_LENGTH - packets);
 		context->callback.sc = out_stream_callback;
+		if (s->flags & CIP_NO_HEADER)
+			s->handle_packet = handle_out_packet_without_header;
+		else
+			s->handle_packet = handle_out_packet;
 	}
 
 	s->start_cycle = cycle;
@@ -782,6 +847,11 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	amdtp_stream_update(s);
 
+	if (s->flags & CIP_NO_HEADER)
+		s->tag = TAG_NO_CIP_HEADER;
+	else
+		s->tag = TAG_CIP;
+
 	s->packet_index = 0;
 	do {
 		if (s->direction == AMDTP_IN_STREAM)
@@ -794,7 +864,7 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 
 	/* NOTE: TAG1 matches CIP. This just affects in stream. */
 	tag = FW_ISO_CONTEXT_MATCH_TAG1;
-	if (s->flags & CIP_EMPTY_WITH_TAG0)
+	if ((s->flags & CIP_EMPTY_WITH_TAG0) || (s->flags & CIP_NO_HEADER))
 		tag |= FW_ISO_CONTEXT_MATCH_TAG0;
 
 	s->callbacked = false;
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index a31dfd8..2bd4de4 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -31,6 +31,7 @@
  *	allows 5 times as large as IEC 61883-6 defines.
  * @CIP_HEADER_WITHOUT_EOH: Only for in-stream. CIP Header doesn't include
  *	valid EOH.
+ * @CIP_NO_HEADERS: a lack of headers in packets
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -42,6 +43,7 @@ enum cip_flags {
 	CIP_EMPTY_HAS_WRONG_DBC	= 0x20,
 	CIP_JUMBO_PAYLOAD	= 0x40,
 	CIP_HEADER_WITHOUT_EOH	= 0x80,
+	CIP_NO_HEADER		= 0x100,
 };
 
 /**
@@ -104,6 +106,10 @@ struct amdtp_stream {
 	struct fw_iso_context *context;
 	struct iso_packets_buffer buffer;
 	int packet_index;
+	int tag;
+	int (*handle_packet)(struct amdtp_stream *s,
+			unsigned int payload_quadlets, unsigned int cycle,
+			unsigned int index);
 
 	/* For CIP headers. */
 	unsigned int source_node_id_field;
-- 
2.9.3
