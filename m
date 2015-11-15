From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] ALSA: dice: add MIDI ports according to
	current number of MIDI substreams
Date: Sun, 15 Nov 2015 18:25:31 +0900
Message-ID: <1447579536-4459-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 72404260586
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:41 +0100 (CET)
In-Reply-To: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit changes the way to add ALSA MIDI ports. This driver read the
number of multiplexed MIDI substreams from hardware register, then adds the
same number of ALSA MIDI ports. This commit is based on my assumption that
the number is fixed at all of supported sampling transfer frequency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 151b09f..59ac5cb 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -103,16 +103,29 @@ static void set_midi_substream_names(struct snd_dice *dice,
 
 int snd_dice_create_midi(struct snd_dice *dice)
 {
+	__be32 reg;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
-	unsigned int i, midi_in_ports, midi_out_ports;
+	unsigned int midi_in_ports, midi_out_ports;
 	int err;
 
-	midi_in_ports = midi_out_ports = 0;
-	for (i = 0; i < 3; i++) {
-		midi_in_ports = max(dice->tx_midi_ports[i], midi_in_ports);
-		midi_out_ports = max(dice->rx_midi_ports[i], midi_out_ports);
-	}
+	/*
+	 * Use current number of MIDI conformant data channel.
+	 *
+	 * TODO: in the case that the number of MIDI conformant data channel
+	 * differs depending on current sampling transfer frequency?
+	 */
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_MIDI,
+					   &reg, sizeof(reg));
+	if (err < 0)
+		return err;
+	midi_in_ports = be32_to_cpu(reg);
+
+	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_MIDI,
+					   &reg, sizeof(reg));
+	if (err < 0)
+		return err;
+	midi_out_ports = be32_to_cpu(reg);
 
 	if (midi_in_ports + midi_out_ports == 0)
 		return 0;
-- 
2.5.0
