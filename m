From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: firewire-motu: add tracepoints for
	messages for unique protocol
Date: Sun,  9 Apr 2017 21:33:29 +0900
Message-ID: <20170409123329.12079-4-o-takashi@sakamocchi.jp>
References: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 2182526648D
 for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2017 14:33:34 +0200 (CEST)
In-Reply-To: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
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

MOTU units transfer/receive messages in each data block of their
isochronous packet payload. A part of content in the message is cleard for
MIDI message transmission, while the rest is unknown yet. Additional
features are required to assist users and developers to reveal the
details.

This commit adds tracepoints for the purpose. The tracepoints are designed
for MOTU's protocol version 2 and 3 (Protocol version 1 is not upstreamed
yet). In the tracepoints, events are probed to gather first two 24 bit
data chunks of each data block. The chunks are formatted into elements
of 64 bit array with padding in MSB.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu-trace.h | 50 ++++++++++++++++++++++++++++++++++
 sound/firewire/motu/amdtp-motu.c       | 17 ++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/sound/firewire/motu/amdtp-motu-trace.h b/sound/firewire/motu/amdtp-motu-trace.h
index 5862bf9..cd0cbfa9 100644
--- a/sound/firewire/motu/amdtp-motu-trace.h
+++ b/sound/firewire/motu/amdtp-motu-trace.h
@@ -15,6 +15,8 @@
 
 static void copy_sph(u32 *frame, __be32 *buffer, unsigned int data_blocks,
 		     unsigned int data_block_quadlets);
+static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
+			 unsigned int data_block_quadlets);
 
 TRACE_EVENT(in_data_block_sph,
 	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
@@ -64,6 +66,54 @@ TRACE_EVENT(out_data_block_sph,
 	)
 );
 
+TRACE_EVENT(in_data_block_message,
+	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
+	TP_ARGS(s, data_blocks, buffer),
+	TP_STRUCT__entry(
+		__field(int, src)
+		__field(int, dst)
+		__field(unsigned int, data_blocks)
+		__dynamic_array(u64, messages, data_blocks)
+	),
+	TP_fast_assign(
+		__entry->src = fw_parent_device(s->unit)->node_id;
+		__entry->dst = fw_parent_device(s->unit)->card->node_id;
+		__entry->data_blocks = data_blocks;
+		copy_message(__get_dynamic_array(messages), buffer, data_blocks, s->data_block_quadlets);
+	),
+	TP_printk(
+		"%04x %04x %u %s",
+		__entry->src,
+		__entry->dst,
+		__entry->data_blocks,
+		__print_array(__get_dynamic_array(messages), __entry->data_blocks, 8)
+	)
+);
+
+TRACE_EVENT(out_data_block_message,
+	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
+	TP_ARGS(s, data_blocks, buffer),
+	TP_STRUCT__entry(
+		__field(int, src)
+		__field(int, dst)
+		__field(unsigned int, data_blocks)
+		__dynamic_array(u64, messages, data_blocks)
+	),
+	TP_fast_assign(
+		__entry->src = fw_parent_device(s->unit)->card->node_id;
+		__entry->dst = fw_parent_device(s->unit)->node_id;
+		__entry->data_blocks = data_blocks;
+		copy_message(__get_dynamic_array(messages), buffer, data_blocks, s->data_block_quadlets);
+	),
+	TP_printk(
+		"%04x %04x %u %s",
+		__entry->src,
+		__entry->dst,
+		__entry->data_blocks,
+		__print_array(__get_dynamic_array(messages), __entry->data_blocks, 8)
+	)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 2c77e8b..996b5f8 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -280,6 +280,21 @@ static void copy_sph(u32 *frames, __be32 *buffer, unsigned int data_blocks,
 	}
 }
 
+/* For tracepoints. */
+static void copy_message(u64 *frames, __be32 *buffer, unsigned int data_blocks,
+			 unsigned int data_block_quadlets)
+{
+	unsigned int i;
+
+	/* This is just for v2/v3 protocol. */
+	for (i = 0; i < data_blocks; ++i) {
+		*frames = (be32_to_cpu(buffer[1]) << 16) |
+			  (be32_to_cpu(buffer[2]) >> 16);
+		buffer += data_block_quadlets;
+		frames++;
+	}
+}
+
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 				__be32 *buffer, unsigned int data_blocks,
 				unsigned int *syt)
@@ -288,6 +303,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	struct snd_pcm_substream *pcm;
 
 	trace_in_data_block_sph(s, data_blocks, buffer);
+	trace_in_data_block_message(s, data_blocks, buffer);
 
 	if (p->midi_ports)
 		read_midi_messages(s, buffer, data_blocks);
@@ -365,6 +381,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 	write_sph(s, buffer, data_blocks);
 
 	trace_out_data_block_sph(s, data_blocks, buffer);
+	trace_out_data_block_message(s, data_blocks, buffer);
 
 	return data_blocks;
 }
-- 
2.9.3
