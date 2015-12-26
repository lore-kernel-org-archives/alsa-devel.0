From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: dice: purge transaction
	initialization at timeout of Dice notification
Date: Sat, 26 Dec 2015 12:35:25 +0900
Message-ID: <1451100926-20637-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D44C2614A0
 for <alsa-devel@alsa-project.org>; Sat, 26 Dec 2015 04:35:36 +0100 (CET)
In-Reply-To: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In previous commit, card registration is processed under situation
with few bus reset. There's no need to add a workaround of transaction
re-initialization at timeout.

This commit purges the re-initialization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index 75a2125..d5f7de7 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -65,16 +65,15 @@ static unsigned int get_clock_info(struct snd_dice *dice, __be32 *info)
 static int set_clock_info(struct snd_dice *dice,
 			  unsigned int rate, unsigned int source)
 {
-	unsigned int retries = 3;
 	unsigned int i;
 	__be32 info;
 	u32 mask;
 	u32 clock;
 	int err;
-retry:
+
 	err = get_clock_info(dice, &info);
 	if (err < 0)
-		goto end;
+		return err;
 
 	clock = be32_to_cpu(info);
 	if (source != UINT_MAX) {
@@ -87,10 +86,8 @@ retry:
 			if (snd_dice_rates[i] == rate)
 				break;
 		}
-		if (i == ARRAY_SIZE(snd_dice_rates)) {
-			err = -EINVAL;
-			goto end;
-		}
+		if (i == ARRAY_SIZE(snd_dice_rates))
+			return -EINVAL;
 
 		mask = CLOCK_RATE_MASK;
 		clock &= ~mask;
@@ -104,25 +101,13 @@ retry:
 	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
 						&info, 4);
 	if (err < 0)
-		goto end;
+		return err;
 
-	/* Timeout means it's invalid request, probably bus reset occurred. */
 	if (wait_for_completion_timeout(&dice->clock_accepted,
-			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
-		if (retries-- == 0) {
-			err = -ETIMEDOUT;
-			goto end;
-		}
-
-		err = snd_dice_transaction_reinit(dice);
-		if (err < 0)
-			goto end;
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0)
+		return -ETIMEDOUT;
 
-		msleep(500);	/* arbitrary */
-		goto retry;
-	}
-end:
-	return err;
+	return 0;
 }
 
 int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
-- 
2.5.0
