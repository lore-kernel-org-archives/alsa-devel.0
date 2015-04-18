From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v6 2/6] ALSA: jack: extend snd_jack_new to
	support phantom jack
Date: Sat, 18 Apr 2015 18:04:16 +0800
Message-ID: <1429351460-15932-3-git-send-email-yang.jie@intel.com>
References: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D45162615F7
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 12:01:03 +0200 (CEST)
In-Reply-To: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
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

For phantom jack, we won't create real jack device, but jack kctl
may be needed.

Here, we extend snd_jack_new() to support phantom jack creating:
pass in a bool param for [non-]phantom flag, and a non-Null param
(struct snd_jack_kctl **) to indicate that we need create kctl
at this jack creating stage.

We can also add kctl to a jack after the jack is created.

This make the integrating the existing HDA jack kctl and soc jack
kctl possible.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/jack.h            |  4 +--
 sound/core/jack.c               | 56 +++++++++++++++++++++++++----------------
 sound/pci/hda/hda_jack.c        |  2 +-
 sound/pci/oxygen/xonar_wm87x6.c |  2 +-
 sound/soc/soc-jack.c            |  2 +-
 5 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 8337000..11d772f 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -95,7 +95,7 @@ struct snd_jack_kctl {
 #ifdef CONFIG_SND_JACK
 
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jack);
+		 struct snd_jack **jack, bool phantom_jack, struct snd_jack_kctl **jjack_kctl);
 int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name, int mask);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
@@ -105,7 +105,7 @@ void snd_jack_report(struct snd_jack *jack, int status);
 
 #else
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
-			       struct snd_jack **jack)
+			       struct snd_jack **jack, bool phantom_jack, struct snd_jack_kctl **jjack_kctl)
 {
 	return 0;
 }
diff --git a/sound/core/jack.c b/sound/core/jack.c
index a03fc93..7dbbd7d 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -235,6 +235,10 @@ EXPORT_SYMBOL(snd_jack_add_new_kctls);
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
  *         this jack
  * @jjack: Used to provide the allocated jack object to the caller.
+ * @phantom_jack: for phantom jack, only create needed kctl, won't create
+ *         real jackdevice
+ * @jjack_kctl: create kctl if non-NULL pointer passed in, and provide it to
+ *         the caller. also add it to the non-phantom jack kctl list
  *
  * Creates a new jack object.
  *
@@ -242,7 +246,7 @@ EXPORT_SYMBOL(snd_jack_add_new_kctls);
  * On success @jjack will be initialised.
  */
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jjack)
+		 struct snd_jack **jjack, bool phantom_jack, struct snd_jack_kctl **jjack_kctl)
 {
 	struct snd_jack *jack;
 	int err;
@@ -253,35 +257,43 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		.dev_disconnect = snd_jack_dev_disconnect,
 	};
 
-	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
-	if (jack == NULL)
-		return -ENOMEM;
+	if (jjack_kctl)
+		*jjack_kctl = snd_jack_kctl_new(card, id, type);
 
-	jack->id = kstrdup(id, GFP_KERNEL);
+	/* don't creat real jack device for phantom jack */
+	if (!phantom_jack) {
+		jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
+		if (jack == NULL)
+			return -ENOMEM;
 
-	jack->input_dev = input_allocate_device();
-	if (jack->input_dev == NULL) {
-		err = -ENOMEM;
-		goto fail_input;
-	}
+		jack->id = kstrdup(id, GFP_KERNEL);
+
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
 
-	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
-	if (err < 0)
-		goto fail_input;
+		err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
+		if (err < 0)
+			goto fail_input;
 
-	jack->card = card;
-	INIT_LIST_HEAD(&jack->kctl_list);
+		jack->card = card;
+		INIT_LIST_HEAD(&jack->kctl_list);
 
-	*jjack = jack;
+		if (jjack_kctl && *jjack_kctl)
+			snd_jack_kctl_add(jack, *jjack_kctl);
+		*jjack = jack;
+	}
 
 	return 0;
 
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index e664307..2136670 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -417,7 +417,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
-				   &jack->jack);
+				   &jack->jack, false, NULL);
 		if (err < 0)
 			return err;
 		jack->jack->private_data = jack;
diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 6ce6860..a37450b 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -286,7 +286,7 @@ static void xonar_ds_init(struct oxygen *chip)
 	xonar_enable_output(chip);
 
 	snd_jack_new(chip->card, "Headphone",
-		     SND_JACK_HEADPHONE, &data->hp_jack);
+		     SND_JACK_HEADPHONE, &data->hp_jack, false, NULL);
 	xonar_ds_handle_hp_jack(chip);
 
 	snd_component_add(chip->card, "WM8776");
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9f60c25..836368b 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -48,7 +48,7 @@ int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	ret = snd_jack_new(card->snd_card, id, type, &jack->jack);
+	ret = snd_jack_new(card->snd_card, id, type, &jack->jack, false, NULL);
 	if (ret)
 		return ret;
 
-- 
1.9.1
