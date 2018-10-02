From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: firewire: use managed-resource of fw
	unit device for private data
Date: Wed,  3 Oct 2018 08:21:50 +0900
Message-ID: <20181002232154.29225-2-o-takashi@sakamocchi.jp>
References: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E28C267730
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 01:22:08 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so629875pgv.13
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2018 16:22:08 -0700 (PDT)
In-Reply-To: <20181002232154.29225-1-o-takashi@sakamocchi.jp>
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

At present, private data of each driver in ALSA firewire stack is
allocated/freed by kernel slab allocator for corresponding unit on
IEEE 1394 bus. In this case, resource-managed slab allocator is
available to release memory object automatically just before releasing
device structure for the unit. This idea can prevent runtime from
memory leak due to programming mistakes.

This commit uses the allocator for the private data. These drivers
already use reference counter to maintain lifetime of device structure
for the unit by a pair of fw_unit_get()/fw_unit_put(). The private data
is safely released in a callback of 'struct snd_card.private_free().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c         | 13 ++++++-------
 sound/firewire/dice/dice.c           |  8 +++-----
 sound/firewire/digi00x/digi00x.c     |  9 ++++-----
 sound/firewire/fireface/ff.c         | 10 +++-------
 sound/firewire/fireworks/fireworks.c |  6 ++----
 sound/firewire/motu/motu.c           | 10 ++++------
 sound/firewire/oxfw/oxfw.c           | 11 ++++-------
 sound/firewire/tascam/tascam.c       | 10 +++-------
 8 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 93676354f87f..fb05f2c1b60b 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -129,12 +129,11 @@ name_device(struct snd_bebob *bebob)
 static void bebob_free(struct snd_bebob *bebob)
 {
 	snd_bebob_stream_destroy_duplex(bebob);
-	fw_unit_put(bebob->unit);
 
 	kfree(bebob->maudio_special_quirk);
 
 	mutex_destroy(&bebob->mutex);
-	kfree(bebob);
+	fw_unit_put(bebob->unit);
 }
 
 /*
@@ -295,15 +294,15 @@ bebob_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
 	}
 
 	/* Allocate this independent of sound card instance. */
-	bebob = kzalloc(sizeof(struct snd_bebob), GFP_KERNEL);
-	if (bebob == NULL)
+	bebob = devm_kzalloc(&unit->device, sizeof(struct snd_bebob),
+			     GFP_KERNEL);
+	if (!bebob)
 		return -ENOMEM;
-
 	bebob->unit = fw_unit_get(unit);
-	bebob->entry = entry;
-	bebob->spec = spec;
 	dev_set_drvdata(&unit->device, bebob);
 
+	bebob->entry = entry;
+	bebob->spec = spec;
 	mutex_init(&bebob->mutex);
 	spin_lock_init(&bebob->lock);
 	init_waitqueue_head(&bebob->hwdep_wait);
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 774eb2205668..9bf77adb3127 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -126,10 +126,9 @@ static void dice_free(struct snd_dice *dice)
 {
 	snd_dice_stream_destroy_duplex(dice);
 	snd_dice_transaction_destroy(dice);
-	fw_unit_put(dice->unit);
 
 	mutex_destroy(&dice->mutex);
-	kfree(dice);
+	fw_unit_put(dice->unit);
 }
 
 /*
@@ -223,10 +222,9 @@ static int dice_probe(struct fw_unit *unit,
 	}
 
 	/* Allocate this independent of sound card instance. */
-	dice = kzalloc(sizeof(struct snd_dice), GFP_KERNEL);
-	if (dice == NULL)
+	dice = devm_kzalloc(&unit->device, sizeof(struct snd_dice), GFP_KERNEL);
+	if (!dice)
 		return -ENOMEM;
-
 	dice->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, dice);
 
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
index ef689997d6a5..654420f1c9bd 100644
--- a/sound/firewire/digi00x/digi00x.c
+++ b/sound/firewire/digi00x/digi00x.c
@@ -46,10 +46,8 @@ static void dg00x_free(struct snd_dg00x *dg00x)
 	snd_dg00x_stream_destroy_duplex(dg00x);
 	snd_dg00x_transaction_unregister(dg00x);
 
-	fw_unit_put(dg00x->unit);
-
 	mutex_destroy(&dg00x->mutex);
-	kfree(dg00x);
+	fw_unit_put(dg00x->unit);
 }
 
 static void dg00x_card_free(struct snd_card *card)
@@ -120,8 +118,9 @@ static int snd_dg00x_probe(struct fw_unit *unit,
 	struct snd_dg00x *dg00x;
 
 	/* Allocate this independent of sound card instance. */
-	dg00x = kzalloc(sizeof(struct snd_dg00x), GFP_KERNEL);
-	if (dg00x == NULL)
+	dg00x = devm_kzalloc(&unit->device, sizeof(struct snd_dg00x),
+			     GFP_KERNEL);
+	if (!dg00x)
 		return -ENOMEM;
 
 	dg00x->unit = fw_unit_get(unit);
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 4974bc7980e9..98731bd8816f 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -32,10 +32,8 @@ static void ff_free(struct snd_ff *ff)
 	snd_ff_stream_destroy_duplex(ff);
 	snd_ff_transaction_unregister(ff);
 
-	fw_unit_put(ff->unit);
-
 	mutex_destroy(&ff->mutex);
-	kfree(ff);
+	fw_unit_put(ff->unit);
 }
 
 static void ff_card_free(struct snd_card *card)
@@ -102,11 +100,9 @@ static int snd_ff_probe(struct fw_unit *unit,
 {
 	struct snd_ff *ff;
 
-	ff = kzalloc(sizeof(struct snd_ff), GFP_KERNEL);
-	if (ff == NULL)
+	ff = devm_kzalloc(&unit->device, sizeof(struct snd_ff), GFP_KERNEL);
+	if (!ff)
 		return -ENOMEM;
-
-	/* initialize myself */
 	ff->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, ff);
 
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index f2d073365cf6..2ff7b9cff9b0 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -188,12 +188,11 @@ static void efw_free(struct snd_efw *efw)
 {
 	snd_efw_stream_destroy_duplex(efw);
 	snd_efw_transaction_remove_instance(efw);
-	fw_unit_put(efw->unit);
 
 	kfree(efw->resp_buf);
 
 	mutex_destroy(&efw->mutex);
-	kfree(efw);
+	fw_unit_put(efw->unit);
 }
 
 /*
@@ -312,10 +311,9 @@ efw_probe(struct fw_unit *unit, const struct ieee1394_device_id *entry)
 {
 	struct snd_efw *efw;
 
-	efw = kzalloc(sizeof(struct snd_efw), GFP_KERNEL);
+	efw = devm_kzalloc(&unit->device, sizeof(struct snd_efw), GFP_KERNEL);
 	if (efw == NULL)
 		return -ENOMEM;
-
 	efw->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, efw);
 
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 300d31b6f191..fd5726424c7a 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -57,10 +57,9 @@ static void motu_free(struct snd_motu *motu)
 	snd_motu_transaction_unregister(motu);
 
 	snd_motu_stream_destroy_duplex(motu);
-	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
-	kfree(motu);
+	fw_unit_put(motu->unit);
 }
 
 /*
@@ -143,14 +142,13 @@ static int motu_probe(struct fw_unit *unit,
 	struct snd_motu *motu;
 
 	/* Allocate this independently of sound card instance. */
-	motu = kzalloc(sizeof(struct snd_motu), GFP_KERNEL);
-	if (motu == NULL)
+	motu = devm_kzalloc(&unit->device, sizeof(struct snd_motu), GFP_KERNEL);
+	if (!motu)
 		return -ENOMEM;
-
-	motu->spec = (const struct snd_motu_spec *)entry->driver_data;
 	motu->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, motu);
 
+	motu->spec = (const struct snd_motu_spec *)entry->driver_data;
 	mutex_init(&motu->mutex);
 	spin_lock_init(&motu->lock);
 	init_waitqueue_head(&motu->hwdep_wait);
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 2ea8be6c8584..b892a8642204 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -121,8 +121,6 @@ static void oxfw_free(struct snd_oxfw *oxfw)
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
 
-	fw_unit_put(oxfw->unit);
-
 	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; i++) {
 		kfree(oxfw->tx_stream_formats[i]);
 		kfree(oxfw->rx_stream_formats[i]);
@@ -130,7 +128,7 @@ static void oxfw_free(struct snd_oxfw *oxfw)
 
 	kfree(oxfw->spec);
 	mutex_destroy(&oxfw->mutex);
-	kfree(oxfw);
+	fw_unit_put(oxfw->unit);
 }
 
 /*
@@ -293,14 +291,13 @@ static int oxfw_probe(struct fw_unit *unit,
 		return -ENODEV;
 
 	/* Allocate this independent of sound card instance. */
-	oxfw = kzalloc(sizeof(struct snd_oxfw), GFP_KERNEL);
-	if (oxfw == NULL)
+	oxfw = devm_kzalloc(&unit->device, sizeof(struct snd_oxfw), GFP_KERNEL);
+	if (!oxfw)
 		return -ENOMEM;
-
-	oxfw->entry = entry;
 	oxfw->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, oxfw);
 
+	oxfw->entry = entry;
 	mutex_init(&oxfw->mutex);
 	spin_lock_init(&oxfw->lock);
 	init_waitqueue_head(&oxfw->hwdep_wait);
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index d3fdc463a884..53f20153ba71 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -90,10 +90,8 @@ static void tscm_free(struct snd_tscm *tscm)
 	snd_tscm_transaction_unregister(tscm);
 	snd_tscm_stream_destroy_duplex(tscm);
 
-	fw_unit_put(tscm->unit);
-
 	mutex_destroy(&tscm->mutex);
-	kfree(tscm);
+	fw_unit_put(tscm->unit);
 }
 
 static void tscm_card_free(struct snd_card *card)
@@ -164,11 +162,9 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	struct snd_tscm *tscm;
 
 	/* Allocate this independent of sound card instance. */
-	tscm = kzalloc(sizeof(struct snd_tscm), GFP_KERNEL);
-	if (tscm == NULL)
+	tscm = devm_kzalloc(&unit->device, sizeof(struct snd_tscm), GFP_KERNEL);
+	if (!tscm)
 		return -ENOMEM;
-
-	/* initialize myself */
 	tscm->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, tscm);
 
-- 
2.17.1
