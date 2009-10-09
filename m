From: <LoganLi@viatech.com.cn>
Subject: [PATCH 10/30] ALSA: HDA VIA: Add smart5.1 function.
Date: Fri, 9 Oct 2009 18:40:25 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C37@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B326103AEC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:20 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Add smart5.1 function.

Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
While off, they act as "line out" / "line in" / "mic in".
While on, they acts as "line out" / "back left/right" / "center/lfe".

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |  177
++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 173 insertions(+), 4 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -211,7 +211,7 @@
 
 struct via_spec {
 	/* codec parameterization */
-	struct snd_kcontrol_new *mixers[3];
+	struct snd_kcontrol_new *mixers[4];
 	unsigned int num_mixers;
 
 	struct hda_verb *init_verbs[5];
@@ -253,6 +253,7 @@
 	const struct hda_input_mux *hp_mux;
 	unsigned int hp_independent_mode;
 	unsigned int hp_independent_mode_index;
+	unsigned int smart51_enabled;
 
 	enum VIA_HDA_CODEC codec_type;
 
@@ -390,6 +391,8 @@
 	}
 }
 
+static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin);
+
 static void set_pin_power_state(struct hda_codec *codec, hda_nid_t nid,
 				unsigned int *affected_parm)
 {
@@ -400,9 +403,10 @@
 		& AC_DEFCFG_MISC_NO_PRESENCE; /* do not support pin
sense */
 	unsigned present = snd_hda_codec_read(codec, nid, 0,
 					      AC_VERB_GET_PIN_SENSE, 0)
>> 31;
-
-	if ((no_presence || present) && get_defcfg_connect(def_conf)
-	    != AC_JACK_PORT_NONE) {
+	struct via_spec *spec = codec->spec;
+	if ((spec->smart51_enabled && is_smart51_pins(spec, nid))
+	    || ((no_presence || present)
+		&& get_defcfg_connect(def_conf) != AC_JACK_PORT_NONE)) {
 		*affected_parm = AC_PWRST_D0; /* if it's connected */
 		parm = AC_PWRST_D0;
 	} else
@@ -657,6 +661,167 @@
 	{ } /* end */
 };
 
+static void notify_aa_path_ctls(struct hda_codec *codec)
+{
+	int i;
+	struct snd_ctl_elem_id id;
+	const char *labels[] = {"Mic", "Front Mic", "Line"};
+
+	memset(&id, 0, sizeof(id));
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	for (i = 0; i < ARRAY_SIZE(labels); i++) {
+		sprintf(id.name, "%s Playback Volume", labels[i]);
+		snd_ctl_notify(codec->bus->card,
SNDRV_CTL_EVENT_MASK_VALUE,
+			       &id);
+	}
+}
+
+static void mute_aa_path(struct hda_codec *codec, int mute)
+{
+	struct via_spec *spec = codec->spec;
+	hda_nid_t  nid_mixer;
+	int start_idx;
+	int end_idx;
+	int i;
+	/* get nid of MW0 and start & end index */
+	switch (spec->codec_type) {
+	case VT1708:
+		nid_mixer = 0x17;
+		start_idx = 2;
+		end_idx = 4;
+		break;
+	case VT1709_10CH:
+	case VT1709_6CH:
+		nid_mixer = 0x18;
+		start_idx = 2;
+		end_idx = 4;
+		break;
+	case VT1708B_8CH:
+	case VT1708B_4CH:
+	case VT1708S:
+		nid_mixer = 0x16;
+		start_idx = 2;
+		end_idx = 4;
+		break;
+	default:
+		return;
+	}
+	/* check AA path's mute status */
+	for (i = start_idx; i <= end_idx; i++) {
+		int val = mute ? HDA_AMP_MUTE : HDA_AMP_UNMUTE;
+		snd_hda_codec_amp_stereo(codec, nid_mixer, HDA_INPUT, i,
+					 HDA_AMP_MUTE, val);
+	}
+}
+static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin)
+{
+	int res = 0;
+	int index;
+	for (index = AUTO_PIN_MIC; index < AUTO_PIN_FRONT_LINE; index++)
{
+		if (pin == spec->autocfg.input_pins[index]) {
+			res = 1;
+			break;
+		}
+	}
+	return res;
+}
+
+static int via_smart51_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int via_smart51_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	int index[] = { AUTO_PIN_MIC, AUTO_PIN_FRONT_MIC, AUTO_PIN_LINE
};
+	int on = 1;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(index); i++) {
+		hda_nid_t nid = spec->autocfg.input_pins[index[i]];
+		if (nid) {
+			int ctl =
+			    snd_hda_codec_read(codec, nid, 0,
+
AC_VERB_GET_PIN_WIDGET_CONTROL,
+					       0);
+			if (i == AUTO_PIN_FRONT_MIC
+			    && spec->hp_independent_mode)
+				continue; /* ignore FMic for independent
HP */
+			if (ctl & AC_PINCTL_IN_EN
+			    && !(ctl & AC_PINCTL_OUT_EN))
+				on = 0;
+		}
+	}
+	*ucontrol->value.integer.value = on;
+	return 0;
+}
+
+static int via_smart51_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	int out_in = *ucontrol->value.integer.value
+		? AC_PINCTL_OUT_EN : AC_PINCTL_IN_EN;
+	int index[] = { AUTO_PIN_MIC, AUTO_PIN_FRONT_MIC, AUTO_PIN_LINE
};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(index); i++) {
+		hda_nid_t nid = spec->autocfg.input_pins[index[i]];
+		if (i == AUTO_PIN_FRONT_MIC
+		    && spec->hp_independent_mode)
+			continue; /* don't retask FMic for independent
HP */
+		if (nid) {
+			unsigned int parm = snd_hda_codec_read(
+				codec, nid, 0,
+				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+			parm &= ~(AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN);
+			parm |= out_in;
+			snd_hda_codec_write(codec, nid, 0,
+
AC_VERB_SET_PIN_WIDGET_CONTROL,
+					    parm);
+			if (out_in == AC_PINCTL_OUT_EN) {
+				mute_aa_path(codec, 1);
+				notify_aa_path_ctls(codec);
+			}
+		}
+		if (i == AUTO_PIN_FRONT_MIC) {
+			if (spec->codec_type == VT1708S) {
+				/* input = index 1 (AOW3) */
+				snd_hda_codec_write(
+					codec, nid, 0,
+					AC_VERB_SET_CONNECT_SEL, 1);
+				snd_hda_codec_amp_stereo(
+					codec, nid, HDA_OUTPUT,
+					0, HDA_AMP_MUTE,
HDA_AMP_UNMUTE);
+			}
+		}
+	}
+	spec->smart51_enabled = *ucontrol->value.integer.value;
+	set_jack_power_state(codec);
+	return 1;
+}
+
+static struct snd_kcontrol_new via_smart51_mixer[] = {
+	{
+	 .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	 .name = "Smart 5.1",
+	 .count = 1,
+	 .info = via_smart51_info,
+	 .get = via_smart51_get,
+	 .put = via_smart51_put,
+	 },
+	{}			/* end */
+};
+
 /* capture mixer elements */
 static struct snd_kcontrol_new vt1708_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_INPUT),
@@ -1587,6 +1752,7 @@
 	if (spec->hp_mux)
 		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
+	spec->mixers[spec->num_mixers++] = via_smart51_mixer;
 	return 1;
 }
 
@@ -2086,6 +2252,7 @@
 	if (spec->hp_mux)
 		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
+	spec->mixers[spec->num_mixers++] = via_smart51_mixer;
 	return 1;
 }
 
@@ -2648,6 +2815,7 @@
 	if (spec->hp_mux)
 		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
+	spec->mixers[spec->num_mixers++] = via_smart51_mixer;
 	return 1;
 }
 
@@ -3141,6 +3309,7 @@
 	if (spec->hp_mux)
 		spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
+	spec->mixers[spec->num_mixers++] = via_smart51_mixer;
 	return 1;
 }
