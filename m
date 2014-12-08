From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 03/15] ALSA: dice: Support for non SYT-Match
	sampling clock source mode
Date: Tue,  9 Dec 2014 00:10:37 +0900
Message-ID: <1418051449-18371-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 55602260453
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:10:58 +0100 (CET)
In-Reply-To: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit allows this driver to handle devices with non SYT-Match
sampling clock source.

When sampling clock source is SYT-Match mode, devices handle
'presentation timestamp' in received packets and generates sampling clock
according to the information. In this case, driver is synchronization master
and must transfer correct value in SYT field of each packets in outgoing
stream, then the outgoing stream is a master stream.

On the other hand, non SYT-Match mode, devices do this. So drivers must pick
up the value in SYT field of incoming packets and use the value for outgoing
stream. Currently firewire-lib module achieve this work.

Furthermore, without SYT-Match and internal clock source, the sampling rate
should be fixed for the other devices connected to the handled device. This
commit add a restriction of sampling rate at this situation.

With these implementations, this driver has no need to set clock source.
This commit remove set function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c         | 35 ++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice-stream.c      | 35 ++++++++++++++++++++++------------
 sound/firewire/dice/dice-transaction.c |  5 -----
 sound/firewire/dice/dice.h             |  2 --
 4 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index b9ce026..062b7a3 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -140,6 +140,8 @@ end:
 static int pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	unsigned int source, rate;
+	bool internal;
 	int err;
 
 	err = snd_dice_stream_lock_try(dice);
@@ -149,6 +151,39 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	err = init_hw_info(dice, substream);
 	if (err < 0)
 		goto err_locked;
+
+	err = snd_dice_transaction_get_clock_source(dice, &source);
+	if (err < 0)
+		goto err_locked;
+	switch (source) {
+	case CLOCK_SOURCE_AES1:
+	case CLOCK_SOURCE_AES2:
+	case CLOCK_SOURCE_AES3:
+	case CLOCK_SOURCE_AES4:
+	case CLOCK_SOURCE_AES_ANY:
+	case CLOCK_SOURCE_ADAT:
+	case CLOCK_SOURCE_TDIF:
+	case CLOCK_SOURCE_WC:
+		internal = false;
+		break;
+	default:
+		internal = true;
+		break;
+	}
+
+	/*
+	 * When source of clock is not internal, available sampling rate is
+	 * limited at current sampling rate.
+	 */
+	if (!internal) {
+		err = snd_dice_transaction_get_rate(dice, &rate);
+		if (err < 0)
+			goto err_locked;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
 end:
 	return err;
 err_locked:
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index e60b84d..20765a0 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -161,9 +161,29 @@ end:
 
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
+		break;
+	case CLOCK_SOURCE_ARX1:	/* in 1st stream, which this driver uses */
+		*sync_mode = 0;
+		break;
+	default:
+		*sync_mode = CIP_SYNC_TO_DEVICE;
+		break;
+	}
+end:
+	return err;
 }
 
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
@@ -310,15 +330,6 @@ int snd_dice_stream_init_duplex(struct snd_dice *dice)
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
diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index 1fe304c..aee7461 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -137,11 +137,6 @@ int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
 
 	return err;
 }
-int snd_dice_transaction_set_clock_source(struct snd_dice *dice,
-					  unsigned int source)
-{
-	return set_clock_info(dice, UINT_MAX, source);
-}
 
 int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate)
 {
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index a62ee22..f30326e 100644
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
-- 
2.1.0
