From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] [PATCH 3/3] firewire-lib: support Linux
	tracing to dump a part of packet data
Date: Sat, 16 Apr 2016 01:23:24 +0900
Message-ID: <1460737404-19699-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DFA632650B0
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 18:23:34 +0200 (CEST)
In-Reply-To: <1460737404-19699-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

When audio and music units have some quirks in their sequence of packet,
it's really hard for non-owners to identify the quirks. To handle the
quirks, developers need a dump for sequence of packets at least, however
it's difficult to users who have no knowledge and equipment for this
purpose.

This commit adds tracepoints for this situation. When users encounter
the issue, they can dump a part of packet data via Linux tracing framework
as long as using drivers in ALSA firewire stack.

Additionally, tracepoints for outgoing packets will be our help to check
and debug packet processing.

This commit adds 'snd_firewire_lib' subsystem with 'in_packet' and
'out_packet' events. In the events, some attributes of packets and the
index of packet managed by this module are recorded per packet.

This is a sample:

$ trace-cmd record -e snd_firewire_lib:out_packet \
                   -e snd_firewire_lib:in_packet
/sys/kernel/tracing/events/snd_firewire_lib/out_packet/filter
/sys/kernel/tracing/events/snd_firewire_lib/in_packet/filter
Hit Ctrl^C to stop recording
^C
$ trace-cmd report trace.dat
...
23647.033934: in_packet:  01 4073 ffc0 ffc1 00 000f0040 9001b2d1 122 44
23647.033936: in_packet:  01 4074 ffc0 ffc1 00 000f0048 9001c83b 122 45
23647.033937: in_packet:  01 4075 ffc0 ffc1 00 000f0050 9001ffff 002 46
23647.033938: in_packet:  01 4076 ffc0 ffc1 00 000f0050 9001e1a6 122 47
23647.035426: out_packet: 01 4123 ffc1 ffc0 01 010f00d0 9001fb40 122 17
23647.035428: out_packet: 01 4124 ffc1 ffc0 01 010f00d8 9001ffff 002 18
23647.035429: out_packet: 01 4125 ffc1 ffc0 01 010f00d8 900114aa 122 19
23647.035430: out_packet: 01 4126 ffc1 ffc0 01 010f00e0 90012a15 122 20
(Some common fields are omitted for a line to be within 80 characters.)
...

One line represent one packet. The legend for the last nine fields is:
 - The second of cycle scheduled for the packet
 - The count of cycle scheduled for the packet
 - The ID of node as source (hex)
  - Some devices transfer packets with invalid source node ID in their CIP
    header.
 - The ID of node as destination (hex)
  - The value is not in CIP header of packets.
 - The value of isochronous channel
 - The first quadlet of CIP header (hex)
 - The second quadlet of CIP header (hex)
 - The number of included quadlets
 - The index of packet inner buffer maintained by this module

This is an example to parse these lines from text file by Python3 script,
according to IEC 61883-1/6:

\#!/usr/bin/env python3
import sys

def parse_ts(second, cycle, syt):
    offset = syt & 0xfff
    syt >>= 12
    if cycle & 0x0f > syt:
        cycle += 0x10
    cycle &= 0x1ff0
    cycle |= syt
    second += cycle // 8000
    cycle %= 8000
    # In CYCLE_TIMER of 1394 OHCI, second is represented in 8 bit.
    second %= 128
    return (second, cycle, offset)

def calc_ts(second, cycle, offset):
    ts = offset
    ts += cycle * 3072
    # In DMA descriptor of 1394 OHCI, second is represented in 3 bit.
    ts += (second % 8) * 8000 * 3072
    return ts

def subtract_ts(minuend, subtrahend):
    # In DMA descriptor of 1394 OHCI, second is represented in 3 bit.
    if minuend < subtrahend:
        minuend += 8 * 8000 * 3072
    return minuend - subtrahend

if len(sys.argv) != 2:
    print('At least, one argument is required for packet dump.')
    sys.exit()

filename = sys.argv[1]

data = []

prev = 0
with open(filename, 'r') as f:
    for line in f:
        pos = line.find('packet:')
        if pos < 0:
            continue

        pos += len('packet:')
        line = line[pos:].strip()
        fields = line.split(' ')

        datum = []

        datum.append(fields[8])

        payload_size = int(fields[7], 10)
        data_block_size = int(fields[5][2:4], 16)
        data_blocks = (payload_size - 2) / data_block_size
        datum.append(data_blocks)

        second = int(fields[0], 10)
        cycle = int(fields[1], 10)
        start = (second << 25) | (cycle << 12)
        datum.append('0x{0:08x}'.format(start))
        start = calc_ts(second, cycle, 0)

        datum.append("0x" + fields[5])
        datum.append("0x" + fields[6])

        syt = int(fields[6][4:], 16)
        # Empty packet in IEC 61883-1, or NODATA in IEC 61883-6
        if syt == 0xffff:
            second = 0
            cycle = 0
            tick = 0
        else:
            second, cycle, tick = parse_ts(second, cycle, syt)
        ts = calc_ts(second, cycle, tick)
        datum.append(start)
        datum.append(ts)
        if ts == 0:
            datum.append(0)
            datum.append(0)
        else:
            # Usual case, or a case over 8 seconds.
            if ts > start or start > 7 * 8000 * 3072:
                datum.append(subtract_ts(ts, start))
                if ts > prev or start > 7 * 8000 * 3072:
                    gap = subtract_ts(ts, prev)
                    datum.append(gap)
                else:
                    datum.append('backward')
            else:
                datum.append('invalid')
            prev = ts

        data.append(datum)

The data variable includes array with these elements:
- The index of the packet
- The number of data blocks in the packet
- The value of cycle start (hex)
- The value of CIP header 1 in IEC 61883-1 (hex)
- The value of CIP header 2 in IEC 61883-1 (hex)
- The value of cycle start (tick)
- The value of calculated presentation timestamp (tick)
- The offset between the cycle start and presentation timestamp
- The elapsed ticks from the previous presentation timestamp

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile             |  3 ++
 sound/firewire/amdtp-stream-trace.h | 98 +++++++++++++++++++++++++++++++++++++
 sound/firewire/amdtp-stream.c       | 19 +++++--
 3 files changed, 115 insertions(+), 5 deletions(-)
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
index 0000000..425d1d7
--- /dev/null
+++ b/sound/firewire/amdtp-stream-trace.h
@@ -0,0 +1,98 @@
+/*
+ * amdtp-stream-trace.h - tracepoint definitions to dump a part of packet data
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
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, u32 cip_header[2], unsigned int payload_quadlets),
+	TP_ARGS(s, cycles, cip_header, payload_quadlets),
+	TP_STRUCT__entry(
+		__field(unsigned int, second)
+		__field(unsigned int, cycle)
+		__field(int, channel)
+		__field(int, src)
+		__field(int, dest)
+		__field(u32, cip_header0)
+		__field(u32, cip_header1)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->second = cycles / CYCLES_PER_SECOND;
+		__entry->cycle = cycles % CYCLES_PER_SECOND;
+		__entry->channel = s->context->channel;
+		__entry->src = fw_parent_device(s->unit)->node_id;
+		__entry->dest = fw_parent_device(s->unit)->card->node_id;
+		__entry->cip_header0 = cip_header[0];
+		__entry->cip_header1 = cip_header[1];
+		__entry->payload_quadlets = payload_quadlets;
+		__entry->index = s->packet_index;
+	),
+	TP_printk(
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u",
+		__entry->second,
+		__entry->cycle,
+		__entry->src,
+		__entry->dest,
+		__entry->channel,
+		__entry->cip_header0,
+		__entry->cip_header1,
+		__entry->payload_quadlets,
+		__entry->index)
+);
+
+TRACE_EVENT(out_packet,
+	TP_PROTO(const struct amdtp_stream *s, u32 cycles, __be32 *cip_header, unsigned int payload_length),
+	TP_ARGS(s, cycles, cip_header, payload_length),
+	TP_STRUCT__entry(
+		__field(unsigned int, second)
+		__field(unsigned int, cycle)
+		__field(int, channel)
+		__field(int, src)
+		__field(int, dest)
+		__field(u32, cip_header0)
+		__field(u32, cip_header1)
+		__field(unsigned int, payload_quadlets)
+		__field(unsigned int, index)
+	),
+	TP_fast_assign(
+		__entry->second = cycles / CYCLES_PER_SECOND;
+		__entry->cycle = cycles % CYCLES_PER_SECOND;
+		__entry->channel = s->context->channel;
+		__entry->src = fw_parent_device(s->unit)->card->node_id;
+		__entry->dest = fw_parent_device(s->unit)->node_id;
+		__entry->cip_header0 = be32_to_cpu(cip_header[0]);
+		__entry->cip_header1 = be32_to_cpu(cip_header[1]);
+		__entry->payload_quadlets = payload_length / 4;
+		__entry->index = s->packet_index;
+	),
+	TP_printk(
+		"%02u %04u %04x %04x %02d %08x %08x %03u %02u",
+		__entry->second,
+		__entry->cycle,
+		__entry->src,
+		__entry->dest,
+		__entry->channel,
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
index 4d86da0..a84a9ff 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -19,6 +19,10 @@
 #define CYCLES_PER_SECOND	8000
 #define TICKS_PER_SECOND	(TICKS_PER_CYCLE * CYCLES_PER_SECOND)
 
+/* Always support Linux tracing subsystem. */
+#define CREATE_TRACE_POINTS
+#include "amdtp-stream-trace.h"
+
 #define TRANSFER_DELAY_TICKS	0x2e00 /* 479.17 microseconds */
 
 /* isochronous header parameters */
@@ -409,7 +413,7 @@ static inline int queue_in_packet(struct amdtp_stream *s)
 }
 
 static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
-			     unsigned int syt)
+			     unsigned int cycle, unsigned int syt)
 {
 	__be32 *buffer;
 	unsigned int payload_length;
@@ -433,6 +437,8 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 	if (queue_out_packet(s, payload_length, false) < 0)
 		return -EIO;
 
+	trace_out_packet(s, cycle, buffer, payload_length);
+
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm && pcm_frames > 0)
 		update_pcm_pointers(s, pcm, pcm_frames);
@@ -443,7 +449,8 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 
 static int handle_in_packet(struct amdtp_stream *s,
 			    unsigned int payload_quadlets, __be32 *buffer,
-			    unsigned int *data_blocks, unsigned int syt)
+			    unsigned int *data_blocks, unsigned int cycle,
+			    unsigned int syt)
 {
 	u32 cip_header[2];
 	unsigned int fmt, fdf;
@@ -455,6 +462,8 @@ static int handle_in_packet(struct amdtp_stream *s,
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
+	trace_in_packet(s, cycle, cip_header, payload_quadlets);
+
 	/*
 	 * This module supports 'Two-quadlet CIP header with SYT field'.
 	 * For convenience, also check FMT field is AM824 or not.
@@ -595,7 +604,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		syt = calculate_syt(s, cycle);
 		data_blocks = calculate_data_blocks(s, syt);
 
-		if (handle_out_packet(s, data_blocks, syt) < 0) {
+		if (handle_out_packet(s, data_blocks, cycle, syt) < 0) {
 			s->packet_index = -1;
 			amdtp_stream_pcm_abort(s);
 			return;
@@ -647,7 +656,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 
 		syt = be32_to_cpu(buffer[1]) & CIP_SYT_MASK;
 		if (handle_in_packet(s, payload_quadlets, buffer,
-						&data_blocks, syt) < 0) {
+						&data_blocks, cycle, syt) < 0) {
 			s->packet_index = -1;
 			break;
 		}
@@ -655,7 +664,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		/* Process sync slave stream */
 		if (s->sync_slave && s->sync_slave->callbacked) {
 			if (handle_out_packet(s->sync_slave,
-					      data_blocks, syt) < 0) {
+					      data_blocks, cycle, syt) < 0) {
 				s->packet_index = -1;
 				break;
 			}
-- 
2.7.4
