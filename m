From: libin.yang@linux.intel.com
Subject: [RFC PATCH 1/2] ALSA: hda - jack support DP MST audio
Date: Tue,  3 Nov 2015 16:42:55 +0800
Message-ID: <1446540176-110181-2-git-send-email-libin.yang@linux.intel.com>
References: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 89174265112
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:44:42 +0100 (CET)
In-Reply-To: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Add jack support for DP MST audio in hda_jack.c

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_jack.c   | 158 +++++++++++++++++++++++++++++++++++++++------
 sound/pci/hda/hda_jack.h   |  28 +++++++-
 sound/pci/hda/patch_hdmi.c |   2 +-
 3 files changed, 166 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 366efbf..c0a018b 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -47,7 +47,8 @@ bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 EXPORT_SYMBOL_GPL(is_jack_detectable);
 
 /* execute pin sense measurement */
-static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
+static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid,
+					hda_dev_t dev_id)
 {
 	u32 pincap;
 	u32 val;
@@ -59,7 +60,7 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 					AC_VERB_SET_PIN_SENSE, 0);
 	}
 	val = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_PIN_SENSE, 0);
+				  AC_VERB_GET_PIN_SENSE, dev_id);
 	if (codec->inv_jack_detect)
 		val ^= AC_PINSENSE_PRESENCE;
 	return val;
@@ -86,6 +87,28 @@ snd_hda_jack_tbl_get(struct hda_codec *codec, hda_nid_t nid)
 EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get);
 
 /**
+ * snd_hda_jack_tbl_get_mst - query the jack-table entry for the given NID
+ * @codec: the HDA codec
+ * @nid: pin NID to refer to
+ * @dev_id: device entry id
+ */
+struct hda_jack_tbl *
+snd_hda_jack_tbl_get_mst(struct hda_codec *codec, hda_nid_t nid,
+			hda_dev_t dev_id)
+{
+	struct hda_jack_tbl *jack = codec->jacktbl.list;
+	int i;
+
+	if (!nid || !jack)
+		return NULL;
+	for (i = 0; i < codec->jacktbl.used; i++, jack++)
+		if (jack->nid == nid && jack->dev_id == dev_id)
+			return jack;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get_mst);
+
+/**
  * snd_hda_jack_tbl_get_from_tag - query the jack-table entry for the given tag
  * @codec: the HDA codec
  * @tag: tag value to refer to
@@ -109,17 +132,20 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get_from_tag);
  * snd_hda_jack_tbl_new - create a jack-table entry for the given NID
  * @codec: the HDA codec
  * @nid: pin NID to assign
+ * @dev_id: device entry id
  */
 static struct hda_jack_tbl *
-snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
+snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id)
 {
-	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
+	struct hda_jack_tbl *jack =
+		snd_hda_jack_tbl_get_mst(codec, nid, dev_id);
 	if (jack)
 		return jack;
 	jack = snd_array_new(&codec->jacktbl);
 	if (!jack)
 		return NULL;
 	jack->nid = nid;
+	jack->dev_id = dev_id;
 	jack->jack_dirty = 1;
 	jack->tag = codec->jacktbl.used;
 	return jack;
@@ -157,9 +183,11 @@ static void jack_detect_update(struct hda_codec *codec,
 	if (jack->phantom_jack)
 		jack->pin_sense = AC_PINSENSE_PRESENCE;
 	else
-		jack->pin_sense = read_pin_sense(codec, jack->nid);
+		jack->pin_sense =
+			read_pin_sense(codec, jack->nid, jack->dev_id);
 
 	/* A gating jack indicates the jack is invalid if gating is unplugged */
+	/* fixme: MST audio doesn't using gating and gated jack. */
 	if (jack->gating_jack && !snd_hda_jack_detect(codec, jack->gating_jack))
 		jack->pin_sense &= ~AC_PINSENSE_PRESENCE;
 
@@ -198,18 +226,20 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_set_dirty_all);
  * snd_hda_pin_sense - execute pin sense measurement
  * @codec: the CODEC to sense
  * @nid: the pin NID to sense
+ * @dev_id: device entry id
  *
  * Execute necessary pin sense measurement and return its Presence Detect,
  * Impedance, ELD Valid etc. status bits.
  */
-u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
+u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id)
 {
-	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
+	struct hda_jack_tbl *jack =
+		snd_hda_jack_tbl_get_mst(codec, nid, dev_id);
 	if (jack) {
 		jack_detect_update(codec, jack);
 		return jack->pin_sense;
 	}
-	return read_pin_sense(codec, nid);
+	return read_pin_sense(codec, nid, dev_id);
 }
 EXPORT_SYMBOL_GPL(snd_hda_pin_sense);
 
@@ -226,7 +256,7 @@ int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid)
 	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get(codec, nid);
 	if (jack && jack->phantom_jack)
 		return HDA_JACK_PHANTOM;
-	else if (snd_hda_pin_sense(codec, nid) & AC_PINSENSE_PRESENCE)
+	else if (snd_hda_pin_sense(codec, nid, 0) & AC_PINSENSE_PRESENCE)
 		return HDA_JACK_PRESENT;
 	else
 		return HDA_JACK_NOT_PRESENT;
@@ -234,7 +264,31 @@ int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid)
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
 
 /**
- * snd_hda_jack_detect_enable - enable the jack-detection
+ * snd_hda_jack_detect_state_mst - query pin Presence Detect status in mst mode
+ * @codec: the CODEC to sense
+ * @nid: the pin NID to sense
+ * @dev_id: device entry id
+ *
+ * Query and return the device entry's Presence Detect status, as either
+ * HDA_JACK_NOT_PRESENT, HDA_JACK_PRESENT or HDA_JACK_PHANTOM.
+ */
+int snd_hda_jack_detect_state_mst(struct hda_codec *codec, hda_nid_t nid,
+					hda_dev_t dev_id)
+{
+	struct hda_jack_tbl *jack =
+		snd_hda_jack_tbl_get_mst(codec, nid, dev_id);
+
+	if (jack && jack->phantom_jack)
+		return HDA_JACK_PHANTOM;
+	else if (snd_hda_pin_sense(codec, nid, dev_id) & AC_PINSENSE_PRESENCE)
+		return HDA_JACK_PRESENT;
+	else
+		return HDA_JACK_NOT_PRESENT;
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state_mst);
+
+/**
+ * snd_hda_jack_detect_enable_callback - enable the jack-detection
  * @codec: the HDA codec
  * @nid: pin NID to enable
  * @func: callback function to register
@@ -251,7 +305,7 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 	struct hda_jack_callback *callback = NULL;
 	int err;
 
-	jack = snd_hda_jack_tbl_new(codec, nid);
+	jack = snd_hda_jack_tbl_new(codec, nid, 0);
 	if (!jack)
 		return ERR_PTR(-ENOMEM);
 	if (func) {
@@ -279,6 +333,52 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
 
 /**
+ * snd_hda_jack_detect_enable_callback_mst - enable the jack-detection for mst
+ * @codec: the HDA codec
+ * @nid: pin NID to enable
+ * @dev_id: device entry id
+ * @func: callback function to register
+ *
+ * In the case of error, the return value will be a pointer embedded with
+ * errno.  Check and handle the return value appropriately with standard
+ * macros such as @IS_ERR() and @PTR_ERR().
+ */
+struct hda_jack_callback *
+snd_hda_jack_detect_enable_callback_mst(struct hda_codec *codec, hda_nid_t nid,
+			hda_dev_t dev_id, hda_jack_callback_fn func)
+{
+	struct hda_jack_tbl *jack;
+	struct hda_jack_callback *callback = NULL;
+	int err;
+
+	jack = snd_hda_jack_tbl_new(codec, nid, dev_id);
+	if (!jack)
+		return ERR_PTR(-ENOMEM);
+	if (func) {
+		callback = kzalloc(sizeof(*callback), GFP_KERNEL);
+		if (!callback)
+			return ERR_PTR(-ENOMEM);
+		callback->func = func;
+		callback->tbl = jack;
+		callback->next = jack->callback;
+		jack->callback = callback;
+	}
+
+	if (jack->jack_detect)
+		return callback; /* already registered */
+	jack->jack_detect = 1;
+	if (codec->jackpoll_interval > 0)
+		return callback; /* No unsol if we're polling instead */
+	err = snd_hda_codec_write_cache(codec, nid, 0,
+					 AC_VERB_SET_UNSOLICITED_ENABLE,
+					 AC_USRSP_EN | jack->tag);
+	if (err < 0)
+		return ERR_PTR(err);
+	return callback;
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback_mst);
+
+/**
  * snd_hda_jack_detect_enable - Enable the jack detection on the given pin
  * @codec: the HDA codec
  * @nid: pin NID to enable jack detection
@@ -303,8 +403,9 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable);
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid)
 {
-	struct hda_jack_tbl *gated = snd_hda_jack_tbl_new(codec, gated_nid);
-	struct hda_jack_tbl *gating = snd_hda_jack_tbl_new(codec, gating_nid);
+	struct hda_jack_tbl *gated = snd_hda_jack_tbl_new(codec, gated_nid, 0);
+	struct hda_jack_tbl *gating =
+		snd_hda_jack_tbl_new(codec, gating_nid, 0);
 
 	if (!gated || !gating)
 		return -EINVAL;
@@ -369,6 +470,8 @@ static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 static void hda_free_jack_priv(struct snd_jack *jack)
 {
 	struct hda_jack_tbl *jacks = jack->private_data;
+	if (jacks == NULL)
+		return;
 	jacks->nid = 0;
 	jacks->jack = NULL;
 }
@@ -377,6 +480,7 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
  * @codec: the HDA codec
  * @nid: pin NID to assign
+ * @dev_id: device entry id
  * @name: string name for the jack
  * @phantom_jack: flag to deal as a phantom jack
  *
@@ -384,17 +488,18 @@ static void hda_free_jack_priv(struct snd_jack *jack)
  * will have the given name and index.
  */
 static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
-			  const char *name, bool phantom_jack)
+		hda_dev_t dev_id, const char *name, bool phantom_jack)
 {
 	struct hda_jack_tbl *jack;
 	int err, state, type;
 
-	jack = snd_hda_jack_tbl_new(codec, nid);
+	jack = snd_hda_jack_tbl_new(codec, nid, dev_id);
 	if (!jack)
 		return 0;
 	if (jack->jack)
 		return 0; /* already created */
 
+	/* all device entries use same pincfg */
 	type = get_input_jack_type(codec, nid);
 	err = snd_jack_new(codec->card, name, type,
 			   &jack->jack, true, phantom_jack);
@@ -405,7 +510,7 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	jack->type = type;
 	jack->jack->private_data = jack;
 	jack->jack->private_free = hda_free_jack_priv;
-	state = snd_hda_jack_detect(codec, nid);
+	state = snd_hda_jack_detect_mst(codec, nid, dev_id);
 	snd_jack_report(jack->jack, state ? jack->type : 0);
 
 	return 0;
@@ -422,10 +527,27 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name)
 {
-	return __snd_hda_jack_add_kctl(codec, nid, name, false);
+	return __snd_hda_jack_add_kctl(codec, nid, 0, name, false);
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl);
 
+/**
+ * snd_hda_jack_add_kctl_mst - Add a jack kctl for the given pin for mst mode
+ * @codec: the HDA codec
+ * @nid: pin NID
+ * @dev_id: device entry id
+ * @name: the name string for the jack ctl
+ *
+ * This is a simple helper calling __snd_hda_jack_add_kctl().
+ */
+int snd_hda_jack_add_kctl_mst(struct hda_codec *codec, hda_nid_t nid,
+			hda_dev_t dev_id, const char *name)
+{
+	return __snd_hda_jack_add_kctl(codec, nid, dev_id, name, false);
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl_mst);
+
+
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 			 const struct auto_pin_cfg *cfg,
 			 const char *base_name)
@@ -451,7 +573,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 	if (phantom_jack)
 		/* Example final name: "Internal Mic Phantom Jack" */
 		strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
-	err = __snd_hda_jack_add_kctl(codec, nid, name, phantom_jack);
+	err = __snd_hda_jack_add_kctl(codec, nid, 0, name, phantom_jack);
 	if (err < 0)
 		return err;
 
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 387d309..c9d4f8e 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -29,6 +29,7 @@ struct hda_jack_callback {
 
 struct hda_jack_tbl {
 	hda_nid_t nid;
+	hda_dev_t dev_id;
 	unsigned char tag;		/* unsol event tag */
 	struct hda_jack_callback *callback;
 	/* jack-detection stuff */
@@ -46,6 +47,9 @@ struct hda_jack_tbl {
 struct hda_jack_tbl *
 snd_hda_jack_tbl_get(struct hda_codec *codec, hda_nid_t nid);
 struct hda_jack_tbl *
+snd_hda_jack_tbl_get_mst(struct hda_codec *codec, hda_nid_t nid,
+				 hda_dev_t dev_id);
+struct hda_jack_tbl *
 snd_hda_jack_tbl_get_from_tag(struct hda_codec *codec, unsigned char tag);
 
 void snd_hda_jack_tbl_clear(struct hda_codec *codec);
@@ -56,11 +60,14 @@ int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid);
 struct hda_jack_callback *
 snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 				    hda_jack_callback_fn cb);
+struct hda_jack_callback *
+snd_hda_jack_detect_enable_callback_mst(struct hda_codec *codec, hda_nid_t nid,
+			hda_dev_t dev_id, hda_jack_callback_fn func);
 
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid);
 
-u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid);
+u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id);
 
 /* the jack state returned from snd_hda_jack_detect_state() */
 enum {
@@ -68,7 +75,8 @@ enum {
 };
 
 int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid);
-
+int snd_hda_jack_detect_state_mst(struct hda_codec *codec,
+					hda_nid_t nid, hda_dev_t dev_id);
 /**
  * snd_hda_jack_detect - Detect the jack
  * @codec: the HDA codec
@@ -79,13 +87,27 @@ static inline bool snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
 	return snd_hda_jack_detect_state(codec, nid) != HDA_JACK_NOT_PRESENT;
 }
 
+/**
+ * snd_hda_jack_detect - Detect the jack
+ * @codec: the HDA codec
+ * @nid: pin NID to check jack detection
+ * @dev_id: device entry id
+ */
+static inline bool snd_hda_jack_detect_mst(struct hda_codec *codec,
+				hda_nid_t nid, hda_dev_t dev_id)
+{
+	return (snd_hda_jack_detect_state_mst(codec, nid, dev_id) !=
+			HDA_JACK_NOT_PRESENT);
+}
+
 bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);
-
+int snd_hda_jack_add_kctl_mst(struct hda_codec *codec, hda_nid_t nid,
+			   hda_dev_t dev_id, const char *name);
 void snd_hda_jack_report_sync(struct hda_codec *codec);
 
 void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8d31366..39d68ba 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1664,7 +1664,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	bool ret;
 
 	snd_hda_power_up_pm(codec);
-	present = snd_hda_pin_sense(codec, pin_nid);
+	present = snd_hda_pin_sense(codec, pin_nid, 0);
 
 	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
-- 
1.9.1
