From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/11] ALSA: firewire-lib: allows to implement
	external MIDI callback function
Date: Mon, 30 Mar 2015 00:05:29 +0900
Message-ID: <1427641531-9047-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 707C72606CA
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:45 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit is a preparation for devices which is not conformant to
IEC 61883-1:2005 or MMA/AMEI RP-027. This commit allows each driver to
implement own MIDI callback functions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 30 +++++++++++++++++++++++-------
 sound/firewire/amdtp.h |  5 +++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index e061355..2758fb8 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -68,6 +68,11 @@
 
 static void pcm_period_tasklet(unsigned long data);
 
+static void amdtp_fill_midi(struct amdtp_stream *s,
+			    __be32 *buffer, unsigned int frames);
+static void amdtp_pull_midi(struct amdtp_stream *s,
+			    __be32 *buffer, unsigned int frames);
+
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -236,7 +241,7 @@ sfc_found:
 	 * We do not know the actual MIDI FIFO size of most devices.  Just
 	 * assume two bytes, i.e., one byte can be received over the bus while
 	 * the previous one is transmitted over MIDI.
-	 * (The value here is adjusted for midi_ratelimit_per_packet().)
+	 * (The value here is adjusted for amdtp_midi_ratelimit_per_packet().)
 	 */
 	s->midi_fifo_limit = rate - MIDI_BYTES_PER_SECOND * s->syt_interval + 1;
 }
@@ -490,7 +495,7 @@ static void amdtp_fill_pcm_silence(struct amdtp_stream *s,
  * fractional values, the values in midi_fifo_used[] are measured in bytes
  * multiplied by the sample rate.
  */
-static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
+bool amdtp_midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
 {
 	int used;
 
@@ -504,11 +509,13 @@ static bool midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port)
 
 	return used < s->midi_fifo_limit;
 }
+EXPORT_SYMBOL(amdtp_midi_ratelimit_per_packet);
 
-static void midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
+void amdtp_midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port)
 {
 	s->midi_fifo_used[port] += amdtp_rate_table[s->sfc];
 }
+EXPORT_SYMBOL(amdtp_midi_rate_use_one_byte);
 
 static void amdtp_fill_midi(struct amdtp_stream *s,
 			    __be32 *buffer, unsigned int frames)
@@ -521,10 +528,10 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 
 		port = (s->data_block_counter + f) % 8;
 		if (f < MAX_MIDI_RX_BLOCKS &&
-		    midi_ratelimit_per_packet(s, port) &&
+		    amdtp_midi_ratelimit_per_packet(s, port) &&
 		    s->midi[port] != NULL &&
 		    snd_rawmidi_transmit(s->midi[port], &b[1], 1) == 1) {
-			midi_rate_use_one_byte(s, port);
+			amdtp_midi_rate_use_one_byte(s, port);
 			b[0] = 0x81;
 		} else {
 			b[0] = 0x80;
@@ -662,7 +669,7 @@ static void handle_out_packet(struct amdtp_stream *s, unsigned int syt)
 	else
 		amdtp_fill_pcm_silence(s, buffer, data_blocks);
 	if (s->midi_ports)
-		amdtp_fill_midi(s, buffer, data_blocks);
+		s->transfer_midi(s, buffer, data_blocks);
 
 	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
 
@@ -760,7 +767,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 			s->transfer_samples(s, pcm, buffer, data_blocks);
 
 		if (s->midi_ports)
-			amdtp_pull_midi(s, buffer, data_blocks);
+			s->transfer_midi(s, buffer, data_blocks);
 	}
 
 	if (s->flags & CIP_DBC_IS_END_EVENT)
@@ -925,6 +932,15 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 	s->syt_offset_state = initial_state[s->sfc].syt_offset;
 	s->last_syt_offset = TICKS_PER_CYCLE;
 
+	/* Confirm MIDI callback function. */
+	if (s->transfer_midi == NULL) {
+		if (s->direction == AMDTP_OUT_STREAM)
+			s->transfer_midi = amdtp_fill_midi;
+		else
+			s->transfer_midi = amdtp_pull_midi;
+	}
+
+
 	/* initialize packet buffer */
 	if (s->direction == AMDTP_IN_STREAM) {
 		dir = DMA_FROM_DEVICE;
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 8a03a91..3999376 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -124,6 +124,8 @@ struct amdtp_stream {
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
 	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
+	void (*transfer_midi)(struct amdtp_stream *s,
+			      __be32 *buffer, unsigned int frame);
 	u8 midi_position;
 
 	unsigned int syt_interval;
@@ -185,6 +187,9 @@ void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 extern const unsigned int amdtp_syt_intervals[CIP_SFC_COUNT];
 extern const unsigned int amdtp_rate_table[CIP_SFC_COUNT];
 
+bool amdtp_midi_ratelimit_per_packet(struct amdtp_stream *s, unsigned int port);
+void amdtp_midi_rate_use_one_byte(struct amdtp_stream *s, unsigned int port);
+
 /**
  * amdtp_stream_running - check stream is running or not
  * @s: the AMDTP stream
-- 
2.1.0
