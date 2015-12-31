From: libin.yang@linux.intel.com
Subject: [PATCH 4/4] ALSA: hda - hdmi monitor hotplug support
	for dynamic pcm assignment
Date: Thu, 31 Dec 2015 09:22:22 +0800
Message-ID: <1451524942-17288-5-git-send-email-libin.yang@linux.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E6F7B265AD8
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 02:25:26 +0100 (CET)
In-Reply-To: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patch adds the support for monitor hotplug of dynamic pcm assignment.

1. unsol_event enabling
 - For codec_has_acomp, unsol_event is disabled.
 - For !codec_has_acomp && !dyn_pcm_assign, use the hda_jack helper to
   enable unsol_event
 - For !codec_has_acomp && dyn_pcm_assign, enable unsol_event with verb
   directly

2. unsol_event handling
 - For !dyn_pcm_assign, use hda_jack helper to report the event
 - For dyn_pcm_assign, use snd_jack_report() directly

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 97 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 81 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 356ae04..293b0e3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -87,6 +87,7 @@ struct hdmi_spec_per_pin {
 	struct snd_kcontrol *eld_ctl;
 	struct hdmi_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
 	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
+	int unsol_tag;
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -1229,23 +1230,44 @@ static void jack_callback(struct hda_codec *codec,
 	check_presence_and_report(codec, jack->tbl->nid);
 }
 
+static hda_nid_t hdmi_get_nid_from_tag(struct hda_codec *codec, int tag)
+{
+	int pin_idx;
+	struct hdmi_spec *spec = codec->spec;
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+
+		if (per_pin->unsol_tag == tag)
+			return per_pin->pin_nid;
+	}
+	/* this will never happen, tag is checked before */
+	return 0;
+}
+
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
 	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	struct hda_jack_tbl *jack;
+	struct hdmi_spec *spec = codec->spec;
 	int dev_entry = (res & AC_UNSOL_RES_DE) >> AC_UNSOL_RES_DE_SHIFT;
+	hda_nid_t nid;
 
-	jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
-	if (!jack)
-		return;
-	jack->jack_dirty = 1;
+	if (!spec->dyn_pcm_assign) {
+		jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
+		if (!jack)
+			return;
+		jack->jack_dirty = 1;
+		nid = jack->nid;
+	} else
+		nid = hdmi_get_nid_from_tag(codec, tag);
 
 	codec_dbg(codec,
 		"HDMI hot plug event: Codec=%d Pin=%d Device=%d Inactive=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, jack->nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
+		codec->addr, nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
-	check_presence_and_report(codec, jack->nid);
+	check_presence_and_report(codec, nid);
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -1270,13 +1292,30 @@ static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
 		;
 }
 
+static bool hdmi_unsol_tag_is_valid(struct hda_codec *codec, int tag)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int i;
+
+	if (!spec->dyn_pcm_assign) {
+		if (snd_hda_jack_tbl_get_from_tag(codec, tag))
+			return true;
+	} else {
+		for (i = 0; i < spec->num_pins; i++) {
+			if (get_pin(spec, i)->unsol_tag == tag)
+				return true;
+		}
+	}
+
+	return false;
+}
 
 static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
 	int subtag = (res & AC_UNSOL_RES_SUBTAG) >> AC_UNSOL_RES_SUBTAG_SHIFT;
 
-	if (!snd_hda_jack_tbl_get_from_tag(codec, tag)) {
+	if (!hdmi_unsol_tag_is_valid(codec, tag)) {
 		codec_dbg(codec, "Unexpected HDMI event tag 0x%x\n", tag);
 		return;
 	}
@@ -1875,7 +1914,8 @@ static void update_eld(struct hda_codec *codec,
 static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 					 int repoll)
 {
-	struct hda_jack_tbl *jack;
+	struct hda_jack_tbl *jack = NULL;
+	struct snd_jack *sjack = NULL;
 	struct hda_codec *codec = per_pin->codec;
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
@@ -1890,7 +1930,7 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	 * the unsolicited response to avoid custom WARs.
 	 */
 	int present;
-	bool ret;
+	bool ret = false;
 	bool do_repoll = false;
 
 	snd_hda_power_up_pm(codec);
@@ -1920,14 +1960,26 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 			do_repoll = true;
 	}
 
+	if (spec->dyn_pcm_assign && per_pin->pcm_idx >= 0) {
+		sjack = spec->pcm_rec[per_pin->pcm_idx].jack;
+		snd_jack_report(sjack,
+			pin_eld->monitor_present ? SND_JACK_AVOUT : 0);
+	}
+
 	if (do_repoll)
 		schedule_delayed_work(&per_pin->work, msecs_to_jiffies(300));
 	else
 		update_eld(codec, per_pin, eld);
 
-	ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;
-
-	jack = snd_hda_jack_tbl_get(codec, pin_nid);
+	if (!spec->dyn_pcm_assign) {
+		ret = !repoll || !pin_eld->monitor_present ||
+			pin_eld->eld_valid;
+		jack = snd_hda_jack_tbl_get(codec, pin_nid);
+	} else if (per_pin->pcm_idx >= 0 && !sjack) {
+		sjack = spec->pcm_rec[per_pin->pcm_idx].jack;
+		snd_jack_report(sjack,
+			pin_eld->monitor_present ? SND_JACK_AVOUT : 0);
+	}
 	if (jack)
 		jack->block_report = !ret;
 
@@ -2511,7 +2563,7 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 {
 	char hdmi_str[32] = "HDMI/DP";
 	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pcm_idx);
 	struct hda_jack_tbl *jack;
 	int pcmdev = get_pcm_rec(spec, pcm_idx).pcm->device;
 	bool phantom_jack;
@@ -2526,7 +2578,7 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 		 * This means pcms and pins are statically mapped.
 		 * And pcm_idx is pin_idx.
 		 */
-		per_pin = get_pin(spec, pcm_idx);
+
 		phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
 		if (phantom_jack)
 			strncat(hdmi_str, " Phantom",
@@ -2540,10 +2592,17 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 			return 0;
 		/* statically bind jack */
 		spec->pcm_rec[pcm_idx].jack = jack->jack;
+		per_pin->unsol_tag = jack->tag;
 		return 0;
 	}
 
-	return add_hdmi_jack_kctl(codec, spec, pcm_idx, hdmi_str);
+	per_pin->unsol_tag = per_pin->pin_nid_idx + 1;
+	ret = add_hdmi_jack_kctl(codec, spec, pcm_idx, hdmi_str);
+	if (!codec_has_acomp(codec))
+		snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
+				AC_VERB_SET_UNSOLICITED_ENABLE,
+				AC_USRSP_EN | per_pin->unsol_tag);
+	return ret;
 }
 
 static int generic_hdmi_build_controls(struct hda_codec *codec)
@@ -2636,7 +2695,13 @@ static int generic_hdmi_init(struct hda_codec *codec)
 		hda_nid_t pin_nid = per_pin->pin_nid;
 
 		hdmi_init_pin(codec, pin_nid);
-		if (!codec_has_acomp(codec))
+		/* if codec_has_acomp, will not enable unsol event
+		 * if !codec_has_acomp && ! dyn_pcm_assign,
+		 *  will use hda_jack
+		 * if !codec_has_acomp && dyn_pcm_assign,
+		 * enable unsol_event when building jack
+		 */
+		if (!codec_has_acomp(codec) && !spec->dyn_pcm_assign)
 			snd_hda_jack_detect_enable_callback(codec, pin_nid,
 				codec->jackpoll_interval > 0 ?
 				jack_callback : NULL);
-- 
1.9.1
