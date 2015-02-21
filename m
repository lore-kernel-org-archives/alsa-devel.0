From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ALSA: fireworks/bebob/dice/oxfw: make it possible to
	shutdown safely
Date: Sat, 21 Feb 2015 23:55:00 +0900
Message-ID: <1424530500-9116-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1424530500-9116-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

A part of these drivers, especially BeBoB driver, are programmed to wait
some events. Thus the drivers should not destroy any data in .remove()
context.

This commit moves some destructors from 'struct fw_driver.remove()' to
'struct snd_card.private_free()' to shutdown safely.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c                | 10 ++++++----
 sound/firewire/bebob/bebob_stream.c         |  4 ----
 sound/firewire/dice/dice.c                  |  5 +----
 sound/firewire/fireworks/fireworks.c        | 10 ++++------
 sound/firewire/fireworks/fireworks_stream.c |  4 ----
 sound/firewire/oxfw/oxfw.c                  | 10 ++++------
 6 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index b612599..611b7da 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -127,8 +127,11 @@ bebob_card_free(struct snd_card *card)
 {
 	struct snd_bebob *bebob = card->private_data;
 
+	snd_bebob_stream_destroy_duplex(bebob);
 	fw_unit_put(bebob->unit);
 
+	kfree(bebob->maudio_special_quirk);
+
 	if (bebob->card_index >= 0) {
 		mutex_lock(&devices_mutex);
 		clear_bit(bebob->card_index, devices_used);
@@ -314,10 +317,9 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob == NULL)
 		return;
 
-	kfree(bebob->maudio_special_quirk);
-
-	snd_bebob_stream_destroy_duplex(bebob);
-	snd_card_disconnect(bebob->card);
+	/* Awake bus-reset waiters. */
+	if (!completion_done(&bebob->bus_reset))
+		complete_all(&bebob->bus_reset);
 
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(bebob->card);
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index fcca3ee..98e4fc8 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -716,14 +716,10 @@ void snd_bebob_stream_update_duplex(struct snd_bebob *bebob)
  */
 void snd_bebob_stream_destroy_duplex(struct snd_bebob *bebob)
 {
-	mutex_lock(&bebob->mutex);
-
 	amdtp_stream_destroy(&bebob->rx_stream);
 	amdtp_stream_destroy(&bebob->tx_stream);
 
 	destroy_both_connections(bebob);
-
-	mutex_unlock(&bebob->mutex);
 }
 
 /*
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 797f072..70a111d 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -236,6 +236,7 @@ static void dice_card_free(struct snd_card *card)
 {
 	struct snd_dice *dice = card->private_data;
 
+	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
 	fw_unit_put(dice->unit);
 
@@ -313,10 +314,6 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	snd_card_disconnect(dice->card);
-
-	snd_dice_stream_destroy_duplex(dice);
-
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(dice->card);
 }
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 1e33394..2682e7e 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -184,8 +184,12 @@ efw_card_free(struct snd_card *card)
 {
 	struct snd_efw *efw = card->private_data;
 
+	snd_efw_stream_destroy_duplex(efw);
+	snd_efw_transaction_remove_instance(efw);
 	fw_unit_put(efw->unit);
 
+	kfree(efw->resp_buf);
+
 	if (efw->card_index >= 0) {
 		mutex_lock(&devices_mutex);
 		clear_bit(efw->card_index, devices_used);
@@ -193,7 +197,6 @@ efw_card_free(struct snd_card *card)
 	}
 
 	mutex_destroy(&efw->mutex);
-	kfree(efw->resp_buf);
 }
 
 static int
@@ -297,11 +300,6 @@ static void efw_remove(struct fw_unit *unit)
 {
 	struct snd_efw *efw = dev_get_drvdata(&unit->device);
 
-	snd_efw_stream_destroy_duplex(efw);
-	snd_efw_transaction_remove_instance(efw);
-
-	snd_card_disconnect(efw->card);
-
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(efw->card);
 }
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index f817b7a..c55db1b 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -324,12 +324,8 @@ void snd_efw_stream_update_duplex(struct snd_efw *efw)
 
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw)
 {
-	mutex_lock(&efw->mutex);
-
 	destroy_stream(efw, &efw->rx_stream);
 	destroy_stream(efw, &efw->tx_stream);
-
-	mutex_unlock(&efw->mutex);
 }
 
 void snd_efw_stream_lock_changed(struct snd_efw *efw)
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 1607b26..8c6ce01 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -115,6 +115,10 @@ static void oxfw_card_free(struct snd_card *card)
 	struct snd_oxfw *oxfw = card->private_data;
 	unsigned int i;
 
+	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
+	if (oxfw->has_output)
+		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
+
 	fw_unit_put(oxfw->unit);
 
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
@@ -220,12 +224,6 @@ static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	snd_card_disconnect(oxfw->card);
-
-	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
-	if (oxfw->has_output)
-		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
-
 	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(oxfw->card);
 }
-- 
2.1.0


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
