From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: Create sysfs attribute files via
	groups
Date: Wed, 26 Feb 2014 07:47:23 +0100
Message-ID: <1393397252-11690-2-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C82E265139
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E36447501F
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

Instead of calling each time device_create_file(), create the groups
of sysfs attribute files at once in a normal way.  Add a new helper
function, snd_get_device(), to return the associated device object,
so that we can handle the sysfs addition locally.

Since the sysfs file addition is done differently now,
snd_add_device_sysfs_file() helper function is removed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h      |   3 +-
 include/sound/hwdep.h     |   1 +
 sound/core/hwdep.c        |  14 ++++++
 sound/core/pcm.c          |  30 +++++++++++--
 sound/core/sound.c        |  23 +++++-----
 sound/pci/hda/hda_codec.c |  16 -------
 sound/pci/hda/hda_hwdep.c | 110 ++++++++++++++++++++++++----------------------
 sound/pci/hda/hda_local.h |  18 --------
 8 files changed, 112 insertions(+), 103 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index a3e3e89b63b6..9c1187334195 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -248,8 +248,7 @@ static inline int snd_register_device(int type, struct snd_card *card, int dev,
 
 int snd_unregister_device(int type, struct snd_card *card, int dev);
 void *snd_lookup_minor_data(unsigned int minor, int type);
-int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      struct device_attribute *attr);
+struct device *snd_get_device(int type, struct snd_card *card, int dev);
 
 #ifdef CONFIG_SND_OSSEMUL
 int snd_register_oss_device(int type, struct snd_card *card, int dev,
diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index 6233eb092d0a..193a3c57ed25 100644
--- a/include/sound/hwdep.h
+++ b/include/sound/hwdep.h
@@ -68,6 +68,7 @@ struct snd_hwdep {
 	wait_queue_head_t open_wait;
 	void *private_data;
 	void (*private_free) (struct snd_hwdep *hwdep);
+	const struct attribute_group **groups;
 
 	struct mutex open_mutex;
 	int used;			/* reference counter */
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 8c778659fa03..99f7e8515ba1 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -436,6 +436,20 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		mutex_unlock(&register_mutex);
 		return err;
 	}
+
+	if (hwdep->groups) {
+		struct device *d = snd_get_device(SNDRV_DEVICE_TYPE_HWDEP,
+						  hwdep->card, hwdep->device);
+		if (d) {
+			err = sysfs_create_groups(&d->kobj, hwdep->groups);
+			if (err < 0)
+				dev_warn(card->dev,
+					 "hwdep %d:%d: cannot create sysfs groups\n",
+					 card->number, hwdep->device);
+			put_device(d);
+		}
+	}
+
 #ifdef CONFIG_SND_OSSEMUL
 	hwdep->ossreg = 0;
 	if (hwdep->oss_type >= 0) {
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 9defdaef520b..43932e8dce66 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1018,8 +1018,20 @@ static ssize_t show_pcm_class(struct device *dev,
         return snprintf(buf, PAGE_SIZE, "%s\n", str);
 }
 
-static struct device_attribute pcm_attrs =
-	__ATTR(pcm_class, S_IRUGO, show_pcm_class, NULL);
+static DEVICE_ATTR(pcm_class, S_IRUGO, show_pcm_class, NULL);
+static struct attribute *pcm_dev_attrs[] = {
+	&dev_attr_pcm_class.attr,
+	NULL
+};
+
+static struct attribute_group pcm_dev_attr_group = {
+	.attrs	= pcm_dev_attrs,
+};
+
+static const struct attribute_group *pcm_dev_attr_groups[] = {
+	&pcm_dev_attr_group,
+	NULL
+};
 
 static int snd_pcm_dev_register(struct snd_device *device)
 {
@@ -1069,8 +1081,18 @@ static int snd_pcm_dev_register(struct snd_device *device)
 			mutex_unlock(&register_mutex);
 			return err;
 		}
-		snd_add_device_sysfs_file(devtype, pcm->card, pcm->device,
-					  &pcm_attrs);
+
+		dev = snd_get_device(devtype, pcm->card, pcm->device);
+		if (dev) {
+			err = sysfs_create_groups(&dev->kobj,
+						  pcm_dev_attr_groups);
+			if (err < 0)
+				dev_warn(dev,
+					 "pcm %d:%d: cannot create sysfs groups\n",
+					 pcm->card->number, pcm->device);
+			put_device(dev);
+		}
+
 		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next)
 			snd_pcm_timer_init(substream);
 	}
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 60ab9b1f44b9..38ad1a0dd3f7 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -355,22 +355,25 @@ int snd_unregister_device(int type, struct snd_card *card, int dev)
 
 EXPORT_SYMBOL(snd_unregister_device);
 
-int snd_add_device_sysfs_file(int type, struct snd_card *card, int dev,
-			      struct device_attribute *attr)
+/* get the assigned device to the given type and device number;
+ * the caller needs to release it via put_device() after using it
+ */
+struct device *snd_get_device(int type, struct snd_card *card, int dev)
 {
-	int minor, ret = -EINVAL;
-	struct device *d;
+	int minor;
+	struct device *d = NULL;
 
 	mutex_lock(&sound_mutex);
 	minor = find_snd_minor(type, card, dev);
-	if (minor >= 0 && (d = snd_minors[minor]->dev) != NULL)
-		ret = device_create_file(d, attr);
+	if (minor >= 0) {
+		d = snd_minors[minor]->dev;
+		if (d)
+			get_device(d);
+	}
 	mutex_unlock(&sound_mutex);
-	return ret;
-
+	return d;
 }
-
-EXPORT_SYMBOL(snd_add_device_sysfs_file);
+EXPORT_SYMBOL(snd_get_device);
 
 #ifdef CONFIG_PROC_FS
 /*
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 115502783b64..51360d916e6b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -852,21 +852,6 @@ static int snd_hda_bus_dev_free(struct snd_device *device)
 	return snd_hda_bus_free(bus);
 }
 
-#ifdef CONFIG_SND_HDA_HWDEP
-static int snd_hda_bus_dev_register(struct snd_device *device)
-{
-	struct hda_bus *bus = device->device_data;
-	struct hda_codec *codec;
-	list_for_each_entry(codec, &bus->codec_list, list) {
-		snd_hda_hwdep_add_sysfs(codec);
-		snd_hda_hwdep_add_power_sysfs(codec);
-	}
-	return 0;
-}
-#else
-#define snd_hda_bus_dev_register	NULL
-#endif
-
 /**
  * snd_hda_bus_new - create a HDA bus
  * @card: the card entry
@@ -882,7 +867,6 @@ int snd_hda_bus_new(struct snd_card *card,
 	struct hda_bus *bus;
 	int err;
 	static struct snd_device_ops dev_ops = {
-		.dev_register = snd_hda_bus_dev_register,
 		.dev_free = snd_hda_bus_dev_free,
 	};
 
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 53c961992d0c..53eef6a01589 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -124,6 +124,8 @@ static void hwdep_free(struct snd_hwdep *hwdep)
 	clear_hwdep_elements(hwdep->private_data);
 }
 
+static const struct attribute_group *snd_hda_dev_attr_groups[];
+
 int snd_hda_create_hwdep(struct hda_codec *codec)
 {
 	char hwname[16];
@@ -140,6 +142,7 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	hwdep->private_data = codec;
 	hwdep->private_free = hwdep_free;
 	hwdep->exclusive = 1;
+	hwdep->groups = snd_hda_dev_attr_groups;
 
 	hwdep->ops.open = hda_hwdep_open;
 	hwdep->ops.ioctl = hda_hwdep_ioctl;
@@ -176,21 +179,8 @@ static ssize_t power_off_acct_show(struct device *dev,
 	return sprintf(buf, "%u\n", jiffies_to_msecs(codec->power_off_acct));
 }
 
-static struct device_attribute power_attrs[] = {
-	__ATTR_RO(power_on_acct),
-	__ATTR_RO(power_off_acct),
-};
-
-int snd_hda_hwdep_add_power_sysfs(struct hda_codec *codec)
-{
-	struct snd_hwdep *hwdep = codec->hwdep;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(power_attrs); i++)
-		snd_add_device_sysfs_file(SNDRV_DEVICE_TYPE_HWDEP, hwdep->card,
-					  hwdep->device, &power_attrs[i]);
-	return 0;
-}
+static DEVICE_ATTR_RO(power_on_acct);
+static DEVICE_ATTR_RO(power_off_acct);
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_SND_HDA_RECONFIG
@@ -568,44 +558,21 @@ static ssize_t user_pin_configs_store(struct device *dev,
 	return count;
 }
 
-#define CODEC_ATTR_RW(type) \
-	__ATTR(type, 0644, type##_show, type##_store)
-#define CODEC_ATTR_RO(type) \
-	__ATTR_RO(type)
-#define CODEC_ATTR_WO(type) \
-	__ATTR(type, 0200, NULL, type##_store)
-
-static struct device_attribute codec_attrs[] = {
-	CODEC_ATTR_RW(vendor_id),
-	CODEC_ATTR_RW(subsystem_id),
-	CODEC_ATTR_RW(revision_id),
-	CODEC_ATTR_RO(afg),
-	CODEC_ATTR_RO(mfg),
-	CODEC_ATTR_RW(vendor_name),
-	CODEC_ATTR_RW(chip_name),
-	CODEC_ATTR_RW(modelname),
-	CODEC_ATTR_RW(init_verbs),
-	CODEC_ATTR_RW(hints),
-	CODEC_ATTR_RO(init_pin_configs),
-	CODEC_ATTR_RW(user_pin_configs),
-	CODEC_ATTR_RO(driver_pin_configs),
-	CODEC_ATTR_WO(reconfig),
-	CODEC_ATTR_WO(clear),
-};
-
-/*
- * create sysfs files on hwdep directory
- */
-int snd_hda_hwdep_add_sysfs(struct hda_codec *codec)
-{
-	struct snd_hwdep *hwdep = codec->hwdep;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(codec_attrs); i++)
-		snd_add_device_sysfs_file(SNDRV_DEVICE_TYPE_HWDEP, hwdep->card,
-					  hwdep->device, &codec_attrs[i]);
-	return 0;
-}
+static DEVICE_ATTR_RW(vendor_id);
+static DEVICE_ATTR_RW(subsystem_id);
+static DEVICE_ATTR_RW(revision_id);
+static DEVICE_ATTR_RO(afg);
+static DEVICE_ATTR_RO(mfg);
+static DEVICE_ATTR_RW(vendor_name);
+static DEVICE_ATTR_RW(chip_name);
+static DEVICE_ATTR_RW(modelname);
+static DEVICE_ATTR_RW(init_verbs);
+static DEVICE_ATTR_RW(hints);
+static DEVICE_ATTR_RO(init_pin_configs);
+static DEVICE_ATTR_RW(user_pin_configs);
+static DEVICE_ATTR_RO(driver_pin_configs);
+static DEVICE_ATTR_WO(reconfig);
+static DEVICE_ATTR_WO(clear);
 
 /*
  * Look for hint string
@@ -884,3 +851,40 @@ int snd_hda_load_patch(struct hda_bus *bus, size_t fw_size, const void *fw_buf)
 }
 EXPORT_SYMBOL_GPL(snd_hda_load_patch);
 #endif /* CONFIG_SND_HDA_PATCH_LOADER */
+
+/*
+ * sysfs entries
+ */
+static struct attribute *hda_dev_attrs[] = {
+#ifdef CONFIG_PM
+	&dev_attr_power_on_acct.attr,
+	&dev_attr_power_off_acct.attr,
+#endif
+#ifdef CONFIG_SND_HDA_RECONFIG
+	&dev_attr_vendor_id.attr,
+	&dev_attr_subsystem_id.attr,
+	&dev_attr_revision_id.attr,
+	&dev_attr_afg.attr,
+	&dev_attr_mfg.attr,
+	&dev_attr_vendor_name.attr,
+	&dev_attr_chip_name.attr,
+	&dev_attr_modelname.attr,
+	&dev_attr_init_verbs.attr,
+	&dev_attr_hints.attr,
+	&dev_attr_init_pin_configs.attr,
+	&dev_attr_user_pin_configs.attr,
+	&dev_attr_driver_pin_configs.attr,
+	&dev_attr_reconfig.attr,
+	&dev_attr_clear.attr,
+#endif
+	NULL
+};
+
+static struct attribute_group hda_dev_attr_group = {
+	.attrs	= hda_dev_attrs,
+};
+
+static const struct attribute_group *snd_hda_dev_attr_groups[] = {
+	&hda_dev_attr_group,
+	NULL
+};
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index da80c5bd7fd4..31545923f6ac 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -597,24 +597,6 @@ int snd_hda_create_hwdep(struct hda_codec *codec);
 static inline int snd_hda_create_hwdep(struct hda_codec *codec) { return 0; }
 #endif
 
-#if defined(CONFIG_PM) && defined(CONFIG_SND_HDA_HWDEP)
-int snd_hda_hwdep_add_power_sysfs(struct hda_codec *codec);
-#else
-static inline int snd_hda_hwdep_add_power_sysfs(struct hda_codec *codec)
-{
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_SND_HDA_RECONFIG
-int snd_hda_hwdep_add_sysfs(struct hda_codec *codec);
-#else
-static inline int snd_hda_hwdep_add_sysfs(struct hda_codec *codec)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_SND_HDA_RECONFIG
 const char *snd_hda_get_hint(struct hda_codec *codec, const char *key);
 int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key);
-- 
1.9.0
