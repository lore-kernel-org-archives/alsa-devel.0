From: libin.yang@linux.intel.com
Subject: [PATCH 3/4] ALSA: hda - hdmi jack created based on pcm
Date: Thu, 31 Dec 2015 09:22:21 +0800
Message-ID: <1451524942-17288-4-git-send-email-libin.yang@linux.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E483265AE1
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

Jack is created based on pcm.

For dyn_pcm_assign:
 Driver will not use hda_jack. It will operate snd_jack directly.
 snd_jack pointer will be stored in spec->pcm.jack. When pcm is
 assigned to pin, jack will be assigned to pin automatically.
For !dyn_pcm_assign:
 Driver will continue using hda_jack for less impact on the old cases.
 Pcm is statically assigned to pin. So is jack. spec->pcm.jack will
 save the snd_jack pointer created in hda_jack.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 96 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5549ddf..356ae04 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -85,7 +85,6 @@ struct hdmi_spec_per_pin {
 	struct mutex lock;
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
-	struct snd_jack *acomp_jack; /* jack via audio component */
 	struct hdmi_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
 	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
 	int repoll_count;
@@ -1943,6 +1942,7 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 {
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
+	struct snd_jack *jack = NULL;
 	int size;
 
 	mutex_lock(&per_pin->lock);
@@ -1966,8 +1966,18 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 		eld->eld_size = 0;
 	}
 
+	/* pcm_idx >=0 before update_eld() means it is in monitor
+	 * disconnected event. Jack must be fetched before update_eld()
+	 * Get jack before update_eld()
+	 */
+	if (per_pin->pcm_idx >= 0)
+		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
 	update_eld(codec, per_pin, eld);
-	snd_jack_report(per_pin->acomp_jack,
+	if (jack == NULL && per_pin->pcm_idx >= 0)
+		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
+	if (jack == NULL)
+		goto unlock;
+	snd_jack_report(jack,
 			eld->monitor_present ? SND_JACK_AVOUT : 0);
  unlock:
 	mutex_unlock(&per_pin->lock);
@@ -2471,15 +2481,16 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
-static void free_acomp_jack_priv(struct snd_jack *jack)
+static void free_hdmi_jack_priv(struct snd_jack *jack)
 {
-	struct hdmi_spec_per_pin *per_pin = jack->private_data;
+	struct hdmi_pcm *pcm = jack->private_data;
 
-	per_pin->acomp_jack = NULL;
+	pcm->jack = NULL;
 }
 
-static int add_acomp_jack_kctl(struct hda_codec *codec,
-			       struct hdmi_spec_per_pin *per_pin,
+static int add_hdmi_jack_kctl(struct hda_codec *codec,
+			       struct hdmi_spec *spec,
+			       int pcm_idx,
 			       const char *name)
 {
 	struct snd_jack *jack;
@@ -2489,45 +2500,67 @@ static int add_acomp_jack_kctl(struct hda_codec *codec,
 			   true, false);
 	if (err < 0)
 		return err;
-	per_pin->acomp_jack = jack;
-	jack->private_data = per_pin;
-	jack->private_free = free_acomp_jack_priv;
+
+	spec->pcm_rec[pcm_idx].jack = jack;
+	jack->private_data = &spec->pcm_rec[pcm_idx];
+	jack->private_free = free_hdmi_jack_priv;
 	return 0;
 }
 
-static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
+static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 {
 	char hdmi_str[32] = "HDMI/DP";
 	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-	int pcmdev = get_pcm_rec(spec, pin_idx).pcm->device;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hda_jack_tbl *jack;
+	int pcmdev = get_pcm_rec(spec, pcm_idx).pcm->device;
 	bool phantom_jack;
+	int ret;
 
 	if (pcmdev > 0)
 		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d", pcmdev);
-	if (codec_has_acomp(codec))
-		return add_acomp_jack_kctl(codec, per_pin, hdmi_str);
-	phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
-	if (phantom_jack)
-		strncat(hdmi_str, " Phantom",
-			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
 
-	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str,
-				     phantom_jack);
+	/* for !dyn_pcm_assign, we still use hda_jack for compatibility */
+	if (!spec->dyn_pcm_assign) {
+		/* if not dyn_pcm_assign, it must be non-MST mode.
+		 * This means pcms and pins are statically mapped.
+		 * And pcm_idx is pin_idx.
+		 */
+		per_pin = get_pin(spec, pcm_idx);
+		phantom_jack = !is_jack_detectable(codec, per_pin->pin_nid);
+		if (phantom_jack)
+			strncat(hdmi_str, " Phantom",
+				sizeof(hdmi_str) - strlen(hdmi_str) - 1);
+		ret = snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str,
+					    phantom_jack);
+		if (ret < 0)
+			return ret;
+		jack = snd_hda_jack_tbl_get(codec, per_pin->pin_nid);
+		if (jack == NULL)
+			return 0;
+		/* statically bind jack */
+		spec->pcm_rec[pcm_idx].jack = jack->jack;
+		return 0;
+	}
+
+	return add_hdmi_jack_kctl(codec, spec, pcm_idx, hdmi_str);
 }
 
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
 	int err;
-	int pin_idx;
+	int pin_idx, pcm_idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
-		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 
-		err = generic_hdmi_build_jack(codec, pin_idx);
+	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
+		err = generic_hdmi_build_jack(codec, pcm_idx);
 		if (err < 0)
 			return err;
+	}
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 
 		err = snd_hda_create_dig_out_ctls(codec,
 						  per_pin->pin_nid,
@@ -2626,18 +2659,23 @@ static void hdmi_array_free(struct hdmi_spec *spec)
 static void generic_hdmi_free(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int pin_idx;
+	int pin_idx, pcm_idx;
 
 	if (codec_has_acomp(codec))
 		snd_hdac_i915_register_notifier(NULL);
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-
 		cancel_delayed_work_sync(&per_pin->work);
 		eld_proc_free(per_pin);
-		if (per_pin->acomp_jack)
-			snd_device_free(codec->card, per_pin->acomp_jack);
+	}
+
+	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++) {
+		if (spec->dyn_pcm_assign)
+			snd_device_free(codec->card,
+					spec->pcm_rec[pcm_idx].jack);
+		else
+			spec->pcm_rec[pcm_idx].jack = NULL;
 	}
 
 	if (spec->i915_bound)
-- 
1.9.1
