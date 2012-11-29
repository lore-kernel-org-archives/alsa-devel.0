From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda - Implement shared front mic/hp
	jack for HP Z220
Date: Thu, 29 Nov 2012 16:21:28 +0100
Message-ID: <1354202489-12769-5-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F38142650D7
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D48D9A38EA
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
In-Reply-To: <1354202489-12769-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HP Z220 with ALC221 codec has a front jack that should work as both
the front mic and the secondary headphone.  This patch adds a new
mixer enum to change the jack behavior.

In the headphone mode, the auto-mic switching is disabled and the
input is fixed to the rear line-in.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c5cc47b..95c5bc7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -213,6 +213,10 @@ struct alc_spec {
 	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
 	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
 
+	/* front-mic / HP sharing for HP Z220 */
+	unsigned int shared_fmic_hp_mode:1;
+	hda_nid_t shared_fmic_hp_nid;
+
 	/* auto-mute control */
 	int automute_mode;
 	hda_nid_t automute_mixer_nid[AUTO_CFG_MAX_OUTS];
@@ -5959,6 +5963,143 @@ static void alc269_fixup_pcm_44k(struct hda_codec *codec,
 	spec->stream_analog_capture = &alc269_44k_pcm_analog_capture;
 }
 
+/* allow switching HP/front-mic on HP Z220 */
+static int alc221_shared_fmic_hp_mode_info(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = {
+		"Mic", "Headphone"
+	};
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item >= 2)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int alc221_shared_fmic_hp_mode_get(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->shared_fmic_hp_mode;
+	return 0;
+}
+
+static void alc221_shared_fmic_hp_mode_update(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	struct hda_jack_tbl *jack;
+	hda_nid_t fmic_nid = spec->shared_fmic_hp_nid;
+	unsigned int pinctl, mute, idx;
+	hda_jack_callback callback;
+
+	if (!fmic_nid)
+		return;
+
+	/* utterly hackish: replace the secondary hp pin, enable/disable the
+	 * automic on the fly
+	 */
+	if (spec->shared_fmic_hp_mode) {
+		spec->autocfg.hp_outs = 2;
+		spec->autocfg.hp_pins[1] = fmic_nid;
+		callback = alc_hp_automute;
+		pinctl = PIN_HP;
+		mute = AMP_OUT_UNMUTE;
+		spec->auto_mic = 0;
+		alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
+		/* choose the same DAC as the primary HP output */
+		idx = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
+					 AC_VERB_GET_CONNECT_SEL, 0);
+		snd_hda_codec_write(codec, fmic_nid, 0,
+				    AC_VERB_SET_CONNECT_SEL, idx);
+	} else {
+		spec->autocfg.hp_outs = 1;
+		spec->autocfg.hp_pins[1] = 0;
+		callback = alc_mic_automute;
+		pinctl = PIN_VREF80;
+		mute = AMP_OUT_MUTE;
+		spec->auto_mic = 1;
+	}
+
+	snd_hda_codec_write(codec, fmic_nid, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl);
+	snd_hda_codec_write(codec, fmic_nid, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, mute);
+
+	jack = snd_hda_jack_tbl_get(codec, fmic_nid);
+	if (jack)
+		jack->callback = callback;
+	else
+		snd_hda_jack_detect_enable_callback(codec, fmic_nid,
+						    ALC_HP_EVENT, callback);
+	alc_hp_automute(codec, NULL);
+	alc_mic_automute(codec, NULL);
+}
+
+static int alc221_shared_fmic_hp_mode_put(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+
+	if (spec->shared_fmic_hp_mode == ucontrol->value.enumerated.item[0])
+		return 0;
+	spec->shared_fmic_hp_mode = ucontrol->value.enumerated.item[0];
+	alc221_shared_fmic_hp_mode_update(codec);
+	return 1;
+}
+
+static const struct snd_kcontrol_new alc221_shared_fmic_hp_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Front Mic Jack Mode",
+	.info = alc221_shared_fmic_hp_mode_info,
+	.get = alc221_shared_fmic_hp_mode_get,
+	.put = alc221_shared_fmic_hp_mode_put,
+};
+
+static int alc221_add_shared_fmic_hp_mode(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	struct snd_kcontrol_new *knew;
+	char name[22];
+
+	if (spec->autocfg.hp_outs != 1 || spec->am_num_entries != 2)
+		return -EINVAL;
+
+	snd_hda_get_pin_label(codec, spec->am_entry[1].pin, &spec->autocfg,
+			      name, sizeof(name), NULL);
+	strlcat(name, " Jack Mode", sizeof(name));
+
+	knew = alc_kcontrol_new(spec);
+	if (!knew)
+		return -ENOMEM;
+	*knew = alc221_shared_fmic_hp_mode_enum;
+	knew->name = kstrdup(name, GFP_KERNEL);
+	if (!knew->name)
+		return -ENOMEM;
+	spec->shared_fmic_hp_nid = spec->am_entry[1].pin;
+	spec->shared_fmic_hp_mode = 0;
+	return 0;
+}
+
+static void alc221_fixup_shared_fmic_hp(struct hda_codec *codec,
+					const struct alc_fixup *fix, int action)
+{
+	switch (action) {
+	case ALC_FIXUP_ACT_PROBE:
+		if (alc221_add_shared_fmic_hp_mode(codec) < 0)
+			return;
+		break;
+	case ALC_FIXUP_ACT_INIT:
+		alc221_shared_fmic_hp_mode_update(codec);
+		break;
+	}
+}
+
 static void alc269_fixup_stereo_dmic(struct hda_codec *codec,
 				     const struct alc_fixup *fix, int action)
 {
@@ -6055,6 +6196,7 @@ enum {
 	ALC269_FIXUP_MIC2_MUTE_LED,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
+	ALC221_FIXUP_SHARED_FMIC_HP,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC271_FIXUP_AMIC_MIC2,
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
@@ -6198,6 +6340,10 @@ static const struct alc_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT
 	},
+	[ALC221_FIXUP_SHARED_FMIC_HP] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc221_fixup_shared_fmic_hp,
+	},
 	[ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT] = {
 		.type = ALC_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
@@ -6224,6 +6370,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x1791, "HP Z220", ALC221_FIXUP_SHARED_FMIC_HP),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
1.8.0.1
