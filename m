From: Daniel Drake <drake@endlessm.com>
Subject: Re: User-friendly dynamic HDA pin reconfiguration
Date: Thu, 29 Nov 2018 16:58:08 +0800
Message-ID: <20181129085808.5448-1-drake@endlessm.com>
References: <s5hwopyhytw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A7F5267B21
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 09:58:14 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id z10so625694pgp.7
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 00:58:13 -0800 (PST)
In-Reply-To: <s5hwopyhytw.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Actually the generic parser allows to create a "Headphone Mic Jack
> Mode" enum control in a certain condition.  This allows user to switch
> the headphone jack role via the enum.  Isn't it the case?

Thanks for the pointer. In this case the hardware actually has two jacks:
a combined headphones/mic jack (i.e. headset), plus a Line In/Out jack.

The headset jack is already working fine. I traced the code you mentioned,
it has this condition:
	if (spec->hp_mic_pin &&
	    (spec->auto_mic || spec->input_mux.num_items == 1 ||
	     spec->add_jack_modes)) {
		err = create_hp_mic_jack_mode(codec, spec->hp_mic_pin);

hp_mic_pin is not set because we hit this codepath in create_hp_mic():

		else if (cfg->num_inputs == 1) {
			defcfg = snd_hda_codec_get_pincfg(codec, cfg->inputs[0].pin);
			if (snd_hda_get_input_pin_attr(defcfg) != INPUT_PIN_ATTR_INT)
				return 0;
		}

and given that the headset jack is already working OK, I don't think
this code is relevant in this case.

However I did take it as a suggestion that I could implement a custom mixer
control to change the pin settings. I tried setting both pincfg and pinctl,
however after changing the value of my new control, the kernel still
describes the pin with the same name in the exposed mixer control,
"Line Out Playback Switch", so I'm not sure how a userspace agent such
as pulseaudio would be able to know that it should now offer a Line In
input option.

My scratch code is below. Further input appreciated!

---
 sound/pci/hda/patch_realtek.c | 74 ++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 46d41d8c92eb..d6ff2f96a9db 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -105,6 +105,9 @@ struct alc_spec {
 	int current_headset_mode;
 	int current_headset_type;
 
+	/* Line jack mode selector */
+	unsigned int line_jack_mode;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -5168,6 +5171,68 @@ static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
 	}
 }
 
+static int vcopperbox_line_mode_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = { "Line In", "Line Out" };
+	return snd_hda_enum_helper_info(kcontrol, uinfo, 2, texts);
+}
+
+static int vcopperbox_line_mode_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	// FIXME autodetect based on pin cfg val?
+	ucontrol->value.enumerated.item[0] = spec->line_jack_mode;
+	return 0;
+}
+
+static int vcopperbox_line_mode_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	unsigned int val = ucontrol->value.enumerated.item[0];
+	unsigned int pincfg, pinctl;
+
+	// FIXME just tweak the bits of interest
+	// page 182
+	// bits 20 to 23 is the type selector, 8=IN 0=OUT 2=HP OUT
+	if (val == 0) {
+		/* Line In */
+		pincfg = 0x018110d1;
+		pinctl = PIN_IN;
+	} else {
+		/* Line Out */
+		pincfg = 0x01211030;
+		pinctl = PIN_OUT;
+	}
+
+	snd_hda_codec_set_pincfg(codec, 0x1a, pincfg);
+	snd_hda_set_pin_ctl_cache(codec, 0x1a, pinctl);
+	spec->line_jack_mode = val;
+	return 1;
+}
+
+static const struct snd_kcontrol_new vcopperbox_line_select_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.info = vcopperbox_line_mode_info,
+	.get = vcopperbox_line_mode_get,
+	.put = vcopperbox_line_mode_put,
+};
+
+static void alc269_acer_vcopperbox_line_select(struct hda_codec *codec,
+					       const struct hda_fixup *fix,
+					       int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PROBE)
+		snd_hda_gen_add_kctl(&spec->gen, "Line Jack Mode",
+				     &vcopperbox_line_select_enum);
+}
+
 static void alc283_hp_automute_hook(struct hda_codec *codec,
 				    struct hda_jack_callback *jack)
 {
@@ -5560,6 +5625,7 @@ enum {
 	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC282_FIXUP_ACER_TRAVELMATE_PINS,
 	ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
+	ALC269VC_FIXUP_ACER_VCOPPERBOX_LINE_SELECT,
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC294_FIXUP_ASUS_SPK_NOISE,
 	ALC256_FIXUP_ACER_SWIFT_NO_MIC_PRESENCE,
@@ -6487,6 +6553,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	},
+	[ALC269VC_FIXUP_ACER_VCOPPERBOX_LINE_SELECT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_acer_vcopperbox_line_select,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 	[ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6496,7 +6568,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ },
                 },
 		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE
+		.chain_id = ALC269VC_FIXUP_ACER_VCOPPERBOX_LINE_SELECT
 	},
 	[ALC294_FIXUP_ASUS_SPK_NOISE] = {
 		.type = HDA_FIXUP_VERBS,
-- 
2.19.1
