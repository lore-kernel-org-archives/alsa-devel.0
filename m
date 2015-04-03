From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v4 1/5] ALSA: jack: create jack kcontrols for
	every jack input
Date: Fri,  3 Apr 2015 20:07:14 +0800
Message-ID: <1428062838-14786-2-git-send-email-yang.jie@intel.com>
References: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 19CBF26586A
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 14:04:17 +0200 (CEST)
In-Reply-To: <1428062838-14786-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently the ALSA jack core registers only input devices for each jack
registered. These jack input devices are not readable by userspace devices
that run as non root.

This patch adds support for additionally registering jack kcontrol devices
for every input jack registered. This allows non root userspace to read
jack status.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Modified-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
Reveiwed-by: Mark Brown <broonie@kernel.org>
---
 include/sound/jack.h |  21 ++++++++
 sound/core/jack.c    | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 1 deletion(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2182350..07f7035 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -73,6 +73,8 @@ enum snd_jack_types {
 
 struct snd_jack {
 	struct input_dev *input_dev;
+	struct list_head kctl_list;
+	struct snd_card *card;
 	int registered;
 	int type;
 	const char *id;
@@ -82,10 +84,20 @@ struct snd_jack {
 	void (*private_free)(struct snd_jack *);
 };
 
+struct snd_jack_kctl {
+	struct snd_kcontrol *kctl;
+	struct list_head list;		/* list of controls belong to the same jack */
+	unsigned int mask_bits;	/* one of the corresponding bits of status change will report to this kctl */
+	void *private_data;
+	void (*private_free)(struct snd_jack_kctl *jack_kctl);
+};
+
 #ifdef CONFIG_SND_JACK
 
+struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const char *kctl_name, unsigned int mask);
 int snd_jack_new(struct snd_card *card, const char *id, int type,
 		 struct snd_jack **jack);
+int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name, int mask);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 		     int keytype);
@@ -93,6 +105,10 @@ int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 void snd_jack_report(struct snd_jack *jack, int status);
 
 #else
+static inline struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const char *kctl_name, unsigned int mask)
+{
+	return NULL;
+}
 
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 			       struct snd_jack **jack)
@@ -100,6 +116,11 @@ static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 	return 0;
 }
 
+static inline int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name, int mask)
+{
+	return 0;
+}
+
 static inline void snd_jack_set_parent(struct snd_jack *jack,
 				       struct device *parent)
 {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 8658578..c74111f 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <sound/jack.h>
 #include <sound/core.h>
+#include <sound/control.h>
 
 static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 	SW_HEADPHONE_INSERT,
@@ -54,7 +55,13 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
 static int snd_jack_dev_free(struct snd_device *device)
 {
 	struct snd_jack *jack = device->device_data;
+	struct snd_card *card = device->card;
+	struct snd_jack_kctl *jack_kctl, *tmp_jack_kctl;
 
+	list_for_each_entry_safe(jack_kctl, tmp_jack_kctl, &jack->kctl_list, list) {
+		list_del_init(&jack_kctl->list);
+		snd_ctl_remove(card, jack_kctl->kctl);
+	}
 	if (jack->private_free)
 		jack->private_free(jack);
 
@@ -100,6 +107,97 @@ static int snd_jack_dev_register(struct snd_device *device)
 	return err;
 }
 
+static int snd_jack_get_available_index(struct snd_card *card, const char *name)
+{
+	struct snd_ctl_elem_id sid;
+
+	memset(&sid, 0, sizeof(sid));
+
+	sid.index = 0;
+	sid.iface = SNDRV_CTL_ELEM_IFACE_CARD;
+	strlcpy(sid.name, name, sizeof(sid.name));
+
+	while (snd_ctl_find_id(card, &sid)) {
+		sid.index++;
+	}
+	return sid.index;
+}
+
+static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl)
+{
+	struct snd_jack_kctl *jack_kctl;
+
+	if (kctl) {
+		jack_kctl = kctl->private_data;
+		if (jack_kctl) {
+			if (jack_kctl->private_free)
+				jack_kctl->private_free(jack_kctl);
+			list_del(&jack_kctl->list);
+			kfree(jack_kctl);
+		}
+	}
+
+}
+
+static void snd_jack_kctl_name_gen(char *name, const char *jack_id, int size)
+{
+	size_t count = strlen(jack_id);
+
+	/* remove redundant " Jack" from jack_id */
+	if (strstr(jack_id, " Jack"))
+		count -= 5;
+
+	count = (size > count) ? count + 1 : size;
+	/* name[count] will be filled to '\0' */
+	strlcpy(name, jack_id, count);
+
+}
+
+static void snd_jack_kctl_add(struct snd_jack *jack, struct snd_jack_kctl *jack_kctl)
+{
+	list_add_tail(&jack_kctl->list, &jack->kctl_list);
+}
+
+/**
+ * snd_jack_kctl_new - Create a new snd_jack_kctl and return it
+ * @card:  the card instance
+ * @kctl_name:  the name for the snd_kcontrol object
+ * @mask:  a bitmask of enum snd_jack_type values that can be detected
+ *         by this snd_jack_kctl object.
+ *
+ * Creates a new snd_kcontrol object, and assign it to the new created
+ *	     snd_jack_kctl object.
+ *
+ * Return: The new created snd_jack_kctl object, or NULL if failed.
+ */
+struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const char *kctl_name, unsigned int mask)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_jack_kctl *jack_kctl;
+	int index;
+
+	index = snd_jack_get_available_index(card, kctl_name);
+	kctl = snd_kctl_jack_new(kctl_name, index, card);
+	if (!kctl)
+		return NULL;
+
+	jack_kctl = kzalloc(sizeof(*jack_kctl), GFP_KERNEL);
+
+	if (!jack_kctl) {
+		kfree(kctl);//needed?
+		return NULL;
+	}
+
+	jack_kctl->kctl = kctl;
+	jack_kctl->mask_bits = mask;
+
+	kctl->private_data = jack_kctl;
+	kctl->private_free = snd_jack_kctl_private_free;
+
+	return jack_kctl;
+}
+EXPORT_SYMBOL(snd_jack_kctl_new);
+
 /**
  * snd_jack_new - Create a new jack
  * @card:  the card instance
@@ -163,6 +261,39 @@ fail_input:
 EXPORT_SYMBOL(snd_jack_new);
 
 /**
+ * snd_jack_add_new_kctls - Create a new snd_jack_kctl and add it to jack
+ * @jack:  the jack instance which the kctl will attaching to
+ * @name:  the name for the snd_kcontrol object
+ * @mask:  a bitmask of enum snd_jack_type values that can be detected
+ *         by this snd_jack_kctl object.
+ *
+ * Creates a new snd_kcontrol object, and assign it to the new created
+ *	     snd_jack_kctl object, then add it to the jack kctl_list.
+ *
+ * Return: Zero if successful, or a negative error code on failure.
+ */
+int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name, int mask)
+{
+	struct snd_jack_kctl *jack_kctl;
+	int err;
+	char jack_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	snd_jack_kctl_name_gen(jack_name, name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	jack_kctl = snd_jack_kctl_new(jack->card, jack_name, mask);
+	if (!jack_kctl)
+		return -ENOMEM;
+
+	err = snd_ctl_add(jack->card, jack_kctl->kctl);
+	if (err < 0)
+		return err;
+
+	snd_jack_kctl_add(jack, jack_kctl);
+	return 0;
+}
+EXPORT_SYMBOL(snd_jack_add_new_kctls);
+
+/**
  * snd_jack_set_parent - Set the parent device for a jack
  *
  * @jack:   The jack to configure
@@ -230,6 +361,7 @@ EXPORT_SYMBOL(snd_jack_set_key);
  */
 void snd_jack_report(struct snd_jack *jack, int status)
 {
+	struct snd_jack_kctl *jack_kctl;
 	int i;
 
 	if (!jack)
@@ -245,13 +377,20 @@ void snd_jack_report(struct snd_jack *jack, int status)
 
 	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
-		if (jack->type & testbit)
+		if (jack->type & testbit) {
 			input_report_switch(jack->input_dev,
 					    jack_switch_types[i],
 					    status & testbit);
+		}
 	}
 
 	input_sync(jack->input_dev);
+
+	list_for_each_entry(jack_kctl, &jack->kctl_list, list) {
+		snd_kctl_jack_report(jack->card, jack_kctl->kctl,
+					status & jack_kctl->mask_bits);
+	}
+
 }
 EXPORT_SYMBOL(snd_jack_report);
 
-- 
1.9.1
