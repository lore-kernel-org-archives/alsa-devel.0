From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v8 1/7] ALSA: jack: implement kctl creating for
	jack device
Date: Wed, 22 Apr 2015 14:03:47 +0800
Message-ID: <1429682633-10765-2-git-send-email-yang.jie@intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B61DC265A69
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 08:00:32 +0200 (CEST)
In-Reply-To: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
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
Cc: alsa-devel@alsa-project.org, tanu.kaskinen@linux.intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently the ALSA jack core registers only input devices for each jack
registered. These jack input devices are not readable by userspace devices
that run as non root. This patch and the following series patches will
implement kctls inside the core jack part, including kctls creating, status
changing report, for both HD-Audio and ASoC jack. This allows non root
userspace to read jack status and act on it.

This patch implement snd_jack_add_new_kctl(), which will create a kcontrol,
add it to the card, and also attach it to the jack kctl list.

The patch also initial the jack kctl list after jack is newed, and report
kctl status when doing jack report.

In the following patches, We will update snd_jack_new() to support phantom
jack creating, and also enable a kcontrol creating at this jack new stage.
After that, we can remove these part from HDA jack, and leave jack kctls
handled by core part thoroughly.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Modified-by: Jie Yang <yang.jie@intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
Reveiwed-by: Mark Brown <broonie@kernel.org>
---
 include/sound/jack.h  |  15 +++++++-
 sound/core/Kconfig    |   3 --
 sound/core/Makefile   |   3 +-
 sound/core/jack.c     | 104 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/Kconfig |   1 -
 5 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2182350..9781e75 100644
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
@@ -82,10 +84,17 @@ struct snd_jack {
 	void (*private_free)(struct snd_jack *);
 };
 
+struct snd_jack_kctl {
+	struct snd_kcontrol *kctl;
+	struct list_head list;		/* list of controls belong to the same jack */
+	unsigned int mask_bits;	/* one of the corresponding bits of status change will report to this kctl */
+};
+
 #ifdef CONFIG_SND_JACK
 
 int snd_jack_new(struct snd_card *card, const char *id, int type,
 		 struct snd_jack **jack);
+int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 		     int keytype);
@@ -93,13 +102,17 @@ int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
 void snd_jack_report(struct snd_jack *jack, int status);
 
 #else
-
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
 			       struct snd_jack **jack)
 {
 	return 0;
 }
 
+static inline int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
+{
+	return 0;
+}
+
 static inline void snd_jack_set_parent(struct snd_jack *jack,
 				       struct device *parent)
 {
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 313f22e..63cc2e9 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -221,9 +221,6 @@ config SND_PCM_XRUN_DEBUG
 config SND_VMASTER
 	bool
 
-config SND_KCTL_JACK
-	bool
-
 config SND_DMA_SGBUF
 	def_bool y
 	depends on X86
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 4daf2f5..e041dc2 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -7,8 +7,7 @@ snd-y     := sound.o init.o memory.o info.o control.o misc.o device.o
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
 snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
-snd-$(CONFIG_SND_KCTL_JACK) += ctljack.o
-snd-$(CONFIG_SND_JACK)	  += jack.o
+snd-$(CONFIG_SND_JACK)	  += ctljack.o jack.o
 
 snd-pcm-y := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o memalloc.o
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 8658578..741db7c 100644
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
 
@@ -100,6 +107,90 @@ static int snd_jack_dev_register(struct snd_device *device)
 	return err;
 }
 
+static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl)
+{
+	struct snd_jack_kctl *jack_kctl;
+
+	jack_kctl = kctl->private_data;
+	if (jack_kctl) {
+		list_del(&jack_kctl->list);
+		kfree(jack_kctl);
+	}
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
+static struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const char *name, unsigned int mask)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_jack_kctl *jack_kctl;
+	int err;
+
+	kctl = snd_kctl_jack_new(name, 0, card);
+	if (!kctl)
+		return NULL;
+
+	err = snd_ctl_add(card, kctl);
+	if (err < 0)
+		return NULL;
+
+	jack_kctl = kzalloc(sizeof(*jack_kctl), GFP_KERNEL);
+
+	if (!jack_kctl)
+		goto error;
+
+	jack_kctl->kctl = kctl;
+	jack_kctl->mask_bits = mask;
+
+	kctl->private_data = jack_kctl;
+	kctl->private_free = snd_jack_kctl_private_free;
+
+	return jack_kctl;
+error:
+	snd_ctl_free_one(kctl);
+	return NULL;
+}
+
+/**
+ * snd_jack_add_new_kctl - Create a new snd_jack_kctl and add it to jack
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
+int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask)
+{
+	struct snd_jack_kctl *jack_kctl;
+
+	jack_kctl = snd_jack_kctl_new(jack->card, name, mask);
+	if (!jack_kctl)
+		return -ENOMEM;
+
+	snd_jack_kctl_add(jack, jack_kctl);
+	return 0;
+}
+EXPORT_SYMBOL(snd_jack_add_new_kctl);
+
 /**
  * snd_jack_new - Create a new jack
  * @card:  the card instance
@@ -150,6 +241,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (err < 0)
 		goto fail_input;
 
+	jack->card = card;
+	INIT_LIST_HEAD(&jack->kctl_list);
+
 	*jjack = jack;
 
 	return 0;
@@ -230,6 +324,7 @@ EXPORT_SYMBOL(snd_jack_set_key);
  */
 void snd_jack_report(struct snd_jack *jack, int status)
 {
+	struct snd_jack_kctl *jack_kctl;
 	int i;
 
 	if (!jack)
@@ -245,13 +340,20 @@ void snd_jack_report(struct snd_jack *jack, int status)
 
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
 
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f0f2c5..363f365 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -4,7 +4,6 @@ config SND_HDA
 	tristate
 	select SND_PCM
 	select SND_VMASTER
-	select SND_KCTL_JACK
 
 config SND_HDA_INTEL
 	tristate "HD Audio PCI"
-- 
1.9.1
