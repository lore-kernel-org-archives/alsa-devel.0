From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH] ALSA: firewire-lib: support Linux tracing
	to dump a part of packet data
Date: Sun, 27 Mar 2016 21:18:06 +0900
Message-ID: <1459081086-6145-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id BD7C3260711
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 14:18:10 +0200 (CEST)
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

When audio and music units have some quirks in their sequence of packet,
it's really hard for non-owners to identify the quirks. To handle the
quirks, developers need a dump for sequence of packets at least, however
it's difficult to users who have no knowledge and equipment for this
purpose.

This commit adds tracepoints for this situation. When users encounter
the issue, they can dump a part of packet data via Linux tracing framework
as long as using drivers in ALSA firewire stack.

This commit adds 'snd-firewire-lib' subsystem with 'in_packet' and
'out_packet' events. In the events, the content of CIP headers, the number
of included quadlets and the index of packet managed by this module are
recorded per packet.

This is a sample:

$ trace-cmd record -e snd_firewire_lib:out_packet -e snd_firewire_lib:in_packet
/sys/kernel/tracing/events/snd_firewire_lib/out_packet/filter
/sys/kernel/tracing/events/snd_firewire_lib/in_packet/filter
Hit Ctrl^C to stop recording
^C
$ trace-cmd report trace.dat
...
<idle>-0  [002] 40398.221702: out_packet: 00070008 9001427a: 058: 31
<idle>-0  [002] 40398.221703: in_packet:  01020010 9001ffff: 002: 15
<idle>-0  [002] 40398.221703: out_packet: 00070010 9001ffff: 002: 32
<idle>-0  [002] 40398.223679: in_packet:  010b0010 900157e4: 090: 16
<idle>-0  [002] 40398.223681: out_packet: 00070010 900157e4: 058: 33
<idle>-0  [002] 40398.223681: in_packet:  010b0018 9001714f: 090: 17
...

One line represent one packet. The legend for the last four fields is:
 - The first quadlet of CIP header
 - The second quadlet of CIP header
 - The number of included quadlets
 - The index of packet inner buffer maintained by this module

Currently, when detecting packet discontinuity, this module stops packet
streaming. This is reasonable to packet streaming implementation. However,
to identify the quirks, packet streaming should continue to dump enough
sequence of packet. This commit adds a condition statement and a marker
for this purpose.
---
 sound/firewire/Makefile             |  3 ++
 sound/firewire/amdtp-stream-trace.h | 68 +++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.c       | 17 +++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/amdtp-stream-trace.h

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 003c090..0ee1fb1 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,3 +1,6 @@
+# To find a header included by define_trace.h.
+CFLAGS_amdtp-stream.o	:= -I$(src)
+
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp-stream.o amdtp-am824.o
 snd-isight-objs := isight.o
diff --git a/sound/firewire/amdtp-stream-trace.h b/sound/firewire/amdtp-stream-trace.h
new file mode 100644
index 0000000..316d495
--- /dev/null
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -0,0 +1,68 @@
+/*
+ * amdtp-stream-trace.h - Linux tracing application for ALSA AMDTP engine
+ *
+ * Copyright (c) 2016 Takashi Sakamoto
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM		snd_firewire_lib
+
+#if !defined(_AMDTP_STREAM_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _AMDTP_STREAM_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(in_packet,
+	TP_PROTO(u32 cip_header0, u32 cip_header1, unsigned int payload_quadlets, unsigned int index),
+	TP_ARGS(cip_header0, cip_header1, payload_quadlets, index),
+	TP_STRUCT__entry(
+		__field(u32, cip_header0)
+		__field(u32, cip_header1)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->cip_header0 = cip_header0;
+		__entry->cip_header1 = cip_header1;
+		__entry->payload_quadlets = payload_quadlets;
+		__entry->index = index;
+	),
+	TP_printk(
+		"%08x %08x: %03u: %02u",
+		__entry->cip_header0,
+		__entry->cip_header1,
+		__entry->payload_quadlets,
+		__entry->index)
+);
+
+TRACE_EVENT(out_packet,
+	TP_PROTO(u32 cip_header0, u32 cip_header1, unsigned int payload_quadlets, unsigned int index),
+	TP_ARGS(cip_header0, cip_header1, payload_quadlets, index),
+	TP_STRUCT__entry(
+		__field(u32, cip_header0)
+		__field(u32, cip_header1)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->cip_header0 = cip_header0;
+		__entry->cip_header1 = cip_header1;
+		__entry->payload_quadlets = payload_quadlets;
+		__entry->index = index;
+	),
+	TP_printk(
+		"%08x %08x: %03u: %02u",
+		__entry->cip_header0,
+		__entry->cip_header1,
+		__entry->payload_quadlets,
+		__entry->index)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH	.
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE	amdtp-stream-trace
+#include <trace/define_trace.h>
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index ed29026..152375f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -15,6 +15,10 @@
 #include <sound/pcm_params.h>
 #include "amdtp-stream.h"
 
+/* Always support tracepoints enabled by Linux tracing subsystem. */
+#define CREATE_TRACE_POINTS
+#include "amdtp-stream-trace.h"
+
 #define TICKS_PER_CYCLE		3072
 #define CYCLES_PER_SECOND	8000
 #define TICKS_PER_SECOND	(TICKS_PER_CYCLE * CYCLES_PER_SECOND)
@@ -426,6 +430,10 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
 	payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
+
+	trace_out_packet(be32_to_cpu(buffer[0]), be32_to_cpu(buffer[1]),
+			 payload_length / 4, s->packet_index);
+
 	if (queue_out_packet(s, payload_length, false) < 0)
 		return -EIO;
 
@@ -451,6 +459,9 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
+	trace_in_packet(cip_header[0], cip_header[1], payload_quadlets,
+			s->packet_index);
+
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
@@ -523,7 +534,11 @@ static int handle_in_packet(struct amdtp_stream *s,
 		dev_err(&s->unit->device,
 			"Detect discontinuity of CIP: %02X %02X\n",
 			s->data_block_counter, data_block_counter);
-		return -EIO;
+		if (!trace_in_packet_enabled())
+			return -EIO;
+
+		/* To identifying this situation. */
+		trace_in_packet(0xffffffff, 0xffffffff, 999, 99);
 	}
 
 	pcm_frames = s->process_data_blocks(s, buffer + 2, *data_blocks, &syt);
-- 
2.7.3
