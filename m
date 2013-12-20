From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/38] firewire-lib: Add sort function for transmitted packet
Date: Fri, 20 Dec 2013 22:14:00 +0900
Message-ID: <1387545269-3875-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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

The aim of this commit is to assure the continuity of timestamp in in-packets
transmitted by the device.

When callback of receive-context is processed, the parameters of in-packets are
stored in sort table and sorted by its value of data block counter. The sort
algorism works faster in ordered sequence than in messy sequence. This is
convinient for this purpose because the sequence is assumed not to be so messy.
After sorting, packets are processed except for a last few packets in sort
table. These packets are stored in buffer once and used in next cycle.

Fireworks with firmware version 5.5 or former is a type of device which
transmits packets with a bit disorder. For example,

Index  Payload	CIP header 1  CIP header 2
023    210      3F1100F8      900478E9
024    002      3F1100F8      90FFFFFF
025    210      3F110000      900490E9
026    210      3F110008      9004A4E9
027    210      3F110010      9004B8E9
028    002      3F110010      90FFFFFF
029    210      3F110020      9004E4E8 <-
030    210      3F110018      9004D0E8 <-
031    210      3F110028      9004F8E8
032    002      3F110028      90FFFFFF
033    210      3F110030      900410E8
034    210      3F110038      900424E8
035    210      3F110040      900438E8
036    002      3F110040      90FFFFFF
037    210      3F110050      900464E8 <-
038    210      3F110048      900450E8 <-
039    210      3F110058      900478E8
040    002      3F110058      90FFFFFF
041    210      3F110068      9004A4E8 <-
042    210      3F110060      900490E8 <-
043    210      3F110070      9004B8E8
044    002      3F110070      90FFFFFF
045    210      3F110080      9004E4E7 <-
046    210      3F110078      9004D0E8 <-

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 130 +++++++++++++++++++++++++++++++++++++++++++------
 sound/firewire/amdtp.h |   4 ++
 2 files changed, 119 insertions(+), 15 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 03dd9b3..b17ec9b 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -45,6 +45,7 @@
 #define AMDTP_DBS_MASK		0x00ff0000
 #define AMDTP_DBS_SHIFT		16
 #define AMDTP_DBC_MASK		0x000000ff
+#define DBC_THRESHOLD		(AMDTP_DBC_MASK / 2)
 
 /* TODO: make these configurable */
 #define INTERRUPT_INTERVAL	16
@@ -54,6 +55,13 @@
 #define IN_PACKET_HEADER_SIZE	4
 #define OUT_PACKET_HEADER_SIZE	0
 
+/* for re-ordering receive packets */
+struct sort_table {
+	unsigned int id;
+	unsigned int dbc;
+	unsigned int payload_size;
+};
+
 static void pcm_period_tasklet(unsigned long data);
 
 /**
@@ -78,6 +86,9 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->callbacked = false;
 	s->sync_slave = ERR_PTR(-1);
 
+	s->sort_table = NULL;
+	s->left_packets = NULL;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -736,6 +747,44 @@ static void handle_in_packet(struct amdtp_stream *s,
 		update_pcm_pointers(s, pcm, data_blocks);
 }
 
+#define SWAP(tbl, m, n) \
+	t = tbl[n].id; \
+	tbl[n].id = tbl[m].id; \
+	tbl[m].id = t; \
+	t = tbl[n].dbc; \
+	tbl[n].dbc = tbl[m].dbc; \
+	tbl[m].dbc = t; \
+	t = tbl[n].payload_size; \
+	tbl[n].payload_size = tbl[m].payload_size; \
+	tbl[m].payload_size = t;
+static void packet_sort(struct sort_table *tbl, unsigned int len)
+{
+	unsigned int i, j, k, t;
+
+	i = 0;
+	do {
+		for (j = i + 1; j < len; j++) {
+			if (((tbl[i].dbc > tbl[j].dbc) &&
+			     (tbl[i].dbc - tbl[j].dbc < DBC_THRESHOLD))) {
+				SWAP(tbl, i, j);
+			} else if ((tbl[j].dbc > tbl[i].dbc) &&
+				   (tbl[j].dbc - tbl[i].dbc >
+							DBC_THRESHOLD)) {
+				for (k = i; k > 0; k--) {
+					if ((tbl[k].dbc > tbl[j].dbc) ||
+					    (tbl[j].dbc - tbl[k].dbc >
+							DBC_THRESHOLD)) {
+						SWAP(tbl, j, k);
+					}
+					break;
+				}
+			}
+			break;
+		}
+		i = j;
+	} while (i < len);
+}
+
 static void out_stream_callback(struct fw_iso_context *context, u32 cycle,
 				size_t header_length, void *header,
 				void *private_data)
@@ -762,30 +811,65 @@ static void in_stream_callback(struct fw_iso_context *context, u32 cycle,
 			       void *private_data)
 {
 	struct amdtp_stream *s = private_data;
-	unsigned int p, packets, syt, data_quadlets;
+	struct sort_table *entry, *tbl = s->sort_table;
+	unsigned int i, j, k, index, packets, syt, remain_packets;
 	__be32 *buffer, *headers = header;
 
 	/* The number of packets in buffer */
 	packets = header_length / IN_PACKET_HEADER_SIZE;
 
-	for (p = 0; p < packets; p++) {
-		buffer = s->buffer.packets[s->packet_index].buffer;
+	/* Store into sort table and sort. */
+	for (i = 0; i < packets; i++) {
+		entry = &tbl[s->remain_packets + i];
+		entry->id = i;
 
-		/* The number of quadlets in this packet */
-		data_quadlets =
-			(be32_to_cpu(headers[p]) >> ISO_DATA_LENGTH_SHIFT) / 4;
+		index = s->packet_index + i;
+		if (index >= QUEUE_LENGTH)
+			index -= QUEUE_LENGTH;
+		buffer = s->buffer.packets[index].buffer;
+		entry->dbc = be32_to_cpu(buffer[0]) & AMDTP_DBC_MASK;
 
-		/* Process sync slave stream */
-		if ((s->flags & CIP_BLOCKING) &&
-		    (s->flags & CIP_SYNC_TO_DEVICE) &&
-		    s->sync_slave->callbacked) {
-			syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
-			handle_out_packet(s->sync_slave, syt);
-		}
+		entry->payload_size = be32_to_cpu(headers[i]) >>
+				      ISO_DATA_LENGTH_SHIFT;
+	}
+	packet_sort(tbl, packets + s->remain_packets);
 
-		/* handle each packet data */
-		handle_in_packet(s, data_quadlets, buffer);
+	/*
+	 * for convinience, tbl[i].id >= QUEUE_LENGTH is a label to identify
+	 * previous packets in buffer.
+	 */
+	remain_packets = s->remain_packets;
+	s->remain_packets = packets / 4;
+	for (i = 0, j = 0, k = 0; i < remain_packets + packets; i++) {
+		if (tbl[i].id < QUEUE_LENGTH) {
+			index = s->packet_index + tbl[i].id;
+			if (index >= QUEUE_LENGTH)
+				index -= QUEUE_LENGTH;
+			buffer = s->buffer.packets[index].buffer;
+		} else
+			buffer = s->left_packets +
+				 amdtp_stream_get_max_payload(s) * j++;
+
+		if (i < remain_packets + packets - s->remain_packets) {
+			/* Process sync slave stream */
+			if ((s->flags & CIP_BLOCKING) &&
+			    (s->flags & CIP_SYNC_TO_DEVICE) &&
+			    s->sync_slave->callbacked) {
+				syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
+				handle_out_packet(s->sync_slave, syt);
+			}
+			handle_in_packet(s, tbl[i].payload_size / 4, buffer);
+		} else {
+			tbl[k].id = tbl[i].id + QUEUE_LENGTH;
+			tbl[k].dbc = tbl[i].dbc;
+			tbl[k].payload_size = tbl[i].payload_size;
+			memcpy(s->left_packets +
+					amdtp_stream_get_max_payload(s) * k++,
+			       buffer, tbl[i].payload_size);
+		}
+	}
 
+	for (i = 0; i < packets; i++) {
 		if (queue_in_packet(s) < 0) {
 			amdtp_stream_pcm_abort(s);
 			return;
@@ -884,6 +968,17 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	if (err < 0)
 		goto err_unlock;
 
+	/* for sorting transmitted packets */
+	if (s->direction == AMDTP_IN_STREAM) {
+		s->remain_packets = 0;
+		s->sort_table = kzalloc(sizeof(struct sort_table) *
+					QUEUE_LENGTH, GFP_KERNEL);
+		if (s->sort_table == NULL)
+			return -ENOMEM;
+		s->left_packets = kzalloc(amdtp_stream_get_max_payload(s) *
+					  QUEUE_LENGTH / 4, GFP_KERNEL);
+	}
+
 	s->context = fw_iso_context_create(fw_parent_device(s->unit)->card,
 					   type, channel, speed, header_size,
 					   amdtp_stream_callback, s);
@@ -982,6 +1077,11 @@ void amdtp_stream_stop(struct amdtp_stream *s)
 	s->context = ERR_PTR(-1);
 	iso_packets_buffer_destroy(&s->buffer, s->unit);
 
+	if (s->sort_table != NULL)
+		kfree(s->sort_table);
+	if (s->left_packets != NULL)
+		kfree(s->left_packets);
+
 	s->callbacked = false;
 
 	mutex_unlock(&s->mutex);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index e5d5999..4f57c9e 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -109,6 +109,10 @@ struct amdtp_stream {
 	bool callbacked;
 	wait_queue_head_t callback_wait;
 	struct amdtp_stream *sync_slave;
+
+	void *sort_table;
+	void *left_packets;
+	unsigned int remain_packets;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
