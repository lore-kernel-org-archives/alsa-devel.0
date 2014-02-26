From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/10] ALSA: hda - Enable sysfs attributes
	without CONFIG_SND_HDA_RECONFIG
Date: Wed, 26 Feb 2014 07:47:31 +0100
Message-ID: <1393397252-11690-10-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D52B26561C
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0134D75028
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:47:38 +0000 (UTC)
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

Some sysfs attributes like init_pin_configs or vendor_name are really
basic and should be available no matter whether the codec driver is
re-configurable or not.  Put them out of #ifdef
CONFIG_SND_HDA_RECONFIG and allow the read-only accesses.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h |   2 +-
 sound/pci/hda/hda_sysfs.c | 165 ++++++++++++++++++++++++----------------------
 2 files changed, 89 insertions(+), 78 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index ad5871f3a669..a4233136cb93 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -333,8 +333,8 @@ struct hda_codec {
 	struct snd_array driver_pins;	/* pin configs set by codec parser */
 	struct snd_array cvt_setups;	/* audio convert setups */
 
-#ifdef CONFIG_SND_HDA_RECONFIG
 	struct mutex user_mutex;
+#ifdef CONFIG_SND_HDA_RECONFIG
 	struct snd_array init_verbs;	/* additional init verbs */
 	struct snd_array hints;		/* additional hints */
 	struct snd_array user_pins;	/* default pin configs to override */
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index c92ac267f5af..da0f51460533 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -48,6 +48,65 @@ static DEVICE_ATTR_RO(power_on_acct);
 static DEVICE_ATTR_RO(power_off_acct);
 #endif /* CONFIG_PM */
 
+#define CODEC_INFO_SHOW(type)					\
+static ssize_t type##_show(struct device *dev,			\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
+	return sprintf(buf, "0x%x\n", codec->type);		\
+}
+
+#define CODEC_INFO_STR_SHOW(type)				\
+static ssize_t type##_show(struct device *dev,			\
+			     struct device_attribute *attr,	\
+					char *buf)		\
+{								\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
+	return sprintf(buf, "%s\n",				\
+		       codec->type ? codec->type : "");		\
+}
+
+CODEC_INFO_SHOW(vendor_id);
+CODEC_INFO_SHOW(subsystem_id);
+CODEC_INFO_SHOW(revision_id);
+CODEC_INFO_SHOW(afg);
+CODEC_INFO_SHOW(mfg);
+CODEC_INFO_STR_SHOW(vendor_name);
+CODEC_INFO_STR_SHOW(chip_name);
+CODEC_INFO_STR_SHOW(modelname);
+
+static ssize_t pin_configs_show(struct hda_codec *codec,
+				struct snd_array *list,
+				char *buf)
+{
+	int i, len = 0;
+	mutex_lock(&codec->user_mutex);
+	for (i = 0; i < list->used; i++) {
+		struct hda_pincfg *pin = snd_array_elem(list, i);
+		len += sprintf(buf + len, "0x%02x 0x%08x\n",
+			       pin->nid, pin->cfg);
+	}
+	mutex_unlock(&codec->user_mutex);
+	return len;
+}
+
+static ssize_t init_pin_configs_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct hda_codec *codec = dev_get_drvdata(dev);
+	return pin_configs_show(codec, &codec->init_pins, buf);
+}
+
+static ssize_t driver_pin_configs_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct hda_codec *codec = dev_get_drvdata(dev);
+	return pin_configs_show(codec, &codec->driver_pins, buf);
+}
+
 #ifdef CONFIG_SND_HDA_RECONFIG
 
 /*
@@ -111,34 +170,6 @@ static char *kstrndup_noeol(const char *src, size_t len)
 	return s;
 }
 
-#define CODEC_INFO_SHOW(type)					\
-static ssize_t type##_show(struct device *dev,			\
-			   struct device_attribute *attr,	\
-			   char *buf)				\
-{								\
-	struct hda_codec *codec = dev_get_drvdata(dev);		\
-	return sprintf(buf, "0x%x\n", codec->type);		\
-}
-
-#define CODEC_INFO_STR_SHOW(type)				\
-static ssize_t type##_show(struct device *dev,			\
-			     struct device_attribute *attr,	\
-					char *buf)		\
-{								\
-	struct hda_codec *codec = dev_get_drvdata(dev);		\
-	return sprintf(buf, "%s\n",				\
-		       codec->type ? codec->type : "");		\
-}
-
-CODEC_INFO_SHOW(vendor_id);
-CODEC_INFO_SHOW(subsystem_id);
-CODEC_INFO_SHOW(revision_id);
-CODEC_INFO_SHOW(afg);
-CODEC_INFO_SHOW(mfg);
-CODEC_INFO_STR_SHOW(vendor_name);
-CODEC_INFO_STR_SHOW(chip_name);
-CODEC_INFO_STR_SHOW(modelname);
-
 #define CODEC_INFO_STORE(type)					\
 static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
@@ -344,29 +375,6 @@ static ssize_t hints_store(struct device *dev,
 	return count;
 }
 
-static ssize_t pin_configs_show(struct hda_codec *codec,
-				struct snd_array *list,
-				char *buf)
-{
-	int i, len = 0;
-	mutex_lock(&codec->user_mutex);
-	for (i = 0; i < list->used; i++) {
-		struct hda_pincfg *pin = snd_array_elem(list, i);
-		len += sprintf(buf + len, "0x%02x 0x%08x\n",
-			       pin->nid, pin->cfg);
-	}
-	mutex_unlock(&codec->user_mutex);
-	return len;
-}
-
-static ssize_t init_pin_configs_show(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct hda_codec *codec = dev_get_drvdata(dev);
-	return pin_configs_show(codec, &codec->init_pins, buf);
-}
-
 static ssize_t user_pin_configs_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -375,14 +383,6 @@ static ssize_t user_pin_configs_show(struct device *dev,
 	return pin_configs_show(codec, &codec->user_pins, buf);
 }
 
-static ssize_t driver_pin_configs_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct hda_codec *codec = dev_get_drvdata(dev);
-	return pin_configs_show(codec, &codec->driver_pins, buf);
-}
-
 #define MAX_PIN_CONFIGS		32
 
 static int parse_user_pin_configs(struct hda_codec *codec, const char *buf)
@@ -410,19 +410,10 @@ static ssize_t user_pin_configs_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR_RW(vendor_id);
-static DEVICE_ATTR_RW(subsystem_id);
-static DEVICE_ATTR_RW(revision_id);
-static DEVICE_ATTR_RO(afg);
-static DEVICE_ATTR_RO(mfg);
-static DEVICE_ATTR_RW(vendor_name);
-static DEVICE_ATTR_RW(chip_name);
-static DEVICE_ATTR_RW(modelname);
+/* sysfs attributes exposed only when CONFIG_SND_HDA_RECONFIG=y */
 static DEVICE_ATTR_RW(init_verbs);
 static DEVICE_ATTR_RW(hints);
-static DEVICE_ATTR_RO(init_pin_configs);
 static DEVICE_ATTR_RW(user_pin_configs);
-static DEVICE_ATTR_RO(driver_pin_configs);
 static DEVICE_ATTR_WO(reconfig);
 static DEVICE_ATTR_WO(clear);
 
@@ -484,6 +475,26 @@ int snd_hda_get_int_hint(struct hda_codec *codec, const char *key, int *valp)
 EXPORT_SYMBOL_GPL(snd_hda_get_int_hint);
 #endif /* CONFIG_SND_HDA_RECONFIG */
 
+/*
+ * common sysfs attributes
+ */
+#ifdef CONFIG_SND_HDA_RECONFIG
+#define RECONFIG_DEVICE_ATTR(name)	DEVICE_ATTR_RW(name)
+#else
+#define RECONFIG_DEVICE_ATTR(name)	DEVICE_ATTR_RO(name)
+#endif
+static RECONFIG_DEVICE_ATTR(vendor_id);
+static RECONFIG_DEVICE_ATTR(subsystem_id);
+static RECONFIG_DEVICE_ATTR(revision_id);
+static DEVICE_ATTR_RO(afg);
+static DEVICE_ATTR_RO(mfg);
+static RECONFIG_DEVICE_ATTR(vendor_name);
+static RECONFIG_DEVICE_ATTR(chip_name);
+static RECONFIG_DEVICE_ATTR(modelname);
+static DEVICE_ATTR_RO(init_pin_configs);
+static DEVICE_ATTR_RO(driver_pin_configs);
+
+
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 
 /* parser mode */
@@ -708,11 +719,6 @@ EXPORT_SYMBOL_GPL(snd_hda_load_patch);
  * sysfs entries
  */
 static struct attribute *hda_dev_attrs[] = {
-#ifdef CONFIG_PM
-	&dev_attr_power_on_acct.attr,
-	&dev_attr_power_off_acct.attr,
-#endif
-#ifdef CONFIG_SND_HDA_RECONFIG
 	&dev_attr_vendor_id.attr,
 	&dev_attr_subsystem_id.attr,
 	&dev_attr_revision_id.attr,
@@ -721,11 +727,16 @@ static struct attribute *hda_dev_attrs[] = {
 	&dev_attr_vendor_name.attr,
 	&dev_attr_chip_name.attr,
 	&dev_attr_modelname.attr,
+	&dev_attr_init_pin_configs.attr,
+	&dev_attr_driver_pin_configs.attr,
+#ifdef CONFIG_PM
+	&dev_attr_power_on_acct.attr,
+	&dev_attr_power_off_acct.attr,
+#endif
+#ifdef CONFIG_SND_HDA_RECONFIG
 	&dev_attr_init_verbs.attr,
 	&dev_attr_hints.attr,
-	&dev_attr_init_pin_configs.attr,
 	&dev_attr_user_pin_configs.attr,
-	&dev_attr_driver_pin_configs.attr,
 	&dev_attr_reconfig.attr,
 	&dev_attr_clear.attr,
 #endif
@@ -743,8 +754,8 @@ const struct attribute_group *snd_hda_dev_attr_groups[] = {
 
 void snd_hda_sysfs_init(struct hda_codec *codec)
 {
-#ifdef CONFIG_SND_HDA_RECONFIG
 	mutex_init(&codec->user_mutex);
+#ifdef CONFIG_SND_HDA_RECONFIG
 	snd_array_init(&codec->init_verbs, sizeof(struct hda_verb), 32);
 	snd_array_init(&codec->hints, sizeof(struct hda_hint), 32);
 	snd_array_init(&codec->user_pins, sizeof(struct hda_pincfg), 16);
-- 
1.9.0
