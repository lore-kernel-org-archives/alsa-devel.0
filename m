From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: dice: old firmware optimization for
	Dice notification
Date: Thu, 11 Feb 2016 20:18:38 +0900
Message-ID: <1455189518-29261-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1455189518-29261-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEE226063A
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 12:18:44 +0100 (CET)
In-Reply-To: <1455189518-29261-1-git-send-email-o-takashi@sakamocchi.jp>
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

As long as I tested, Dice-based models produced by TC Electronic with
factory-configured settings transfer no notification within
ensure_phase_lock(). On the other hand, with upgraded firmwares, it
starts to transfer the notification. This seems to be a quirk of earlier
firmwares.

This commit ensures phase lock by reading a register after waiting for
the notification. Even if it's timed-out, ensure_phase_lock() return
success as long as the register has expected clock status.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index e4938b0..a64b3cc 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -31,7 +31,7 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
  */
 static int ensure_phase_lock(struct snd_dice *dice)
 {
-	__be32 reg;
+	__be32 reg, nominal;
 	int err;
 
 	err = snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
@@ -48,8 +48,19 @@ static int ensure_phase_lock(struct snd_dice *dice)
 		return err;
 
 	if (wait_for_completion_timeout(&dice->clock_accepted,
-			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0)
-		return -ETIMEDOUT;
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
+		/*
+		 * Old versions of Dice firmware transfer no notification when
+		 * the same clock status as current one is set. In this case,
+		 * just check current clock status.
+		 */
+		err = snd_dice_transaction_read_global(dice, GLOBAL_STATUS,
+						&nominal, sizeof(nominal));
+		if (err < 0)
+			return err;
+		if (!(be32_to_cpu(nominal) & STATUS_SOURCE_LOCKED))
+			return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
2.5.0
