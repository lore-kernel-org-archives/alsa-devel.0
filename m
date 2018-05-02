From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 04/13] ALSA: dice: cache stream formats at
	current mode of sampling transmission frequency
Date: Wed,  2 May 2018 19:16:42 +0900
Message-ID: <20180502101651.26173-5-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 83EBF267668
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:30 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id e9so7401494pfi.4
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:30 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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

In former commits, proxy structure get members for cache of stream
formats. This commit fills the cache with stream formats at current mode
of sampling transmission frequency.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 86 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c        |  4 ++
 sound/firewire/dice/dice.h        |  3 ++
 3 files changed, 93 insertions(+)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 928a255bfc35..f8bfe287bd02 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -30,6 +30,34 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	[6] = 192000,
 };
 
+int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
+				  enum snd_dice_rate_mode *mode)
+{
+	/* Corresponding to each entry in snd_dice_rates. */
+	static const enum snd_dice_rate_mode modes[] = {
+		[0] = SND_DICE_RATE_MODE_LOW,
+		[1] = SND_DICE_RATE_MODE_LOW,
+		[2] = SND_DICE_RATE_MODE_LOW,
+		[3] = SND_DICE_RATE_MODE_MIDDLE,
+		[4] = SND_DICE_RATE_MODE_MIDDLE,
+		[5] = SND_DICE_RATE_MODE_HIGH,
+		[6] = SND_DICE_RATE_MODE_HIGH,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
+		if (!(dice->clock_caps & BIT(i)))
+			continue;
+		if (snd_dice_rates[i] != rate)
+			continue;
+
+		*mode = modes[i];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * This operation has an effect to synchronize GLOBAL_STATUS/GLOBAL_SAMPLE_RATE
  * to GLOBAL_STATUS. Especially, just after powering on, these are different.
@@ -484,6 +512,64 @@ void snd_dice_stream_update_duplex(struct snd_dice *dice)
 	}
 }
 
+int snd_dice_stream_detect_current_formats(struct snd_dice *dice)
+{
+	unsigned int rate;
+	enum snd_dice_rate_mode mode;
+	__be32 reg[2];
+	struct reg_params tx_params, rx_params;
+	int i;
+	int err;
+
+	/*
+	 * Available stream format is restricted at current mode of sampling
+	 * clock.
+	 */
+	err = snd_dice_transaction_get_rate(dice, &rate);
+	if (err < 0)
+		return err;
+
+	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Just after owning the unit (GLOBAL_OWNER), the unit can return
+	 * invalid stream formats. Selecting clock parameters have an effect
+	 * for the unit to refine it.
+	 */
+	err = ensure_phase_lock(dice);
+	if (err < 0)
+		return err;
+
+	err = get_register_params(dice, &tx_params, &rx_params);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < tx_params.count; ++i) {
+		err = snd_dice_transaction_read_tx(dice,
+				tx_params.size * i + TX_NUMBER_AUDIO,
+				reg, sizeof(reg));
+		if (err < 0)
+			return err;
+		dice->tx_pcm_chs[i][mode] = be32_to_cpu(reg[0]);
+		dice->tx_midi_ports[i] = max_t(unsigned int,
+				be32_to_cpu(reg[1]), dice->tx_midi_ports[i]);
+	}
+	for (i = 0; i < rx_params.count; ++i) {
+		err = snd_dice_transaction_read_rx(dice,
+				rx_params.size * i + RX_NUMBER_AUDIO,
+				reg, sizeof(reg));
+		if (err < 0)
+			return err;
+		dice->rx_pcm_chs[i][mode] = be32_to_cpu(reg[0]);
+		dice->rx_midi_ports[i] = max_t(unsigned int,
+				be32_to_cpu(reg[1]), dice->rx_midi_ports[i]);
+	}
+
+	return 0;
+}
+
 static void dice_lock_changed(struct snd_dice *dice)
 {
 	dice->dev_lock_changed = true;
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 96bb01b6b751..002f3f3cbc6a 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -199,6 +199,10 @@ static void do_registration(struct work_struct *work)
 
 	dice_card_strings(dice);
 
+	err = snd_dice_stream_detect_current_formats(dice);
+	if (err < 0)
+		goto error;
+
 	err = snd_dice_stream_init_duplex(dice);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 8f68976930c5..0c044f28b9e7 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -201,11 +201,14 @@ void snd_dice_transaction_destroy(struct snd_dice *dice);
 #define SND_DICE_RATES_COUNT	7
 extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
 
+int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
+				  enum snd_dice_rate_mode *mode);
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate);
 void snd_dice_stream_stop_duplex(struct snd_dice *dice);
 int snd_dice_stream_init_duplex(struct snd_dice *dice);
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice);
 void snd_dice_stream_update_duplex(struct snd_dice *dice);
+int snd_dice_stream_detect_current_formats(struct snd_dice *dice);
 
 int snd_dice_stream_lock_try(struct snd_dice *dice);
 void snd_dice_stream_lock_release(struct snd_dice *dice);
-- 
2.14.1
