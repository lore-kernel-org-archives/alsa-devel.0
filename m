From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: dice: fix NULL pointer dereference
	at remove units when sound card is not registered
Date: Sat, 26 Mar 2016 21:05:58 +0900
Message-ID: <1458993959-22637-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id EA774261294
 for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2016 13:06:04 +0100 (CET)
In-Reply-To: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
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

When sound card is not registered, in a callback of unit removal, ALSA dice
driver calls amdtp_stream_stop(). This causes a NULL pointer dereference in
__mutex_lock_slowpath() because of uninitialized mutex data.

When private data is going to be released, no userspace applications refer
to AMDTP stream data anymore. Thus no need to stop the streams. This
commit just destroys the stream data to fix the bug.

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
