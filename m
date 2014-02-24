From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ALSA: Use priority list for managing
	device list
Date: Mon, 24 Feb 2014 10:51:53 +0100
Message-ID: <1393235514-15668-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BEFB82652AA
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 10:51:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 88A04ACB3
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 09:51:54 +0000 (UTC)
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

Basically, the device type specifies the priority of the device to be
registered / freed, too.  However, the priority value isn't well
utilized but only it's checked as a group.  This results in
inconsistent register and free order (where each of them should be in
reversed direction).

This patch simplifies the device list management code by simply
inserting a list entry at creation time in an incremental order for
the priority value.  Since we can just follow the link for register,
disconnect and free calls, we don't have to specify the group; so the
whole enum definitions are also simplified as well.

The visible change to outside is that the priorities of some object
types are revisited.  For example, now the SNDRV_DEV_LOWLEVEL object
is registered before others (control, PCM, etc) and, in return,
released after others.  Similarly, SNDRV_DEV_CODEC is in a lower
priority than SNDRV_DEV_BUS for ensuring the dependency.

Also, the unused SNDRV_DEV_TOPLEVEL, SNDRV_DEV_LOWLEVEL_PRE and
SNDRV_DEV_LOWLEVEL_NORMAL are removed as a cleanup.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h | 28 ++++++++--------------
 sound/core/device.c  | 66 +++++++++++++++++++++++++++++-----------------------
 sound/core/init.c    | 14 +++--------
 3 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index a3e3e89b63b6..5927378dc692 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -46,24 +46,22 @@ struct completion;
 
 /* device allocation stuff */
 
-#define SNDRV_DEV_TYPE_RANGE_SIZE		0x1000
-
+/* type of the object used in snd_device_*()
+ * this also defines the calling order
+ */
 enum snd_device_type {
-	SNDRV_DEV_TOPLEVEL	= 0,
-	SNDRV_DEV_CONTROL	= 1,
-	SNDRV_DEV_LOWLEVEL_PRE	= 2,
-	SNDRV_DEV_LOWLEVEL_NORMAL = 0x1000,
+	SNDRV_DEV_LOWLEVEL,
+	SNDRV_DEV_CONTROL,
+	SNDRV_DEV_INFO,
+	SNDRV_DEV_BUS,
+	SNDRV_DEV_CODEC,
 	SNDRV_DEV_PCM,
+	SNDRV_DEV_COMPRESS,
 	SNDRV_DEV_RAWMIDI,
 	SNDRV_DEV_TIMER,
 	SNDRV_DEV_SEQUENCER,
 	SNDRV_DEV_HWDEP,
-	SNDRV_DEV_INFO,
-	SNDRV_DEV_BUS,
-	SNDRV_DEV_CODEC,
 	SNDRV_DEV_JACK,
-	SNDRV_DEV_COMPRESS,
-	SNDRV_DEV_LOWLEVEL	= 0x2000,
 };
 
 enum snd_device_state {
@@ -72,12 +70,6 @@ enum snd_device_state {
 	SNDRV_DEV_DISCONNECTED,
 };
 
-enum snd_device_cmd {
-	SNDRV_DEV_CMD_PRE,
-	SNDRV_DEV_CMD_NORMAL,
-	SNDRV_DEV_CMD_POST,
-};
-
 struct snd_device;
 
 struct snd_device_ops {
@@ -321,7 +313,7 @@ int snd_device_register_all(struct snd_card *card);
 int snd_device_disconnect(struct snd_card *card, void *device_data);
 int snd_device_disconnect_all(struct snd_card *card);
 int snd_device_free(struct snd_card *card, void *device_data);
-int snd_device_free_all(struct snd_card *card, enum snd_device_cmd cmd);
+int snd_device_free_all(struct snd_card *card);
 
 /* isadma.c */
 
diff --git a/sound/core/device.c b/sound/core/device.c
index 856bfdc79cee..53291ff21a09 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -45,6 +45,7 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		   void *device_data, struct snd_device_ops *ops)
 {
 	struct snd_device *dev;
+	struct list_head *p;
 
 	if (snd_BUG_ON(!card || !device_data || !ops))
 		return -ENXIO;
@@ -53,17 +54,36 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 		dev_err(card->dev, "Cannot allocate device, type=%d\n", type);
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&dev->list);
 	dev->card = card;
 	dev->type = type;
 	dev->state = SNDRV_DEV_BUILD;
 	dev->device_data = device_data;
 	dev->ops = ops;
-	list_add(&dev->list, &card->devices);	/* add to the head of list */
+
+	/* insert the entry in an incrementally sorted list */
+	list_for_each_prev(p, &card->devices) {
+		struct snd_device *pdev = list_entry(p, struct snd_device, list);
+		if ((unsigned int)pdev->type <= (unsigned int)type)
+			break;
+	}
+
+	list_add(&dev->list, p);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_device_new);
 
+static struct snd_device *look_for_dev(struct snd_card *card, void *device_data)
+{
+	struct snd_device *dev;
+
+	list_for_each_entry(dev, &card->devices, list)
+		if (dev->device_data == device_data)
+			return dev;
+
+	return NULL;
+}
+
 /**
  * snd_device_free - release the device from the card
  * @card: the card instance
@@ -82,9 +102,8 @@ int snd_device_free(struct snd_card *card, void *device_data)
 	
 	if (snd_BUG_ON(!card || !device_data))
 		return -ENXIO;
-	list_for_each_entry(dev, &card->devices, list) {
-		if (dev->device_data != device_data)
-			continue;
+	dev = look_for_dev(card, device_data);
+	if (dev) {
 		/* unlink */
 		list_del(&dev->list);
 		if (dev->state == SNDRV_DEV_REGISTERED &&
@@ -103,7 +122,6 @@ int snd_device_free(struct snd_card *card, void *device_data)
 		device_data, __builtin_return_address(0));
 	return -ENXIO;
 }
-
 EXPORT_SYMBOL(snd_device_free);
 
 /**
@@ -125,9 +143,8 @@ int snd_device_disconnect(struct snd_card *card, void *device_data)
 
 	if (snd_BUG_ON(!card || !device_data))
 		return -ENXIO;
-	list_for_each_entry(dev, &card->devices, list) {
-		if (dev->device_data != device_data)
-			continue;
+	dev = look_for_dev(card, device_data);
+	if (dev) {
 		if (dev->state == SNDRV_DEV_REGISTERED &&
 		    dev->ops->dev_disconnect) {
 			if (dev->ops->dev_disconnect(dev))
@@ -162,9 +179,8 @@ int snd_device_register(struct snd_card *card, void *device_data)
 
 	if (snd_BUG_ON(!card || !device_data))
 		return -ENXIO;
-	list_for_each_entry(dev, &card->devices, list) {
-		if (dev->device_data != device_data)
-			continue;
+	dev = look_for_dev(card, device_data);
+	if (dev) {
 		if (dev->state == SNDRV_DEV_BUILD && dev->ops->dev_register) {
 			if ((err = dev->ops->dev_register(dev)) < 0)
 				return err;
@@ -177,7 +193,6 @@ int snd_device_register(struct snd_card *card, void *device_data)
 	snd_BUG();
 	return -ENXIO;
 }
-
 EXPORT_SYMBOL(snd_device_register);
 
 /*
@@ -212,7 +227,7 @@ int snd_device_disconnect_all(struct snd_card *card)
 
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
-	list_for_each_entry(dev, &card->devices, list) {
+	list_for_each_entry_reverse(dev, &card->devices, list) {
 		if (snd_device_disconnect(card, dev->device_data) < 0)
 			err = -ENXIO;
 	}
@@ -223,24 +238,17 @@ int snd_device_disconnect_all(struct snd_card *card)
  * release all the devices on the card.
  * called from init.c
  */
-int snd_device_free_all(struct snd_card *card, enum snd_device_cmd cmd)
+int snd_device_free_all(struct snd_card *card)
 {
-	struct snd_device *dev;
-	int err;
-	unsigned int range_low, range_high, type;
+	struct snd_device *dev, *next;
+	int ret = 0;
 
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
-	range_low = (unsigned int)cmd * SNDRV_DEV_TYPE_RANGE_SIZE;
-	range_high = range_low + SNDRV_DEV_TYPE_RANGE_SIZE - 1;
-      __again:
-	list_for_each_entry(dev, &card->devices, list) {
-		type = (unsigned int)dev->type;
-		if (type >= range_low && type <= range_high) {
-			if ((err = snd_device_free(card, dev->device_data)) < 0)
-				return err;
-			goto __again;
-		}
+	list_for_each_entry_safe_reverse(dev, next, &card->devices, list) {
+		int err = snd_device_free(card, dev->device_data);
+		if (err < 0)
+			ret = err;
 	}
-	return 0;
+	return ret;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index b7085eb19079..9e7f17b72fb6 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -266,7 +266,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	return 0;
 
       __error_ctl:
-	snd_device_free_all(card, SNDRV_DEV_CMD_PRE);
+	snd_device_free_all(card);
       __error:
 	put_device(&card->card_dev);
   	return err;
@@ -454,16 +454,8 @@ static int snd_card_do_free(struct snd_card *card)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
-	if (snd_device_free_all(card, SNDRV_DEV_CMD_PRE) < 0) {
-		dev_err(card->dev, "unable to free all devices (pre)\n");
-		/* Fatal, but this situation should never occur */
-	}
-	if (snd_device_free_all(card, SNDRV_DEV_CMD_NORMAL) < 0) {
-		dev_err(card->dev, "unable to free all devices (normal)\n");
-		/* Fatal, but this situation should never occur */
-	}
-	if (snd_device_free_all(card, SNDRV_DEV_CMD_POST) < 0) {
-		dev_err(card->dev, "unable to free all devices (post)\n");
+	if (snd_device_free_all(card) < 0) {
+		dev_err(card->dev, "unable to free all devices\n");
 		/* Fatal, but this situation should never occur */
 	}
 	if (card->private_free)
-- 
1.8.5.2
