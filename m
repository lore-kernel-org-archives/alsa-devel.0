From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v5 2/5] ALSA: jack: add a parameter to pass
	kctl for snd_jack_new
Date: Tue,  7 Apr 2015 12:44:48 +0800
Message-ID: <1428381891-30517-3-git-send-email-yang.jie@intel.com>
References: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B6D260559
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 06:41:53 +0200 (CEST)
In-Reply-To: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currentlly, for HDA jack, we will create jack kctl before calling
snd_jack_new(). In our new design, this kctl should belong to the
jack, so we add a param(struct snd_jack_kctl *) to pass the kctl,
then we can add the kctl to jack during jack creating.

This make our design more compatible with existing HDA jack kctl.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/jack.h            |  4 ++--
 sound/core/jack.c               | 11 +++++++++--
 sound/pci/hda/hda_jack.c        |  2 +-
 sound/pci/oxygen/xonar_wm87x6.c |  2 +-
 sound/soc/soc-jack.c            |  2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 07f7035..5b580f8 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -96,7 +96,7 @@ struct snd_jack_kctl {
 
 struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, const char *kctl_name, unsigned int mask);
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jack);
+		 struct snd_jack **jack, struct snd_jack_kctl *jack_kctl);
 int snd_jack_add_new_kctls(struct snd_jack *jack, const char * name, int mask);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
 int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
@@ -111,7 +111,7 @@ static inline struct snd_jack_kctl * snd_jack_kctl_new(struct snd_card *card, co
 }
 
 static inline int snd_jack_new(struct snd_card *card, const char *id, int type,
-			       struct snd_jack **jack)
+			       struct snd_jack **jack, struct snd_jack_kctl *jack_kctl)
 {
 	return 0;
 }
diff --git a/sound/core/jack.c b/sound/core/jack.c
index c74111f..b6e7be1 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -205,6 +205,8 @@ EXPORT_SYMBOL(snd_jack_kctl_new);
  * @type:  a bitmask of enum snd_jack_type values that can be detected by
  *         this jack
  * @jjack: Used to provide the allocated jack object to the caller.
+ * @kctl: if kctl != NULL, it means we don't need create new kcontrol for this
+ * 	     jack, just assign it to the jack.
  *
  * Creates a new jack object.
  *
@@ -212,7 +214,7 @@ EXPORT_SYMBOL(snd_jack_kctl_new);
  * On success @jjack will be initialised.
  */
 int snd_jack_new(struct snd_card *card, const char *id, int type,
-		 struct snd_jack **jjack)
+		 struct snd_jack **jjack, struct snd_jack_kctl *jack_kctl)
 {
 	struct snd_jack *jack;
 	int err;
@@ -236,7 +238,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	}
 
 	jack->input_dev->phys = "ALSA";
-
+	jack->card = card;
 	jack->type = type;
 
 	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
@@ -248,6 +250,11 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (err < 0)
 		goto fail_input;
 
+	INIT_LIST_HEAD(&jack->kctl_list);
+
+	if (jack_kctl)
+		snd_jack_kctl_add(jack, jack_kctl);
+
 	*jjack = jack;
 
 	return 0;
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index e664307..9397250 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -417,7 +417,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (!phantom_jack) {
 		jack->type = get_input_jack_type(codec, nid);
 		err = snd_jack_new(codec->bus->card, name, jack->type,
-				   &jack->jack);
+				   &jack->jack, NULL);
 		if (err < 0)
 			return err;
 		jack->jack->private_data = jack;
diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
index 6ce6860..d30ec63 100644
--- a/sound/pci/oxygen/xonar_wm87x6.c
+++ b/sound/pci/oxygen/xonar_wm87x6.c
@@ -286,7 +286,7 @@ static void xonar_ds_init(struct oxygen *chip)
 	xonar_enable_output(chip);
 
 	snd_jack_new(chip->card, "Headphone",
-		     SND_JACK_HEADPHONE, &data->hp_jack);
+		     SND_JACK_HEADPHONE, &data->hp_jack, NULL);
 	xonar_ds_handle_hp_jack(chip);
 
 	snd_component_add(chip->card, "WM8776");
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 9f60c25..3c87e32 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -48,7 +48,7 @@ int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 	INIT_LIST_HEAD(&jack->jack_zones);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	ret = snd_jack_new(card->snd_card, id, type, &jack->jack);
+	ret = snd_jack_new(card->snd_card, id, type, &jack->jack, NULL);
 	if (ret)
 		return ret;
 
-- 
1.9.1
