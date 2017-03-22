From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/18] ALSA: firewire-motu: postpone sound card
	registration
Date: Wed, 22 Mar 2017 21:30:12 +0900
Message-ID: <20170322123028.24148-3-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4450F2670FC
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:39 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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

Just after appearing on IEEE 1394 bus, this unit generates several bus
resets. This is due to loading firmware from on-board flash memory and
initialize hardware. It's better to postpone sound card registration.

This commit applies this idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 97 ++++++++++++++++++++++++++++++++++------------
 sound/firewire/motu/motu.h |  5 +++
 2 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 2684e74..bdd82dd 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -38,59 +38,108 @@ static void name_card(struct snd_motu *motu)
 		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
 }
 
-static void motu_card_free(struct snd_card *card)
+static void motu_free(struct snd_motu *motu)
 {
-	struct snd_motu *motu = card->private_data;
-
 	fw_unit_put(motu->unit);
 
 	mutex_destroy(&motu->mutex);
+	kfree(motu);
 }
 
-static int motu_probe(struct fw_unit *unit,
-		      const struct ieee1394_device_id *entry)
+/*
+ * This module releases the FireWire unit data after all ALSA character devices
+ * are released by applications. This is for releasing stream data or finishing
+ * transactions safely. Thus at returning from .remove(), this module still keep
+ * references for the unit.
+ */
+static void motu_card_free(struct snd_card *card)
 {
-	struct snd_card *card;
-	struct snd_motu *motu;
-	int err;
+	motu_free(card->private_data);
+}
 
-	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(*motu), &card);
-	if (err < 0)
-		return err;
+static void do_registration(struct work_struct *work)
+{
+	struct snd_motu *motu = container_of(work, struct snd_motu, dwork.work);
+	int err;
 
-	motu = card->private_data;
-	motu->card = card;
-	motu->unit = fw_unit_get(unit);
-	card->private_free = motu_card_free;
+	if (motu->registered)
+		return;
 
-	mutex_init(&motu->mutex);
+	err = snd_card_new(&motu->unit->device, -1, NULL, THIS_MODULE, 0,
+			   &motu->card);
+	if (err < 0)
+		return;
 
 	name_card(motu);
 
-	err = snd_card_register(card);
+	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
 
+	/*
+	 * After registered, motu instance can be released corresponding to
+	 * releasing the sound card instance.
+	 */
+	motu->card->private_free = motu_card_free;
+	motu->card->private_data = motu;
+	motu->registered = true;
+
+	return;
+error:
+	snd_card_free(motu->card);
+	dev_info(&motu->unit->device,
+		 "Sound card registration failed: %d\n", err);
+}
+
+static int motu_probe(struct fw_unit *unit,
+		      const struct ieee1394_device_id *entry)
+{
+	struct snd_motu *motu;
+
+	/* Allocate this independently of sound card instance. */
+	motu = kzalloc(sizeof(struct snd_motu), GFP_KERNEL);
+	if (motu == NULL)
+		return -ENOMEM;
+
+	motu->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, motu);
 
+	mutex_init(&motu->mutex);
+
+	/* Allocate and register this sound card later. */
+	INIT_DEFERRABLE_WORK(&motu->dwork, do_registration);
+	snd_fw_schedule_registration(unit, &motu->dwork);
+
 	return 0;
-error:
-	snd_card_free(card);
-	return err;
 }
 
 static void motu_remove(struct fw_unit *unit)
 {
 	struct snd_motu *motu = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(motu->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_delayed_work_sync(&motu->dwork);
+
+	if (motu->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(motu->card);
+	} else {
+		/* Don't forget this case. */
+		motu_free(motu);
+	}
 }
 
 static void motu_bus_update(struct fw_unit *unit)
 {
-	return;
+	struct snd_motu *motu = dev_get_drvdata(&unit->device);
+
+	/* Postpone a workqueue for deferred registration. */
+	if (!motu->registered)
+		snd_fw_schedule_registration(unit, &motu->dwork);
 }
 
 #define SND_MOTU_DEV_ENTRY(model)			\
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index f3d0b28..eb0ffd5 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -20,10 +20,15 @@
 #include <sound/control.h>
 #include <sound/core.h>
 
+#include "../lib.h"
+
 struct snd_motu {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	struct mutex mutex;
+
+	bool registered;
+	struct delayed_work dwork;
 };
 
 #endif
-- 
2.9.3
