From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v8 3/7] ALSA: jack: extend snd_jack_new to
	support phantom jack
Date: Wed, 22 Apr 2015 14:03:49 +0800
Message-ID: <1429682633-10765-4-git-send-email-yang.jie@intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A39265ADF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 08:00:35 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

For phantom jack, we won't create input device, but jack kctl
may be needed.

Here, we extend snd_jack_new() to support phantom jack creating:
pass in a bool param for [non-]phantom flag, and a bool param
initial_jack to indicate that if we need create kctl at this
jack creating stage.

We can also add kctl to a jack after the jack is created.

This make the integrating the existing HDA jack kctl and soc jack
kctl possible.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/jack.h            |  4 ++--
 sound/core/jack.c               | 38 ++++++++++++++++++++++++++------------
 sound/pci/hda/hda_jack.c        |  2 +-
 sound/pci/oxygen/xonar_wm87x6.c |  2 +-
 sound/soc/soc-jack.c            |  2 +-
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 9781e75..3f51c17 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -93,7 +93,7 @@ struct snd_jack_kctl {
 #ifdef CONFIG_SND_JACK
 
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jack);
+		 struct snd_jack **jack, bool initial_kctl, bool phantom_jack);
 int snd_jack_add_new_kctl(struct snd_jack *jack, const char * name, int mask);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
@@ -103,7 +103,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
 
 #else
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
-			       struct snd_jack **jack)
+			       struct snd_jack **jack, bool initial_kctl, bool phantom_jack)
 {
 	return 0;
 }
diff --git a/sound/core/jack.c b/sound/core/jack.c
index b13d0b1..6c729ef 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -198,6 +198,9 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
  *         this jack
  * @jjack: Used to provide the allocated jack object to the caller.
+ * @phantom_jack: for phantom jack, only create needed kctl, won't create
+ *         input device
+ * @initial_kctl: create kctl if true, also add it to the non-phantom jack kctl list
  *
  * Creates a new jack object.
  *
@@ -205,9 +208,10 @@ EXPORT_SYMBOL(snd_jack_add_new_kctl);
  * On success @jjack will be initialised.
  */
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jjack)
+		 struct snd_jack **jjack, bool initial_kctl, bool phantom_jack)
 {
 	struct snd_jack *jack;
+	struct snd_jack_kctl *jack_kctl = NULL;
 	int err;
 	int i;
 	static struct snd_device_ops ops = {
@@ -216,26 +220,33 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		.dev_disconnect = snd_jack_dev_disconnect,
 	};
 
+	if (initial_kctl)
+		jack_kctl = snd_jack_kctl_new(card, id, type);
+
 	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
 	if (jack == NULL)
 		return -ENOMEM;
 
 	jack->id = kstrdup(id, GFP_KERNEL);
 
-	jack->input_dev = input_allocate_device();
-	if (jack->input_dev == NULL) {
-		err = -ENOMEM;
-		goto fail_input;
-	}
+	/* don't creat input device for phantom jack */
+	if (!phantom_jack) {
+		jack->input_dev = input_allocate_device();
+		if (jack->input_dev == NULL) {
+			err = -ENOMEM;
+			goto fail_input;
+		}
 
-	jack->input_dev->phys = "ALSA";
+		jack->input_dev->phys = "ALSA";
 
-	jack->type = type;
+		jack->type = type;
 
-	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
-		if (type & (1 << i))
-			input_set_capability(jack->input_dev, EV_SW,
-					     jack_switch_types[i]);
+		for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
+			if (type & (1 << i))
+				input_set_capability(jack->input_dev, EV_SW,
+						     jack_switch_types[i]);
+
+	}
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -244,6 +255,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	jack->card = card;
 	INIT_LIST_HEAD(&jack->kctl_list);
 
+	if (initial_kctl && jack_kctl)
+		snd_jack_kctl_add(jack, jack_kctl);
+
 	*jjack = jack;
 
 	return 0;
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index a046e2f..5314c73 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -417,7 +417,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
-				   &jack->jack);
+				   &jack->jack, false, false);
 		if (err < 0)
 			return err;
 		jack->jack->private_data = jack;
diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 6ce6860..90ac479 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -286,7 +286,7 @@ static void xonar_ds_init(struct oxygen *chip)
 	xonar_enable_output(chip);
 
 	snd_jack_new(chip->card, "Headphone",
-		     SND_JACK_HEADPHONE, &data->hp_jack);
+		     SND_JACK_HEADPHONE, &data->hp_jack, false, false);
 	xonar_ds_handle_hp_jack(chip);
 
 	snd_component_add(chip->card, "WM8776");
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9f60c25..70a9bdd 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -48,7 +48,7 @@ int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	ret = snd_jack_new(card->snd_card, id, type, &jack->jack);
+	ret = snd_jack_new(card->snd_card, id, type, &jack->jack, false, false);
 	if (ret)
 		return ret;
 
-- 
1.9.1
