From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] ALSA: dice: get the number of MBLA data
	channel at opening PCM substream
Date: Sun, 15 Nov 2015 18:25:32 +0900
Message-ID: <1447579536-4459-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 724BE260592
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

This commit is a preparation to remove members related to the array
number of channels for multi bit linear audio data and MIDI conformant
data. The number of multi bit linear audio data channel is retrieved by
asynchronous transaction to some registers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index eaaabf0..c3343b6 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -296,17 +296,30 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
+	__be32 reg;
 	struct snd_pcm *pcm;
-	unsigned int i, capture, playback;
+	unsigned int capture, playback;
 	int err;
 
-	capture = playback = 0;
-	for (i = 0; i < 3; i++) {
-		if (dice->tx_channels[i] > 0)
-			capture = 1;
-		if (dice->rx_channels[i] > 0)
-			playback = 1;
-	}
+	/*
+	 * Check whether PCM substreams are required.
+	 *
+	 * TODO: in the case that any PCM substreams are not avail at a certain
+	 * sampling transfer frequency?
+	 */
+	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
+					   &reg, sizeof(reg));
+	if (err < 0)
+		return err;
+	if (be32_to_cpu(reg) > 0)
+		capture = 1;
+
+	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
+					   &reg, sizeof(reg));
+	if (err < 0)
+		return err;
+	if (be32_to_cpu(reg) > 0)
+		playback = 1;
 
 	err = snd_pcm_new(dice->card, "DICE", 0, playback, capture, &pcm);
 	if (err < 0)
-- 
2.5.0
