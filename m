From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: dice: correct variable types for
	__be32 data
Date: Sun, 18 Oct 2015 22:39:49 +0900
Message-ID: <1445175593-11293-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 68D1F264F4B
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:58 +0200 (CEST)
In-Reply-To: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some local variables in some functions are typed as unsigned int, while
__be32 value is assigned to them. This causes sparse warnings.

dice-stream.c:50:17: warning: incorrect type in assignment (different base types)
dice-stream.c:50:17:    expected unsigned int [unsigned] channel
dice-stream.c:50:17:    got restricted __be32 [usertype] <noident>
dice-stream.c:74:17: warning: incorrect type in assignment (different base types)
dice-stream.c:74:17:    expected unsigned int [unsigned] channel
dice-stream.c:74:17:    got restricted __be32 [usertype] <noident>

This commit fixes this bug.

Fixes: 288a8d0cb04f('ALSA: dice: Change the way to start stream')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 2108f7f..a6a39f7 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -44,16 +44,16 @@ int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
 static void release_resources(struct snd_dice *dice,
 			      struct fw_iso_resources *resources)
 {
-	unsigned int channel;
+	__be32 channel;
 
 	/* Reset channel number */
 	channel = cpu_to_be32((u32)-1);
 	if (resources == &dice->tx_resources)
 		snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-					      &channel, 4);
+					      &channel, sizeof(channel));
 	else
 		snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
-					      &channel, 4);
+					      &channel, sizeof(channel));
 
 	fw_iso_resources_free(resources);
 }
@@ -62,7 +62,7 @@ static int keep_resources(struct snd_dice *dice,
 			  struct fw_iso_resources *resources,
 			  unsigned int max_payload_bytes)
 {
-	unsigned int channel;
+	__be32 channel;
 	int err;
 
 	err = fw_iso_resources_allocate(resources, max_payload_bytes,
@@ -74,10 +74,10 @@ static int keep_resources(struct snd_dice *dice,
 	channel = cpu_to_be32(resources->channel);
 	if (resources == &dice->tx_resources)
 		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-						    &channel, 4);
+						    &channel, sizeof(channel));
 	else
 		err = snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS,
-						    &channel, 4);
+						    &channel, sizeof(channel));
 	if (err < 0)
 		release_resources(dice, resources);
 end:
-- 
2.1.4
