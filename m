From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/13] ALSA: fireface: postpone sound card
	registration
Date: Sat, 11 Feb 2017 23:24:58 +0900
Message-ID: <20170211142509.4795-3-o-takashi@sakamocchi.jp>
References: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 29A25266A74
 for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2017 15:25:14 +0100 (CET)
In-Reply-To: <20170211142509.4795-1-o-takashi@sakamocchi.jp>
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

This commit schedules workqueue to process actual probe processing
2 seconds after the last bus-reset. The card instance is kept at unit
probe callback and released at card free callback. Therefore, when the
actual probe processing fails, the memory block is wasted. This is due to
simplify driver implementation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireface/ff.c | 84 ++++++++++++++++++++++++++++++++------------
 sound/firewire/fireface/ff.h |  5 +++
 2 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
index 358bba2..7c02639 100644
--- a/sound/firewire/fireface/ff.c
+++ b/sound/firewire/fireface/ff.c
@@ -28,58 +28,98 @@ static void name_card(struct snd_ff *ff)
 		 dev_name(&ff->unit->device), 100 << fw_dev->max_speed);
 }
 
-static void ff_card_free(struct snd_card *card)
+static void ff_free(struct snd_ff *ff)
 {
-	struct snd_ff *ff = card->private_data;
-
 	fw_unit_put(ff->unit);
 
 	mutex_destroy(&ff->mutex);
+	kfree(ff);
+}
+
+static void ff_card_free(struct snd_card *card)
+{
+	ff_free(card->private_data);
+}
+
+static void do_registration(struct work_struct *work)
+{
+	struct snd_ff *ff = container_of(work, struct snd_ff, dwork.work);
+	int err;
+
+	if (ff->registered)
+		return;
+
+	err = snd_card_new(&ff->unit->device, -1, NULL, THIS_MODULE, 0,
+			   &ff->card);
+	if (err < 0)
+		return;
+
+	name_card(ff);
+
+	err = snd_card_register(ff->card);
+	if (err < 0)
+		goto error;
+
+	ff->card->private_free = ff_card_free;
+	ff->card->private_data = ff;
+	ff->registered = true;
+
+	return;
+error:
+	snd_card_free(ff->card);
+	dev_info(&ff->unit->device,
+		 "Sound card registration failed: %d\n", err);
 }
 
 static int snd_ff_probe(struct fw_unit *unit,
 			   const struct ieee1394_device_id *entry)
 {
-	struct snd_card *card;
 	struct snd_ff *ff;
-	int err;
 
-	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
-			   sizeof(struct snd_ff), &card);
-	if (err < 0)
-		return err;
-	card->private_free = ff_card_free;
+	ff = kzalloc(sizeof(struct snd_ff), GFP_KERNEL);
+	if (ff == NULL)
+		return -ENOMEM;
 
 	/* initialize myself */
-	ff = card->private_data;
-	ff->card = card;
 	ff->unit = fw_unit_get(unit);
 	dev_set_drvdata(&unit->device, ff);
 
 	mutex_init(&ff->mutex);
 
-	name_card(ff);
-
-	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	/* Register this sound card later. */
+	INIT_DEFERRABLE_WORK(&ff->dwork, do_registration);
+	snd_fw_schedule_registration(unit, &ff->dwork);
 
 	return 0;
 }
 
 static void snd_ff_update(struct fw_unit *unit)
 {
-	return;
+	struct snd_ff *ff = dev_get_drvdata(&unit->device);
+
+	/* Postpone a workqueue for deferred registration. */
+	if (!ff->registered)
+		snd_fw_schedule_registration(unit, &ff->dwork);
 }
 
 static void snd_ff_remove(struct fw_unit *unit)
 {
 	struct snd_ff *ff = dev_get_drvdata(&unit->device);
 
-	/* No need to wait for releasing card object in this context. */
-	snd_card_free_when_closed(ff->card);
+	/*
+	 * Confirm to stop the work for registration before the sound card is
+	 * going to be released. The work is not scheduled again because bus
+	 * reset handler is not called anymore.
+	 */
+	cancel_work_sync(&ff->dwork.work);
+
+	if (ff->registered) {
+		/* No need to wait for releasing card object in this context. */
+		snd_card_free_when_closed(ff->card);
+	} else {
+		/* Don't forget this case. */
+		ff_free(ff);
+	}
 }
 
 static const struct ieee1394_device_id snd_ff_id_table[] = {
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
index 64d488e..a0faae1 100644
--- a/sound/firewire/fireface/ff.h
+++ b/sound/firewire/fireface/ff.h
@@ -20,9 +20,14 @@
 
 #include <sound/core.h>
 
+#include "../lib.h"
+
 struct snd_ff {
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
