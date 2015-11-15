From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: dice: ensure phase lock before
	starting streaming
Date: Sun, 15 Nov 2015 18:25:34 +0900
Message-ID: <1447579536-4459-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E92742606D3
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:42 +0100 (CET)
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

In former commits, probing process has no need to set sampling transfer
frequency, while some models require to set the frequency before streaming.
The reason may be due to phase lock of clock source.

This commit envelops the function in stream layer and rename it.
Additionally, this commit reduces the number of transactions to check
the state of clock because one register represents both of source and
frequency of the clock.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c         |   6 +-
 sound/firewire/dice/dice-stream.c      |  76 ++++++++++++++++++-----
 sound/firewire/dice/dice-transaction.c | 109 ---------------------------------
 sound/firewire/dice/dice.h             |   7 +--
 4 files changed, 67 insertions(+), 131 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index c3343b6..1387cbf 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -35,7 +35,11 @@ static int limit_channels_and_rates(struct snd_dice *dice,
 	hw->channels_min = hw->channels_max = be32_to_cpu(reg[0]);
 
 	/* Retrieve current sampling transfer frequency and limit to it. */
-	err = snd_dice_transaction_get_rate(dice, &rate);
+	err = snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
+					       &reg, sizeof(reg[0]));
+	if (err < 0)
+		return err;
+	err = snd_dice_stream_calculate_rate(reg[0], &rate);
 	if (err < 0)
 		return err;
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 3462724..a5fc694 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -12,7 +12,7 @@
 #define	CALLBACK_TIMEOUT	200
 #define NOTIFICATION_TIMEOUT_MS	100
 
-const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
+static const unsigned int dice_stream_rates[] = {
 	/* mode 0 */
 	[0] =  32000,
 	[1] =  44100,
@@ -25,6 +25,51 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	[6] = 192000,
 };
 
+int snd_dice_stream_calculate_rate(__be32 reg, unsigned int *rate)
+{
+	unsigned int index;
+
+	index = (be32_to_cpu(reg) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
+	if (index >= ARRAY_SIZE(dice_stream_rates))
+		return -EIO;
+
+	*rate = dice_stream_rates[index];
+
+	return 0;
+}
+
+static int ensure_phase_lock(struct snd_dice *dice, __be32 reg)
+{
+	unsigned int retries = 3;
+	int err;
+retry:
+	if (completion_done(&dice->clock_accepted))
+		reinit_completion(&dice->clock_accepted);
+
+	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
+						&reg, sizeof(reg));
+	if (err < 0)
+		goto end;
+
+	/* Timeout means it's invalid request, probably bus reset occurred. */
+	if (wait_for_completion_timeout(&dice->clock_accepted,
+			msecs_to_jiffies(NOTIFICATION_TIMEOUT_MS)) == 0) {
+		if (retries-- == 0) {
+			err = -ETIMEDOUT;
+			goto end;
+		}
+
+		err = snd_dice_transaction_reinit(dice);
+		if (err < 0)
+			goto end;
+
+		msleep(500);	/* arbitrary */
+		goto retry;
+	}
+end:
+	return err;
+}
+
 static void release_resources(struct snd_dice *dice,
 			      struct fw_iso_resources *resources)
 {
@@ -151,21 +196,16 @@ end:
 	return err;
 }
 
-static int get_sync_mode(struct snd_dice *dice, enum cip_flags *sync_mode)
+static inline int calculate_sync_mode(__be32 reg, enum cip_flags *sync_mode)
 {
-	u32 source;
-	int err;
-
-	err = snd_dice_transaction_get_clock_source(dice, &source);
-	if (err < 0)
-		goto end;
+	int err = 0;
 
-	switch (source) {
+	switch (be32_to_cpu(reg) & CLOCK_SOURCE_MASK) {
 	/* So-called 'SYT Match' modes, sync_to_syt value of packets received */
 	case CLOCK_SOURCE_ARX4:	/* in 4th stream */
 	case CLOCK_SOURCE_ARX3:	/* in 3rd stream */
 	case CLOCK_SOURCE_ARX2:	/* in 2nd stream */
-		err = -ENOSYS;
+		err = -EINVAL;
 		break;
 	case CLOCK_SOURCE_ARX1:	/* in 1st stream, which this driver uses */
 		*sync_mode = 0;
@@ -174,13 +214,14 @@ static int get_sync_mode(struct snd_dice *dice, enum cip_flags *sync_mode)
 		*sync_mode = CIP_SYNC_TO_DEVICE;
 		break;
 	}
-end:
+
 	return err;
 }
 
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 {
 	struct amdtp_stream *master, *slave;
+	__be32 reg;
 	unsigned int curr_rate;
 	enum cip_flags sync_mode;
 	int err = 0;
@@ -188,7 +229,12 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	if (dice->substreams_counter == 0)
 		goto end;
 
-	err = get_sync_mode(dice, &sync_mode);
+	err = snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
+					       &reg, sizeof(reg));
+	if (err < 0)
+		goto end;
+
+	err = calculate_sync_mode(reg, &sync_mode);
 	if (err < 0)
 		goto end;
 	if (sync_mode == CIP_SYNC_TO_DEVICE) {
@@ -204,7 +250,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 		stop_stream(dice, master);
 
 	/* Stop stream if rate is different. */
-	err = snd_dice_transaction_get_rate(dice, &curr_rate);
+	err = snd_dice_stream_calculate_rate(reg, &curr_rate);
 	if (err < 0) {
 		dev_err(&dice->unit->device,
 			"fail to get sampling rate\n");
@@ -223,10 +269,10 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 
 		amdtp_stream_set_sync(sync_mode, master, slave);
 
-		err = snd_dice_transaction_set_rate(dice, rate);
+		err = ensure_phase_lock(dice, reg);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
-				"fail to set sampling rate\n");
+				"fail to ensure phase lock\n");
 			goto end;
 		}
 
diff --git a/sound/firewire/dice/dice-transaction.c b/sound/firewire/dice/dice-transaction.c
index aee7461..2819f95 100644
--- a/sound/firewire/dice/dice-transaction.c
+++ b/sound/firewire/dice/dice-transaction.c
@@ -9,8 +9,6 @@
 
 #include "dice.h"
 
-#define NOTIFICATION_TIMEOUT_MS	100
-
 static u64 get_subaddr(struct snd_dice *dice, enum snd_dice_addr_type type,
 		       u64 offset)
 {
@@ -56,113 +54,6 @@ int snd_dice_transaction_read(struct snd_dice *dice,
 				  get_subaddr(dice, type, offset), buf, len, 0);
 }
 
-static unsigned int get_clock_info(struct snd_dice *dice, __be32 *info)
-{
-	return snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
-						info, 4);
-}
-
-static int set_clock_info(struct snd_dice *dice,
-			  unsigned int rate, unsigned int source)
-{
-	unsigned int retries = 3;
-	unsigned int i;
-	__be32 info;
-	u32 mask;
-	u32 clock;
-	int err;
-retry:
-	err = get_clock_info(dice, &info);
-	if (err < 0)
-		goto end;
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
-		if (i == ARRAY_SIZE(snd_dice_rates)) {
-			err = -EINVAL;
-			goto end;
-		}
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
-		if (err < 0)
-			goto end;
-
-		msleep(500);	/* arbitrary */
-		goto retry;
-	}
-end:
-	return err;
-}
-
-int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
-					  unsigned int *source)
-{
-	__be32 info;
-	int err;
-
-	err = get_clock_info(dice, &info);
-	if (err >= 0)
-		*source = be32_to_cpu(info) & CLOCK_SOURCE_MASK;
-
-	return err;
-}
-
-int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate)
-{
-	__be32 info;
-	unsigned int index;
-	int err;
-
-	err = get_clock_info(dice, &info);
-	if (err < 0)
-		goto end;
-
-	index = (be32_to_cpu(info) & CLOCK_RATE_MASK) >> CLOCK_RATE_SHIFT;
-	if (index >= SND_DICE_RATES_COUNT) {
-		err = -ENOSYS;
-		goto end;
-	}
-
-	*rate = snd_dice_rates[index];
-end:
-	return err;
-}
-int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate)
-{
-	return set_clock_info(dice, rate, UINT_MAX);
-}
-
 int snd_dice_transaction_set_enable(struct snd_dice *dice)
 {
 	__be32 value;
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 3d91a02..c9af892 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -149,18 +149,13 @@ static inline int snd_dice_transaction_read_sync(struct snd_dice *dice,
 					 buf, len);
 }
 
-int snd_dice_transaction_get_clock_source(struct snd_dice *dice,
-					  unsigned int *source);
-int snd_dice_transaction_set_rate(struct snd_dice *dice, unsigned int rate);
-int snd_dice_transaction_get_rate(struct snd_dice *dice, unsigned int *rate);
 int snd_dice_transaction_set_enable(struct snd_dice *dice);
 void snd_dice_transaction_clear_enable(struct snd_dice *dice);
 int snd_dice_transaction_init(struct snd_dice *dice);
 int snd_dice_transaction_reinit(struct snd_dice *dice);
 void snd_dice_transaction_destroy(struct snd_dice *dice);
 
-#define SND_DICE_RATES_COUNT	7
-extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
+int snd_dice_stream_calculate_rate(__be32 reg, unsigned int *rate);
 
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate);
 void snd_dice_stream_stop_duplex(struct snd_dice *dice);
-- 
2.5.0
