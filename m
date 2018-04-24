From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/11] ALSA: dice: enable to change current
	sampling transmission frequency
Date: Wed, 25 Apr 2018 08:42:28 +0900
Message-ID: <20180424234234.6063-6-o-takashi@sakamocchi.jp>
References: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E769267714
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 01:43:20 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id l27so13561577pfk.12
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 16:43:20 -0700 (PDT)
In-Reply-To: <20180424234234.6063-1-o-takashi@sakamocchi.jp>
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
 sound/firewire/dice/dice-stream.c | 44 +++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index e22896aaf346..92f3c345fa59 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -52,19 +52,32 @@ int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
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
 					       &reg, sizeof(reg));
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
 
 	if (completion_done(&dice->clock_accepted))
 		reinit_completion(&dice->clock_accepted);
 
+	reg = cpu_to_be32(data);
 	err = snd_dice_transaction_write_global(dice, GLOBAL_CLOCK_SELECT,
 						&reg, sizeof(reg));
 	if (err < 0)
@@ -210,6 +223,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 			 unsigned int rate, struct reg_params *params)
 {
 	__be32 reg[2];
+	unsigned int mode;
 	unsigned int i, pcm_chs, midi_ports;
 	struct amdtp_stream *streams;
 	struct fw_iso_resources *resources;
@@ -224,12 +238,23 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
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
+			pcm_cache = dice->tx_channels[i][mode];
+			midi_cache = dice->tx_midi_ports[i];
 			err = snd_dice_transaction_read_tx(dice,
 					params->size * i + TX_NUMBER_AUDIO,
 					reg, sizeof(reg));
 		} else {
+			pcm_cache = dice->rx_channels[i][mode];
+			midi_cache = dice->rx_midi_ports[i];
 			err = snd_dice_transaction_read_rx(dice,
 					params->size * i + RX_NUMBER_AUDIO,
 					reg, sizeof(reg));
@@ -239,6 +264,14 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
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
@@ -300,10 +333,9 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 			"fail to get sampling rate\n");
 		return err;
 	}
-	if (rate == 0)
+
+	if (rate != 0)
 		rate = curr_rate;
-	if (rate != curr_rate)
-		return -EINVAL;
 
 	/* Judge to need to restart streams. */
 	for (i = 0; i < MAX_STREAMS; i++) {
@@ -318,7 +350,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 				break;
 		}
 	}
-	need_to_start = (i < MAX_STREAMS);
+	need_to_start = (rate != curr_rate || i < MAX_STREAMS);
 
 	if (need_to_start) {
 		/* Stop transmission. */
@@ -327,7 +359,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
 		release_resources(dice);
 
-		err = ensure_phase_lock(dice);
+		err = ensure_phase_lock(dice, rate);
 		if (err < 0) {
 			dev_err(&dice->unit->device,
 				"fail to ensure phase lock\n");
-- 
2.14.1
