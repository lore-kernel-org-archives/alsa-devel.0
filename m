From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] ALSA: dice: limit stream to current
	sampling transfer frequency.
Date: Sun, 15 Nov 2015 18:25:30 +0900
Message-ID: <1447579536-4459-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7660726062B
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

In previous commit, ALSA Dice driver limits PCM substreams at current
sampling transfer frequency and current number of Multi bit linear audio
data channel. Thus, the driver has no need to start AMDTP streams at
the other sampling transfer frequency than current. This is due to Dice
hardware design.

This commit limits AMDTP stream at current sampling transfer frequency,
according to the design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index a6a39f7..4f74e3e 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -99,6 +99,7 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 			unsigned int rate)
 {
 	struct fw_iso_resources *resources;
+	__be32 reg[2];
 	unsigned int i, mode, pcm_chs, midi_ports;
 	bool double_pcm_frames;
 	int err;
@@ -108,14 +109,20 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 		goto end;
 	if (stream == &dice->tx_stream) {
 		resources = &dice->tx_resources;
-		pcm_chs = dice->tx_channels[mode];
-		midi_ports = dice->tx_midi_ports[mode];
+		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
+						   reg, sizeof(reg));
 	} else {
 		resources = &dice->rx_resources;
-		pcm_chs = dice->rx_channels[mode];
-		midi_ports = dice->rx_midi_ports[mode];
+		err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
+						   reg, sizeof(reg));
 	}
 
+	if (err < 0)
+		goto end;
+
+	pcm_chs = be32_to_cpu(reg[0]);
+	midi_ports = be32_to_cpu(reg[1]);
+
 	/*
 	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
 	 * one data block of AMDTP packet. Thus sampling transfer frequency is
@@ -224,8 +231,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	}
 	if (rate == 0)
 		rate = curr_rate;
-	if (rate != curr_rate)
-		stop_stream(dice, master);
+	if (rate != curr_rate) {
+		err = -EINVAL;
+		goto end;
+	}
 
 	if (!amdtp_stream_running(master)) {
 		stop_stream(dice, slave);
-- 
2.5.0
