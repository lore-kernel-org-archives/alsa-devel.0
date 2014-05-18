From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 11/13] dice: Support for non SYT-Match sampling
	clock source mode
Date: Sun, 18 May 2014 22:36:36 +0900
Message-ID: <1400420198-24312-12-git-send-email-o-takashi@sakamocchi.jp>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 91ABD264FDF
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 15:37:00 +0200 (CEST)
In-Reply-To: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit allows another mode.

When sampling clock source is SYT-Match mode, devices handle
'presentation timestamp' in received packets and generates sampling clock
according to the information. In this case, driver is synchronization master
and must transfer correct value in SYT field of each packets in outgoing
stream, then the outgoing stream is a master stream.

On the other hand, non SYT-Match mode, devices do this. So drivers must pick
up the value in SYT field of incoming packets and use the value for outgoing
stream.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.h             |  2 --
 sound/firewire/dice/dice_stream.c      | 33 +++++++++++++++++++++------------
 sound/firewire/dice/dice_transaction.c |  5 -----
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index a868485..8ea5cb4 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -152,8 +152,6 @@ static inline int snd_dice_transaction_read_sync(struct snd_dice *dice,
 					 buf, len);
 }
 
-int snd_dice_transaction_set_clock_source(struct snd_dice *dice,
-					  unsigned int source);
 int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
 					  unsigned int *source);
 int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate);
diff --git a/sound/firewire/dice/dice_stream.c b/sound/firewire/dice/dice_stream.c
index d8b2ca6..033b0ac 100644
--- a/sound/firewire/dice/dice_stream.c
+++ b/sound/firewire/dice/dice_stream.c
@@ -150,9 +150,27 @@ end:
 
 static int get_sync_mode(struct snd_dice *dice, enum cip_flags *sync_mode)
 {
-	/* Currently, clock source is fixed at SYT-Match mode. */
-	*sync_mode = 0;
-	return 0;
+	u32 source;
+	int err;
+
+	err = snd_dice_transaction_get_clock_source(dice, &source);
+	if (err < 0)
+		goto end;
+
+	switch (source) {
+	/* So-called 'SYT Match' modes, sync_to_syt value of packets received */
+	case CLOCK_SOURCE_ARX4:	/* in 4th stream */
+	case CLOCK_SOURCE_ARX3:	/* in 3rd stream */
+	case CLOCK_SOURCE_ARX2:	/* in 2nd stream */
+		err = -ENOSYS;
+	case CLOCK_SOURCE_ARX1:	/* in 1st stream */
+		*sync_mode = 0;
+		break;
+	default:
+		*sync_mode = CIP_SYNC_TO_DEVICE;
+	}
+end:
+	return err;
 }
 
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
@@ -306,15 +324,6 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
 		goto end;
 
 	err = init_stream(dice, &dice->rx_stream);
-	if (err < 0)
-		goto end;
-
-	/* Currently, clock source is fixed at SYT-Match mode. */
-	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
-	if (err < 0) {
-		destroy_stream(dice, &dice->rx_stream);
-		destroy_stream(dice, &dice->tx_stream);
-	}
 end:
 	return err;
 }
diff --git a/sound/firewire/dice/dice_transaction.c b/sound/firewire/dice/dice_transaction.c
index 90773b8..b49c202 100644
--- a/sound/firewire/dice/dice_transaction.c
+++ b/sound/firewire/dice/dice_transaction.c
@@ -125,11 +125,6 @@ int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
 
 	return err;
 }
-int snd_dice_transaction_set_clock_source(struct snd_dice *dice,
-					  unsigned int source)
-{
-	return set_clock_info(dice, UINT_MAX, source);
-}
 
 int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate)
 {
-- 
1.8.3.2
