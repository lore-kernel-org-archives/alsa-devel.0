From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/10] ALSA: Clean up snd_device_*() codes
Date: Wed, 26 Feb 2014 07:47:27 +0100
Message-ID: <1393397252-11690-6-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FA4B265562
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EA80775024
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:47:37 +0000 (UTC)
In-Reply-To: <1393397252-11690-1-git-send-email-tiwai@suse.de>
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

A few code cleanups and optimizations.  In addition, drop
snd_device_disconnect() that isn't used at all, and drop the return
values from snd_device_free*().

Another slight difference by this change is that now the device state
will become always SNDRV_DEV_REGISTERED no matter whether dev_register
ops is present or not.  It's for better consistency.  There should be
no impact for the current tree, as the state isn't checked.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |   5 +-
 sound/core/device.c  | 128 ++++++++++++++++++++-------------------------------
 sound/core/init.c    |   5 +-
 3 files changed, 52 insertions(+), 86 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index f1e41f4b067f..aac9a8590265 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -309,10 +309,9 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
-int snd_device_disconnect(struct snd_card *card, void *device_data);
 int snd_device_disconnect_all(struct snd_card *card);
-int snd_device_free(struct snd_card *card, void *device_data);
-int snd_device_free_all(struct snd_card *card);
+void snd_device_free(struct snd_card *card, void *device_data);
+void snd_device_free_all(struct snd_card *card);
 
 /* isadma.c */
 
diff --git a/sound/core/device.c b/sound/core/device.c
index 53291ff21a09..41bec3075ae5 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -73,6 +73,30 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 }
 EXPORT_SYMBOL(snd_device_new);
 
+static int __snd_device_disconnect(struct snd_device *dev)
+{
+	if (dev->state == SNDRV_DEV_REGISTERED) {
+		if (dev->ops->dev_disconnect &&
+		    dev->ops->dev_disconnect(dev))
+			dev_err(dev->card->dev, "device disconnect failure\n");
+		dev->state = SNDRV_DEV_DISCONNECTED;
+	}
+	return 0;
+}
+
+static void __snd_device_free(struct snd_device *dev)
+{
+	/* unlink */
+	list_del(&dev->list);
+
+	__snd_device_disconnect(dev);
+	if (dev->ops->dev_free) {
+		if (dev->ops->dev_free(dev))
+			dev_err(dev->card->dev, "device free failure\n");
+	}
+	kfree(dev);
+}
+
 static struct snd_device *look_for_dev(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
@@ -92,71 +116,33 @@ static struct snd_device *look_for_dev(struct snd_card *card, void *device_data)
  * Removes the device from the list on the card and invokes the
  * callbacks, dev_disconnect and dev_free, corresponding to the state.
  * Then release the device.
- *
- * Return: Zero if successful, or a negative error code on failure or if the
- * device not found.
  */
-int snd_device_free(struct snd_card *card, void *device_data)
+void snd_device_free(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
 	
 	if (snd_BUG_ON(!card || !device_data))
-		return -ENXIO;
+		return;
 	dev = look_for_dev(card, device_data);
-	if (dev) {
-		/* unlink */
-		list_del(&dev->list);
-		if (dev->state == SNDRV_DEV_REGISTERED &&
-		    dev->ops->dev_disconnect)
-			if (dev->ops->dev_disconnect(dev))
-				dev_err(card->dev,
-					"device disconnect failure\n");
-		if (dev->ops->dev_free) {
-			if (dev->ops->dev_free(dev))
-				dev_err(card->dev, "device free failure\n");
-		}
-		kfree(dev);
-		return 0;
-	}
-	dev_dbg(card->dev, "device free %p (from %pF), not found\n",
-		device_data, __builtin_return_address(0));
-	return -ENXIO;
+	if (dev)
+		__snd_device_free(dev);
+	else
+		dev_dbg(card->dev, "device free %p (from %pF), not found\n",
+			device_data, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(snd_device_free);
 
-/**
- * snd_device_disconnect - disconnect the device
- * @card: the card instance
- * @device_data: the data pointer to disconnect
- *
- * Turns the device into the disconnection state, invoking
- * dev_disconnect callback, if the device was already registered.
- *
- * Usually called from snd_card_disconnect().
- *
- * Return: Zero if successful, or a negative error code on failure or if the
- * device not found.
- */
-int snd_device_disconnect(struct snd_card *card, void *device_data)
+static int __snd_device_register(struct snd_device *dev)
 {
-	struct snd_device *dev;
-
-	if (snd_BUG_ON(!card || !device_data))
-		return -ENXIO;
-	dev = look_for_dev(card, device_data);
-	if (dev) {
-		if (dev->state == SNDRV_DEV_REGISTERED &&
-		    dev->ops->dev_disconnect) {
-			if (dev->ops->dev_disconnect(dev))
-				dev_err(card->dev,
-					"device disconnect failure\n");
-			dev->state = SNDRV_DEV_DISCONNECTED;
+	if (dev->state == SNDRV_DEV_BUILD) {
+		if (dev->ops->dev_register) {
+			int err = dev->ops->dev_register(dev);
+			if (err < 0)
+				return err;
 		}
-		return 0;
+		dev->state = SNDRV_DEV_REGISTERED;
 	}
-	dev_dbg(card->dev, "device disconnect %p (from %pF), not found\n",
-		device_data, __builtin_return_address(0));
-	return -ENXIO;
+	return 0;
 }
 
 /**
@@ -175,21 +161,12 @@ int snd_device_disconnect(struct snd_card *card, void *device_data)
 int snd_device_register(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
-	int err;
 
 	if (snd_BUG_ON(!card || !device_data))
 		return -ENXIO;
 	dev = look_for_dev(card, device_data);
-	if (dev) {
-		if (dev->state == SNDRV_DEV_BUILD && dev->ops->dev_register) {
-			if ((err = dev->ops->dev_register(dev)) < 0)
-				return err;
-			dev->state = SNDRV_DEV_REGISTERED;
-			return 0;
-		}
-		dev_dbg(card->dev, "snd_device_register busy\n");
-		return -EBUSY;
-	}
+	if (dev)
+		return __snd_device_register(dev);
 	snd_BUG();
 	return -ENXIO;
 }
@@ -207,11 +184,9 @@ int snd_device_register_all(struct snd_card *card)
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry(dev, &card->devices, list) {
-		if (dev->state == SNDRV_DEV_BUILD && dev->ops->dev_register) {
-			if ((err = dev->ops->dev_register(dev)) < 0)
-				return err;
-			dev->state = SNDRV_DEV_REGISTERED;
-		}
+		err = __snd_device_register(dev);
+		if (err < 0)
+			return err;
 	}
 	return 0;
 }
@@ -228,7 +203,7 @@ int snd_device_disconnect_all(struct snd_card *card)
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry_reverse(dev, &card->devices, list) {
-		if (snd_device_disconnect(card, dev->device_data) < 0)
+		if (__snd_device_disconnect(dev) < 0)
 			err = -ENXIO;
 	}
 	return err;
@@ -238,17 +213,12 @@ int snd_device_disconnect_all(struct snd_card *card)
  * release all the devices on the card.
  * called from init.c
  */
-int snd_device_free_all(struct snd_card *card)
+void snd_device_free_all(struct snd_card *card)
 {
 	struct snd_device *dev, *next;
-	int ret = 0;
 
 	if (snd_BUG_ON(!card))
-		return -ENXIO;
-	list_for_each_entry_safe_reverse(dev, next, &card->devices, list) {
-		int err = snd_device_free(card, dev->device_data);
-		if (err < 0)
-			ret = err;
-	}
-	return ret;
+		return;
+	list_for_each_entry_safe_reverse(dev, next, &card->devices, list)
+		__snd_device_free(dev);
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 9e7f17b72fb6..5ee83845c5de 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -454,10 +454,7 @@ static int snd_card_do_free(struct snd_card *card)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
-	if (snd_device_free_all(card) < 0) {
-		dev_err(card->dev, "unable to free all devices\n");
-		/* Fatal, but this situation should never occur */
-	}
+	snd_device_free_all(card);
 	if (card->private_free)
 		card->private_free(card);
 	snd_info_free_entry(card->proc_id);
-- 
1.9.0
