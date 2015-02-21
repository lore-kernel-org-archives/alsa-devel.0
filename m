From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: fireworks/bebob/dice/oxfw: add reference-counting
	for FireWire unit
Date: Sat, 21 Feb 2015 23:54:57 +0900
Message-ID: <1424530500-9116-2-git-send-email-o-takashi@sakamocchi.jp>
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

Fireworks and Dice drivers try to touch instances of FireWire unit after
sound card object is released, while references to the unit is decremented
in .remove(). When unplugging during streaming, sound card object is
released after .remove(), thus Fireworks and Dice drivers causes GPF or
Null-pointer-dereferencing to application processes because an instance of
FireWire unit was already released.

This commit adds reference-counting for FireWire unit in drivers to allow
them to touch an instance of FireWire unit after .remove(). In most case,
any operations after .remove() may be failed safely.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 12 +++++++++++-
 sound/firewire/dice/dice.c           | 11 ++++++++++-
 sound/firewire/fireworks/fireworks.c | 12 +++++++++++-
 sound/firewire/oxfw/oxfw.c           | 11 ++++++++++-
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index fc19c99..b612599 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -116,11 +116,19 @@ end:
 	return err;
 }
 
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
 static void
 bebob_card_free(struct snd_card *card)
 {
 	struct snd_bebob *bebob = card->private_data;
 
+	fw_unit_put(bebob->unit);
+
 	if (bebob->card_index >= 0) {
 		mutex_lock(&devices_mutex);
 		clear_bit(bebob->card_index, devices_used);
@@ -205,7 +213,7 @@ bebob_probe(struct fw_unit *unit,
 	card->private_free = bebob_card_free;
 
 	bebob->card = card;
-	bebob->unit = unit;
+	bebob->unit = fw_unit_get(unit);
 	bebob->spec = spec;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
@@ -310,6 +318,8 @@ static void bebob_remove(struct fw_unit *unit)
 
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
+
+	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(bebob->card);
 }
 
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 90d8f40..797f072 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -226,11 +226,19 @@ static void dice_card_strings(struct snd_dice *dice)
 	strcpy(card->mixername, "DICE");
 }
 
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
 static void dice_card_free(struct snd_card *card)
 {
 	struct snd_dice *dice = card->private_data;
 
 	snd_dice_transaction_destroy(dice);
+	fw_unit_put(dice->unit);
+
 	mutex_destroy(&dice->mutex);
 }
 
@@ -251,7 +259,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice = card->private_data;
 	dice->card = card;
-	dice->unit = unit;
+	dice->unit = fw_unit_get(unit);
 	card->private_free = dice_card_free;
 
 	spin_lock_init(&dice->lock);
@@ -309,6 +317,7 @@ static void dice_remove(struct fw_unit *unit)
 
 	snd_dice_stream_destroy_duplex(dice);
 
+	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(dice->card);
 }
 
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 3e2ed8e..1e33394 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -173,11 +173,19 @@ end:
 	return err;
 }
 
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
 static void
 efw_card_free(struct snd_card *card)
 {
 	struct snd_efw *efw = card->private_data;
 
+	fw_unit_put(efw->unit);
+
 	if (efw->card_index >= 0) {
 		mutex_lock(&devices_mutex);
 		clear_bit(efw->card_index, devices_used);
@@ -218,7 +226,7 @@ efw_probe(struct fw_unit *unit,
 	card->private_free = efw_card_free;
 
 	efw->card = card;
-	efw->unit = unit;
+	efw->unit = fw_unit_get(unit);
 	mutex_init(&efw->mutex);
 	spin_lock_init(&efw->lock);
 	init_waitqueue_head(&efw->hwdep_wait);
@@ -293,6 +301,8 @@ static void efw_remove(struct fw_unit *unit)
 	snd_efw_transaction_remove_instance(efw);
 
 	snd_card_disconnect(efw->card);
+
+	/* No need to wait for releasing card object in this context. */
 	snd_card_free_when_closed(efw->card);
 }
 
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 60e5cad..1607b26 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -104,11 +104,19 @@ end:
 	return err;
 }
 
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
 static void oxfw_card_free(struct snd_card *card)
 {
 	struct snd_oxfw *oxfw = card->private_data;
 	unsigned int i;
 
+	fw_unit_put(oxfw->unit);
+
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
 		kfree(oxfw->tx_stream_formats[i]);
 		kfree(oxfw->rx_stream_formats[i]);
@@ -136,7 +144,7 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw = card->private_data;
 	oxfw->card = card;
 	mutex_init(&oxfw->mutex);
-	oxfw->unit = unit;
+	oxfw->unit = fw_unit_get(unit);
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 	spin_lock_init(&oxfw->lock);
 	init_waitqueue_head(&oxfw->hwdep_wait);
@@ -218,6 +226,7 @@ static void oxfw_remove(struct fw_unit *unit)
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
+	/* No need to wait for releasing card object in this context. */
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
