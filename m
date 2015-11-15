From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/8] ALSA: dice: wait for ensuring phase lock
Date: Sun, 15 Nov 2015 18:25:36 +0900
Message-ID: <1447579536-4459-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E0B52606E0
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:44 +0100 (CET)
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
 sound/firewire/dice/dice-stream.c | 40 +++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index aa639c6..33d20d5 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -40,34 +40,42 @@ int snd_dice_stream_calculate_rate(__be32 reg, unsigned int *rate)
 
 static int ensure_phase_lock(struct snd_dice *dice, __be32 reg)
 {
-	unsigned int retries = 3;
+	__be32 stat;
+	unsigned int retries = 10;
 	int err;
-retry:
+
 	if (completion_done(&dice->clock_accepted))
 		reinit_completion(&dice->clock_accepted);
 
 	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
 						&reg, sizeof(reg));
 	if (err < 0)
-		goto end;
+		return err;
 
-	/* Timeout means it's invalid request, probably bus reset occurred. */
-	if (wait_for_completion_timeout(&dice->clock_accepted,
-			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
-		if (retries-- == 0) {
-			err = -ETIMEDOUT;
-			goto end;
-		}
+	wait_for_completion_timeout(&dice->clock_accepted,
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS));
 
-		err = snd_dice_transaction_reinit(dice);
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
+		      (be32_to_cpu(reg) & STATUS_NOMINAL_RATE_MASK)))
+			break;
 
-		msleep(500);	/* arbitrary */
-		goto retry;
+		msleep(100);
 	}
-end:
-	return err;
+	if (retries == 0)
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 static void release_resources(struct snd_dice *dice,
-- 
2.5.0
