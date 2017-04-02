From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire-digi00x: handle all MIDI
	messages on streaming packets
Date: Sun,  2 Apr 2017 23:48:25 +0900
Message-ID: <20170402144827.32497-3-o-takashi@sakamocchi.jp>
References: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2667126696B
 for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2017 16:48:32 +0200 (CEST)
In-Reply-To: <20170402144827.32497-1-o-takashi@sakamocchi.jp>
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

At a commit 9dc5d31cdceb ("ALSA: firewire-digi00x: handle MIDI messages in
isochronous packets"), a functionality to handle MIDI messages on
isochronous packet was supported. But this includes some of my
misunderstanding. This commit is to fix them.

For digi00x series, first data channel of data blocks in rx/tx packet
includes MIDI messages. The data channel has 0x80 in 8 bit of its MSB,
however it's against IEC 61883-6. Unique data format is applied:
 - Upper 4 bits of LSB represent port number.
  - 0x0: port 1.
  - 0x2: port 2.
  - 0xe: console port.
 - Lower 4 bits of LSB represent the number of included MIDI message bytes;
   0x0/0x1/0x2.
 - Two bytes of middle of this data channel have MIDI bytes.

Especially, MIDI messages from/to console surface are also transferred by
isochronous packets, as well as physical MIDI ports.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/amdtp-dot.c | 55 +++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index b3cffd0..a468854 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -28,6 +28,9 @@
  */
 #define MAX_MIDI_RX_BLOCKS	8
 
+/* 3 = MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) + 1. */
+#define MAX_MIDI_PORTS		3
+
 /*
  * The double-oh-three algorithm was discovered by Robin Gareus and Damien
  * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
@@ -42,10 +45,8 @@ struct amdtp_dot {
 	unsigned int pcm_channels;
 	struct dot_state state;
 
-	unsigned int midi_ports;
-	/* 2 = MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) */
-	struct snd_rawmidi_substream *midi[2];
-	int midi_fifo_used[2];
+	struct snd_rawmidi_substream *midi[MAX_MIDI_PORTS];
+	int midi_fifo_used[MAX_MIDI_PORTS];
 	int midi_fifo_limit;
 
 	void (*transfer_samples)(struct amdtp_stream *s,
@@ -124,8 +125,8 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
 		return -EBUSY;
 
 	/*
-	 * A first data channel is for MIDI conformant data channel, the rest is
-	 * Multi Bit Linear Audio data channel.
+	 * A first data channel is for MIDI messages, the rest is Multi Bit
+	 * Linear Audio data channel.
 	 */
 	err = amdtp_stream_set_parameters(s, rate, pcm_channels + 1);
 	if (err < 0)
@@ -135,11 +136,6 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
 
 	p->pcm_channels = pcm_channels;
 
-	if (s->direction == AMDTP_IN_STREAM)
-		p->midi_ports = DOT_MIDI_IN_PORTS;
-	else
-		p->midi_ports = DOT_MIDI_OUT_PORTS;
-
 	/*
 	 * We do not know the actual MIDI FIFO size of most devices.  Just
 	 * assume two bytes, i.e., one byte can be received over the bus while
@@ -281,13 +277,25 @@ static void write_midi_messages(struct amdtp_stream *s, __be32 *buffer,
 		b = (u8 *)&buffer[0];
 
 		len = 0;
-		if (port < p->midi_ports &&
+		if (port < MAX_MIDI_PORTS &&
 		    midi_ratelimit_per_packet(s, port) &&
 		    p->midi[port] != NULL)
 			len = snd_rawmidi_transmit(p->midi[port], b + 1, 2);
 
 		if (len > 0) {
-			b[3] = (0x10 << port) | len;
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1.
+			 * - 0010b: physical MIDI port 2.
+			 * - 1110b: console MIDI port.
+			 */
+			if (port == 2)
+				b[3] = 0xe0;
+			else if (port == 1)
+				b[3] = 0x20;
+			else
+				b[3] = 0x00;
+			b[3] |= len;
 			midi_use_bytes(s, port, len);
 		} else {
 			b[1] = 0;
@@ -309,11 +317,22 @@ static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
 
 	for (f = 0; f < data_blocks; f++) {
 		b = (u8 *)&buffer[0];
-		port = b[3] >> 4;
-		len = b[3] & 0x0f;
 
-		if (port < p->midi_ports && p->midi[port] && len > 0)
-			snd_rawmidi_receive(p->midi[port], b + 1, len);
+		len = b[3] & 0x0f;
+		if (len > 0) {
+			/*
+			 * Upper 4 bits of LSB represent port number.
+			 * - 0000b: physical MIDI port 1. Use port 0.
+			 * - 1110b: console MIDI port. Use port 2.
+			 */
+			if (b[3] >> 4 > 0)
+				port = 2;
+			else
+				port = 0;
+
+			if (port < MAX_MIDI_PORTS && p->midi[port])
+				snd_rawmidi_receive(p->midi[port], b + 1, len);
+		}
 
 		buffer += s->data_block_quadlets;
 	}
@@ -364,7 +383,7 @@ void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
 {
 	struct amdtp_dot *p = s->protocol;
 
-	if (port < p->midi_ports)
+	if (port < MAX_MIDI_PORTS)
 		ACCESS_ONCE(p->midi[port]) = midi;
 }
 
-- 
2.9.3
