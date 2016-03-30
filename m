From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] ALSA: dice: simplify unit probe processing
Date: Thu, 31 Mar 2016 08:47:03 +0900
Message-ID: <1459381629-24189-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 86F3826172B
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 01:47:14 +0200 (CEST)
In-Reply-To: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
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

In former commit, ALSA dice driver doesn't generate kernel warnings
when unplugging units before initializing stream data.

This commit moves the initialization to delayed registration of sound
card, to simplify unit probe processing.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 8b64aef..53ca441 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -201,6 +201,10 @@ static void do_registration(struct work_struct *work)
 
 	dice_card_strings(dice);
 
+	err = snd_dice_stream_init_duplex(dice);
+	if (err < 0)
+		goto error;
+
 	snd_dice_create_proc(dice);
 
 	err = snd_dice_create_pcm(dice);
@@ -229,6 +233,7 @@ static void do_registration(struct work_struct *work)
 
 	return;
 error:
+	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
 	snd_card_free(dice->card);
 	dev_info(&dice->unit->device,
@@ -273,12 +278,6 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	init_completion(&dice->clock_accepted);
 	init_waitqueue_head(&dice->hwdep_wait);
 
-	err = snd_dice_stream_init_duplex(dice);
-	if (err < 0) {
-		dice_free(dice);
-		return err;
-	}
-
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&dice->dwork, do_registration);
 	schedule_registration(dice);
-- 
2.7.4
