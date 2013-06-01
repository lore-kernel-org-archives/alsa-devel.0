From: o-takashi@sakamocchi.jp
Subject: [PATCH 2/2] Add MIDI stream support with data rate restriction
Date: Sun,  2 Jun 2013 00:25:37 +0900
Message-ID: <1370100337-22463-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

IEC 61883-6 defines MIDI comformant deta and MMA/AMEI RP-027 defines its
implementation. This patch add handling MIDI stream according to them.

According to MMA/AMEI RP-027, one MIDI channel in AMDTP stream can handle
8 MIDI streams. The index of MIDI stream in one MIDI comformant
data channel is defined as "mod(data_block_count, 8)".

And one MIDI comformant data can send MIDI message up to 3 bytes. Every MIDI
comformant data includes "label" to indicate the number of bytes in its most
significant byte.

Then theoretically one MIDI stream can transmit MIDI messages up to 72,000
bytes per second at 192.0kHz (= 192,000 / 8 * 3).

But MIDI interface is based on MPU401-UART. It's maximum rate is 3,150 bytes
per seconds without label. So each device require a buffer between IEEE 1394
and MPU401-UART.

Actually Echo's Fireworks cannot handle higer data rate. The devices can
overflow MIDI messages when receiving at higher data rate. To prevent from
this, this module apply a restriction.

According to MMA/AMEI RP-027, to arrange data rate between transmitter and
receiver, they communicate by "a negotiation prucedure" and the devices without
this procedure should just support 3,125 bytes per second (1 byte per 320
microseconds) with 1 byte label.

This patch add an restriction of data rate up to 2,756 or 3,000 bytes per second
with simple logic. This restriction causes quite a small delay comparing to the
maximum data rate. But I hope to keep codes to be as simple as possible.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c |  157 +++++++++++++++++++++++++++++++++++++++++++++---
 sound/firewire/amdtp.h |   15 +++++
 2 files changed, 163 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index a042fe1..9d14361 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -1,6 +1,7 @@
 /*
  * Audio and Music Data Transmission Protocol (IEC 61883-6) streams
- * with Common Isochronous Packet (IEC 61883-1) headers
+ * with Common Isochronous Packet (IEC 61883-1) headers and MIDI comformant
+ * data according to MMA/AMEI RP-027.
  *
  * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
  * Licensed under the terms of the GNU General Public License, version 2.
@@ -12,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
+#include <sound/rawmidi.h>
 #include "amdtp.h"
 
 #define TICKS_PER_CYCLE		3072
@@ -52,6 +54,8 @@ static void pcm_period_tasklet(unsigned long data);
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		enum amdtp_stream_direction direction, enum cip_flags flags)
 {
+	int i;
+
 	if (flags != CIP_NONBLOCKING)
 		return -EINVAL;
 
@@ -64,6 +68,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->packet_index = 0;
 
 	s->pcm = NULL;
+	for (i = 0; i < AMDTP_MAX_MIDI_STREAMS; i += 1)
+		s->midi[i] = NULL;
 
 	return 0;
 }
@@ -405,18 +411,102 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
-	unsigned int i;
+	unsigned int m, f, c, port;
+	int len;
+	u8 b[4];
+
+	/*
+	 * This module can't support "negotiation procedure" in
+	 * MMA/AMEI RP-027. Then a maximum data rate is 3,125 bytes per second
+	 * without 1 byte label. This table is for the restriction. With this
+	 * table, the maximum data rate is between 2,000 to 3,000 bytes per
+	 * second.
+	 */
+	static const int block_interval[] = {
+		[CIP_SFC_32000]   = 16,
+		[CIP_SFC_44100]   = 16,
+		[CIP_SFC_48000]   = 16,
+		[CIP_SFC_88200]   = 32,
+		[CIP_SFC_96000]   = 32,
+		[CIP_SFC_176400]  = 64,
+		[CIP_SFC_192000]  = 64
+	};
 
-	for (i = 0; i < frames; ++i)
-		buffer[s->pcm_channels + i * s->data_block_quadlets] =
-						cpu_to_be32(0x80000000);
+	for (f = 0; f < frames; f += 1) {
+		/* skip PCM data */
+		buffer += s->pcm_channels;
+
+		/*
+		 * According to MMA/AMEI RP-027, one channels of AM824 can
+		 * handle 8 MIDI streams.
+		 */
+		m = (s->data_block_counter + f) % 8;
+		for (c = 0; c < DIV_ROUND_UP(s->midi_ports, 8); c += 1) {
+			/* MIDI stream number */
+			port = c * 8 + m;
+
+			b[0] = 0x80;
+			b[1] = 0x00;
+			b[2] = 0x00;
+			b[3] = 0x00;
+			len = 0;
+
+			if ((m == (s->data_block_counter + f) %
+						block_interval[s->sfc]) &&
+			    (s->midi[port] != NULL) &&
+			    test_bit(port, &s->midi_triggered)) {
+				len = snd_rawmidi_transmit(s->midi[port],
+								b + 1, 1);
+				if (len <= 0)
+					b[1] = 0x00;
+				else
+					b[0] = 0x81;
+			}
+
+			buffer[c] = (b[0] << 24) | (b[1] << 16) |
+							(b[2] << 8) | b[3];
+			buffer[c] = be32_to_cpu(buffer[c]);
+		}
+		buffer += s->data_block_quadlets - s->pcm_channels;
+	}
 }
 
 static void amdtp_pull_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
-	/* not implemented yet */
-	return;
+	unsigned int m, f, p, port;
+	int len, ret;
+	u8 *b;
+
+	for (f = 0; f < frames; f += 1) {
+		buffer += s->pcm_channels;
+
+		m = (s->data_block_counter + f) % 8;
+
+		for (p = 0; p < s->midi_ports; p += 1) {
+			b = (u8 *)&buffer[p];
+
+			if (b[0] < 0x81 || 0x83 < b[0])
+				continue;
+
+			len = b[0] - 0x80;
+
+			/* MIDI stream number */
+			port = p * 8 + m;
+
+			if ((s->midi[port] == NULL) ||
+			    !test_bit(port, &s->midi_triggered))
+				continue;
+
+			ret = snd_rawmidi_receive(s->midi[port], b + 1, len);
+			if (ret != len) {
+				dev_err(&s->unit->device,
+				"MIDI[%d] receive: %08X %08X %08X %08X\n",
+				port, b[0], b[1], b[2], b[3]);
+			}
+		}
+		buffer += s->data_block_quadlets - s->pcm_channels;
+	}
 }
 
 static void queue_out_packet(struct amdtp_stream *s, unsigned int cycle)
@@ -538,8 +628,8 @@ static void handle_in_packet_data(struct amdtp_stream *s,
 		 * current sampling rate. This is a workaround for Fireworks.
 		 */
 		if ((data_quadlets - 2) % data_block_quadlets > 0)
-			s->data_block_quadlets =
-					s->pcm_channels + s->midi_ports;
+			s->data_block_quadlets = s->pcm_channels +
+					DIV_ROUND_UP(s->midi_ports, 8);
 		else
 			s->data_block_quadlets = data_block_quadlets;
 
@@ -871,3 +961,52 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s)
 	}
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_abort);
+
+/**
+ * amdtp_stream_midi_insert - add MIDI stream
+ * @s: the AMDTP stream
+ * @substream: the MIDI stream to be added
+ *
+ * This function don't check the number of midi substream but it should be
+ * within AMDTP_MAX_MIDI_STREAMS.
+ */
+void amdtp_stream_midi_insert(struct amdtp_stream *s,
+				struct snd_rawmidi_substream *substream)
+{
+	ACCESS_ONCE(s->midi[substream->number]) = substream;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_insert);
+
+/**
+ * amdtp_stream_midi_extract - remove MIDI stream
+ * @s: the AMDTP stream
+ * @substream: the MIDI stream to be removed
+ *
+ * This function should not be automatically called by amdtp_stream_stop
+ * because the AMDTP stream only with MIDI stream need to be restarted by
+ * PCM streams at requested sampling rate.
+ */
+void amdtp_stream_midi_extract(struct amdtp_stream *s,
+				  struct snd_rawmidi_substream *substream)
+{
+	ACCESS_ONCE(s->midi[substream->number]) = NULL;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_extract);
+
+/**
+ * amdtp_stream_midi_running - check any MIDI streams are running or not
+ * @s: the AMDTP stream
+ *
+ * If this function returns true, any MIDI streams are running.
+ */
+bool amdtp_stream_midi_running(struct amdtp_stream *s)
+{
+	int i;
+	for (i = 0; i < AMDTP_MAX_MIDI_STREAMS; i += 1) {
+		if (!IS_ERR_OR_NULL(s->midi[i]))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(amdtp_stream_midi_running);
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 056f84a..492d87c 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -32,6 +32,12 @@ enum cip_sfc {
 
 #define AMDTP_OUT_PCM_FORMAT_BITS	(SNDRV_PCM_FMTBIT_S16 | \
 					 SNDRV_PCM_FMTBIT_S32)
+/*
+ * This module support maximum 8 MIDI streams
+ * This is not in MMA/AMEI RP-027 but for our convinience.
+ * Then AMDTP packets include maximum 2 quadlets in each data blocks.
+ */
+#define AMDTP_MAX_MIDI_STREAMS 16
 
 struct fw_unit;
 struct fw_iso_context;
@@ -75,6 +81,9 @@ struct amdtp_stream {
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
+
+	struct snd_rawmidi_substream *midi[AMDTP_MAX_MIDI_STREAMS];
+	unsigned long midi_triggered;	/* bit table for each MIDI substream */
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
@@ -94,6 +103,12 @@ void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 
+void amdtp_stream_midi_register(struct amdtp_stream *s,
+				struct snd_rawmidi_substream *substream);
+void amdtp_stream_midi_unregister(struct amdtp_stream *s,
+				  struct snd_rawmidi_substream *substream);
+bool amdtp_stream_midi_running(struct amdtp_stream *s);
+
 /**
  * amdtp_stream_set_pcm - configure format of PCM samples
  * @s: the AMDTP stream to be configured
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
