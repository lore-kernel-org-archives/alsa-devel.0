From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] firewire-digi00x: handle MIDI messages in
	isochronous packets
Date: Sun, 11 Oct 2015 12:30:15 +0900
Message-ID: <1444534219-31718-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A12DB2605E8
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 05:30:30 +0200 (CEST)
In-Reply-To: <1444534219-31718-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In Digi 002/003 protocol, MIDI messages are transferred in the last data
channel of data blocks. Although this data channel has a label of 0x80,
it's not fully MIDI conformant data channel especially because the Counter
field always zero independently of included MIDI bytes. The 4th byte of
the data channel in LSB tells the number of included MIDI bytes. This byte
also includes the number of MIDI port. Therefore, the data format in this
data channel is:
 * 1st: 0x80 as label
 * 2nd: MIDI bytes
 * 3rd: 0 or MIDI bytes
 * 4th: the number of MIDI byte and the number of MIDI port

This commit adds support of MIDI messages in data block processing layer.

Like AM824 data format, this data channel has a capability to transfer
more MIDI messages than the capability of phisical MIDI bus. Therefore, a
throttle for data rate is  required to prevent devices' internal buffer to
overflow.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/amdtp-dot.c      | 120 ++++++++++++++++++++++++++++++--
 sound/firewire/digi00x/digi00x-stream.c |   4 +-
 sound/firewire/digi00x/digi00x.h        |   9 ++-
 3 files changed, 125 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/digi00x/amdtp-dot.c b/sound/firewire/digi00x/amdtp-dot.c
index c12ce4d..b02a5e8c 100644
--- a/sound/firewire/digi00x/amdtp-dot.c
+++ b/sound/firewire/digi00x/amdtp-dot.c
@@ -17,6 +17,18 @@
 #define AMDTP_FDF_AM824		0x00
 
 /*
+ * Nominally 3125 bytes/second, but the MIDI port's clock might be
+ * 1% too slow, and the bus clock 100 ppm too fast.
+ */
+#define MIDI_BYTES_PER_SECOND	3093
+
+/*
+ * Several devices look only at the first eight data blocks.
+ * In any case, this is more than enough for the MIDI data rate.
+ */
+#define MAX_MIDI_RX_BLOCKS	8
+
+/*
  * The double-oh-three algorithm was discovered by Robin Gareus and Damien
  * Zammit in 2012, with reverse-engineering for Digi 003 Rack.
  */
@@ -31,6 +43,10 @@ struct amdtp_dot {
 	struct dot_state state;
 
 	unsigned int midi_ports;
+	/* 2 = MAX(DOT_MIDI_IN_PORTS, DOT_MIDI_OUT_PORTS) */
+	struct snd_rawmidi_substream *midi[2];
+	int midi_fifo_used[2];
+	int midi_fifo_limit;
 
 	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
@@ -99,7 +115,7 @@ static void dot_encode_step(struct dot_state *state, __be32 *const buffer)
 }
 
 int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
-			     unsigned int pcm_channels, unsigned int midi_ports)
+			     unsigned int pcm_channels)
 {
 	struct amdtp_dot *p = s->protocol;
 	int err;
@@ -118,7 +134,19 @@ int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
 	s->fdf = AMDTP_FDF_AM824 | s->sfc;
 
 	p->pcm_channels = pcm_channels;
-	p->midi_ports = midi_ports;
+
+	if (s->direction == AMDTP_IN_STREAM)
+		p->midi_ports = DOT_MIDI_IN_PORTS;
+	else
+		p->midi_ports = DOT_MIDI_OUT_PORTS;
+
+	/*
+	 * We do not know the actual MIDI FIFO size of most devices.  Just
+	 * assume two bytes, i.e., one byte can be received over the bus while
+	 * the previous one is transmitted over MIDI.
+	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 */
+	p->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
 
 	return 0;
 }
@@ -216,6 +244,81 @@ static void write_pcm_silence(struct amdtp_stream *s, __be32 *buffer,
 	}
 }
 
+static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
+{
+	struct amdtp_dot *p = s->protocol;
+	int used;
+
+	used = p->midi_fifo_used[port];
+	if (used == 0)
+		return true;
+
+	used -= MIDI_BYTES_PER_SECOND * s->syt_interval;
+	used = max(used, 0);
+	p->midi_fifo_used[port] = used;
+
+	return used < p->midi_fifo_limit;
+}
+
+static inline void midi_use_bytes(struct amdtp_stream *s,
+				  unsigned int port, unsigned int count)
+{
+	struct amdtp_dot *p = s->protocol;
+
+	p->midi_fifo_used[port] += amdtp_rate_table[s->sfc] * count;
+}
+
+static void write_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+				unsigned int data_blocks)
+{
+	struct amdtp_dot *p = s->protocol;
+	unsigned int f, port;
+	int len;
+	u8 *b;
+
+	for (f = 0; f < data_blocks; f++) {
+		port = (s->data_block_counter + f) % 8;
+		b = (u8 *)&buffer[0];
+
+		len = 0;
+		if (port < p->midi_ports &&
+		    midi_ratelimit_per_packet(s, port) &&
+		    p->midi[port] != NULL)
+			len = snd_rawmidi_transmit(p->midi[port], b + 1, 2);
+
+		if (len > 0) {
+			b[3] = (0x10 << port) | len;
+			midi_use_bytes(s, port, len);
+		} else {
+			b[1] = 0;
+			b[2] = 0;
+			b[3] = 0;
+		}
+		b[0] = 0x80;
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
+static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+			       unsigned int data_blocks)
+{
+	struct amdtp_dot *p = s->protocol;
+	unsigned int f, port, len;
+	u8 *b;
+
+	for (f = 0; f < data_blocks; f++) {
+		b = (u8 *)&buffer[0];
+		port = b[3] >> 4;
+		len = b[3] & 0x0f;
+
+		if (port < p->midi_ports && p->midi[port] && len > 0)
+			snd_rawmidi_receive(p->midi[port], b + 1, len);
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
 int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
 				     struct snd_pcm_runtime *runtime)
 {
@@ -256,6 +359,15 @@ void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format)
 	}
 }
 
+void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			  struct snd_rawmidi_substream *midi)
+{
+	struct amdtp_dot *p = s->protocol;
+
+	if (port < p->midi_ports)
+		ACCESS_ONCE(p->midi[port]) = midi;
+}
+
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 					   __be32 *buffer,
 					   unsigned int data_blocks,
@@ -273,7 +385,7 @@ static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 		pcm_frames = 0;
 	}
 
-	/* A place holder for MIDI processing. */
+	read_midi_messages(s, buffer, data_blocks);
 
 	return pcm_frames;
 }
@@ -296,7 +408,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 		pcm_frames = 0;
 	}
 
-	/* A place holder for MIDI processing. */
+	write_midi_messages(s, buffer, data_blocks);
 
 	return pcm_frames;
 }
diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 8aac31b..e9be162 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -199,7 +199,7 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 
 	/* Keep resources for out-stream. */
 	err = amdtp_dot_set_parameters(&dg00x->rx_stream, rate,
-				       snd_dg00x_stream_pcm_channels[i], 0);
+				       snd_dg00x_stream_pcm_channels[i]);
 	if (err < 0)
 		return err;
 	err = fw_iso_resources_allocate(&dg00x->rx_resources,
@@ -210,7 +210,7 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
 
 	/* Keep resources for in-stream. */
 	err = amdtp_dot_set_parameters(&dg00x->tx_stream, rate,
-				       snd_dg00x_stream_pcm_channels[i], 0);
+				       snd_dg00x_stream_pcm_channels[i]);
 	if (err < 0)
 		return err;
 	err = fw_iso_resources_allocate(&dg00x->tx_resources,
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
index b960c86..88df67b 100644
--- a/sound/firewire/digi00x/digi00x.h
+++ b/sound/firewire/digi00x/digi00x.h
@@ -24,6 +24,7 @@
 #include <sound/pcm_params.h>
 #include <sound/firewire.h>
 #include <sound/hwdep.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../iso-resources.h"
@@ -103,15 +104,19 @@ enum snd_dg00x_optical_mode {
 	SND_DG00X_OPT_IFACE_MODE_COUNT,
 };
 
+#define DOT_MIDI_IN_PORTS	1
+#define DOT_MIDI_OUT_PORTS	2
+
 int amdtp_dot_init(struct amdtp_stream *s, struct fw_unit *unit,
 		   enum amdtp_stream_direction dir);
 int amdtp_dot_set_parameters(struct amdtp_stream *s, unsigned int rate,
-			     unsigned int pcm_channels,
-			     unsigned int midi_ports);
+			     unsigned int pcm_channels);
 void amdtp_dot_reset(struct amdtp_stream *s);
 int amdtp_dot_add_pcm_hw_constraints(struct amdtp_stream *s,
 				     struct snd_pcm_runtime *runtime);
 void amdtp_dot_set_pcm_format(struct amdtp_stream *s, snd_pcm_format_t format);
+void amdtp_dot_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			  struct snd_rawmidi_substream *midi);
 
 int snd_dg00x_transaction_register(struct snd_dg00x *dg00x);
 int snd_dg00x_transaction_reregister(struct snd_dg00x *dg00x);
-- 
2.1.4
