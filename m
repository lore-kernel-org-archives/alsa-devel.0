From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/20] ALSA: Clean up snd_device_*() codes
Date: Wed, 12 Feb 2014 11:52:27 +0100
Message-ID: <1392202347-11774-21-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C4CE2651D2
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E9C5FAC95
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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
snd_device_disconnect() that isn't used at all.

Another slight difference by this change is that now the device state
will become always SNDRV_DEV_REGISTERED no matter whether dev_register
ops is present or not.  It's for better consistency.  There should be
no impact for the current tree, as the state isn't checked.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |   1 -
 sound/core/device.c  | 104 +++++++++++++++++++++------------------------------
 2 files changed, 42 insertions(+), 63 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 07a7ab9a49bf..fb05573215d3 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -310,7 +310,6 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
-int snd_device_disconnect(struct snd_card *card, void *device_data);
 int snd_device_disconnect_all(struct snd_card *card);
 int snd_device_free(struct snd_card *card, void *device_data);
 int snd_device_free_all(struct snd_card *card);
diff --git a/sound/core/device.c b/sound/core/device.c
index b6f9d6702c69..d622bcd4ff53 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -73,6 +73,31 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 }
 EXPORT_SYMBOL(snd_device_new);
 
+static int __snd_device_disconnect(struct snd_device *dev)
+{
+	if (dev->state == SNDRV_DEV_REGISTERED) {
+		if (dev->ops->dev_disconnect &&
+		    dev->ops->dev_disconnect(dev))
+			snd_printk(KERN_ERR "device disconnect failure\n");
+		dev->state = SNDRV_DEV_DISCONNECTED;
+	}
+	return 0;
+}
+
+static int __snd_device_free(struct snd_device *dev)
+{
+	/* unlink */
+	list_del(&dev->list);
+
+	__snd_device_disconnect(dev);
+	if (dev->ops->dev_free) {
+		if (dev->ops->dev_free(dev))
+			snd_printk(KERN_ERR "device free failure\n");
+	}
+	kfree(dev);
+	return 0;
+}
+
 static struct snd_device *look_for_dev(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
@@ -103,59 +128,25 @@ int snd_device_free(struct snd_card *card, void *device_data)
 	if (snd_BUG_ON(!card || !device_data))
 		return -ENXIO;
 	dev = look_for_dev(card, device_data);
-	if (dev) {
-		/* unlink */
-		list_del(&dev->list);
-		if (dev->state == SNDRV_DEV_REGISTERED &&
-		    dev->ops->dev_disconnect)
-			if (dev->ops->dev_disconnect(dev))
-				snd_printk(KERN_ERR
-					   "device disconnect failure\n");
-		if (dev->ops->dev_free) {
-			if (dev->ops->dev_free(dev))
-				snd_printk(KERN_ERR "device free failure\n");
-		}
-		kfree(dev);
-		return 0;
-	}
+	if (dev)
+		return __snd_device_free(dev);
 	snd_printd("device free %p (from %pF), not found\n", device_data,
 		   __builtin_return_address(0));
 	return -ENXIO;
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
-				snd_printk(KERN_ERR "device disconnect failure\n");
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
-	snd_printd("device disconnect %p (from %pF), not found\n", device_data,
-		   __builtin_return_address(0));
-	return -ENXIO;
+	return 0;
 }
 
 /**
@@ -174,21 +165,12 @@ int snd_device_disconnect(struct snd_card *card, void *device_data)
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
-		snd_printd("snd_device_register busy\n");
-		return -EBUSY;
-	}
+	if (dev)
+		return __snd_device_register(dev);
 	snd_BUG();
 	return -ENXIO;
 }
@@ -206,11 +188,9 @@ int snd_device_register_all(struct snd_card *card)
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
@@ -227,7 +207,7 @@ int snd_device_disconnect_all(struct snd_card *card)
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry_reverse(dev, &card->devices, list) {
-		if (snd_device_disconnect(card, dev->device_data) < 0)
+		if (__snd_device_disconnect(dev) < 0)
 			err = -ENXIO;
 	}
 	return err;
@@ -245,7 +225,7 @@ int snd_device_free_all(struct snd_card *card)
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry_safe_reverse(dev, next, &card->devices, list) {
-		int err = snd_device_free(card, dev->device_data);
+		int err = __snd_device_free(dev);
 		if (err < 0)
 			ret = err;
 	}
-- 
1.8.5.2
