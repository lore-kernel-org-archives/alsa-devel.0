From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]model for alc262 to support Lenovo 3000
Date: Thu, 20 Mar 2008 09:44:54 +0800
Message-ID: <1205977494.20080.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-b7+tBBsWxfG++aFutF13"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 81FCC246F9
	for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2008 02:43:55 +0100 (CET)
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
Cc: tiwai@suse.de, zhe.jiang@intel.com
List-Id: alsa-devel@alsa-project.org


--=-b7+tBBsWxfG++aFutF13
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Please refer to [0003856] on the alsa mantis.
This model is to support the Lenovo 3000 y410.

Thanks!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>


--=-b7+tBBsWxfG++aFutF13
Content-Disposition: attachment; filename=lenovo_3000_y410_alc262.patch
Content-Type: text/x-patch; name=lenovo_3000_y410_alc262.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-hg20080319/alsa-kernel/pci/hda/patch_realtek.c	2008-03-19 09:00:09.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-20 09:33:33.000000000 +0800
@@ -98,6 +98,7 @@ enum {
 	ALC262_SONY_ASSAMD,
 	ALC262_BENQ_T31,
 	ALC262_ULTRA,
+	ALC262_LENOVO_3000,
 	ALC262_AUTO,
 	ALC262_MODEL_LAST /* last tag */
 };
@@ -8728,6 +8729,12 @@ static struct hda_verb alc262_fujitsu_un
 	{}
 };
 
+static struct hda_verb alc262_lenovo_3000_unsol_verbs[] = {
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC_HP_EVENT},
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{}
+};
+
 static struct hda_input_mux alc262_fujitsu_capture_source = {
 	.num_items = 3,
 	.items = {
@@ -8808,6 +8815,46 @@ static struct hda_bind_ctls alc262_fujit
 	},
 };
 
+/* mute/unmute internal speaker according to the hp jack and mute state */
+static void alc262_lenovo_3000_automute(struct hda_codec *codec, int force)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int mute;
+
+	if (force || !spec->sense_updated) {
+		unsigned int present_int_hp;
+		/* need to execute and sync at first */
+		snd_hda_codec_read(codec, 0x1b, 0, AC_VERB_SET_PIN_SENSE, 0);
+		present_int_hp = snd_hda_codec_read(codec, 0x1b, 0,
+					AC_VERB_GET_PIN_SENSE, 0);
+		spec->jack_present = (present_int_hp & 0x80000000) != 0;
+		spec->sense_updated = 1;
+	}
+	if (spec->jack_present) {
+		/* mute internal speaker */
+		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, HDA_AMP_MUTE);
+		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, HDA_AMP_MUTE);
+	} else {
+		/* unmute internal speaker if necessary */
+		mute = snd_hda_codec_amp_read(codec, 0x1b, 0, HDA_OUTPUT, 0);
+		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, mute);
+		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, mute);
+	}
+}
+
+/* unsolicited event for HP jack sensing */
+static void alc262_lenovo_3000_unsol_event(struct hda_codec *codec,
+				       unsigned int res)
+{
+	if ((res >> 26) != ALC_HP_EVENT)
+		return;
+	alc262_lenovo_3000_automute(codec, 1);
+}
+
 /* bind hp and internal speaker mute (with plug check) */
 static int alc262_fujitsu_master_sw_put(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
@@ -8849,6 +8896,44 @@ static struct snd_kcontrol_new alc262_fu
 	{ } /* end */
 };
 
+/* bind hp and internal speaker mute (with plug check) */
+static int alc262_lenovo_3000_master_sw_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	long *valp = ucontrol->value.integer.value;
+	int change;
+
+	change = snd_hda_codec_amp_stereo(codec, 0x1b, HDA_OUTPUT, 0,
+						 HDA_AMP_MUTE,
+						 valp ? 0 : HDA_AMP_MUTE);
+
+	if (change)
+		alc262_lenovo_3000_automute(codec, 0);
+	return change;
+}
+
+static struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
+	HDA_BIND_VOL("Master Playback Volume", &alc262_fujitsu_bind_master_vol),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_amp_switch_get,
+		.put = alc262_lenovo_3000_master_sw_put,
+		.private_value = HDA_COMPOSE_AMP_VAL(0x1b, 3, 0, HDA_OUTPUT),
+	},
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	{ } /* end */
+};
+
 /* additional init verbs for Benq laptops */
 static struct hda_verb alc262_EAPD_verbs[] = {
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
@@ -9398,6 +9483,7 @@ static const char *alc262_models[ALC262_
 	[ALC262_BENQ_T31]	= "benq-t31",
 	[ALC262_SONY_ASSAMD]	= "sony-assamd",
 	[ALC262_ULTRA]		= "ultra",
+	[ALC262_LENOVO_3000]	= "lenovo-3000",
 	[ALC262_AUTO]		= "auto",
 };
 
@@ -9434,6 +9520,7 @@ static struct snd_pci_quirk alc262_cfg_t
 	SND_PCI_QUIRK(0x10cf, 0x142d, "Fujitsu Lifebook E8410", ALC262_FUJITSU),
 	SND_PCI_QUIRK(0x144d, 0xc032, "Samsung Q1 Ultra", ALC262_ULTRA),
 	SND_PCI_QUIRK(0x144d, 0xc039, "Samsung Q1U EL", ALC262_ULTRA),
+	SND_PCI_QUIRK(0x17aa, 0x384e, "Lenovo 3000 y410", ALC262_LENOVO_3000),
 	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8", ALC262_BENQ_ED8),
 	SND_PCI_QUIRK(0x17ff, 0x058d, "Benq T31-16", ALC262_BENQ_T31),
 	SND_PCI_QUIRK(0x17ff, 0x058f, "Benq Hippo", ALC262_HIPPO_1),
@@ -9596,6 +9683,19 @@ static struct alc_config_preset alc262_p
 		.unsol_event = alc262_ultra_unsol_event,
 		.init_hook = alc262_ultra_automute,
 	},
+	[ALC262_LENOVO_3000] = {
+		.mixers = { alc262_lenovo_3000_mixer },
+		.init_verbs = { alc262_init_verbs, alc262_EAPD_verbs,
+				alc262_lenovo_3000_unsol_verbs },
+		.num_dacs = ARRAY_SIZE(alc262_dac_nids),
+		.dac_nids = alc262_dac_nids,
+		.hp_nid = 0x03,
+		.dig_out_nid = ALC262_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc262_modes),
+		.channel_mode = alc262_modes,
+		.input_mux = &alc262_fujitsu_capture_source,
+		.unsol_event = alc262_lenovo_3000_unsol_event,
+	},
 };
 
 static int patch_alc262(struct hda_codec *codec)

--=-b7+tBBsWxfG++aFutF13
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-b7+tBBsWxfG++aFutF13--
