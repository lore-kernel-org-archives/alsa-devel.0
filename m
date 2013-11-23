From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/17] firewire-lib: Add quirks for Fireworks
	chipset
Date: Sat, 23 Nov 2013 15:08:04 +0900
Message-ID: <1385186884-8259-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D87942651D0
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:08:13 +0100 (CET)
In-Reply-To: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds two modifications for Fireworks quirks.

1. The driver can indicate the number of first data blocks in which this module
put MIDI messages for out stream.
This commit add 'blocks_for_midi' member to 'amdtp_stream' structure for this
purpose. Fireworks can pick up MIDI messages in first 8 data blocks and ignore
in other data blocks.

2. This module calculate data block size by itself don't check counter.
One of Fireworks device, AudioFirePre8, always reports 8 data block size in
transmitted packets and the data block counter is incremented by 8. But this is
wrong. This commit force this module to calculate data block size and not to
check counter continuity.

I confirm these quirks in firmware version 4.8 to 5.8. I have no investigation
for the other versions.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 52 ++++++++++++++++++++++++++------------------------
 sound/firewire/amdtp.h |  2 ++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index cb74ade..eb42e57 100644
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
@@ -622,8 +624,14 @@ static void amdtp_fill_midi(struct amdtp_stream *s,
 			b[1] = 0x00;
 			len = 0;
 
+			/*
+			 * NOTE:
+			 * Fireworks ignores midi messages in more than first 8
+			 * data blocks in an packet.
+			 */
 			port = c * 8 + m;
-			if ((s->midi[port] != NULL) &&
+			if ((f < s->blocks_for_midi) &&
+			    (s->midi[port] != NULL) &&
 			    test_bit(port, &s->midi_triggered)) {
 				len = snd_rawmidi_transmit(s->midi[port],
 								b + 1, 1);
@@ -784,7 +792,7 @@ static void handle_in_packet(struct amdtp_stream *s,
 			     __be32 *buffer)
 {
 	u32 cip_header[2];
-	unsigned int data_block_quadlets, data_blocks, data_block_counter;
+	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 
 	cip_header[0] = be32_to_cpu(buffer[0]);
@@ -808,27 +816,17 @@ static void handle_in_packet(struct amdtp_stream *s,
 	      ((cip_header[1] & CIP_SYT_MASK) == CIP_SYT_NO_INFO)))
 		return;
 
-	data_block_quadlets =
-			(cip_header[1] & AMDTP_DBS_MASK) >> AMDTP_DBS_SHIFT;
-	/* avoid division by zero */
-	if (data_block_quadlets == 0) {
-		dev_info(&s->unit->device,
-			 "Detect invalid value in dbs field: %08X\n",
-			 data_block_quadlets);
-		return;
-	}
-
-	data_blocks = (payload_quadlets - 2) / data_block_quadlets;
-	data_block_counter = (cip_header[1] & AMDTP_DBC_MASK);
-
-	/* check packet continuity */
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
-	if (s->data_block_counter != data_block_counter) {
-		dev_err(&s->unit->device,
-			"Detect uncontinuity of CIP packets\n");
-		s->data_block_counter = data_block_counter;
-		return;
-	}
+	/*
+	 * This module don't use the value of dbs and dbc beceause Echo
+	 * AudioFirePre8 reports inappropriate value.
+	 *
+	 * This device always reports a fixed value "16" as data block
+	 * size at any sampling rates but actually data block size isdifferent.
+	 *
+	 * Additionally the value of data block count always incremented by
+	 * "8" at any sampling rates but actually it's different.
+	 */
+	data_blocks = (payload_quadlets - 2) / s->data_block_quadlets;
 
 	buffer += 2;
 
@@ -1108,10 +1106,14 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 			goto err_context;
 	} while (s->packet_index > 0);
 
-	/* NOTE: TAG1 matches CIP. This just affects in stream */
+	/*
+	 * NOTE: TAG1 matches CIP. This just affects in stream.
+	 * Fireworks transmits NODATA packets with TAG0.
+	 */
 	s->data_block_counter = 0;
 	s->callbacked = false;
-	err = fw_iso_context_start(s->context, -1, 0, FW_ISO_CONTEXT_MATCH_TAG1);
+	err = fw_iso_context_start(s->context, -1, 0,
+			FW_ISO_CONTEXT_MATCH_TAG0 | FW_ISO_CONTEXT_MATCH_TAG1);
 	if (err < 0)
 		goto err_context;
 
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 02ff8de..d79ae1c 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -109,6 +109,8 @@ struct amdtp_stream {
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 	unsigned long midi_triggered;
+	/* quirk: the first count of data blocks in an AMDTP packet for MIDI */
+	unsigned int blocks_for_midi;
 
 	bool callbacked;
 	wait_queue_head_t callback_wait;
-- 
1.8.3.2
