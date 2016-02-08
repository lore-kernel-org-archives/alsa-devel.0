From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] ALSA: dice: ensure phase lock before
	starting streaming
Date: Mon,  8 Feb 2016 22:54:20 +0900
Message-ID: <1454939660-21133-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1454939660-21133-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 437072610A3
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 14:54:28 +0100 (CET)
In-Reply-To: <1454939660-21133-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commits, probing process has no need to set sampling transfer
frequency. Although it's OK to drop a function to change the frequency
from this module, some models require it before streaming. This seems to
be due to phase lock of clock source.

This commit moves the function from transaction layer to stream layer, and
rename it according to the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c      | 34 +++++++++++++++++++--
 sound/firewire/dice/dice-transaction.c | 54 ----------------------------------
 sound/firewire/dice/dice.h             |  1 -
 3 files changed, 32 insertions(+), 57 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 716db09..e4938b0 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -10,6 +10,7 @@
 #include "dice.h"
 
 #define	CALLBACK_TIMEOUT	200
+#define NOTIFICATION_TIMEOUT_MS	(2 * MSEC_PER_SEC)
 
 const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	/* mode 0 */
@@ -24,6 +25,35 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	[6] = 192000,
 };
 
+/*
+ * This operation has an effect to synchronize GLOBAL_STATUS/GLOBAL_SAMPLE_RATE
+ * to GLOBAL_STATUS. Especially, just after powering on, these are different.
+ */
+static int ensure_phase_lock(struct snd_dice *dice)
+{
+	__be32 reg;
+	int err;
+
+	err = snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
+					       &reg, sizeof(reg));
+	if (err < 0)
+		return err;
+
+	if (completion_done(&dice->clock_accepted))
+		reinit_completion(&dice->clock_accepted);
+
+	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
+						&reg, sizeof(reg));
+	if (err < 0)
+		return err;
+
+	if (wait_for_completion_timeout(&dice->clock_accepted,
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static void release_resources(struct snd_dice *dice,
 			      struct fw_iso_resources *resources)
 {
@@ -222,10 +252,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 
 		amdtp_stream_set_sync(sync_mode, master, slave);
 
-		err = snd_dice_transaction_set_rate(dice, rate);
+		err = ensure_phase_lock(dice);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
-				"fail to set sampling rate\n");
+				"fail to ensure phase lock\n");
 			goto end;
 		}
 
diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index a4ff4e0..76f9f72 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -9,8 +9,6 @@
 
 #include "dice.h"
 
-#define NOTIFICATION_TIMEOUT_MS	(2 * MSEC_PER_SEC)
-
 static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
 		       u64 offset)
 {
@@ -62,54 +60,6 @@ static unsigned int get_clock_info(struct snd_dice *dice, __be32 *info)
 						info, 4);
 }
 
-static int set_clock_info(struct snd_dice *dice,
-			  unsigned int rate, unsigned int source)
-{
-	unsigned int i;
-	__be32 info;
-	u32 mask;
-	u32 clock;
-	int err;
-
-	err = get_clock_info(dice, &info);
-	if (err < 0)
-		return err;
-
-	clock = be32_to_cpu(info);
-	if (source != UINT_MAX) {
-		mask = CLOCK_SOURCE_MASK;
-		clock &= ~mask;
-		clock |= source;
-	}
-	if (rate != UINT_MAX) {
-		for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
-			if (snd_dice_rates[i] == rate)
-				break;
-		}
-		if (i == ARRAY_SIZE(snd_dice_rates))
-			return -EINVAL;
-
-		mask = CLOCK_RATE_MASK;
-		clock &= ~mask;
-		clock |= i << CLOCK_RATE_SHIFT;
-	}
-	info = cpu_to_be32(clock);
-
-	if (completion_done(&dice->clock_accepted))
-		reinit_completion(&dice->clock_accepted);
-
-	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
-						&info, 4);
-	if (err < 0)
-		return err;
-
-	if (wait_for_completion_timeout(&dice->clock_accepted,
-			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
 int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
 					  unsigned int *source)
 {
@@ -143,10 +93,6 @@ int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate)
 end:
 	return err;
 }
-int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate)
-{
-	return set_clock_info(dice, rate, UINT_MAX);
-}
 
 int snd_dice_transaction_set_enable(struct snd_dice *dice)
 {
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index c968f98..423cdba 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -154,7 +154,6 @@ static inline int snd_dice_transaction_read_sync(struct snd_dice *dice,
 
 int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
 					  unsigned int *source);
-int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate);
 int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate);
 int snd_dice_transaction_set_enable(struct snd_dice *dice);
 void snd_dice_transaction_clear_enable(struct snd_dice *dice);
-- 
2.5.0
