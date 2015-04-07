From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v5 3/5] ALSA: hda - Update to use the new jack
	kctls method
Date: Tue,  7 Apr 2015 12:44:49 +0800
Message-ID: <1428381891-30517-4-git-send-email-yang.jie@intel.com>
References: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBEB26055E
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 06:41:54 +0200 (CEST)
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

In the new jack kctls design, snd_kcontrol is created during
snd_jack_kctl creating, then, we can wrap it in struct
hda_jack_tbl. The new method to create HDA jack kctl as
below:

1. call snd_jack_kctl_new()(in __snd_hda_jack_add_kctl()) to
new a jack_kctl(also new kctl), and use snd_hda_ctl_add to
add kctl to card;
2. new a hda_jack_tbl, appoint jack_kctl to jack_tbl->jack_kctl;
3. for non-phantom jack, call snd_jack_new() with this jack_kctl,
then the jack_kctl will be added to the new created jack;

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/pci/hda/hda_jack.c | 52 ++++++++++++++++++++++--------------------------
 sound/pci/hda/hda_jack.h |  4 +---
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 9397250..9a1ba35 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -132,11 +132,11 @@ void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 
 	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
 		struct hda_jack_callback *cb, *next;
-#ifdef CONFIG_SND_HDA_INPUT_JACK
+
 		/* free jack instances manually when clearing/reconfiguring */
 		if (!codec->bus->shutdown && jack->jack)
 			snd_device_free(codec->bus->card, jack->jack);
-#endif
+
 		for (cb = jack->callback; cb; cb = next) {
 			next = cb->next;
 			kfree(cb);
@@ -337,20 +337,16 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 	jack = codec->jacktbl.list;
 	for (i = 0; i < codec->jacktbl.used; i++, jack++)
 		if (jack->nid) {
-			if (!jack->kctl || jack->block_report)
+			if (!jack->jack_kctl || jack->block_report)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
-			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 			if (jack->jack)
 				snd_jack_report(jack->jack,
 						state ? jack->type : 0);
-#endif
 		}
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
 
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 /* guess the jack type from the pin-config */
 static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -371,13 +367,12 @@ static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 	}
 }
 
-static void hda_free_jack_priv(struct snd_jack *jack)
+static void hda_free_jack_priv(struct snd_jack_kctl *jack_kctl)
 {
-	struct hda_jack_tbl *jacks = jack->private_data;
+	struct hda_jack_tbl *jacks = jack_kctl->private_data;
 	jacks->nid = 0;
 	jacks->jack = NULL;
 }
-#endif
 
 /**
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
@@ -394,37 +389,38 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name, int idx, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
-	struct snd_kcontrol *kctl;
-	int err, state;
+	struct snd_jack_kctl *jack_kctl;
+	int err, state, type;
 
 	jack = snd_hda_jack_tbl_new(codec, nid);
 	if (!jack)
 		return 0;
-	if (jack->kctl)
+	if (jack->jack_kctl)
 		return 0; /* already created */
-	kctl = snd_kctl_jack_new(name, idx, codec);
-	if (!kctl)
+
+	type = get_input_jack_type(codec, nid);
+	jack_kctl = snd_jack_kctl_new(codec->bus->card, name, type);
+	if (!jack_kctl)
 		return -ENOMEM;
-	err = snd_hda_ctl_add(codec, nid, kctl);
+
+	err = snd_hda_ctl_add(codec, nid, jack_kctl->kctl);
 	if (err < 0)
 		return err;
-	jack->kctl = kctl;
+	jack->jack_kctl = jack_kctl;
 	jack->phantom_jack = !!phantom_jack;
 
 	state = snd_hda_jack_detect(codec, nid);
-	snd_kctl_jack_report(codec->bus->card, kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
+	snd_kctl_jack_report(codec->bus->card, jack_kctl->kctl, state);
 	if (!phantom_jack) {
-		jack->type = get_input_jack_type(codec, nid);
+		jack->type = type;
 		err = snd_jack_new(codec->bus->card, name, jack->type,
-				   &jack->jack, NULL);
+				   &jack->jack, jack_kctl);
 		if (err < 0)
 			return err;
-		jack->jack->private_data = jack;
-		jack->jack->private_free = hda_free_jack_priv;
+		jack->jack_kctl->private_data = jack;
+		jack->jack_kctl->private_free = hda_free_jack_priv;
 		snd_jack_report(jack->jack, state ? jack->type : 0);
 	}
-#endif
 	return 0;
 }
 
@@ -453,10 +449,10 @@ static int get_unique_index(struct hda_codec *codec, const char *name, int idx)
 	jack = codec->jacktbl.list;
 	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
 		/* jack->kctl.id contains "XXX Jack" name string with index */
-		if (jack->kctl &&
-		    !strncmp(name, jack->kctl->id.name, len) &&
-		    !strcmp(" Jack", jack->kctl->id.name + len) &&
-		    jack->kctl->id.index == idx) {
+		if (jack->jack_kctl->kctl &&
+		    !strncmp(name, jack->jack_kctl->kctl->id.name, len) &&
+		    !strcmp(" Jack", jack->jack_kctl->kctl->id.name + len) &&
+		    jack->jack_kctl->kctl->id.index == idx) {
 			idx++;
 			goto again;
 		}
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index b279e32..346a639 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -39,11 +39,9 @@ struct hda_jack_tbl {
 	unsigned int block_report:1;    /* in a transitional state - do not report to userspace */
 	hda_nid_t gating_jack;		/* valid when gating jack plugged */
 	hda_nid_t gated_jack;		/* gated is dependent on this jack */
-	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
+	struct snd_jack_kctl *jack_kctl;
 	struct snd_jack *jack;
-#endif
 };
 
 struct hda_jack_tbl *
-- 
1.9.1
