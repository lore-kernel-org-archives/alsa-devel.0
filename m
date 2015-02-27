From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/9] ALSA: core: Re-add snd_device_disconnect()
Date: Fri, 27 Feb 2015 23:55:41 +0100
Message-ID: <1425077744-4553-7-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9E52651AF
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 78C6DAC70
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Revive snd_device_disconnect() again so that it can be called from the
individual driver.  This time, HD-audio will need it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  3 ++-
 sound/core/device.c  | 43 +++++++++++++++++++++++++++++++++----------
 sound/core/init.c    |  5 +----
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index da5748289968..b12931f513f4 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -278,7 +278,8 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
-int snd_device_disconnect_all(struct snd_card *card);
+void snd_device_disconnect(struct snd_card *card, void *device_data);
+void snd_device_disconnect_all(struct snd_card *card);
 void snd_device_free(struct snd_card *card, void *device_data);
 void snd_device_free_all(struct snd_card *card);
 
diff --git a/sound/core/device.c b/sound/core/device.c
index 41bec3075ae5..446dc452654e 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -73,7 +73,7 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 }
 EXPORT_SYMBOL(snd_device_new);
 
-static int __snd_device_disconnect(struct snd_device *dev)
+static void __snd_device_disconnect(struct snd_device *dev)
 {
 	if (dev->state == SNDRV_DEV_REGISTERED) {
 		if (dev->ops->dev_disconnect &&
@@ -81,7 +81,6 @@ static int __snd_device_disconnect(struct snd_device *dev)
 			dev_err(dev->card->dev, "device disconnect failure\n");
 		dev->state = SNDRV_DEV_DISCONNECTED;
 	}
-	return 0;
 }
 
 static void __snd_device_free(struct snd_device *dev)
@@ -109,6 +108,34 @@ static struct snd_device *look_for_dev(struct snd_card *card, void *device_data)
 }
 
 /**
+ * snd_device_disconnect - disconnect the device
+ * @card: the card instance
+ * @device_data: the data pointer to disconnect
+ *
+ * Turns the device into the disconnection state, invoking
+ * dev_disconnect callback, if the device was already registered.
+ *
+ * Usually called from snd_card_disconnect().
+ *
+ * Return: Zero if successful, or a negative error code on failure or if the
+ * device not found.
+ */
+void snd_device_disconnect(struct snd_card *card, void *device_data)
+{
+	struct snd_device *dev;
+
+	if (snd_BUG_ON(!card || !device_data))
+		return;
+	dev = look_for_dev(card, device_data);
+	if (dev)
+		__snd_device_disconnect(dev);
+	else
+		dev_dbg(card->dev, "device disconnect %p (from %pF), not found\n",
+			device_data, __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(snd_device_disconnect);
+
+/**
  * snd_device_free - release the device from the card
  * @card: the card instance
  * @device_data: the data pointer to release
@@ -195,18 +222,14 @@ int snd_device_register_all(struct snd_card *card)
  * disconnect all the devices on the card.
  * called from init.c
  */
-int snd_device_disconnect_all(struct snd_card *card)
+void snd_device_disconnect_all(struct snd_card *card)
 {
 	struct snd_device *dev;
-	int err = 0;
 
 	if (snd_BUG_ON(!card))
-		return -ENXIO;
-	list_for_each_entry_reverse(dev, &card->devices, list) {
-		if (__snd_device_disconnect(dev) < 0)
-			err = -ENXIO;
-	}
-	return err;
+		return;
+	list_for_each_entry_reverse(dev, &card->devices, list)
+		__snd_device_disconnect(dev);
 }
 
 /*
diff --git a/sound/core/init.c b/sound/core/init.c
index 35419054821c..04734e047bfe 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -400,7 +400,6 @@ static const struct file_operations snd_shutdown_f_ops =
 int snd_card_disconnect(struct snd_card *card)
 {
 	struct snd_monitor_file *mfile;
-	int err;
 
 	if (!card)
 		return -EINVAL;
@@ -445,9 +444,7 @@ int snd_card_disconnect(struct snd_card *card)
 #endif
 
 	/* notify all devices that we are disconnected */
-	err = snd_device_disconnect_all(card);
-	if (err < 0)
-		dev_err(card->dev, "not all devices for card %i can be disconnected\n", card->number);
+	snd_device_disconnect_all(card);
 
 	snd_info_card_disconnect(card);
 	if (card->registered) {
-- 
2.3.0
