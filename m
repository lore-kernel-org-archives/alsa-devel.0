From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/10] ALSA: dice: wait for ensuring phase lock
Date: Sat, 12 Dec 2015 12:06:02 +0900
Message-ID: <1449889570-26641-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CAF126549F
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 04:06:15 +0100 (CET)
In-Reply-To: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
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

Some users have reported that their Dice based models generate packet
discontinuity at the beginning of streaming. When standing on an
assumption that the value of SYT field in transferred AMDTP packet comes
from phase lock circuit, this comes from phase unlocking with current
clock source. Just waiting for dice notification is not enough to prevent
from packet discontinuity.

This commit checks the register of phase lock after clock state change for
this purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-transaction.c | 54 +++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index 9ea223a..ba0f526 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -65,16 +65,16 @@ static unsigned int get_clock_info(struct snd_dice *dice, __be32 *info)
 static int set_clock_info(struct snd_dice *dice,
 			  unsigned int rate, unsigned int source)
 {
-	unsigned int retries = 3;
+	unsigned int retries = 10;
 	unsigned int i;
-	__be32 info;
+	__be32 info, stat;
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
@@ -87,10 +87,8 @@ retry:
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
@@ -104,25 +102,33 @@ retry:
 	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
 						&info, 4);
 	if (err < 0)
-		goto end;
-
-	/* Timeout means it's invalid request, probably bus reset occurred. */
-	if (wait_for_completion_timeout(&dice->clock_accepted,
-			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
-		if (retries-- == 0) {
-			err = -ETIMEDOUT;
-			goto end;
-		}
-
-		err = snd_dice_transaction_reinit(dice);
+		return err;
+
+	wait_for_completion_timeout(&dice->clock_accepted,
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS));
+
+	/*
+	 * Some models don't perform phase lock yet. In this case, transferred
+	 * packet includes dicsontinuity. Here, wait till one second.
+	 */
+	while (retries-- > 0) {
+		err = snd_dice_transaction_read_global(dice, GLOBAL_STATUS,
+						       &stat, sizeof(stat));
 		if (err < 0)
-			goto end;
+			return err;
+
+		if ((be32_to_cpu(stat) & 0x01) == STATUS_SOURCE_LOCKED &&
+		    ((be32_to_cpu(stat) & STATUS_NOMINAL_RATE_MASK) ==
+		      (be32_to_cpu(info) & STATUS_NOMINAL_RATE_MASK)))
+			break;
 
-		msleep(500);	/* arbitrary */
-		goto retry;
+		msleep(100);
 	}
-end:
-	return err;
+
+	if (retries == 0)
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
-- 
2.5.0
