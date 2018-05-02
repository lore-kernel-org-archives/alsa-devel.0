From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 10/13] ALSA: dice: enable to change current
	sampling transmission frequency
Date: Wed,  2 May 2018 19:16:48 +0900
Message-ID: <20180502101651.26173-11-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 689A12676A2
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:42 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id v63so11387315pfk.8
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:42 -0700 (PDT)
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

This is a preparation for userspace applications to change current sampling
transmission frequency via ALSA PCM interface.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 47 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 7c0a47c73fa9..c3c892c5c7ff 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -62,9 +62,11 @@ int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
  * This operation has an effect to synchronize GLOBAL_STATUS/GLOBAL_SAMPLE_RATE
  * to GLOBAL_STATUS. Especially, just after powering on, these are different.
  */
-static int ensure_phase_lock(struct snd_dice *dice)
+static int ensure_phase_lock(struct snd_dice *dice, unsigned int rate)
 {
 	__be32 reg, nominal;
+	u32 data;
+	int i;
 	int err;
 
 	err = snd_dice_transaction_read_global(dice, GLOBAL_CLOCK_SELECT,
@@ -72,9 +74,21 @@ static int ensure_phase_lock(struct snd_dice *dice)
 	if (err < 0)
 		return err;
 
+	data = be32_to_cpu(reg);
+
+	data &= ~CLOCK_RATE_MASK;
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
+		if (snd_dice_rates[i] == rate)
+			break;
+	}
+	if (i == ARRAY_SIZE(snd_dice_rates))
+		return -EINVAL;
+	data |= i << CLOCK_RATE_SHIFT;
+
 	if (completion_done(&dice->clock_accepted))
 		reinit_completion(&dice->clock_accepted);
 
+	reg = cpu_to_be32(data);
 	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
 						&reg, sizeof(reg));
 	if (err < 0)
@@ -220,6 +234,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			 unsigned int rate, struct reg_params *params)
 {
 	__be32 reg[2];
+	enum snd_dice_rate_mode mode;
 	unsigned int i, pcm_chs, midi_ports;
 	struct amdtp_stream *streams;
 	struct fw_iso_resources *resources;
@@ -234,12 +249,23 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		resources = dice->rx_resources;
 	}
 
+	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
+	if (err < 0)
+		return err;
+
 	for (i = 0; i < params->count; i++) {
+		unsigned int pcm_cache;
+		unsigned int midi_cache;
+
 		if (dir == AMDTP_IN_STREAM) {
+			pcm_cache = dice->tx_pcm_chs[i][mode];
+			midi_cache = dice->tx_midi_ports[i];
 			err = snd_dice_transaction_read_tx(dice,
 					params->size * i + TX_NUMBER_AUDIO,
 					reg, sizeof(reg));
 		} else {
+			pcm_cache = dice->rx_pcm_chs[i][mode];
+			midi_cache = dice->rx_midi_ports[i];
 			err = snd_dice_transaction_read_rx(dice,
 					params->size * i + RX_NUMBER_AUDIO,
 					reg, sizeof(reg));
@@ -249,6 +275,14 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		pcm_chs = be32_to_cpu(reg[0]);
 		midi_ports = be32_to_cpu(reg[1]);
 
+		/* These are important for developer of this driver. */
+		if (pcm_chs != pcm_cache || midi_ports != midi_cache) {
+			dev_info(&dice->unit->device,
+				 "cache mismatch: pcm: %u:%u, midi: %u:%u\n",
+				 pcm_chs, pcm_cache, midi_ports, midi_cache);
+			return -EPROTO;
+		}
+
 		err = keep_resources(dice, dir, i, rate, pcm_chs, midi_ports);
 		if (err < 0)
 			return err;
@@ -300,12 +334,17 @@ static int start_duplex_streams(struct snd_dice *dice, unsigned int rate)
 	snd_dice_transaction_clear_enable(dice);
 	release_resources(dice);
 
-	err = ensure_phase_lock(dice);
+	err = ensure_phase_lock(dice, rate);
 	if (err < 0) {
 		dev_err(&dice->unit->device, "fail to ensure phase lock\n");
 		return err;
 	}
 
+	/* Likely to have changed stream formats. */
+	err = get_register_params(dice, &tx_params, &rx_params);
+	if (err < 0)
+		return err;
+
 	/* Start both streams. */
 	err = start_streams(dice, AMDTP_IN_STREAM, rate, &tx_params);
 	if (err < 0)
@@ -366,7 +405,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	if (rate == 0)
 		rate = curr_rate;
 	if (rate != curr_rate)
-		return -EINVAL;
+		goto restart;
 
 	/* Check error of packet streaming. */
 	for (i = 0; i < MAX_STREAMS; ++i) {
@@ -560,7 +599,7 @@ int snd_dice_stream_detect_current_formats(struct snd_dice *dice)
 	 * invalid stream formats. Selecting clock parameters have an effect
 	 * for the unit to refine it.
 	 */
-	err = ensure_phase_lock(dice);
+	err = ensure_phase_lock(dice, rate);
 	if (err < 0)
 		return err;
 
-- 
2.14.1
