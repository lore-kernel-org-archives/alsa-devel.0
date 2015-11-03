From: libin.yang@linux.intel.com
Subject: [RFC PATCH 2/2] ALSA: hda - hdmi audio add dynamically
	jack binding to pin
Date: Tue,  3 Nov 2015 16:42:56 +0800
Message-ID: <1446540176-110181-3-git-send-email-libin.yang@linux.intel.com>
References: <1446540176-110181-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 75007265148
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 09:44:44 +0100 (CET)
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

Jack is attached to PCM statically.

When there is monitor connected, dynamically
bind the Jack to pin based on the PCM assignment.

When monitor is disconnected, unbind the jack from the pin.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_jack.c   |  30 +++++++++++-
 sound/pci/hda/hda_jack.h   |   4 ++
 sound/pci/hda/patch_hdmi.c | 111 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 120 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index c0a018b..a4a5398 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -134,7 +134,7 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get_from_tag);
  * @nid: pin NID to assign
  * @dev_id: device entry id
  */
-static struct hda_jack_tbl *
+struct hda_jack_tbl *
 snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id)
 {
 	struct hda_jack_tbl *jack =
@@ -150,6 +150,7 @@ snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id)
 	jack->tag = codec->jacktbl.used;
 	return jack;
 }
+EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_new);
 
 void snd_hda_jack_tbl_clear(struct hda_codec *codec)
 {
@@ -517,6 +518,32 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 }
 
 /**
+ * snd_hda_jack_new - create a new snd_jack
+ * @codec: the HDA codec
+ * @jack: Used to provide the allocated jack object to the caller.
+ * @type:  a bitmask of enum snd_jack_type values that can be detected by
+ *         this jack
+ * @id:    an identifying string for this jack
+ * @phantom_jack: Don't create a input device for phantom jacks.
+ *
+ * Return: Zero if successful, or a negative error code on failure.
+ * On success @jack will be initialised.
+ */
+int snd_hda_jack_new(struct hda_codec *codec, struct snd_jack **jack, int type,
+					 const char *id, bool phantom_jack)
+{
+	int err;
+
+	err = snd_jack_new(codec->card, id, type,
+					   jack, true, phantom_jack);
+	if (err < 0)
+		return err;
+	(*jack)->private_free = hda_free_jack_priv;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hda_jack_new);
+
+/**
  * snd_hda_jack_add_kctl - Add a jack kctl for the given pin
  * @codec: the HDA codec
  * @nid: pin NID
@@ -547,7 +574,6 @@ int snd_hda_jack_add_kctl_mst(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_add_kctl_mst);
 
-
 static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 			 const struct auto_pin_cfg *cfg,
 			 const char *base_name)
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index c9d4f8e..cb79703 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -51,6 +51,8 @@ snd_hda_jack_tbl_get_mst(struct hda_codec *codec, hda_nid_t nid,
 				 hda_dev_t dev_id);
 struct hda_jack_tbl *
 snd_hda_jack_tbl_get_from_tag(struct hda_codec *codec, unsigned char tag);
+struct hda_jack_tbl *
+snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid, hda_dev_t dev_id);
 
 void snd_hda_jack_tbl_clear(struct hda_codec *codec);
 
@@ -104,6 +106,8 @@ bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name);
+int snd_hda_jack_new(struct hda_codec *codec, struct snd_jack **jack, int type,
+					 const char *id, bool phantom_jack);
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg);
 int snd_hda_jack_add_kctl_mst(struct hda_codec *codec, hda_nid_t nid,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 39d68ba..c58cf71 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -143,6 +143,7 @@ struct hdmi_spec {
 	unsigned long pcm_bitmap;
 	struct mutex pcm_lock;
 	int pcm_used;	/* counter of pcm_rec[] */
+	struct snd_jack *jack[16];
 	int dev_num;
 	unsigned int channels_max; /* max over all cvts */
 
@@ -371,14 +372,19 @@ static struct cea_channel_speaker_allocation channel_allocations[] = {
 	((struct hdmi_spec_per_cvt  *)snd_array_elem(&spec->cvts, idx))
 #define get_pcm_rec(spec, idx)	((spec)->pcm_rec[idx])
 
-static int pin_nid_to_pin_index(struct hda_codec *codec, hda_nid_t pin_nid)
+static int pin_id_to_pin_index(struct hda_codec *codec,
+				hda_nid_t pin_nid, hda_dev_t dev_id)
 {
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx;
+	struct hdmi_spec_per_pin *per_pin;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
-		if (get_pin(spec, pin_idx)->pin_nid == pin_nid)
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		per_pin = get_pin(spec, pin_idx);
+		if ((per_pin->pin_nid == pin_nid) &&
+			(per_pin->dev_id == dev_id))
 			return pin_idx;
+	}
 
 	codec_warn(codec, "HDMI: pin nid %d not registered\n", pin_nid);
 	return -EINVAL;
@@ -1184,13 +1190,15 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
 
-static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
+static void check_presence_and_report(struct hda_codec *codec,
+						hda_nid_t nid, hda_dev_t dev_id)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int pin_idx = pin_nid_to_pin_index(codec, nid);
+	int pin_idx = pin_id_to_pin_index(codec, nid, dev_id);
 
 	if (pin_idx < 0)
 		return;
+
 	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
 		snd_hda_jack_report_sync(codec);
 }
@@ -1198,7 +1206,7 @@ static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
 static void jack_callback(struct hda_codec *codec,
 			  struct hda_jack_callback *jack)
 {
-	check_presence_and_report(codec, jack->tbl->nid);
+	check_presence_and_report(codec, jack->tbl->nid, jack->tbl->dev_id);
 }
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -1217,7 +1225,7 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 		codec->addr, jack->nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
-	check_presence_and_report(codec, jack->nid);
+	check_presence_and_report(codec, jack->nid, jack->dev_id);
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -1642,6 +1650,50 @@ static void hdmi_detach_hda_pcm(struct hdmi_spec *spec,
 	}
 }
 
+/**
+ * snd_hda_jack_bind
+ */
+static void snd_hda_jack_bind(struct hda_codec *codec,
+					  struct hda_jack_tbl *jack,
+					  struct hdmi_spec_per_pin *per_pin)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int state;
+
+	if (per_pin->pcm_idx < 0 || per_pin->pcm_idx >= spec->pcm_used) {
+		codec_warn(codec, "HDMI: pin nid %d dev: %d bind jack fail\n",
+				   per_pin->pin_nid, per_pin->dev_id);
+		return;
+	}
+
+	mutex_lock(&spec->pcm_lock);
+	jack->jack = spec->jack[per_pin->pcm_idx];
+	if (jack->jack == NULL) {
+		mutex_unlock(&spec->pcm_lock);
+		return;
+	}
+
+	jack->jack->private_data = jack;
+	state = snd_hda_jack_detect_mst(codec, per_pin->pin_nid,
+						per_pin->dev_id);
+	snd_jack_report(jack->jack, state ? jack->type : 0);
+	mutex_unlock(&spec->pcm_lock);
+}
+
+static void snd_hda_jack_unbind(struct hda_codec *codec,
+					struct hda_jack_tbl *jack)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	if (jack->jack == NULL)
+		return;
+	mutex_lock(&spec->pcm_lock);
+	snd_jack_report(jack->jack, 0);
+	jack->jack->private_data = NULL;
+	jack->jack = NULL;
+	mutex_unlock(&spec->pcm_lock);
+}
+
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_jack_tbl *jack;
@@ -1677,6 +1729,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, pin_eld->monitor_present, eld->eld_valid);
 
+	jack = snd_hda_jack_tbl_get_mst(codec, pin_nid, per_pin->dev_id);
 	if (eld->eld_valid) {
 		if (spec->ops.pin_get_eld(codec, pin_nid, eld->eld_buffer,
 						     &eld->eld_size) < 0)
@@ -1698,12 +1751,14 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			goto unlock;
 		}
 	}
-
 	/* need be protected by spec->lock */
-	if (eld->eld_valid)
+	if (eld->eld_valid) {
 		hdmi_attach_hda_pcm(spec, per_pin);
-	else
+		snd_hda_jack_bind(codec, jack, per_pin);
+	} else {
+		snd_hda_jack_unbind(codec, jack);
 		hdmi_detach_hda_pcm(spec, per_pin);
+	}
 
 	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
@@ -1750,7 +1805,6 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
  unlock:
 	ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;
 
-	jack = snd_hda_jack_tbl_get(codec, pin_nid);
 	if (jack)
 		jack->block_report = !ret;
 
@@ -2234,20 +2288,18 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
-static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
+static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 {
 	char hdmi_str[32] = "HDMI/DP";
 	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-	int pcmdev = get_pcm_rec(spec, pin_idx)->device;
+	int pcmdev = get_pcm_rec(spec, pcm_idx)->device;
 
 	if (pcmdev > 0)
 		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d", pcmdev);
-	if (!is_jack_detectable(codec, per_pin->pin_nid))
-		strncat(hdmi_str, " Phantom",
-			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
 
-	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str);
+	/* fixme: create the jack: it always SND_JACK_AVOUT, non-phantom */
+	return snd_hda_jack_new(codec, &spec->jack[pcm_idx],
+				SND_JACK_AVOUT, hdmi_str, false);
 }
 
 static int generic_hdmi_build_controls(struct hda_codec *codec)
@@ -2255,13 +2307,26 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 	struct hdmi_spec *spec = codec->spec;
 	int err;
 	int pin_idx;
+	int i;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
-		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-
-		err = generic_hdmi_build_jack(codec, pin_idx);
+	/* create snd_jack saved in spec->jack[] */
+	for (i = 0; i < spec->pcm_used; i++) {
+		err = generic_hdmi_build_jack(codec, i);
 		if (err < 0)
 			return err;
+	}
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+		struct hda_jack_tbl *jack;
+
+		jack = snd_hda_jack_tbl_new(codec, per_pin->pin_nid,
+						per_pin->dev_id);
+		if (jack != NULL) {
+			jack->phantom_jack = false;
+			jack->type = SND_JACK_AVOUT;
+			jack->jack = NULL;
+		}
 
 		err = snd_hda_create_dig_out_ctls(codec,
 						  per_pin->pin_nid,
@@ -2492,7 +2557,7 @@ static void intel_pin_eld_notify(void *audio_ptr, int port)
 	struct hda_codec *codec = audio_ptr;
 	int pin_nid = port + 0x04;
 
-	check_presence_and_report(codec, pin_nid);
+	check_presence_and_report(codec, pin_nid, 0);
 }
 
 static int patch_generic_hdmi(struct hda_codec *codec)
-- 
1.9.1
