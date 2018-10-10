From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: firewire: release reference count of
	firewire unit in .remove callback of bus driver
Date: Wed, 10 Oct 2018 15:35:00 +0900
Message-ID: <20181010063502.4698-3-o-takashi@sakamocchi.jp>
References: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D4C2678AB
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 08:35:14 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so2008290pli.11
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2018 23:35:14 -0700 (PDT)
In-Reply-To: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, drivers in ALSA firewire stack blocks .remove
callback of bus driver. This enables to release members of private
data in the callback after releasing device of sound card.

This commit simplifies codes to release the members.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 9 +++------
 sound/firewire/dice/dice.c           | 9 +++------
 sound/firewire/digi00x/digi00x.c     | 9 +++------
 sound/firewire/fireface/ff.c         | 9 +++------
 sound/firewire/fireworks/fireworks.c | 9 +++------
 sound/firewire/isight.c              | 5 +++--
 sound/firewire/motu/motu.c           | 9 +++------
 sound/firewire/oxfw/oxfw.c           | 9 +++------
 sound/firewire/tascam/tascam.c       | 9 +++------
 9 files changed, 27 insertions(+), 50 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 3a5579cb3aa8..34ed8afbb30c 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -129,9 +129,6 @@ name_device(struct snd_bebob *bebob)
 static void bebob_free(struct snd_bebob *bebob)
 {
 	snd_bebob_stream_destroy_duplex(bebob);
-
-	mutex_destroy(&bebob->mutex);
-	fw_unit_put(bebob->unit);
 }
 
 /*
@@ -376,10 +373,10 @@ static void bebob_remove(struct fw_unit *unit)
 	if (bebob->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(bebob->card);
-	} else {
-		/* Don't forget this case. */
-		bebob_free(bebob);
 	}
+
+	mutex_destroy(&bebob->mutex);
+	fw_unit_put(bebob->unit);
 }
 
 static const struct snd_bebob_rate_spec normal_rate_spec = {
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 9bf77adb3127..c6b63e3f36a8 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -126,9 +126,6 @@ static void dice_free(struct snd_dice *dice)
 {
 	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
-
-	mutex_destroy(&dice->mutex);
-	fw_unit_put(dice->unit);
 }
 
 /*
@@ -261,10 +258,10 @@ static void dice_remove(struct fw_unit *unit)
 	if (dice->registered) {
 		/* No need to wait for releasing card object in this context. */
 		snd_card_free_when_closed(dice->card);
-	} else {
-		/* Don't forget this case. */
-		dice_free(dice);
 	}
+
+	mutex_destroy(&dice->mutex);
+	fw_unit_put(dice->unit);
 }
 
 static void dice_bus_reset(struct fw_unit *unit)
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index 554d7ff737a2..7a24348968b9 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -45,9 +45,6 @@ static void dg00x_free(struct snd_dg00x *dg00x)
 {
 	snd_dg00x_stream_destroy_duplex(dg00x);
 	snd_dg00x_transaction_unregister(dg00x);
-
-	mutex_destroy(&dg00x->mutex);
-	fw_unit_put(dg00x->unit);
 }
 
 static void dg00x_card_free(struct snd_card *card)
@@ -174,10 +171,10 @@ static void snd_dg00x_remove(struct fw_unit *unit)
 	if (dg00x->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(dg00x->card);
-	} else {
-		/* Don't forget this case. */
-		dg00x_free(dg00x);
 	}
+
+	mutex_destroy(&dg00x->mutex);
+	fw_unit_put(dg00x->unit);
 }
 
 static const struct ieee1394_device_id snd_dg00x_id_table[] = {
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 73425dfe63bf..37866beeb160 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -31,9 +31,6 @@ static void ff_free(struct snd_ff *ff)
 {
 	snd_ff_stream_destroy_duplex(ff);
 	snd_ff_transaction_unregister(ff);
-
-	mutex_destroy(&ff->mutex);
-	fw_unit_put(ff->unit);
 }
 
 static void ff_card_free(struct snd_card *card)
@@ -147,10 +144,10 @@ static void snd_ff_remove(struct fw_unit *unit)
 	if (ff->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(ff->card);
-	} else {
-		/* Don't forget this case. */
-		ff_free(ff);
 	}
+
+	mutex_destroy(&ff->mutex);
+	fw_unit_put(ff->unit);
 }
 
 static const struct snd_ff_spec spec_ff400 = {
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 5a17ead86e61..5854d2a87a18 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -188,9 +188,6 @@ static void efw_free(struct snd_efw *efw)
 {
 	snd_efw_stream_destroy_duplex(efw);
 	snd_efw_transaction_remove_instance(efw);
-
-	mutex_destroy(&efw->mutex);
-	fw_unit_put(efw->unit);
 }
 
 /*
@@ -360,10 +357,10 @@ static void efw_remove(struct fw_unit *unit)
 	if (efw->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(efw->card);
-	} else {
-		/* Don't forget this case. */
-		efw_free(efw);
 	}
+
+	mutex_destroy(&efw->mutex);
+	fw_unit_put(efw->unit);
 }
 
 static const struct ieee1394_device_id efw_id_table[] = {
diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
index 1f591c8805ea..de4decfb74d5 100644
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -602,8 +602,6 @@ static void isight_card_free(struct snd_card *card)
 	struct isight *isight = card->private_data;
 
 	fw_iso_resources_destroy(&isight->resources);
-	fw_unit_put(isight->unit);
-	mutex_destroy(&isight->mutex);
 }
 
 static u64 get_unit_base(struct fw_unit *unit)
@@ -705,6 +703,9 @@ static void isight_remove(struct fw_unit *unit)
 
 	// Block till all of ALSA character devices are released.
 	snd_card_free(isight->card);
+
+	mutex_destroy(&isight->mutex);
+	fw_unit_put(isight->unit);
 }
 
 static const struct ieee1394_device_id isight_id_table[] = {
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 12680c85b37f..281028ee3273 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -57,9 +57,6 @@ static void motu_free(struct snd_motu *motu)
 	snd_motu_transaction_unregister(motu);
 
 	snd_motu_stream_destroy_duplex(motu);
-
-	mutex_destroy(&motu->mutex);
-	fw_unit_put(motu->unit);
 }
 
 /*
@@ -174,10 +171,10 @@ static void motu_remove(struct fw_unit *unit)
 	if (motu->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(motu->card);
-	} else {
-		/* Don't forget this case. */
-		motu_free(motu);
 	}
+
+	mutex_destroy(&motu->mutex);
+	fw_unit_put(motu->unit);
 }
 
 static void motu_bus_update(struct fw_unit *unit)
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 36f905b371e6..14fe02a9ed5d 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -118,9 +118,6 @@ static void oxfw_free(struct snd_oxfw *oxfw)
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
-
-	mutex_destroy(&oxfw->mutex);
-	fw_unit_put(oxfw->unit);
 }
 
 /*
@@ -329,10 +326,10 @@ static void oxfw_remove(struct fw_unit *unit)
 	if (oxfw->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(oxfw->card);
-	} else {
-		/* Don't forget this case. */
-		oxfw_free(oxfw);
 	}
+
+	mutex_destroy(&oxfw->mutex);
+	fw_unit_put(oxfw->unit);
 }
 
 static const struct compat_info griffin_firewave = {
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index 6f7aaa8c84aa..f4f959128341 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -89,9 +89,6 @@ static void tscm_free(struct snd_tscm *tscm)
 {
 	snd_tscm_transaction_unregister(tscm);
 	snd_tscm_stream_destroy_duplex(tscm);
-
-	mutex_destroy(&tscm->mutex);
-	fw_unit_put(tscm->unit);
 }
 
 static void tscm_card_free(struct snd_card *card)
@@ -214,10 +211,10 @@ static void snd_tscm_remove(struct fw_unit *unit)
 	if (tscm->registered) {
 		// Block till all of ALSA character devices are released.
 		snd_card_free(tscm->card);
-	} else {
-		/* Don't forget this case. */
-		tscm_free(tscm);
 	}
+
+	mutex_destroy(&tscm->mutex);
+	fw_unit_put(tscm->unit);
 }
 
 static const struct ieee1394_device_id snd_tscm_id_table[] = {
-- 
2.19.0
