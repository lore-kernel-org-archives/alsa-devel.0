From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/38] firewire-lib: Add quirks for Fireworks
Date: Fri, 20 Dec 2013 22:14:08 +0900
Message-ID: <1387545269-3875-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
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
wrong.

3.Making this module to have the numebr of first data blocks for MIDI messages
in out-packet
Fireworks can pick up MIDI messages in first 8 data blocks and ignore in other
data blocks.

I confirm these quirks in firmware version 4.8 to 5.8 for Windows. I didn't
investigate for the other versions. But according to contact person in Echo
Audio, there is no differences between firmwares installed by Windows or OS X.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 50 +++++++++++++++++++++++++-------------------------
 sound/firewire/amdtp.h |  2 ++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index fa943f2..7380967 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -89,6 +89,8 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->sort_table = NULL;
 	s->left_packets = NULL;
 
+	s->blocks_for_midi = UINT_MAX;
+
 	return 0;
 }
 EXPORT_SYMBOL(amdtp_stream_init);
@@ -557,8 +559,14 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
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
@@ -711,7 +719,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 			     __be32 *buffer)
 {
 	u32 cip_header[2];
-	unsigned int data_block_quadlets, data_blocks, data_block_counter;
+	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 
 	cip_header[0] = be32_to_cpu(buffer[0]);
@@ -736,27 +744,16 @@ static void handle_in_packet(struct amdtp_stream *s,
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
 
@@ -1036,11 +1033,14 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
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
index a6f50c7..c601aeb 100644
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


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
