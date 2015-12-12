From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/10] ALSA: dice: purge generating channel
	cache
Date: Sat, 12 Dec 2015 12:06:09 +0900
Message-ID: <1449889570-26641-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1449889570-26641-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D482654CE
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 04:06:17 +0100 (CET)
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

Dice interface design doesn't allow drivers to read supported combination
between sampling transfer frequencies and the number of Multi bit linear
audio data channels. Due to the design, ALSA dice driver changes current
sampling transfer frequency to generate cache of the combinations at
probing processing.

Although, this idea is worse because ALSA dice driver changes the state of
clock. This is not what users want when they save favorite configuration
to the device in advance.

Furthermore, there's a possibility that the format of data block is decided
not only according to current sampling transfer frequency, but also the
other factors, i.e. data format for digital interface. It's not good to
generate channel cache according to the sampling transfer frequency only.

This commit purges processing cache data and related structure members. As
a result, users must set preferable sampling transfer frequency before
using ALSA PCM applications, as long as they want to start any PCM
substreams at the rate.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 24 ++------------
 sound/firewire/dice/dice.c        | 67 ++-------------------------------------
 sound/firewire/dice/dice.h        |  7 ----
 3 files changed, 5 insertions(+), 93 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 4f74e3e..716db09 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -24,23 +24,6 @@ const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
 	[6] = 192000,
 };
 
-int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
-				  unsigned int *mode)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
-		if (!(dice->clock_caps & BIT(i)))
-			continue;
-		if (snd_dice_rates[i] != rate)
-			continue;
-
-		*mode = (i - 1) / 2;
-		return 0;
-	}
-	return -EINVAL;
-}
-
 static void release_resources(struct snd_dice *dice,
 			      struct fw_iso_resources *resources)
 {
@@ -100,13 +83,10 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 {
 	struct fw_iso_resources *resources;
 	__be32 reg[2];
-	unsigned int i, mode, pcm_chs, midi_ports;
+	unsigned int i, pcm_chs, midi_ports;
 	bool double_pcm_frames;
 	int err;
 
-	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
-	if (err < 0)
-		goto end;
 	if (stream == &dice->tx_stream) {
 		resources = &dice->tx_resources;
 		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
@@ -133,7 +113,7 @@ static int start_stream(struct snd_dice *dice, struct amdtp_stream *stream,
 	 * For this quirk, blocking mode is required and PCM buffer size should
 	 * be aligned to SYT_INTERVAL.
 	 */
-	double_pcm_frames = mode > 1;
+	double_pcm_frames = rate > 96000;
 	if (double_pcm_frames) {
 		rate /= 2;
 		pcm_chs *= 2;
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index c7d5e05..1993c16 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -57,65 +57,10 @@ static int check_dice_category(struct fw_unit *unit)
 	return 0;
 }
 
-static int highest_supported_mode_rate(struct snd_dice *dice,
-				       unsigned int mode, unsigned int *rate)
-{
-	unsigned int i, m;
-
-	for (i = ARRAY_SIZE(snd_dice_rates); i > 0; i--) {
-		*rate = snd_dice_rates[i - 1];
-		if (snd_dice_stream_get_rate_mode(dice, *rate, &m) < 0)
-			continue;
-		if (mode == m)
-			break;
-	}
-	if (i == 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
-{
-	__be32 values[2];
-	unsigned int rate;
-	int err;
-
-	if (highest_supported_mode_rate(dice, mode, &rate) < 0) {
-		dice->tx_channels[mode] = 0;
-		dice->tx_midi_ports[mode] = 0;
-		dice->rx_channels[mode] = 0;
-		dice->rx_midi_ports[mode] = 0;
-		return 0;
-	}
-
-	err = snd_dice_transaction_set_rate(dice, rate);
-	if (err < 0)
-		return err;
-
-	err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
-					   values, sizeof(values));
-	if (err < 0)
-		return err;
-
-	dice->tx_channels[mode]   = be32_to_cpu(values[0]);
-	dice->tx_midi_ports[mode] = be32_to_cpu(values[1]);
-
-	err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
-					   values, sizeof(values));
-	if (err < 0)
-		return err;
-
-	dice->rx_channels[mode]   = be32_to_cpu(values[0]);
-	dice->rx_midi_ports[mode] = be32_to_cpu(values[1]);
-
-	return 0;
-}
-
-static int dice_read_params(struct snd_dice *dice)
+static int check_clock_caps(struct snd_dice *dice)
 {
 	__be32 value;
-	int mode, err;
+	int err;
 
 	/* some very old firmwares don't tell about their clock support */
 	if (dice->clock_caps > 0) {
@@ -133,12 +78,6 @@ static int dice_read_params(struct snd_dice *dice)
 				   CLOCK_CAP_SOURCE_INTERNAL;
 	}
 
-	for (mode = 2; mode >= 0; --mode) {
-		err = dice_read_mode_params(dice, mode);
-		if (err < 0)
-			return err;
-	}
-
 	return 0;
 }
 
@@ -213,7 +152,7 @@ static void do_probe(struct work_struct *work)
 	if (err < 0)
 		goto end;
 
-	err = dice_read_params(dice);
+	err = check_clock_caps(dice);
 	if (err < 0)
 		goto end;
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 4741113..60f9661 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -56,10 +56,6 @@ struct snd_dice {
 	unsigned int rsrv_offset;
 
 	unsigned int clock_caps;
-	unsigned int tx_channels[3];
-	unsigned int rx_channels[3];
-	unsigned int tx_midi_ports[3];
-	unsigned int rx_midi_ports[3];
 
 	struct fw_address_handler notification_handler;
 	int owner_generation;
@@ -169,9 +165,6 @@ void snd_dice_transaction_destroy(struct snd_dice *dice);
 #define SND_DICE_RATES_COUNT	7
 extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
 
-int snd_dice_stream_get_rate_mode(struct snd_dice *dice,
-				  unsigned int rate, unsigned int *mode);
-
 int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate);
 void snd_dice_stream_stop_duplex(struct snd_dice *dice);
 int snd_dice_stream_init_duplex(struct snd_dice *dice);
-- 
2.5.0
