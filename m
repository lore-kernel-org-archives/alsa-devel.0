From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: oxfw: retry MIDI transferring for
	scs1x at transaction failure
Date: Fri, 19 Feb 2016 09:55:49 +0900
Message-ID: <1455843350-10156-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1455843350-10156-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 753B72612AC
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 01:55:56 +0100 (CET)
In-Reply-To: <1455843350-10156-1-git-send-email-o-takashi@sakamocchi.jp>
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

Currently, ALSA oxfw driver has a TODO to retry MIDI transferring
at transaction failure.

This commit achieves it. Current implementation uses snd_rawmidi_transmit()
to transfer messages, thus the target MIDI messages are not in buffer when
transaction failure is detected. So we cannot use a pair of
snd_rawmidi_transmit_peek() and snd_ramwidi_transmit_ack(). But the
messages are in scs1x specific structure and the data is available for
retries.

This commit adds a member to the structure for the length of messages and
uses the value again at retries.
---
 sound/firewire/oxfw/oxfw-scs1x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index f7ac124..72446ac 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -31,6 +31,7 @@ struct fw_scs1x {
 	u8 buffer[HSS1394_MAX_PACKET_SIZE];
 	bool transaction_running;
 	struct fw_transaction transaction;
+	unsigned int transaction_bytes;
 	struct fw_device *fw_dev;
 };
 
@@ -125,8 +126,8 @@ static void scs_write_callback(struct fw_card *card, int rcode,
 {
 	struct fw_scs1x *scs = callback_data;
 
-	if (rcode == RCODE_GENERATION)
-		;	/* TODO: retry this packet */
+	if (rcode != RCODE_GENERATION)
+		scs->transaction_bytes = 0;
 
 	scs->transaction_running = false;
 	schedule_work(&scs->work);
@@ -183,6 +184,9 @@ static void scs_output_work(struct work_struct *work)
 		return;
 	}
 
+	if (scs->transaction_bytes > 0)
+		goto retry;
+
 	i = scs->output_bytes;
 	for (;;) {
 		if (snd_rawmidi_transmit(stream, &byte, 1) != 1) {
@@ -253,13 +257,16 @@ static void scs_output_work(struct work_struct *work)
 	scs->output_bytes = 1;
 	scs->output_escaped = false;
 
+	scs->transaction_bytes = i;
+retry:
 	scs->transaction_running = true;
 	generation = scs->fw_dev->generation;
 	smp_rmb(); /* node_id vs. generation */
 	fw_send_request(scs->fw_dev->card, &scs->transaction,
 			TCODE_WRITE_BLOCK_REQUEST, scs->fw_dev->node_id,
 			generation, scs->fw_dev->max_speed, HSS1394_ADDRESS,
-			scs->buffer, i, scs_write_callback, scs);
+			scs->buffer, scs->transaction_bytes,
+			scs_write_callback, scs);
 }
 
 static int midi_capture_open(struct snd_rawmidi_substream *stream)
@@ -309,6 +316,7 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
 		scs->output_bytes = 1;
 		scs->output_escaped = false;
 		scs->output_idle = false;
+		scs->transaction_bytes = 0;
 
 		ACCESS_ONCE(scs->output) = stream;
 		schedule_work(&scs->work);
-- 
2.5.0
