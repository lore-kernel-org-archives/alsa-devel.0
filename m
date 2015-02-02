From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/14] ALSA: Allow to pass the device object to
	snd_register_device*()
Date: Mon,  2 Feb 2015 11:24:25 +0100
Message-ID: <1422872678-4815-2-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10FC22604DB
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD3C2ACB7
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

This is a preliminary patch for the further work on embedding struct
device into each sound device instance.  It changes
snd_register_device*() helpers to receive the device object directly
for skipping creating a device there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h | 14 +++++++-------
 sound/core/hwdep.c   |  3 ++-
 sound/core/pcm.c     |  2 +-
 sound/core/sound.c   | 54 +++++++++++++++++++++++++++++++++-------------------
 4 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 1df3f2fe5350..39d14234961d 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -186,6 +186,7 @@ struct snd_minor {
 	int type;			/* SNDRV_DEVICE_TYPE_XXX */
 	int card;			/* card number */
 	int device;			/* device number */
+	bool created;
 	const struct file_operations *f_ops;	/* file operations */
 	void *private_data;		/* private data for f_ops->open */
 	struct device *dev;		/* device for sysfs */
@@ -206,12 +207,10 @@ extern struct class *sound_class;
 
 void snd_request_card(int card);
 
-int snd_register_device_for_dev(int type, struct snd_card *card,
-				int dev,
+int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 				const struct file_operations *f_ops,
-				void *private_data,
-				const char *name,
-				struct device *device);
+				void *private_data, struct device *device,
+				struct device *parent, const char *name);
 
 /**
  * snd_register_device - Register the ALSA device file for the card
@@ -236,8 +235,9 @@ static inline int snd_register_device(int type, struct snd_card *card, int dev,
 				      const char *name)
 {
 	return snd_register_device_for_dev(type, card, dev, f_ops,
-					   private_data, name,
-					   snd_card_get_device_link(card));
+					   private_data, NULL,
+					   snd_card_get_device_link(card),
+					   name);
 }
 
 int snd_unregister_device(int type, struct snd_card *card, int dev);
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 69459e5f712e..85096a150eda 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -433,7 +433,8 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		dev = snd_card_get_device_link(hwdep->card);
 	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_HWDEP,
 					  hwdep->card, hwdep->device,
-					  &snd_hwdep_f_ops, hwdep, name, dev);
+					  &snd_hwdep_f_ops, hwdep,
+					  NULL, dev, name);
 	if (err < 0) {
 		dev_err(dev,
 			"unable to register hardware dependent device %i:%i\n",
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index cfc56c806964..dba5180e5b80 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1115,7 +1115,7 @@ static int snd_pcm_dev_register(struct snd_device *device)
 		err = snd_register_device_for_dev(devtype, pcm->card,
 						  pcm->device,
 						  &snd_pcm_f_ops[cidx],
-						  pcm, str, dev);
+						  pcm, NULL, dev, str);
 		if (err < 0) {
 			list_del(&pcm->list);
 			mutex_unlock(&register_mutex);
diff --git a/sound/core/sound.c b/sound/core/sound.c
index f1333060bf1c..ea1af1acdbe9 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -248,8 +248,9 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
  * @dev: the device index
  * @f_ops: the file operations
  * @private_data: user pointer for f_ops->open()
- * @name: the device file name
- * @device: the &struct device to link this new device to
+ * @device: the device to register, NULL to create a new one
+ * @parent: the &struct device to link this new device to (only for device=NULL)
+ * @name: the device file name (only for device=NULL)
  *
  * Registers an ALSA device file for the given card.
  * The operators have to be set in reg parameter.
@@ -258,14 +259,13 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
  */
 int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 				const struct file_operations *f_ops,
-				void *private_data,
-				const char *name, struct device *device)
+				void *private_data, struct device *device,
+				struct device *parent, const char *name)
 {
 	int minor;
+	int err = 0;
 	struct snd_minor *preg;
 
-	if (snd_BUG_ON(!name))
-		return -EINVAL;
 	preg = kmalloc(sizeof *preg, GFP_KERNEL);
 	if (preg == NULL)
 		return -ENOMEM;
@@ -284,23 +284,32 @@ int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 		minor = -EBUSY;
 #endif
 	if (minor < 0) {
-		mutex_unlock(&sound_mutex);
-		kfree(preg);
-		return minor;
+		err = minor;
+		goto error;
 	}
-	snd_minors[minor] = preg;
-	preg->dev = device_create(sound_class, device, MKDEV(major, minor),
-				  private_data, "%s", name);
-	if (IS_ERR(preg->dev)) {
-		snd_minors[minor] = NULL;
-		mutex_unlock(&sound_mutex);
-		minor = PTR_ERR(preg->dev);
-		kfree(preg);
-		return minor;
+
+	if (device) {
+		preg->created = false;
+		preg->dev = device;
+		device->devt = MKDEV(major, minor);
+		err = device_add(device);
+	} else {
+		preg->created = true;
+		preg->dev = device_create(sound_class, parent,
+					  MKDEV(major, minor), private_data,
+					  "%s", name);
+		if (IS_ERR(preg->dev))
+			err = PTR_ERR(preg->dev);
 	}
+	if (err < 0)
+		goto error;
 
+	snd_minors[minor] = preg;
+ error:
 	mutex_unlock(&sound_mutex);
-	return 0;
+	if (err < 0)
+		kfree(preg);
+	return err;
 }
 
 EXPORT_SYMBOL(snd_register_device_for_dev);
@@ -337,6 +346,7 @@ static int find_snd_minor(int type, struct snd_card *card, int dev)
 int snd_unregister_device(int type, struct snd_card *card, int dev)
 {
 	int minor;
+	struct snd_minor *preg;
 
 	mutex_lock(&sound_mutex);
 	minor = find_snd_minor(type, card, dev);
@@ -345,7 +355,11 @@ int snd_unregister_device(int type, struct snd_card *card, int dev)
 		return -EINVAL;
 	}
 
-	device_destroy(sound_class, MKDEV(major, minor));
+	preg = snd_minors[minor];
+	if (preg && !preg->created)
+		device_del(preg->dev);
+	else
+		device_destroy(sound_class, MKDEV(major, minor));
 
 	kfree(snd_minors[minor]);
 	snd_minors[minor] = NULL;
-- 
2.2.2
