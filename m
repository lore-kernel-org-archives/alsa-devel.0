From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v8 4/7] ALSA: hda - Update to use the new jack
	kctls method
Date: Wed, 22 Apr 2015 14:03:50 +0800
Message-ID: <1429682633-10765-5-git-send-email-yang.jie@intel.com>
References: <1429682633-10765-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F9F2265AE1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 08:00:36 +0200 (CEST)
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

In the new jack kctls design, snd_kcontrol can be created
during snd_jack_new(), or calling snd_jack_add_new_kctls()
to create and attach to the created jack later.

Here we create jack kctls at the jack creating stage, for
both phantom/non-phantom jack.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/pci/hda/hda_jack.c   | 90 +++++++++++++---------------------------------
 sound/pci/hda/hda_jack.h   |  5 +--
 sound/pci/hda/patch_hdmi.c |  2 +-
 3 files changed, 27 insertions(+), 70 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 5314c73..6aeb29d 100644
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
@@ -337,20 +337,15 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 	jack = codec->jacktbl.list;
 	for (i = 0; i < codec->jacktbl.used; i++, jack++)
 		if (jack->nid) {
-			if (!jack->kctl || jack->block_report)
+			if (!jack->jack || jack->block_report)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
-			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
-			if (jack->jack)
-				snd_jack_report(jack->jack,
-						state ? jack->type : 0);
-#endif
+			snd_jack_report(jack->jack,
+					state ? jack->type : 0);
 		}
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
 
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 /* guess the jack type from the pin-config */
 static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -377,54 +372,42 @@ static void hda_free_jack_priv(struct snd_jack *jack)
 	jacks->nid = 0;
 	jacks->jack = NULL;
 }
-#endif
 
 /**
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
  * @codec: the HDA codec
  * @nid: pin NID to assign
  * @name: string name for the jack
- * @idx: index number for the jack
  * @phantom_jack: flag to deal as a phantom jack
  *
  * This assigns a jack-detection kctl to the given pin.  The kcontrol
  * will have the given name and index.
  */
 static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx, bool phantom_jack)
+			  const char *name, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
-	struct snd_kcontrol *kctl;
-	int err, state;
+	int err, state, type;
 
 	jack = snd_hda_jack_tbl_new(codec, nid);
 	if (!jack)
 		return 0;
-	if (jack->kctl)
+	if (jack->jack)
 		return 0; /* already created */
-	kctl = snd_kctl_jack_new(name, codec);
-	if (!kctl)
-		return -ENOMEM;
-	err = snd_hda_ctl_add(codec, nid, kctl);
+
+	type = get_input_jack_type(codec, nid);
+	err = snd_jack_new(codec->bus->card, name, type,
+			   &jack->jack, true, phantom_jack);
 	if (err < 0)
 		return err;
-	jack->kctl = kctl;
-	jack->phantom_jack = !!phantom_jack;
 
+	jack->phantom_jack = !!phantom_jack;
+	jack->type = type;
+	jack->jack->private_data = jack;
+	jack->jack->private_free = hda_free_jack_priv;
 	state = snd_hda_jack_detect(codec, nid);
-	snd_kctl_jack_report(codec->bus->card, kctl, state);
-#ifdef CONFIG_SND_HDA_INPUT_JACK
-	if (!phantom_jack) {
-		jack->type = get_input_jack_type(codec, nid);
-		err = snd_jack_new(codec->bus->card, name, jack->type,
-				   &jack->jack, false, false);
-		if (err < 0)
-			return err;
-		jack->jack->private_data = jack;
-		jack->jack->private_free = hda_free_jack_priv;
-		snd_jack_report(jack->jack, state ? jack->type : 0);
-	}
-#endif
+	snd_jack_report(jack->jack, state ? jack->type : 0);
+
 	return 0;
 }
 
@@ -433,44 +416,23 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
  * @codec: the HDA codec
  * @nid: pin NID
  * @name: the name string for the jack ctl
- * @idx: the ctl index for the jack ctl
  *
  * This is a simple helper calling __snd_hda_jack_add_kctl().
  */
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx)
+			  const char *name)
 {
-	return __snd_hda_jack_add_kctl(codec, nid, name, idx, false);
+	return __snd_hda_jack_add_kctl(codec, nid, name, false);
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);
 
-/* get the unique index number for the given kctl name */
-static int get_unique_index(struct hda_codec *codec, const char *name, int idx)
-{
-	struct hda_jack_tbl *jack;
-	int i, len = strlen(name);
- again:
-	jack = codec->jacktbl.list;
-	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
-		/* jack->kctl.id contains "XXX Jack" name string with index */
-		if (jack->kctl &&
-		    !strncmp(name, jack->kctl->id.name, len) &&
-		    !strcmp(" Jack", jack->kctl->id.name + len) &&
-		    jack->kctl->id.index == idx) {
-			idx++;
-			goto again;
-		}
-	}
-	return idx;
-}
-
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 			 const struct auto_pin_cfg *cfg,
 			 const char *base_name)
 {
 	unsigned int def_conf, conn;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	int idx, err;
+	int err;
 	bool phantom_jack;
 
 	if (!nid)
@@ -482,16 +444,14 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	phantom_jack = (conn != AC_JACK_PORT_COMPLEX) ||
 		       !is_jack_detectable(codec, nid);
 
-	if (base_name) {
+	if (base_name)
 		strlcpy(name, base_name, sizeof(name));
-		idx = 0;
-	} else
-		snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), &idx);
+	else
+		snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), NULL);
 	if (phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
-	idx = get_unique_index(codec, name, idx);
-	err = __snd_hda_jack_add_kctl(codec, nid, name, idx, phantom_jack);
+	err = __snd_hda_jack_add_kctl(codec, nid, name, phantom_jack);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index b279e32..387d309 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -39,11 +39,8 @@ struct hda_jack_tbl {
 	unsigned int block_report:1;    /* in a transitional state - do not report to userspace */
 	hda_nid_t gating_jack;		/* valid when gating jack plugged */
 	hda_nid_t gated_jack;		/* gated is dependent on this jack */
-	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
-#ifdef CONFIG_SND_HDA_INPUT_JACK
 	int type;
 	struct snd_jack *jack;
-#endif
 };
 
 struct hda_jack_tbl *
@@ -85,7 +82,7 @@ static inline bool snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
 bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, int idx);
+			  const char *name);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b422e40..1679337 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2089,7 +2089,7 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
 		strncat(hdmi_str, " Phantom",
 			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
 
-	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str, 0);
+	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str);
 }
 
 static int generic_hdmi_build_controls(struct hda_codec *codec)
-- 
1.9.1
