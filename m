From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/14] ALSA: Simplify snd_device_register()
	variants
Date: Mon,  2 Feb 2015 11:24:37 +0100
Message-ID: <1422872678-4815-14-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B6ED260517
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1803EAD88
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:40 +0000 (UTC)
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

Now that all callers have been replaced with
snd_device_register_for_dev(), let's drop the obsolete device
registration code and concentrate only on the code handling struct
device directly.  That said,

- remove the old snd_device_register(),
- rename snd_device_register_for_dev() with snd_device_register(),
- drop superfluous arguments from snd_device_register(),
- change snd_unregister_device() to pass the device pointer directly

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h           | 39 +++------------------------
 sound/core/compress_offload.c  | 10 +++----
 sound/core/control.c           |  7 +++--
 sound/core/hwdep.c             |  9 +++----
 sound/core/pcm.c               | 21 ++++-----------
 sound/core/rawmidi.c           | 11 ++++----
 sound/core/seq/seq_clientmgr.c |  7 +++--
 sound/core/sound.c             | 61 ++++++++++++++++--------------------------
 sound/core/timer.c             |  7 +++--
 9 files changed, 54 insertions(+), 118 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 4b7e04e85e16..67ac309bb218 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -187,7 +187,6 @@ struct snd_minor {
 	int type;			/* SNDRV_DEVICE_TYPE_XXX */
 	int card;			/* card number */
 	int device;			/* device number */
-	bool created;
 	const struct file_operations *f_ops;	/* file operations */
 	void *private_data;		/* private data for f_ops->open */
 	struct device *dev;		/* device for sysfs */
@@ -210,40 +209,10 @@ void snd_request_card(int card);
 
 void snd_device_initialize(struct device *dev, struct snd_card *card);
 
-int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
-				const struct file_operations *f_ops,
-				void *private_data, struct device *device,
-				struct device *parent, const char *name);
-
-/**
- * snd_register_device - Register the ALSA device file for the card
- * @type: the device type, SNDRV_DEVICE_TYPE_XXX
- * @card: the card instance
- * @dev: the device index
- * @f_ops: the file operations
- * @private_data: user pointer for f_ops->open()
- * @name: the device file name
- *
- * Registers an ALSA device file for the given card.
- * The operators have to be set in reg parameter.
- *
- * This function uses the card's device pointer to link to the
- * correct &struct device.
- *
- * Return: Zero if successful, or a negative error code on failure.
- */
-static inline int snd_register_device(int type, struct snd_card *card, int dev,
-				      const struct file_operations *f_ops,
-				      void *private_data,
-				      const char *name)
-{
-	return snd_register_device_for_dev(type, card, dev, f_ops,
-					   private_data, NULL,
-					   snd_card_get_device_link(card),
-					   name);
-}
-
-int snd_unregister_device(int type, struct snd_card *card, int dev);
+int snd_register_device(int type, struct snd_card *card, int dev,
+			const struct file_operations *f_ops,
+			void *private_data, struct device *device);
+int snd_unregister_device(struct device *dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
 struct device *snd_get_device(int type, struct snd_card *card, int dev);
 
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index cb58c3f7f80c..b123c42e7dc8 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -871,10 +871,9 @@ static int snd_compress_dev_register(struct snd_device *device)
 	pr_debug("reg %s for device %s, direction %d\n", str, compr->name,
 			compr->direction);
 	/* register compressed device */
-	ret = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_COMPRESS,
-					  compr->card, compr->device,
-					  &snd_compr_file_ops, compr,
-					  &compr->dev, NULL, NULL);
+	ret = snd_register_device(SNDRV_DEVICE_TYPE_COMPRESS,
+				  compr->card, compr->device,
+				  &snd_compr_file_ops, compr, &compr->dev);
 	if (ret < 0) {
 		pr_err("snd_register_device failed\n %d", ret);
 		return ret;
@@ -888,8 +887,7 @@ static int snd_compress_dev_disconnect(struct snd_device *device)
 	struct snd_compr *compr;
 
 	compr = device->device_data;
-	snd_unregister_device(SNDRV_DEVICE_TYPE_COMPRESS, compr->card,
-		compr->device);
+	snd_unregister_device(&compr->dev);
 	return 0;
 }
 
diff --git a/sound/core/control.c b/sound/core/control.c
index e214fabbc671..60caba1f2211 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1661,9 +1661,8 @@ static int snd_ctl_dev_register(struct snd_device *device)
 {
 	struct snd_card *card = device->device_data;
 
-	return snd_register_device_for_dev(SNDRV_DEVICE_TYPE_CONTROL, card,
-					   -1, &snd_ctl_f_ops, card,
-					   &card->ctl_dev, NULL, NULL);
+	return snd_register_device(SNDRV_DEVICE_TYPE_CONTROL, card, -1,
+				   &snd_ctl_f_ops, card, &card->ctl_dev);
 }
 
 /*
@@ -1681,7 +1680,7 @@ static int snd_ctl_dev_disconnect(struct snd_device *device)
 	}
 	read_unlock(&card->ctl_files_rwlock);
 
-	return snd_unregister_device(SNDRV_DEVICE_TYPE_CONTROL, card, -1);
+	return snd_unregister_device(&card->ctl_dev);
 }
 
 /*
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 506387ba645d..84244a5143cf 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -432,10 +432,9 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		return -EBUSY;
 	}
 	list_add_tail(&hwdep->list, &snd_hwdep_devices);
-	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_HWDEP,
-					  hwdep->card, hwdep->device,
-					  &snd_hwdep_f_ops, hwdep,
-					  &hwdep->dev, NULL, NULL);
+	err = snd_register_device(SNDRV_DEVICE_TYPE_HWDEP,
+				  hwdep->card, hwdep->device,
+				  &snd_hwdep_f_ops, hwdep, &hwdep->dev);
 	if (err < 0) {
 		dev_err(&hwdep->dev, "unable to register\n");
 		list_del(&hwdep->list);
@@ -480,7 +479,7 @@ static int snd_hwdep_dev_disconnect(struct snd_device *device)
 	if (hwdep->ossreg)
 		snd_unregister_oss_device(hwdep->oss_type, hwdep->card, hwdep->device);
 #endif
-	snd_unregister_device(SNDRV_DEVICE_TYPE_HWDEP, hwdep->card, hwdep->device);
+	snd_unregister_device(&hwdep->dev);
 	list_del_init(&hwdep->list);
 	mutex_unlock(&hwdep->open_mutex);
 	mutex_unlock(&register_mutex);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 4d5120f7a8ab..0345e53a340c 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1105,11 +1105,9 @@ static int snd_pcm_dev_register(struct snd_device *device)
 			break;
 		}
 		/* register pcm */
-		err = snd_register_device_for_dev(devtype, pcm->card,
-						  pcm->device,
-						  &snd_pcm_f_ops[cidx],
-						  pcm, &pcm->streams[cidx].dev,
-						  NULL, NULL);
+		err = snd_register_device(devtype, pcm->card, pcm->device,
+					  &snd_pcm_f_ops[cidx], pcm,
+					  &pcm->streams[cidx].dev);
 		if (err < 0) {
 			list_del(&pcm->list);
 			mutex_unlock(&register_mutex);
@@ -1132,7 +1130,7 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 	struct snd_pcm *pcm = device->device_data;
 	struct snd_pcm_notify *notify;
 	struct snd_pcm_substream *substream;
-	int cidx, devtype;
+	int cidx;
 
 	mutex_lock(&register_mutex);
 	if (list_empty(&pcm->list))
@@ -1155,16 +1153,7 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 		notify->n_disconnect(pcm);
 	}
 	for (cidx = 0; cidx < 2; cidx++) {
-		devtype = -1;
-		switch (cidx) {
-		case SNDRV_PCM_STREAM_PLAYBACK:
-			devtype = SNDRV_DEVICE_TYPE_PCM_PLAYBACK;
-			break;
-		case SNDRV_PCM_STREAM_CAPTURE:
-			devtype = SNDRV_DEVICE_TYPE_PCM_CAPTURE;
-			break;
-		}
-		snd_unregister_device(devtype, pcm->card, pcm->device);
+		snd_unregister_device(&pcm->streams[cidx].dev);
 		if (pcm->streams[cidx].chmap_kctl) {
 			snd_ctl_remove(pcm->card, pcm->streams[cidx].chmap_kctl);
 			pcm->streams[cidx].chmap_kctl = NULL;
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index bccbf7e375d6..b5a748596fc4 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1581,10 +1581,9 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 		return -EBUSY;
 	}
 	list_add_tail(&rmidi->list, &snd_rawmidi_devices);
-	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_RAWMIDI,
-					  rmidi->card, rmidi->device,
-					  &snd_rawmidi_f_ops, rmidi,
-					  &rmidi->dev, NULL, NULL);
+	err = snd_register_device(SNDRV_DEVICE_TYPE_RAWMIDI,
+				  rmidi->card, rmidi->device,
+				  &snd_rawmidi_f_ops, rmidi, &rmidi->dev);
 	if (err < 0) {
 		rmidi_err(rmidi, "unable to register\n");
 		list_del(&rmidi->list);
@@ -1593,7 +1592,7 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 	}
 	if (rmidi->ops && rmidi->ops->dev_register &&
 	    (err = rmidi->ops->dev_register(rmidi)) < 0) {
-		snd_unregister_device(SNDRV_DEVICE_TYPE_RAWMIDI, rmidi->card, rmidi->device);
+		snd_unregister_device(&rmidi->dev);
 		list_del(&rmidi->list);
 		mutex_unlock(&register_mutex);
 		return err;
@@ -1681,7 +1680,7 @@ static int snd_rawmidi_dev_disconnect(struct snd_device *device)
 		rmidi->ossreg = 0;
 	}
 #endif /* CONFIG_SND_OSSEMUL */
-	snd_unregister_device(SNDRV_DEVICE_TYPE_RAWMIDI, rmidi->card, rmidi->device);
+	snd_unregister_device(&rmidi->dev);
 	mutex_unlock(&rmidi->open_mutex);
 	mutex_unlock(&register_mutex);
 	return 0;
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 65b320ec66f1..2b62cd021bc5 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2586,9 +2586,8 @@ int __init snd_sequencer_device_init(void)
 	if (mutex_lock_interruptible(&register_mutex))
 		return -ERESTARTSYS;
 
-	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0,
-					  &snd_seq_f_ops, NULL,
-					  &seq_dev, NULL, NULL);
+	err = snd_register_device(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0,
+				  &snd_seq_f_ops, NULL, &seq_dev);
 	if (err < 0) {
 		mutex_unlock(&register_mutex);
 		put_device(&seq_dev);
@@ -2607,6 +2606,6 @@ int __init snd_sequencer_device_init(void)
  */
 void __exit snd_sequencer_device_done(void)
 {
-	snd_unregister_device(SNDRV_DEVICE_TYPE_SEQUENCER, NULL, 0);
+	snd_unregister_device(&seq_dev);
 	put_device(&seq_dev);
 }
diff --git a/sound/core/sound.c b/sound/core/sound.c
index ea1af1acdbe9..515e62506541 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -242,30 +242,30 @@ static int snd_kernel_minor(int type, struct snd_card *card, int dev)
 #endif
 
 /**
- * snd_register_device_for_dev - Register the ALSA device file for the card
+ * snd_register_device - Register the ALSA device file for the card
  * @type: the device type, SNDRV_DEVICE_TYPE_XXX
  * @card: the card instance
  * @dev: the device index
  * @f_ops: the file operations
  * @private_data: user pointer for f_ops->open()
- * @device: the device to register, NULL to create a new one
- * @parent: the &struct device to link this new device to (only for device=NULL)
- * @name: the device file name (only for device=NULL)
+ * @device: the device to register
  *
  * Registers an ALSA device file for the given card.
  * The operators have to be set in reg parameter.
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
-				const struct file_operations *f_ops,
-				void *private_data, struct device *device,
-				struct device *parent, const char *name)
+int snd_register_device(int type, struct snd_card *card, int dev,
+			const struct file_operations *f_ops,
+			void *private_data, struct device *device)
 {
 	int minor;
 	int err = 0;
 	struct snd_minor *preg;
 
+	if (snd_BUG_ON(!device))
+		return -EINVAL;
+
 	preg = kmalloc(sizeof *preg, GFP_KERNEL);
 	if (preg == NULL)
 		return -ENOMEM;
@@ -288,19 +288,9 @@ int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 		goto error;
 	}
 
-	if (device) {
-		preg->created = false;
-		preg->dev = device;
-		device->devt = MKDEV(major, minor);
-		err = device_add(device);
-	} else {
-		preg->created = true;
-		preg->dev = device_create(sound_class, parent,
-					  MKDEV(major, minor), private_data,
-					  "%s", name);
-		if (IS_ERR(preg->dev))
-			err = PTR_ERR(preg->dev);
-	}
+	preg->dev = device;
+	device->devt = MKDEV(major, minor);
+	err = device_add(device);
 	if (err < 0)
 		goto error;
 
@@ -311,8 +301,7 @@ int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 		kfree(preg);
 	return err;
 }
-
-EXPORT_SYMBOL(snd_register_device_for_dev);
+EXPORT_SYMBOL(snd_register_device);
 
 /* find the matching minor record
  * return the index of snd_minor, or -1 if not found
@@ -343,30 +332,26 @@ static int find_snd_minor(int type, struct snd_card *card, int dev)
  *
  * Return: Zero if successful, or a negative error code on failure.
  */
-int snd_unregister_device(int type, struct snd_card *card, int dev)
+int snd_unregister_device(struct device *dev)
 {
 	int minor;
 	struct snd_minor *preg;
 
 	mutex_lock(&sound_mutex);
-	minor = find_snd_minor(type, card, dev);
-	if (minor < 0) {
-		mutex_unlock(&sound_mutex);
-		return -EINVAL;
+	for (minor = 0; minor < ARRAY_SIZE(snd_minors); ++minor) {
+		preg = snd_minors[minor];
+		if (preg && preg->dev == dev) {
+			snd_minors[minor] = NULL;
+			device_del(dev);
+			kfree(preg);
+			break;
+		}
 	}
-
-	preg = snd_minors[minor];
-	if (preg && !preg->created)
-		device_del(preg->dev);
-	else
-		device_destroy(sound_class, MKDEV(major, minor));
-
-	kfree(snd_minors[minor]);
-	snd_minors[minor] = NULL;
 	mutex_unlock(&sound_mutex);
+	if (minor >= ARRAY_SIZE(snd_minors))
+		return -ENOENT;
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_unregister_device);
 
 /**
diff --git a/sound/core/timer.c b/sound/core/timer.c
index dae40ac11e04..9f0c703ef081 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1976,9 +1976,8 @@ static int __init alsa_timer_init(void)
 		return err;
 	}
 
-	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
-					  &snd_timer_f_ops, NULL,
-					  &timer_dev, NULL, NULL);
+	err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
+				  &snd_timer_f_ops, NULL, &timer_dev);
 	if (err < 0) {
 		pr_err("ALSA: unable to register timer device (%i)\n", err);
 		snd_timer_free_all();
@@ -1992,7 +1991,7 @@ static int __init alsa_timer_init(void)
 
 static void __exit alsa_timer_exit(void)
 {
-	snd_unregister_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0);
+	snd_unregister_device(&timer_dev);
 	snd_timer_free_all();
 	put_device(&timer_dev);
 	snd_timer_proc_done();
-- 
2.2.2
