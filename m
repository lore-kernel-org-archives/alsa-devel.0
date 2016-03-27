From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2] ALSA: dice: fix memory leak when unplugging
Date: Mon, 28 Mar 2016 08:29:32 +0900
Message-ID: <1459121372-7441-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B5B2619D7
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 01:29:38 +0200 (CEST)
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

When sound card is going to be released, dice private data is
also released. Then all of data should be released. However,
stream data is not released. This causes memory leak when
unplugging dice unit.

This commit fixes the bug.

Fixes: 4bdc495c87b3('ALSA: dice: handle several PCM substreams when any isochronous streams are available')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-stream.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index 845d5e5..ec4db3a 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -446,18 +446,12 @@ end:
 
 void snd_dice_stream_destroy_duplex(struct snd_dice *dice)
 {
-	struct reg_params tx_params, rx_params;
-
-	snd_dice_transaction_clear_enable(dice);
+	unsigned int i;
 
-	if (get_register_params(dice, &tx_params, &rx_params) == 0) {
-		stop_streams(dice, AMDTP_IN_STREAM, &tx_params);
-		stop_streams(dice, AMDTP_OUT_STREAM, &rx_params);
+	for (i = 0; i < MAX_STREAMS; i++) {
+		destroy_stream(dice, AMDTP_IN_STREAM, i);
+		destroy_stream(dice, AMDTP_OUT_STREAM, i);
 	}
-
-	release_resources(dice);
-
-	dice->substreams_counter = 0;
 }
 
 void snd_dice_stream_update_duplex(struct snd_dice *dice)
-- 
2.7.3
