From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/39] firewire-lib: Add quirks for Fireworks
Date: Fri, 28 Feb 2014 12:27:30 +0900
Message-ID: <1393558072-25926-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA6C2650C0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:21 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds three modifications for Echo Audio's Fireworks quirks.

1.Making this module to support both TAG0 and TAG1
In IEC 61883-1, each common isochronous packet (CIP) has 'tag' field in its
packet header. The value is generally 0x01 (CIP header is included = TAG1).
But Fireworks in 'IEC 61883 compliant' mode transmits 'no data' packet with
0x00 (No CIP header is included = TAG0) but the packet includes CIP structure.
To process 'presentation timestamp' for duplex streams synchronization
correctly, this packets needs to be handled.

2.Making this module to calculate data block size and not to check continuity
One of Fireworks device, AudioFirePre8, always reports 8 data block size in
in-packets and the data block counter is incremented by 8. But actual value is
different.

3.Making this module to have the numebr of first data blocks for MIDI messages
in out-packet
Fireworks can pick up MIDI messages in first 8 data blocks and ignore in other
data blocks.

I confirm these quirks in firmware version between 4.8 and 5.8 with Windows.
I didn't investigate for the other versions. But according to contact person
in Echo Audio, there is no differences between firmwares installed by Windows
or OS X.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 50 +++++++++++++++++++++++++-------------------------
 sound/firewire/amdtp.h |  2 ++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 9b45382..a2b293a 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -88,6 +88,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->sort_table = NULL;
 	s->left_packets = NULL;
 
+	s->blocks_for_midi = UINT_MAX;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -556,8 +558,14 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 		buffer[s->midi_position] = 0x00;
 		b = (u8 *)&buffer[s->midi_position];
 
+		/*
+		 * NOTE:
+		 * Fireworks ignores midi messages in more than first 8
+		 * data blocks of an packet.
+		 */
 		port = (s->data_block_counter + f) % 8;
-		if ((s->midi[port] == NULL) ||
+		if ((f >= s->blocks_for_midi) ||
+		    (s->midi[port] == NULL) ||
 		    (snd_rawmidi_transmit(s->midi[port], b + 1, 1) <= 0)) {
 			b[0] = 0x80;
 			b[1] = 0x00;	/* confirm to be zero */
@@ -710,7 +718,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 			     __be32 *buffer)
 {
 	u32 cip_header[2];
-	unsigned int data_block_quadlets, data_blocks, data_block_counter;
+	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 
 	cip_header[0] = be32_to_cpu(buffer[0]);
@@ -735,27 +743,16 @@ static void handle_in_packet(struct amdtp_stream *s,
 							AMDTP_FDF_NO_DATA))
 		return;
 
-	data_block_quadlets =
-			(cip_header[1] & AMDTP_DBS_MASK) >> AMDTP_DBS_SHIFT;
-	/* avoid division by zero */
-	if (data_block_quadlets == 0) {
-		dev_info_ratelimited(&s->unit->device,
-				 "Detect invalid value in dbs field: %08X\n",
-				 data_block_quadlets);
-		return;
-	}
-
-	data_blocks = (payload_quadlets - 2) / data_block_quadlets;
-	data_block_counter = cip_header[1] & AMDTP_DBC_MASK;
-
-	/* check packet continuity */
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
-	if (s->data_block_counter != data_block_counter) {
-		dev_info_ratelimited(&s->unit->device,
-				     "Detect uncontinuity of CIP packets\n");
-		s->data_block_counter = data_block_counter;
-		return;
-	}
+	/*
+	 * This module don't use the value of dbs and dbc beceause Echo
+	 * AudioFirePre8 reports inappropriate value.
+	 *
+	 * This model always reports a fixed value "8" as data block size at
+	 * any sampling rates but actually data block size is different.
+	 * Additionally the value of data block count always incremented by
+	 * "8" at any sampling rates but actually it's different.
+	 */
+	data_blocks = (payload_quadlets - 2) / s->data_block_quadlets;
 
 	buffer += 2;
 
@@ -1041,11 +1038,14 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 			goto err_context;
 	} while (s->packet_index > 0);
 
-	/* NOTE: TAG1 matches CIP. This just affects in stream */
+	/*
+	 * NOTE: TAG1 matches CIP. This just affects in stream.
+	 * Fireworks transmits NODATA packets with TAG0.
+	 */
 	s->data_block_counter = 0;
 	s->callbacked = false;
 	err = fw_iso_context_start(s->context, -1, 0,
-				   FW_ISO_CONTEXT_MATCH_TAG1);
+			FW_ISO_CONTEXT_MATCH_TAG0 | FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
 
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 861f509..dce3903 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -113,6 +113,8 @@ struct amdtp_stream {
 	bool pointer_flush;
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+	/* quirk: the first count of data blocks in an AMDTP packet for MIDI */
+	unsigned int blocks_for_midi;
 
 	bool callbacked;
 	wait_queue_head_t callback_wait;
-- 
1.8.3.2
