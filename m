From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 11/13] ALSA: dice: use stream formats to add
	MIDI substreams
Date: Wed,  2 May 2018 19:16:49 +0900
Message-ID: <20180502101651.26173-12-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A11326764D
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:44 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so7390676pgc.9
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:44 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In former commits, proxy structure gets members for cache of stream
formats. The cache can be used to count the number of MIDI substreams
to add.

This commit uses the cache for this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-midi.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/dice/dice-midi.c b/sound/firewire/dice/dice-midi.c
index 8ff6da3c51f7..84eca8a51a02 100644
--- a/sound/firewire/dice/dice-midi.c
+++ b/sound/firewire/dice/dice-midi.c
@@ -101,27 +101,18 @@ int snd_dice_create_midi(struct snd_dice *dice)
 		.close		= midi_close,
 		.trigger	= midi_playback_trigger,
 	};
-	__be32 reg;
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *str;
 	unsigned int midi_in_ports, midi_out_ports;
+	int i;
 	int err;
 
-	/*
-	 * Use the number of MIDI conformant data channel at current sampling
-	 * transfer frequency.
-	 */
-	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_MIDI,
-					   &reg, sizeof(reg));
-	if (err < 0)
-		return err;
-	midi_in_ports = be32_to_cpu(reg);
-
-	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_MIDI,
-					   &reg, sizeof(reg));
-	if (err < 0)
-		return err;
-	midi_out_ports = be32_to_cpu(reg);
+	midi_in_ports = 0;
+	midi_out_ports = 0;
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		midi_in_ports = max(midi_in_ports, dice->tx_midi_ports[i]);
+		midi_out_ports = max(midi_out_ports, dice->rx_midi_ports[i]);
+	}
 
 	if (midi_in_ports + midi_out_ports == 0)
 		return 0;
-- 
2.14.1
