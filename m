From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 08/13] ALSA: dice: use cache of stream
	format to check running stream
Date: Wed,  2 May 2018 19:16:46 +0900
Message-ID: <20180502101651.26173-9-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD9032676A5
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:38 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id c10so11384890pfi.12
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:38 -0700 (PDT)
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

At present, to check running stream, available stream formats are used
at current sampling transmission frequency (stf). But when changing stf,
it's convenient to use cache of stream formats.

This commit applies this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 50 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index dcca28641042..f93ecab47b54 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -294,16 +294,14 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	unsigned int curr_rate;
 	unsigned int i;
 	struct reg_params tx_params, rx_params;
-	bool need_to_start;
+	bool need_to_start = false;
+	enum snd_dice_rate_mode mode;
 	int err;
 
 	if (dice->substreams_counter == 0)
 		return -EIO;
 
-	err = get_register_params(dice, &tx_params, &rx_params);
-	if (err < 0)
-		return err;
-
+	/* Check sampling transmission frequency. */
 	err = snd_dice_transaction_get_rate(dice, &curr_rate);
 	if (err < 0) {
 		dev_err(&dice->unit->device,
@@ -315,22 +313,36 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 	if (rate != curr_rate)
 		return -EINVAL;
 
-	/* Judge to need to restart streams. */
-	for (i = 0; i < MAX_STREAMS; i++) {
-		if (i < tx_params.count) {
-			if (amdtp_streaming_error(&dice->tx_stream[i]) ||
-			    !amdtp_stream_running(&dice->tx_stream[i]))
-				break;
-		}
-		if (i < rx_params.count) {
-			if (amdtp_streaming_error(&dice->rx_stream[i]) ||
-			    !amdtp_stream_running(&dice->rx_stream[i]))
-				break;
-		}
+	/* Check error of packet streaming. */
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		if (amdtp_streaming_error(&dice->tx_stream[i]))
+			break;
+		if (amdtp_streaming_error(&dice->rx_stream[i]))
+			break;
+	}
+	if (i < MAX_STREAMS)
+		need_to_start = true;
+
+	/* Check required streams are running or not. */
+	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
+	if (err < 0)
+		return err;
+	for (i = 0; i < MAX_STREAMS; ++i) {
+		if (dice->tx_pcm_chs[i][mode] > 0 &&
+		    !amdtp_stream_running(&dice->tx_stream[i]))
+			break;
+		if (dice->rx_pcm_chs[i][mode] > 0 &&
+		    !amdtp_stream_running(&dice->rx_stream[i]))
+			break;
 	}
-	need_to_start = (i < MAX_STREAMS);
+	if (i < MAX_STREAMS)
+		need_to_start = true;
 
 	if (need_to_start) {
+		err = get_register_params(dice, &tx_params, &rx_params);
+		if (err < 0)
+			return err;
+
 		/* Stop transmission. */
 		snd_dice_transaction_clear_enable(dice);
 		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
@@ -341,7 +353,7 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 		if (err < 0) {
 			dev_err(&dice->unit->device,
 				"fail to ensure phase lock\n");
-			return err;
+			goto error;
 		}
 
 		/* Start both streams. */
-- 
2.14.1
