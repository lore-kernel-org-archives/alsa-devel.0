From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/7] ALSA: hda - Add widget sysfs tree
Date: Wed, 18 Mar 2015 16:16:34 +0100
Message-ID: <1426691797-17178-5-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD7D2265132
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ABFDCAD0F
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
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

This patch changes the sysfs files assigned to the codec device on the
bus which were formerly identical with hwdep sysfs files.  Now it
shows only a few core parameter, vendor_id, subsystem_id, revision_id,
afg, mfg, vendor_name and chip_name.

In addition, now a widget tree is added to the bus device sysfs
directory for showing the widget topology and attributes.  It's just a
flat tree consisting of subdirectories named as the widget NID
including various attributes like widget capability bits.  The AFG
(usually NID 0x01) is always found there, and it contains always
amp_in_caps, amp_out_caps and power_caps files.  Each of these
attributes show a single value.  The rest are the widget nodes
belonging to that AFG.  Note that the child node might not start from
0x02 but from another value like 0x0a.

Each child node may contain caps, pin_caps, amp_in_caps, amp_out_caps,
power_caps and connections files.  The caps (representing the widget
capability bits) always contain a value.  The rest may contain
value(s) if the attribute exists on the node.  Only connections file
show multiple values while other attributes have zero or one single
value.

An example of ls -R output is like below:
% ls -R /sys/bus/hdaudio/devices/hdaudioC0D0/
/sys/bus/hdaudio/devices/hdaudioC0D0/widgets/:
01/  04/  07/  0a/  0d/  10/  13/  16/  19/  1c/  1f/  22/
02/  05/  08/  0b/  0e/  11/  14/  17/  1a/  1d/  20/  23/
03/  06/  09/  0c/  0f/  12/  15/  18/  1b/  1e/  21/

/sys/bus/hdaudio/devices/hdaudioC0D0/widgets/01:
amp_in_caps  amp_out_caps  power_caps

/sys/bus/hdaudio/devices/hdaudioC0D0/widgets/02:
amp_in_caps  amp_out_caps  caps  connections  pin_caps  pin_cfg
power_caps

/sys/bus/hdaudio/devices/hdaudioC0D0/widgets/03:
.....

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h   |   6 +
 sound/hda/Makefile        |   2 +-
 sound/hda/hdac_device.c   |  35 ++++
 sound/hda/hdac_sysfs.c    | 404 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/hda/local.h         |   4 +
 sound/pci/hda/hda_bind.c  |   4 +-
 sound/pci/hda/hda_codec.c |   6 +-
 7 files changed, 454 insertions(+), 7 deletions(-)
 create mode 100644 sound/hda/hdac_sysfs.c

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index b81b4bec6f05..6ed2b421e29e 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -14,6 +14,7 @@ typedef u16 hda_nid_t;
 struct hdac_bus;
 struct hdac_device;
 struct hdac_driver;
+struct hdac_widget_tree;
 
 /*
  * exported bus type
@@ -53,6 +54,9 @@ struct hdac_device {
 
 	/* misc flags */
 	atomic_t in_pm;		/* suspend/resume being performed */
+
+	/* sysfs */
+	struct hdac_widget_tree *widgets;
 };
 
 /* device/driver type used for matching */
@@ -71,6 +75,8 @@ enum {
 int snd_hdac_device_init(struct hdac_device *dev, struct hdac_bus *bus,
 			 const char *name, unsigned int addr);
 void snd_hdac_device_exit(struct hdac_device *dev);
+int snd_hdac_device_register(struct hdac_device *codec);
+void snd_hdac_device_unregister(struct hdac_device *codec);
 
 int snd_hdac_refresh_widgets(struct hdac_device *codec);
 
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 3c7625e595cf..ae8b5128b5c3 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,3 +1,3 @@
-snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o
+snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o hdac_sysfs.o
 
 obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index a3f52ad4de37..1470ecc354db 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -45,6 +45,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	dev->parent = bus->dev;
 	dev->bus = &snd_hda_bus_type;
 	dev->release = default_release;
+	dev->groups = hdac_dev_attr_groups;
 	dev_set_name(dev, "%s", name);
 	device_enable_async_suspend(dev);
 
@@ -128,6 +129,40 @@ void snd_hdac_device_exit(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_device_exit);
 
 /**
+ * snd_hdac_device_register - register the hd-audio codec base device
+ * codec: the device to register
+ */
+int snd_hdac_device_register(struct hdac_device *codec)
+{
+	int err;
+
+	err = device_add(&codec->dev);
+	if (err < 0)
+		return err;
+	err = hda_widget_sysfs_init(codec);
+	if (err < 0) {
+		device_del(&codec->dev);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_device_register);
+
+/**
+ * snd_hdac_device_unregister - unregister the hd-audio codec base device
+ * codec: the device to unregister
+ */
+void snd_hdac_device_unregister(struct hdac_device *codec)
+{
+	if (device_is_registered(&codec->dev)) {
+		hda_widget_sysfs_exit(codec);
+		device_del(&codec->dev);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_device_unregister);
+
+/**
  * snd_hdac_make_cmd - compose a 32bit command word to be sent to the
  *	HD-audio controller
  * @codec: the codec object
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
new file mode 100644
index 000000000000..b358d5157802
--- /dev/null
+++ b/sound/hda/hdac_sysfs.c
@@ -0,0 +1,404 @@
+/*
+ * sysfs support for HD-audio core device
+ */
+
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/hdaudio.h>
+#include "local.h"
+
+struct hdac_widget_tree {
+	struct kobject *root;
+	struct kobject *afg;
+	struct kobject **nodes;
+};
+
+#define CODEC_ATTR(type)					\
+static ssize_t type##_show(struct device *dev,			\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct hdac_device *codec = dev_to_hdac_dev(dev);	\
+	return sprintf(buf, "0x%x\n", codec->type);		\
+} \
+static DEVICE_ATTR_RO(type)
+
+#define CODEC_ATTR_STR(type)					\
+static ssize_t type##_show(struct device *dev,			\
+			     struct device_attribute *attr,	\
+					char *buf)		\
+{								\
+	struct hdac_device *codec = dev_to_hdac_dev(dev);	\
+	return sprintf(buf, "%s\n",				\
+		       codec->type ? codec->type : "");		\
+} \
+static DEVICE_ATTR_RO(type)
+
+CODEC_ATTR(vendor_id);
+CODEC_ATTR(subsystem_id);
+CODEC_ATTR(revision_id);
+CODEC_ATTR(afg);
+CODEC_ATTR(mfg);
+CODEC_ATTR_STR(vendor_name);
+CODEC_ATTR_STR(chip_name);
+
+static struct attribute *hdac_dev_attrs[] = {
+	&dev_attr_vendor_id.attr,
+	&dev_attr_subsystem_id.attr,
+	&dev_attr_revision_id.attr,
+	&dev_attr_afg.attr,
+	&dev_attr_mfg.attr,
+	&dev_attr_vendor_name.attr,
+	&dev_attr_chip_name.attr,
+	NULL
+};
+
+static struct attribute_group hdac_dev_attr_group = {
+	.attrs	= hdac_dev_attrs,
+};
+
+const struct attribute_group *hdac_dev_attr_groups[] = {
+	&hdac_dev_attr_group,
+	NULL
+};
+
+/*
+ * Widget tree sysfs
+ *
+ * This is a tree showing the attributes of each widget.  It appears like
+ * /sys/bus/hdaudioC0D0/widgets/04/caps
+ */
+
+struct widget_attribute;
+
+struct widget_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct hdac_device *codec, hda_nid_t nid,
+			struct widget_attribute *attr, char *buf);
+	ssize_t (*store)(struct hdac_device *codec, hda_nid_t nid,
+			 struct widget_attribute *attr,
+			 const char *buf, size_t count);
+};
+
+static int get_codec_nid(struct kobject *kobj, struct hdac_device **codecp)
+{
+	struct device *dev = kobj_to_dev(kobj->parent->parent);
+	int nid;
+	ssize_t ret;
+
+	ret = kstrtoint(kobj->name, 16, &nid);
+	if (ret < 0)
+		return ret;
+	*codecp = dev_to_hdac_dev(dev);
+	return nid;
+}
+
+static ssize_t widget_attr_show(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+{
+	struct widget_attribute *wid_attr =
+		container_of(attr, struct widget_attribute, attr);
+	struct hdac_device *codec;
+	int nid;
+
+	if (!wid_attr->show)
+		return -EIO;
+	nid = get_codec_nid(kobj, &codec);
+	if (nid < 0)
+		return nid;
+	return wid_attr->show(codec, nid, wid_attr, buf);
+}
+
+static ssize_t widget_attr_store(struct kobject *kobj, struct attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct widget_attribute *wid_attr =
+		container_of(attr, struct widget_attribute, attr);
+	struct hdac_device *codec;
+	int nid;
+
+	if (!wid_attr->store)
+		return -EIO;
+	nid = get_codec_nid(kobj, &codec);
+	if (nid < 0)
+		return nid;
+	return wid_attr->store(codec, nid, wid_attr, buf, count);
+}
+
+static const struct sysfs_ops widget_sysfs_ops = {
+	.show	= widget_attr_show,
+	.store	= widget_attr_store,
+};
+
+static void widget_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static struct kobj_type widget_ktype = {
+	.release	= widget_release,
+	.sysfs_ops	= &widget_sysfs_ops,
+};
+
+#define WIDGET_ATTR_RO(_name) \
+	struct widget_attribute wid_attr_##_name = __ATTR_RO(_name)
+#define WIDGET_ATTR_RW(_name) \
+	struct widget_attribute wid_attr_##_name = __ATTR_RW(_name)
+
+static ssize_t caps_show(struct hdac_device *codec, hda_nid_t nid,
+			struct widget_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n", get_wcaps(codec, nid));
+}
+
+static ssize_t pin_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			     struct widget_attribute *attr, char *buf)
+{
+	if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP));
+}
+
+static ssize_t pin_cfg_show(struct hdac_device *codec, hda_nid_t nid,
+			    struct widget_attribute *attr, char *buf)
+{
+	unsigned int val;
+
+	if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
+		return 0;
+	if (snd_hdac_read(codec, nid, AC_VERB_GET_CONFIG_DEFAULT, 0, &val))
+		return 0;
+	return sprintf(buf, "0x%08x\n", val);
+}
+
+static bool has_pcm_cap(struct hdac_device *codec, hda_nid_t nid)
+{
+	if (nid == codec->afg || nid == codec->mfg)
+		return true;
+	switch (get_wcaps_type(get_wcaps(codec, nid))) {
+	case AC_WID_AUD_OUT:
+	case AC_WID_AUD_IN:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static ssize_t pcm_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			     struct widget_attribute *attr, char *buf)
+{
+	if (!has_pcm_cap(codec, nid))
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_PCM));
+}
+
+static ssize_t pcm_formats_show(struct hdac_device *codec, hda_nid_t nid,
+				struct widget_attribute *attr, char *buf)
+{
+	if (!has_pcm_cap(codec, nid))
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_STREAM));
+}
+
+static ssize_t amp_in_caps_show(struct hdac_device *codec, hda_nid_t nid,
+				struct widget_attribute *attr, char *buf)
+{
+	if (nid != codec->afg && !(get_wcaps(codec, nid) & AC_WCAP_IN_AMP))
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_AMP_IN_CAP));
+}
+
+static ssize_t amp_out_caps_show(struct hdac_device *codec, hda_nid_t nid,
+				 struct widget_attribute *attr, char *buf)
+{
+	if (nid != codec->afg && !(get_wcaps(codec, nid) & AC_WCAP_OUT_AMP))
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_AMP_OUT_CAP));
+}
+
+static ssize_t power_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			       struct widget_attribute *attr, char *buf)
+{
+	if (nid != codec->afg && !(get_wcaps(codec, nid) & AC_WCAP_POWER))
+		return 0;
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_POWER_STATE));
+}
+
+static ssize_t gpio_caps_show(struct hdac_device *codec, hda_nid_t nid,
+			      struct widget_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%08x\n",
+		       snd_hdac_read_parm(codec, nid, AC_PAR_GPIO_CAP));
+}
+
+static ssize_t connections_show(struct hdac_device *codec, hda_nid_t nid,
+				struct widget_attribute *attr, char *buf)
+{
+	hda_nid_t list[32];
+	int i, nconns;
+	ssize_t ret = 0;
+
+	nconns = snd_hdac_get_connections(codec, nid, list, ARRAY_SIZE(list));
+	if (nconns <= 0)
+		return nconns;
+	for (i = 0; i < nconns; i++)
+		ret += sprintf(buf + ret, "%s0x%02x", i ? " " : "", list[i]);
+	ret += sprintf(buf + ret, "\n");
+	return ret;
+}
+
+static WIDGET_ATTR_RO(caps);
+static WIDGET_ATTR_RO(pin_caps);
+static WIDGET_ATTR_RO(pin_cfg);
+static WIDGET_ATTR_RO(pcm_caps);
+static WIDGET_ATTR_RO(pcm_formats);
+static WIDGET_ATTR_RO(amp_in_caps);
+static WIDGET_ATTR_RO(amp_out_caps);
+static WIDGET_ATTR_RO(power_caps);
+static WIDGET_ATTR_RO(gpio_caps);
+static WIDGET_ATTR_RO(connections);
+
+static struct attribute *widget_node_attrs[] = {
+	&wid_attr_caps.attr,
+	&wid_attr_pin_caps.attr,
+	&wid_attr_pin_cfg.attr,
+	&wid_attr_pcm_caps.attr,
+	&wid_attr_pcm_formats.attr,
+	&wid_attr_amp_in_caps.attr,
+	&wid_attr_amp_out_caps.attr,
+	&wid_attr_power_caps.attr,
+	&wid_attr_connections.attr,
+	NULL,
+};
+
+static struct attribute *widget_afg_attrs[] = {
+	&wid_attr_pcm_caps.attr,
+	&wid_attr_pcm_formats.attr,
+	&wid_attr_amp_in_caps.attr,
+	&wid_attr_amp_out_caps.attr,
+	&wid_attr_power_caps.attr,
+	&wid_attr_gpio_caps.attr,
+	NULL,
+};
+
+static const struct attribute_group widget_node_group = {
+	.attrs = widget_node_attrs,
+};
+
+static const struct attribute_group widget_afg_group = {
+	.attrs = widget_afg_attrs,
+};
+
+static void free_widget_node(struct kobject *kobj,
+			     const struct attribute_group *group)
+{
+	if (kobj) {
+		sysfs_remove_group(kobj, group);
+		kobject_put(kobj);
+	}
+}
+
+static void widget_tree_free(struct hdac_device *codec)
+{
+	struct hdac_widget_tree *tree = codec->widgets;
+	struct kobject **p;
+
+	if (!tree)
+		return;
+	if (tree->nodes) {
+		for (p = tree->nodes; *p; p++)
+			free_widget_node(*p, &widget_node_group);
+		kfree(tree->nodes);
+	}
+	free_widget_node(tree->afg, &widget_afg_group);
+	if (tree->root)
+		kobject_put(tree->root);
+	kfree(tree);
+	codec->widgets = NULL;
+}
+
+static int add_widget_node(struct kobject *parent, hda_nid_t nid,
+			   const struct attribute_group *group,
+			   struct kobject **res)
+{
+	struct kobject *kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
+	int err;
+
+	if (!kobj)
+		return -ENOMEM;
+	kobject_init(kobj, &widget_ktype);
+	err = kobject_add(kobj, parent, "%02x", nid);
+	if (err < 0)
+		return err;
+	err = sysfs_create_group(kobj, group);
+	if (err < 0) {
+		kobject_put(kobj);
+		return err;
+	}
+
+	*res = kobj;
+	return 0;
+}
+
+static int widget_tree_create(struct hdac_device *codec)
+{
+	struct hdac_widget_tree *tree;
+	int i, err;
+	hda_nid_t nid;
+
+	tree = codec->widgets = kzalloc(sizeof(*tree), GFP_KERNEL);
+	if (!tree)
+		return -ENOMEM;
+
+	tree->root = kobject_create_and_add("widgets", &codec->dev.kobj);
+	if (!tree->root)
+		return -ENOMEM;
+
+	if (codec->afg) {
+		err = add_widget_node(tree->root, codec->afg,
+				      &widget_afg_group, &tree->afg);
+		if (err < 0)
+			return err;
+	}
+
+	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
+			      GFP_KERNEL);
+	if (!tree->nodes)
+		return -ENOMEM;
+
+	for (i = 0, nid = codec->start_nid; i < codec->num_nodes; i++, nid++) {
+		err = add_widget_node(tree->root, nid, &widget_node_group,
+				      &tree->nodes[i]);
+		if (err < 0)
+			return err;
+	}
+
+	kobject_uevent(tree->root, KOBJ_CHANGE);
+	return 0;
+}
+
+int hda_widget_sysfs_init(struct hdac_device *codec)
+{
+	int err;
+
+	err = widget_tree_create(codec);
+	if (err < 0) {
+		widget_tree_free(codec);
+		return err;
+	}
+
+	return 0;
+}
+
+void hda_widget_sysfs_exit(struct hdac_device *codec)
+{
+	widget_tree_free(codec);
+}
diff --git a/sound/hda/local.h b/sound/hda/local.h
index a077d1f656f6..d692f417ddc0 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -16,4 +16,8 @@ static inline int get_wcaps_type(unsigned int wcaps)
 	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
 }
 
+extern const struct attribute_group *hdac_dev_attr_groups[];
+int hda_widget_sysfs_init(struct hdac_device *codec);
+void hda_widget_sysfs_exit(struct hdac_device *codec);
+
 #endif /* __HDAC_LOCAL_H */
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index ad276a9771db..130f672e6f37 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -240,7 +240,7 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	else
 		codec->probe_id = 0;
 
-	err = device_add(hda_codec_dev(codec));
+	err = snd_hdac_device_register(&codec->core);
 	if (err < 0)
 		return err;
 
@@ -262,7 +262,7 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	return 0;
 
  error:
-	device_del(hda_codec_dev(codec));
+	snd_hdac_device_unregister(&codec->core);
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_configure);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ddfc0fbbee23..b162fc40348f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -967,8 +967,7 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	codec->in_freeing = 1;
-	if (device_is_registered(hda_codec_dev(codec)))
-		device_del(hda_codec_dev(codec));
+	snd_hdac_device_unregister(&codec->core);
 	put_device(hda_codec_dev(codec));
 	return 0;
 }
@@ -2182,8 +2181,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 		return -EBUSY;
 
 	/* OK, let it free */
-	if (device_is_registered(hda_codec_dev(codec)))
-		device_del(hda_codec_dev(codec));
+	snd_hdac_device_unregister(&codec->core);
 
 	/* allow device access again */
 	snd_hda_unlock_devices(bus);
-- 
2.3.3
