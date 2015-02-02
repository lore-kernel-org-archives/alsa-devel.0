From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/14] ALSA: hwdep: Embed struct device
Date: Mon,  2 Feb 2015 11:24:29 +0100
Message-ID: <1422872678-4815-6-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13CDD2604E1
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B1187ACE8
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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

Like the previous patch, this one embeds the device object into hwdep
object.  For a proper object lifecycle, it's freed in the release
callback.

This also allows us to create sysfs entries via passing to the groups
field of the device without explicit function calls.  Since each
driver can see the device and touch its groups field directly, we
don't need to delegate in hwdep core any longer.  So, remove the
groups field from snd_hwdep, and let the user (in this case only
hda_hwdep.c) modify the device groups.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hwdep.h     |  3 +-
 sound/core/hwdep.c        | 82 ++++++++++++++++++-----------------------------
 sound/pci/hda/hda_hwdep.c |  7 ++--
 3 files changed, 38 insertions(+), 54 deletions(-)

diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index ae04a3ec9c77..ab9fcb2f97f0 100644
--- a/include/sound/hwdep.h
+++ b/include/sound/hwdep.h
@@ -68,8 +68,7 @@ struct snd_hwdep {
 	wait_queue_head_t open_wait;
 	void *private_data;
 	void (*private_free) (struct snd_hwdep *hwdep);
-	struct device *dev;
-	const struct attribute_group **groups;
+	struct device dev;
 
 	struct mutex open_mutex;
 	int used;			/* reference counter */
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 85096a150eda..506387ba645d 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -38,7 +38,6 @@ MODULE_LICENSE("GPL");
 static LIST_HEAD(snd_hwdep_devices);
 static DEFINE_MUTEX(register_mutex);
 
-static int snd_hwdep_free(struct snd_hwdep *hwdep);
 static int snd_hwdep_dev_free(struct snd_device *device);
 static int snd_hwdep_dev_register(struct snd_device *device);
 static int snd_hwdep_dev_disconnect(struct snd_device *device);
@@ -345,6 +344,11 @@ static const struct file_operations snd_hwdep_f_ops =
 	.mmap =		snd_hwdep_mmap,
 };
 
+static void release_hwdep_device(struct device *dev)
+{
+	kfree(container_of(dev, struct snd_hwdep, dev));
+}
+
 /**
  * snd_hwdep_new - create a new hwdep instance
  * @card: the card instance
@@ -378,48 +382,49 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 		dev_err(card->dev, "hwdep: cannot allocate\n");
 		return -ENOMEM;
 	}
+
+	init_waitqueue_head(&hwdep->open_wait);
+	mutex_init(&hwdep->open_mutex);
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id)
 		strlcpy(hwdep->id, id, sizeof(hwdep->id));
+
+	snd_device_initialize(&hwdep->dev, card);
+	hwdep->dev.release = release_hwdep_device;
+	dev_set_name(&hwdep->dev, "hwC%iD%i", card->number, device);
 #ifdef CONFIG_SND_OSSEMUL
 	hwdep->oss_type = -1;
 #endif
-	if ((err = snd_device_new(card, SNDRV_DEV_HWDEP, hwdep, &ops)) < 0) {
-		snd_hwdep_free(hwdep);
+
+	err = snd_device_new(card, SNDRV_DEV_HWDEP, hwdep, &ops);
+	if (err < 0) {
+		put_device(&hwdep->dev);
 		return err;
 	}
-	init_waitqueue_head(&hwdep->open_wait);
-	mutex_init(&hwdep->open_mutex);
+
 	if (rhwdep)
 		*rhwdep = hwdep;
 	return 0;
 }
 EXPORT_SYMBOL(snd_hwdep_new);
 
-static int snd_hwdep_free(struct snd_hwdep *hwdep)
+static int snd_hwdep_dev_free(struct snd_device *device)
 {
+	struct snd_hwdep *hwdep = device->device_data;
 	if (!hwdep)
 		return 0;
 	if (hwdep->private_free)
 		hwdep->private_free(hwdep);
-	kfree(hwdep);
+	put_device(&hwdep->dev);
 	return 0;
 }
 
-static int snd_hwdep_dev_free(struct snd_device *device)
-{
-	struct snd_hwdep *hwdep = device->device_data;
-	return snd_hwdep_free(hwdep);
-}
-
 static int snd_hwdep_dev_register(struct snd_device *device)
 {
 	struct snd_hwdep *hwdep = device->device_data;
 	struct snd_card *card = hwdep->card;
-	struct device *dev;
 	int err;
-	char name[32];
 
 	mutex_lock(&register_mutex);
 	if (snd_hwdep_search(card, hwdep->device)) {
@@ -427,54 +432,31 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		return -EBUSY;
 	}
 	list_add_tail(&hwdep->list, &snd_hwdep_devices);
-	sprintf(name, "hwC%iD%i", hwdep->card->number, hwdep->device);
-	dev = hwdep->dev;
-	if (!dev)
-		dev = snd_card_get_device_link(hwdep->card);
 	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_HWDEP,
 					  hwdep->card, hwdep->device,
 					  &snd_hwdep_f_ops, hwdep,
-					  NULL, dev, name);
+					  &hwdep->dev, NULL, NULL);
 	if (err < 0) {
-		dev_err(dev,
-			"unable to register hardware dependent device %i:%i\n",
-			card->number, hwdep->device);
+		dev_err(&hwdep->dev, "unable to register\n");
 		list_del(&hwdep->list);
 		mutex_unlock(&register_mutex);
 		return err;
 	}
 
-	if (hwdep->groups) {
-		struct device *d = snd_get_device(SNDRV_DEVICE_TYPE_HWDEP,
-						  hwdep->card, hwdep->device);
-		if (d) {
-			if (hwdep->private_data)
-				dev_set_drvdata(d, hwdep->private_data);
-			err = sysfs_create_groups(&d->kobj, hwdep->groups);
-			if (err < 0)
-				dev_warn(dev,
-					 "hwdep %d:%d: cannot create sysfs groups\n",
-					 card->number, hwdep->device);
-			put_device(d);
-		}
-	}
-
 #ifdef CONFIG_SND_OSSEMUL
 	hwdep->ossreg = 0;
 	if (hwdep->oss_type >= 0) {
-		if ((hwdep->oss_type == SNDRV_OSS_DEVICE_TYPE_DMFM) && (hwdep->device != 0)) {
-			dev_warn(dev,
+		if (hwdep->oss_type == SNDRV_OSS_DEVICE_TYPE_DMFM &&
+		    hwdep->device)
+			dev_warn(&hwdep->dev,
 				 "only hwdep device 0 can be registered as OSS direct FM device!\n");
-		} else {
-			if (snd_register_oss_device(hwdep->oss_type,
-						    card, hwdep->device,
-						    &snd_hwdep_f_ops, hwdep) < 0) {
-				dev_err(dev,
-					"unable to register OSS compatibility device %i:%i\n",
-					card->number, hwdep->device);
-			} else
-				hwdep->ossreg = 1;
-		}
+		else if (snd_register_oss_device(hwdep->oss_type,
+						 card, hwdep->device,
+						 &snd_hwdep_f_ops, hwdep) < 0)
+			dev_warn(&hwdep->dev,
+				 "unable to register OSS compatibility device\n");
+		else
+			hwdep->ossreg = 1;
 	}
 #endif
 	mutex_unlock(&register_mutex);
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 014a7849e8fd..11b5a42b4ec8 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -109,7 +109,6 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	hwdep->iface = SNDRV_HWDEP_IFACE_HDA;
 	hwdep->private_data = codec;
 	hwdep->exclusive = 1;
-	hwdep->groups = snd_hda_dev_attr_groups;
 
 	hwdep->ops.open = hda_hwdep_open;
 	hwdep->ops.ioctl = hda_hwdep_ioctl;
@@ -118,7 +117,11 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 #endif
 
 	/* link to codec */
-	hwdep->dev = &codec->dev;
+	hwdep->dev.parent = &codec->dev;
+
+	/* for sysfs */
+	hwdep->dev.groups = snd_hda_dev_attr_groups;
+	dev_set_drvdata(&hwdep->dev, codec);
 
 	return 0;
 }
-- 
2.2.2
