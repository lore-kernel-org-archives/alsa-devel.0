From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 1/2] ALSA: jack: create jack kcontrols for
	every jack input device
Date: Fri, 20 Mar 2015 16:55:18 +0800
Message-ID: <1426841719-14576-3-git-send-email-yang.jie@intel.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B4CD22606E7
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 09:52:35 +0100 (CET)
In-Reply-To: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, broonie@kernel.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
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
 include/sound/jack.h |  8 +++++
 sound/core/jack.c    | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2182350..ef0f0ed 100644
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
@@ -82,6 +84,12 @@ struct snd_jack {
 	void (*private_free)(struct snd_jack *);
 };
 
+struct snd_jack_kctl {
+	struct snd_kcontrol *kctl;
+	struct list_head jack_list;		/* list of controls belong to the same jack*/
+	unsigned int jack_bit_idx;	/* the corresponding jack type bit index */
+};
+
 #ifdef CONFIG_SND_JACK
 
 int snd_jack_new(struct snd_card *card, const char *id, int type,
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 8658578..741924f 100644
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
 
+	list_for_each_entry_safe(jack_kctl, tmp_jack_kctl, &jack->kctl_list, jack_list) {
+		list_del(&jack_kctl->jack_list);
+		snd_ctl_remove(card, jack_kctl->kctl);
+	}
 	if (jack->private_free)
 		jack->private_free(jack);
 
@@ -100,6 +107,73 @@ static int snd_jack_dev_register(struct snd_device *device)
 	return err;
 }
 
+
+/* get the first unused/available index number for the given kctl name */
+static int get_available_index(struct snd_card *card, const char *name)
+{
+	struct snd_kcontrol *kctl;
+	int idx = 0;
+	int len = strlen(name);
+
+	down_write(&card->controls_rwsem);
+	next:
+	list_for_each_entry(kctl, &card->controls, list) {
+		if (!strncmp(name, kctl->id.name, len) &&
+		    !strcmp(" Jack", kctl->id.name + len) &&
+		    kctl->id.index == idx) {
+			idx++;
+			goto next;
+		}
+	}
+	up_write(&card->controls_rwsem);
+	return idx;
+}
+
+static void kctl_private_free(struct snd_kcontrol *kctl)
+{
+	struct snd_jack_kctl *jack_kctl = kctl->private_data;
+	list_del(&jack_kctl->jack_list);
+}
+
+static int snd_jack_new_kctl(struct snd_card *card, struct snd_jack *jack, int type)
+{
+	struct snd_kcontrol *kctl;
+	struct snd_jack_kctl *jack_kctl;
+	int i, err, index, state = 0 /* use 0 for default state ?? */;
+
+	INIT_LIST_HEAD(&jack->kctl_list);
+	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
+		int testbit = 1 << i;
+		if (type & testbit) {
+			index = get_available_index(card,jack->id);
+			kctl = snd_kctl_jack_new(jack->id, index, card);
+			if (!kctl)
+				return -ENOMEM;
+
+			err = snd_ctl_add(card, kctl);
+			if (err < 0)
+				return err;
+
+			jack_kctl = kzalloc(sizeof(*jack_kctl), GFP_KERNEL);
+
+			jack_kctl->kctl = kctl;
+
+			kctl->private_data = jack_kctl;
+			kctl->private_free = kctl_private_free;
+
+			/* use jack_bit_idx for the kctl type bit */
+			jack_kctl->jack_bit_idx = i;
+
+			list_add_tail(&jack_kctl->jack_list, &jack->kctl_list);
+
+			/* set initial jack state */
+			snd_kctl_jack_report(card, kctl, state & testbit);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * snd_jack_new - Create a new jack
  * @card:  the card instance
@@ -138,7 +212,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	}
 
 	jack->input_dev->phys = "ALSA";
-
+	jack->card = card;
 	jack->type = type;
 
 	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
@@ -150,10 +224,17 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (err < 0)
 		goto fail_input;
 
+	/* register jack kcontrols  */
+	err = snd_jack_new_kctl(card, jack, type);
+	if (err < 0)
+		goto fail_kctl;
+
 	*jjack = jack;
 
 	return 0;
 
+fail_kctl:
+	snd_device_free(card, jack);
 fail_input:
 	input_free_device(jack->input_dev);
 	kfree(jack->id);
@@ -230,6 +311,7 @@ EXPORT_SYMBOL(snd_jack_set_key);
  */
 void snd_jack_report(struct snd_jack *jack, int status)
 {
+	struct snd_jack_kctl *jack_kctl;
 	int i;
 
 	if (!jack)
@@ -245,13 +327,26 @@ void snd_jack_report(struct snd_jack *jack, int status)
 
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
+	for (i = 0; i < fls(SND_JACK_BTN_0); i++) {
+		int testbit = 1 << i;
+		if (jack->type & testbit) {
+			list_for_each_entry(jack_kctl, &jack->kctl_list, jack_list) {
+				if (jack_kctl->jack_bit_idx == i) {
+					snd_kctl_jack_report(jack->card, jack_kctl->kctl,
+								status & testbit);
+				}
+			}
+		}
+	}
 }
 EXPORT_SYMBOL(snd_jack_report);
 
-- 
1.9.1
