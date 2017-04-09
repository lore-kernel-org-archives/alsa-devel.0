From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: firewire-motu: add tracepoints for
	SPH in IEC 61883-1 fashion
Date: Sun,  9 Apr 2017 21:33:28 +0900
Message-ID: <20170409123329.12079-3-o-takashi@sakamocchi.jp>
References: <20170409123329.12079-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 252BA266AFA
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

Unique protocol is used for MOTU FireWire series. In this protocol,
data block format is not compliant to AM824 in IEC 61883-1/6. Each of
the data block consists of 24 bit data chunks, except for a first
quadlet. The quadlet is used for source packet header (SPH) described
in IEC 61883-1.

The sequence of SPH seems to represent presentation timestamp
corresponding to included data. Developers have experienced that invalid
sequence brings disorder of units in the series.

Unfortunately, current implementation of ALSA IEC 61883-1/6 engine and
firewire-motu driver brings periodical noises to the units at sampling
transmission frequency based on 44.1 kHz. The engine generates the SPH with
even interval and this mechanism seems not to be suitable to the units.
Further work is required for this issue and infrastructure is preferable
to assist the work.

This commit adds tracepoints for the purpose. In the tracepoints, events
are probed to gather the SPHs from each data blocks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile           |  2 +
 sound/firewire/motu/amdtp-motu-trace.h | 73 ++++++++++++++++++++++++++++++++++
 sound/firewire/motu/amdtp-motu.c       | 20 ++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 sound/firewire/motu/amdtp-motu-trace.h

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index ae84ae6..728f586 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,5 @@
+CFLAGS_amdtp-motu.o	:= -I$(src)
+
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
 			  motu-proc.o motu-pcm.o motu-midi.o motu-hwdep.o \
 			  motu-protocol-v2.o motu-protocol-v3.o
diff --git a/sound/firewire/motu/amdtp-motu-trace.h b/sound/firewire/motu/amdtp-motu-trace.h
new file mode 100644
index 0000000..5862bf9
--- /dev/null
+++ b/sound/firewire/motu/amdtp-motu-trace.h
@@ -0,0 +1,73 @@
+/*
+ * amdtp-motu-trace.h - tracepoint definitions to dump a part of packet data
+ *
+ * Copyright (c) 2017 Takashi Sakamoto
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM		snd_firewire_motu
+
+#if !defined(_SND_FIREWIRE_MOTU_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SND_FIREWIRE_MOTU_TRACE_H
+
+#include <linux/tracepoint.h>
+
+static void copy_sph(u32 *frame, __be32 *buffer, unsigned int data_blocks,
+		     unsigned int data_block_quadlets);
+
+TRACE_EVENT(in_data_block_sph,
+	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
+	TP_ARGS(s, data_blocks, buffer),
+	TP_STRUCT__entry(
+		__field(int, src)
+		__field(int, dst)
+		__field(unsigned int, data_blocks)
+		__dynamic_array(u32, tstamps, data_blocks)
+	),
+	TP_fast_assign(
+		__entry->src = fw_parent_device(s->unit)->node_id;
+		__entry->dst = fw_parent_device(s->unit)->card->node_id;
+		__entry->data_blocks = data_blocks;
+		copy_sph(__get_dynamic_array(tstamps), buffer, data_blocks, s->data_block_quadlets);
+	),
+	TP_printk(
+		"%04x %04x %u %s",
+		__entry->src,
+		__entry->dst,
+		__entry->data_blocks,
+		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, 4)
+	)
+);
+
+TRACE_EVENT(out_data_block_sph,
+	TP_PROTO(struct amdtp_stream *s, unsigned int data_blocks, __be32 *buffer),
+	TP_ARGS(s, data_blocks, buffer),
+	TP_STRUCT__entry(
+		__field(int, src)
+		__field(int, dst)
+		__field(unsigned int, data_blocks)
+		__dynamic_array(u32, tstamps, data_blocks)
+	),
+	TP_fast_assign(
+		__entry->src = fw_parent_device(s->unit)->card->node_id;
+		__entry->dst = fw_parent_device(s->unit)->node_id;
+		__entry->data_blocks = data_blocks;
+		copy_sph(__get_dynamic_array(tstamps), buffer, data_blocks, s->data_block_quadlets);
+	),
+	TP_printk(
+		"%04x %04x %u %s",
+		__entry->src,
+		__entry->dst,
+		__entry->data_blocks,
+		__print_array(__get_dynamic_array(tstamps), __entry->data_blocks, 4)
+	)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH	.
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE	amdtp-motu-trace
+#include <trace/define_trace.h>
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 08bd176..2c77e8b 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -10,6 +10,9 @@
 #include <sound/pcm.h>
 #include "motu.h"
 
+#define CREATE_TRACE_POINTS
+#include "amdtp-motu-trace.h"
+
 #define CIP_FMT_MOTU		0x02
 #define CIP_FMT_MOTU_TX_V3	0x22
 #define MOTU_FDF_AM824		0x22
@@ -264,6 +267,19 @@ static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
 	}
 }
 
+/* For tracepoints. */
+static void copy_sph(u32 *frames, __be32 *buffer, unsigned int data_blocks,
+		     unsigned int data_block_quadlets)
+{
+	unsigned int i;
+
+	for (i = 0; i < data_blocks; ++i) {
+		*frames = be32_to_cpu(*buffer);
+		buffer += data_block_quadlets;
+		frames++;
+	}
+}
+
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 				__be32 *buffer, unsigned int data_blocks,
 				unsigned int *syt)
@@ -271,6 +287,8 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 	struct amdtp_motu *p = s->protocol;
 	struct snd_pcm_substream *pcm;
 
+	trace_in_data_block_sph(s, data_blocks, buffer);
+
 	if (p->midi_ports)
 		read_midi_messages(s, buffer, data_blocks);
 
@@ -346,6 +364,8 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 
 	write_sph(s, buffer, data_blocks);
 
+	trace_out_data_block_sph(s, data_blocks, buffer);
+
 	return data_blocks;
 }
 
-- 
2.9.3
