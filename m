From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/2] ALSA: firewire-lib: limit the MIDI data
	rate
Date: Tue, 25 Nov 2014 22:54:10 +0100
Message-ID: <5474FA82.4030408@ladisch.de>
References: <5474FA18.7000501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2E70C260654
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 22:54:30 +0100 (CET)
In-Reply-To: <5474FA18.7000501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Do no send MIDI bytes at the full rate at which FireWire packets happen
to be sent, but restrict them to the actual rate of a real MIDI port.
This is required by the specification, and prevents data loss when the
device's buffer overruns.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/amdtp.c |   61 +++++++++++++++++++++++++++++++++++++++++++-----
 sound/firewire/amdtp.h |    2 ++
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 17548d8..c0c0c5e 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -22,6 +22,12 @@
 #define TICKS_PER_SECOND	(TICKS_PER_CYCLE * CYCLES_PER_SECOND)

 /*
+ * Nominally 3125 bytes/second, but the MIDI port's clock might be
+ * 1% too slow, and the bus clock 100 ppm too fast.
+ */
+#define MIDI_BYTES_PER_SECOND	3093
+
+/*
  * Several devices look only at the first eight data blocks.
  * In any case, this is more than enough for the MIDI data rate.
  */
@@ -226,6 +232,14 @@ sfc_found:
 	for (i = 0; i < pcm_channels; i++)
 		s->pcm_positions[i] = i;
 	s->midi_position = s->pcm_channels;
+
+	/*
+	 * We do not know the actual MIDI FIFO size of most devices.  Just
+	 * assume two bytes, i.e., one byte can be received over the bus while
+	 * the previous one is transmitted over MIDI.
+	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 */
+	s->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
 }
 EXPORT_SYMBOL(amdtp_stream_set_parameters);

@@ -467,6 +481,36 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
 	}
 }

+/*
+ * To avoid sending MIDI bytes at too high a rate, assume that the receiving
+ * device has a FIFO, and track how much it is filled.  This values increases
+ * by one whenever we send one byte in a packet, but the FIFO empties at
+ * a constant rate independent of our packet rate.  One packet has syt_interval
+ * samples, so the number of bytes that empty out of the FIFO, per packet(!),
+ * is MIDI_BYTES_PER_SECOND * syt_interval / sample_rate.  To avoid storing
+ * fractional values, the values in midi_fifo_used[] are measured in bytes
+ * multiplied by the sample rate.
+ */
+static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
+{
+	int used;
+
+	used = s->midi_fifo_used[port];
+	if (used == 0) /* common shortcut */
+		return true;
+
+	used -= MIDI_BYTES_PER_SECOND * s->syt_interval;
+	used = max(used, 0);
+	s->midi_fifo_used[port] = used;
+
+	return used < s->midi_fifo_limit;
+}
+
+static void midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
+{
+	s->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
+}
+
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
 {
@@ -474,16 +518,21 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 	u8 *b;

 	for (f = 0; f < frames; f++) {
-		buffer[s->midi_position] = 0;
 		b = (u8 *)&buffer[s->midi_position];

 		port = (s->data_block_counter + f) % 8;
-		if ((f >= MAX_MIDI_RX_BLOCKS) ||
-		    (s->midi[port] == NULL) ||
-		    (snd_rawmidi_transmit(s->midi[port], b + 1, 1) <= 0))
-			b[0] = 0x80;
-		else
+		if (f < MAX_MIDI_RX_BLOCKS &&
+		    midi_ratelimit_per_packet(s, port) &&
+		    s->midi[port] != NULL &&
+		    snd_rawmidi_transmit(s->midi[port], &b[1], 1) == 1) {
+			midi_rate_use_one_byte(s, port);
 			b[0] = 0x81;
+		} else {
+			b[0] = 0x80;
+			b[1] = 0;
+		}
+		b[2] = 0;
+		b[3] = 0;

 		buffer += s->data_block_quadlets;
 	}
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index cd4c4df..8a03a91 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -148,6 +148,8 @@ struct amdtp_stream {
 	bool double_pcm_frames;

 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+	int midi_fifo_limit;
+	int midi_fifo_used[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];

 	/* quirk: fixed interval of dbc between previos/current packets. */
 	unsigned int tx_dbc_interval;
