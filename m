From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda - Use the new power control for
	VIA codecs
Date: Wed, 18 Mar 2015 09:50:57 +0100
Message-ID: <1426668658-15911-4-git-send-email-tiwai@suse.de>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8662604DF
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:51:01 +0100 (CET)
In-Reply-To: <1426668658-15911-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

VIA codecs used to have the own power controls but they were disabled
at transition to the generic parser due to the coding assuming the
fixed routes.  Now we get the proper support of equivalently fine
power management in the generic parser, and the old kludges can be
replaced with it.  This results in the reduction of lots of dead
codes.

The advanced PM feature is disabled as default like before for keeping
the compatible behavior.  It's enabled via "Dynamic Power-Control"
mixer element.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 662 +---------------------------------------------
 1 file changed, 12 insertions(+), 650 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 2112fbe9e577..d5d1dca4f11b 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -99,7 +99,6 @@ struct via_spec {
 
 	/* HP mode source */
 	unsigned int dmic_enabled;
-	unsigned int no_pin_power_ctl;
 	enum VIA_HDA_CODEC codec_type;
 
 	/* analog low-power control */
@@ -108,9 +107,6 @@ struct via_spec {
 	/* work to check hp jack state */
 	int hp_work_active;
 	int vt1708_jack_detect;
-
-	void (*set_widgets_power_state)(struct hda_codec *codec);
-	unsigned int dac_stream_tag[4];
 };
 
 static enum VIA_HDA_CODEC get_codec_type(struct hda_codec *codec);
@@ -133,11 +129,12 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	/* VT1708BCE & VT1708S are almost same */
 	if (spec->codec_type == VT1708BCE)
 		spec->codec_type = VT1708S;
-	spec->no_pin_power_ctl = 1;
 	spec->gen.indep_hp = 1;
 	spec->gen.keep_eapd_on = 1;
 	spec->gen.pcm_playback_hook = via_playback_pcm_hook;
 	spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
+	codec->power_mgmt = 1;
+	spec->gen.power_down_unused = 1;
 	return spec;
 }
 
@@ -229,90 +226,6 @@ static void vt1708_update_hp_work(struct hda_codec *codec)
 		vt1708_stop_hp_work(codec);
 }
 
-static void set_widgets_power_state(struct hda_codec *codec)
-{
-#if 0 /* FIXME: the assumed connections don't match always with the
-       * actual routes by the generic parser, so better to disable
-       * the control for safety.
-       */
-	struct via_spec *spec = codec->spec;
-	if (spec->set_widgets_power_state)
-		spec->set_widgets_power_state(codec);
-#endif
-}
-
-static void update_power_state(struct hda_codec *codec, hda_nid_t nid,
-			       unsigned int parm)
-{
-	if (snd_hda_check_power_state(codec, nid, parm))
-		return;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
-}
-
-static void update_conv_power_state(struct hda_codec *codec, hda_nid_t nid,
-			       unsigned int parm, unsigned int index)
-{
-	struct via_spec *spec = codec->spec;
-	unsigned int format;
-
-	if (snd_hda_check_power_state(codec, nid, parm))
-		return;
-	format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
-	if (format && (spec->dac_stream_tag[index] != format))
-		spec->dac_stream_tag[index] = format;
-
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
-	if (parm == AC_PWRST_D0) {
-		format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
-		if (!format && (spec->dac_stream_tag[index] != format))
-			snd_hda_codec_write(codec, nid, 0,
-						  AC_VERB_SET_CHANNEL_STREAMID,
-						  spec->dac_stream_tag[index]);
-	}
-}
-
-static bool smart51_enabled(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	return spec->gen.ext_channel_count > 2;
-}
-
-static bool is_smart51_pins(struct hda_codec *codec, hda_nid_t pin)
-{
-	struct via_spec *spec = codec->spec;
-	int i;
-
-	for (i = 0; i < spec->gen.multi_ios; i++)
-		if (spec->gen.multi_io[i].pin == pin)
-			return true;
-	return false;
-}
-
-static void set_pin_power_state(struct hda_codec *codec, hda_nid_t nid,
-				unsigned int *affected_parm)
-{
-	unsigned parm;
-	unsigned def_conf = snd_hda_codec_get_pincfg(codec, nid);
-	unsigned no_presence = (def_conf & AC_DEFCFG_MISC)
-		>> AC_DEFCFG_MISC_SHIFT
-		& AC_DEFCFG_MISC_NO_PRESENCE; /* do not support pin sense */
-	struct via_spec *spec = codec->spec;
-	unsigned present = 0;
-
-	no_presence |= spec->no_pin_power_ctl;
-	if (!no_presence)
-		present = snd_hda_jack_detect(codec, nid);
-	if ((smart51_enabled(codec) && is_smart51_pins(codec, nid))
-	    || ((no_presence || present)
-		&& get_defcfg_connect(def_conf) != AC_JACK_PORT_NONE)) {
-		*affected_parm = AC_PWRST_D0; /* if it's connected */
-		parm = AC_PWRST_D0;
-	} else
-		parm = AC_PWRST_D3;
-
-	update_power_state(codec, nid, parm);
-}
-
 static int via_pin_power_ctl_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
@@ -323,8 +236,7 @@ static int via_pin_power_ctl_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct via_spec *spec = codec->spec;
-	ucontrol->value.enumerated.item[0] = !spec->no_pin_power_ctl;
+	ucontrol->value.enumerated.item[0] = codec->power_mgmt;
 	return 0;
 }
 
@@ -333,12 +245,12 @@ static int via_pin_power_ctl_put(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct via_spec *spec = codec->spec;
-	unsigned int val = !ucontrol->value.enumerated.item[0];
+	bool val = !!ucontrol->value.enumerated.item[0];
 
-	if (val == spec->no_pin_power_ctl)
+	if (val == codec->power_mgmt)
 		return 0;
-	spec->no_pin_power_ctl = val;
-	set_widgets_power_state(codec);
+	codec->power_mgmt = val;
+	spec->gen.power_down_unused = val;
 	analog_low_current_mode(codec);
 	return 1;
 }
@@ -383,7 +295,7 @@ static void __analog_low_current_mode(struct hda_codec *codec, bool force)
 	bool enable;
 	unsigned int verb, parm;
 
-	if (spec->no_pin_power_ctl)
+	if (!codec->power_mgmt)
 		enable = false;
 	else
 		enable = is_aa_path_mute(codec) && !spec->gen.active_streams;
@@ -440,8 +352,7 @@ static int via_build_controls(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	if (spec->set_widgets_power_state)
-		spec->mixers[spec->num_mixers++] = via_pin_power_ctl_enum;
+	spec->mixers[spec->num_mixers++] = via_pin_power_ctl_enum;
 
 	for (i = 0; i < spec->num_mixers; i++) {
 		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
@@ -485,7 +396,6 @@ static int via_suspend(struct hda_codec *codec)
 static int via_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct via_spec *spec = codec->spec;
-	set_widgets_power_state(codec);
 	analog_low_current_mode(codec);
 	vt1708_update_hp_work(codec);
 	return snd_hda_check_amp_list_power(codec, &spec->gen.loopback, nid);
@@ -573,34 +483,6 @@ static const struct snd_kcontrol_new vt1708_jack_detect_ctl[] = {
 	{} /* terminator */
 };
 
-static void via_jack_powerstate_event(struct hda_codec *codec,
-				      struct hda_jack_callback *tbl)
-{
-	set_widgets_power_state(codec);
-}
-
-static void via_set_jack_unsol_events(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
-	hda_nid_t pin;
-	int i;
-
-	for (i = 0; i < cfg->line_outs; i++) {
-		pin = cfg->line_out_pins[i];
-		if (pin && is_jack_detectable(codec, pin))
-			snd_hda_jack_detect_enable_callback(codec, pin,
-							    via_jack_powerstate_event);
-	}
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		pin = cfg->line_out_pins[i];
-		if (pin && is_jack_detectable(codec, pin))
-			snd_hda_jack_detect_enable_callback(codec, pin,
-							    via_jack_powerstate_event);
-	}
-}
-
 static const struct badness_table via_main_out_badness = {
 	.no_primary_dac = 0x10000,
 	.no_dac = 0x4000,
@@ -634,7 +516,9 @@ static int via_parse_auto_config(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	via_set_jack_unsol_events(codec);
+	/* disable widget PM at start for compatibility */
+	codec->power_mgmt = 0;
+	spec->gen.power_down_unused = 0;
 	return 0;
 }
 
@@ -647,7 +531,6 @@ static int via_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
 
 	/* init power states */
-	set_widgets_power_state(codec);
 	__analog_low_current_mode(codec, true);
 
 	snd_hda_gen_init(codec);
@@ -767,78 +650,6 @@ static int patch_vt1709(struct hda_codec *codec)
 	return 0;
 }
 
-static void set_widgets_power_state_vt1708B(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm;
-	int is_8ch = 0;
-	if ((spec->codec_type != VT1708B_4CH) &&
-	    (codec->vendor_id != 0x11064397))
-		is_8ch = 1;
-
-	/* SW0 (17h) = stereo mixer */
-	imux_is_smixer =
-	(snd_hda_codec_read(codec, 0x17, 0, AC_VERB_GET_CONNECT_SEL, 0x00)
-	 == ((spec->codec_type == VT1708S) ? 5 : 0));
-	/* inputs */
-	/* PW 1/2/5 (1ah/1bh/1eh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x1a, &parm);
-	set_pin_power_state(codec, 0x1b, &parm);
-	set_pin_power_state(codec, 0x1e, &parm);
-	if (imux_is_smixer)
-		parm = AC_PWRST_D0;
-	/* SW0 (17h), AIW 0/1 (13h/14h) */
-	update_power_state(codec, 0x17, parm);
-	update_power_state(codec, 0x13, parm);
-	update_power_state(codec, 0x14, parm);
-
-	/* outputs */
-	/* PW0 (19h), SW1 (18h), AOW1 (11h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x19, &parm);
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x1b, &parm);
-	update_power_state(codec, 0x18, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* PW6 (22h), SW2 (26h), AOW2 (24h) */
-	if (is_8ch) {
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x22, &parm);
-		if (smart51_enabled(codec))
-			set_pin_power_state(codec, 0x1a, &parm);
-		update_power_state(codec, 0x26, parm);
-		update_power_state(codec, 0x24, parm);
-	} else if (codec->vendor_id == 0x11064397) {
-		/* PW7(23h), SW2(27h), AOW2(25h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x23, &parm);
-		if (smart51_enabled(codec))
-			set_pin_power_state(codec, 0x1a, &parm);
-		update_power_state(codec, 0x27, parm);
-		update_power_state(codec, 0x25, parm);
-	}
-
-	/* PW 3/4/7 (1ch/1dh/23h) */
-	parm = AC_PWRST_D3;
-	/* force to D0 for internal Speaker */
-	set_pin_power_state(codec, 0x1c, &parm);
-	set_pin_power_state(codec, 0x1d, &parm);
-	if (is_8ch)
-		set_pin_power_state(codec, 0x23, &parm);
-
-	/* MW0 (16h), Sw3 (27h), AOW 0/3 (10h/25h) */
-	update_power_state(codec, 0x16, imux_is_smixer ? AC_PWRST_D0 : parm);
-	update_power_state(codec, 0x10, parm);
-	if (is_8ch) {
-		update_power_state(codec, 0x25, parm);
-		update_power_state(codec, 0x27, parm);
-	} else if (codec->vendor_id == 0x11064397 && spec->gen.indep_hp_enabled)
-		update_power_state(codec, 0x25, parm);
-}
-
 static int patch_vt1708S(struct hda_codec *codec);
 static int patch_vt1708B(struct hda_codec *codec)
 {
@@ -863,9 +674,6 @@ static int patch_vt1708B(struct hda_codec *codec)
 	}
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
-
 	return 0;
 }
 
@@ -931,8 +739,6 @@ static int patch_vt1708S(struct hda_codec *codec)
 	spec->init_verbs[spec->num_iverbs++] = vt1708S_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
 	return 0;
 }
 
@@ -946,36 +752,6 @@ static const struct hda_verb vt1702_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt1702(struct hda_codec *codec)
-{
-	int imux_is_smixer =
-	snd_hda_codec_read(codec, 0x13, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
-	unsigned int parm;
-	/* inputs */
-	/* PW 1/2/5 (14h/15h/18h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x14, &parm);
-	set_pin_power_state(codec, 0x15, &parm);
-	set_pin_power_state(codec, 0x18, &parm);
-	if (imux_is_smixer)
-		parm = AC_PWRST_D0; /* SW0 (13h) = stereo mixer (idx 3) */
-	/* SW0 (13h), AIW 0/1/2 (12h/1fh/20h) */
-	update_power_state(codec, 0x13, parm);
-	update_power_state(codec, 0x12, parm);
-	update_power_state(codec, 0x1f, parm);
-	update_power_state(codec, 0x20, parm);
-
-	/* outputs */
-	/* PW 3/4 (16h/17h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x17, &parm);
-	set_pin_power_state(codec, 0x16, &parm);
-	/* MW0 (1ah), AOW 0/1 (10h/1dh) */
-	update_power_state(codec, 0x1a, imux_is_smixer ? AC_PWRST_D0 : parm);
-	update_power_state(codec, 0x10, parm);
-	update_power_state(codec, 0x1d, parm);
-}
-
 static int patch_vt1702(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -1005,8 +781,6 @@ static int patch_vt1702(struct hda_codec *codec)
 	spec->init_verbs[spec->num_iverbs++] = vt1702_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt1702;
 	return 0;
 }
 
@@ -1021,71 +795,6 @@ static const struct hda_verb vt1718S_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm, parm2;
-	/* MUX6 (1eh) = stereo mixer */
-	imux_is_smixer =
-	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 5;
-	/* inputs */
-	/* PW 5/6/7 (29h/2ah/2bh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x29, &parm);
-	set_pin_power_state(codec, 0x2a, &parm);
-	set_pin_power_state(codec, 0x2b, &parm);
-	if (imux_is_smixer)
-		parm = AC_PWRST_D0;
-	/* MUX6/7 (1eh/1fh), AIW 0/1 (10h/11h) */
-	update_power_state(codec, 0x1e, parm);
-	update_power_state(codec, 0x1f, parm);
-	update_power_state(codec, 0x10, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* outputs */
-	/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x27, &parm);
-	update_power_state(codec, 0x1a, parm);
-	parm2 = parm; /* for pin 0x0b */
-
-	/* PW2 (26h), AOW2 (ah) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x26, &parm);
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x2b, &parm);
-	update_power_state(codec, 0xa, parm);
-
-	/* PW0 (24h), AOW0 (8h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x24, &parm);
-	if (!spec->gen.indep_hp_enabled) /* check for redirected HP */
-		set_pin_power_state(codec, 0x28, &parm);
-	update_power_state(codec, 0x8, parm);
-	if (!spec->gen.indep_hp_enabled && parm2 != AC_PWRST_D3)
-		parm = parm2;
-	update_power_state(codec, 0xb, parm);
-	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
-	update_power_state(codec, 0x21, imux_is_smixer ? AC_PWRST_D0 : parm);
-
-	/* PW1 (25h), AOW1 (9h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x25, &parm);
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x2a, &parm);
-	update_power_state(codec, 0x9, parm);
-
-	if (spec->gen.indep_hp_enabled) {
-		/* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (ch) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x28, &parm);
-		update_power_state(codec, 0x1b, parm);
-		update_power_state(codec, 0x34, parm);
-		update_power_state(codec, 0xc, parm);
-	}
-}
-
 /* Add a connection to the primary DAC from AA-mixer for some codecs
  * This isn't listed from the raw info, but the chip has a secret connection.
  */
@@ -1146,9 +855,6 @@ static int patch_vt1718S(struct hda_codec *codec)
 	spec->init_verbs[spec->num_iverbs++] = vt1718S_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt1718S;
-
 	return 0;
 }
 
@@ -1188,7 +894,6 @@ static int vt1716s_dmic_put(struct snd_kcontrol *kcontrol,
 	snd_hda_codec_write(codec, 0x26, 0,
 					       AC_VERB_SET_CONNECT_SEL, index);
 	spec->dmic_enabled = index;
-	set_widgets_power_state(codec);
 	return 1;
 }
 
@@ -1223,95 +928,6 @@ static const struct hda_verb vt1716S_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt1716S(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm;
-	unsigned int mono_out, present;
-	/* SW0 (17h) = stereo mixer */
-	imux_is_smixer =
-	(snd_hda_codec_read(codec, 0x17, 0,
-			    AC_VERB_GET_CONNECT_SEL, 0x00) ==  5);
-	/* inputs */
-	/* PW 1/2/5 (1ah/1bh/1eh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x1a, &parm);
-	set_pin_power_state(codec, 0x1b, &parm);
-	set_pin_power_state(codec, 0x1e, &parm);
-	if (imux_is_smixer)
-		parm = AC_PWRST_D0;
-	/* SW0 (17h), AIW0(13h) */
-	update_power_state(codec, 0x17, parm);
-	update_power_state(codec, 0x13, parm);
-
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x1e, &parm);
-	/* PW11 (22h) */
-	if (spec->dmic_enabled)
-		set_pin_power_state(codec, 0x22, &parm);
-	else
-		update_power_state(codec, 0x22, AC_PWRST_D3);
-
-	/* SW2(26h), AIW1(14h) */
-	update_power_state(codec, 0x26, parm);
-	update_power_state(codec, 0x14, parm);
-
-	/* outputs */
-	/* PW0 (19h), SW1 (18h), AOW1 (11h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x19, &parm);
-	/* Smart 5.1 PW2(1bh) */
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x1b, &parm);
-	update_power_state(codec, 0x18, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* PW7 (23h), SW3 (27h), AOW3 (25h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x23, &parm);
-	/* Smart 5.1 PW1(1ah) */
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x1a, &parm);
-	update_power_state(codec, 0x27, parm);
-
-	/* Smart 5.1 PW5(1eh) */
-	if (smart51_enabled(codec))
-		set_pin_power_state(codec, 0x1e, &parm);
-	update_power_state(codec, 0x25, parm);
-
-	/* Mono out */
-	/* SW4(28h)->MW1(29h)-> PW12 (2ah)*/
-	present = snd_hda_jack_detect(codec, 0x1c);
-
-	if (present)
-		mono_out = 0;
-	else {
-		present = snd_hda_jack_detect(codec, 0x1d);
-		if (!spec->gen.indep_hp_enabled && present)
-			mono_out = 0;
-		else
-			mono_out = 1;
-	}
-	parm = mono_out ? AC_PWRST_D0 : AC_PWRST_D3;
-	update_power_state(codec, 0x28, parm);
-	update_power_state(codec, 0x29, parm);
-	update_power_state(codec, 0x2a, parm);
-
-	/* PW 3/4 (1ch/1dh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x1c, &parm);
-	set_pin_power_state(codec, 0x1d, &parm);
-	/* HP Independent Mode, power on AOW3 */
-	if (spec->gen.indep_hp_enabled)
-		update_power_state(codec, 0x25, parm);
-
-	/* force to D0 for internal Speaker */
-	/* MW0 (16h), AOW0 (10h) */
-	update_power_state(codec, 0x16, imux_is_smixer ? AC_PWRST_D0 : parm);
-	update_power_state(codec, 0x10, mono_out ? AC_PWRST_D0 : parm);
-}
-
 static int patch_vt1716S(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -1339,8 +955,6 @@ static int patch_vt1716S(struct hda_codec *codec)
 	spec->mixers[spec->num_mixers++] = vt1716S_mono_out_mixer;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state = set_widgets_power_state_vt1716S;
 	return 0;
 }
 
@@ -1366,98 +980,6 @@ static const struct hda_verb vt1802_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt2002P(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm;
-	unsigned int present;
-	/* MUX9 (1eh) = stereo mixer */
-	imux_is_smixer =
-	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 3;
-	/* inputs */
-	/* PW 5/6/7 (29h/2ah/2bh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x29, &parm);
-	set_pin_power_state(codec, 0x2a, &parm);
-	set_pin_power_state(codec, 0x2b, &parm);
-	parm = AC_PWRST_D0;
-	/* MUX9/10 (1eh/1fh), AIW 0/1 (10h/11h) */
-	update_power_state(codec, 0x1e, parm);
-	update_power_state(codec, 0x1f, parm);
-	update_power_state(codec, 0x10, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* outputs */
-	/* AOW0 (8h)*/
-	update_power_state(codec, 0x8, parm);
-
-	if (spec->codec_type == VT1802) {
-		/* PW4 (28h), MW4 (18h), MUX4(38h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x28, &parm);
-		update_power_state(codec, 0x18, parm);
-		update_power_state(codec, 0x38, parm);
-	} else {
-		/* PW4 (26h), MW4 (1ch), MUX4(37h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x26, &parm);
-		update_power_state(codec, 0x1c, parm);
-		update_power_state(codec, 0x37, parm);
-	}
-
-	if (spec->codec_type == VT1802) {
-		/* PW1 (25h), MW1 (15h), MUX1(35h), AOW1 (9h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x25, &parm);
-		update_power_state(codec, 0x15, parm);
-		update_power_state(codec, 0x35, parm);
-	} else {
-		/* PW1 (25h), MW1 (19h), MUX1(35h), AOW1 (9h) */
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x25, &parm);
-		update_power_state(codec, 0x19, parm);
-		update_power_state(codec, 0x35, parm);
-	}
-
-	if (spec->gen.indep_hp_enabled)
-		update_power_state(codec, 0x9, AC_PWRST_D0);
-
-	/* Class-D */
-	/* PW0 (24h), MW0(18h/14h), MUX0(34h) */
-	present = snd_hda_jack_detect(codec, 0x25);
-
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x24, &parm);
-	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
-	if (spec->codec_type == VT1802)
-		update_power_state(codec, 0x14, parm);
-	else
-		update_power_state(codec, 0x18, parm);
-	update_power_state(codec, 0x34, parm);
-
-	/* Mono Out */
-	present = snd_hda_jack_detect(codec, 0x26);
-
-	parm = present ? AC_PWRST_D3 : AC_PWRST_D0;
-	if (spec->codec_type == VT1802) {
-		/* PW15 (33h), MW8(1ch), MUX8(3ch) */
-		update_power_state(codec, 0x33, parm);
-		update_power_state(codec, 0x1c, parm);
-		update_power_state(codec, 0x3c, parm);
-	} else {
-		/* PW15 (31h), MW8(17h), MUX8(3bh) */
-		update_power_state(codec, 0x31, parm);
-		update_power_state(codec, 0x17, parm);
-		update_power_state(codec, 0x3b, parm);
-	}
-	/* MW9 (21h) */
-	if (imux_is_smixer || !is_aa_path_mute(codec))
-		update_power_state(codec, 0x21, AC_PWRST_D0);
-	else
-		update_power_state(codec, 0x21, AC_PWRST_D3);
-}
-
 /*
  * pin fix-up
  */
@@ -1541,8 +1063,6 @@ static int patch_vt2002P(struct hda_codec *codec)
 		spec->init_verbs[spec->num_iverbs++] = vt2002P_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt2002P;
 	return 0;
 }
 
@@ -1556,81 +1076,6 @@ static const struct hda_verb vt1812_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt1812(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	unsigned int parm;
-	unsigned int present;
-	/* inputs */
-	/* PW 5/6/7 (29h/2ah/2bh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x29, &parm);
-	set_pin_power_state(codec, 0x2a, &parm);
-	set_pin_power_state(codec, 0x2b, &parm);
-	parm = AC_PWRST_D0;
-	/* MUX10/11 (1eh/1fh), AIW 0/1 (10h/11h) */
-	update_power_state(codec, 0x1e, parm);
-	update_power_state(codec, 0x1f, parm);
-	update_power_state(codec, 0x10, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* outputs */
-	/* AOW0 (8h)*/
-	update_power_state(codec, 0x8, AC_PWRST_D0);
-
-	/* PW4 (28h), MW4 (18h), MUX4(38h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x28, &parm);
-	update_power_state(codec, 0x18, parm);
-	update_power_state(codec, 0x38, parm);
-
-	/* PW1 (25h), MW1 (15h), MUX1(35h), AOW1 (9h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x25, &parm);
-	update_power_state(codec, 0x15, parm);
-	update_power_state(codec, 0x35, parm);
-	if (spec->gen.indep_hp_enabled)
-		update_power_state(codec, 0x9, AC_PWRST_D0);
-
-	/* Internal Speaker */
-	/* PW0 (24h), MW0(14h), MUX0(34h) */
-	present = snd_hda_jack_detect(codec, 0x25);
-
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x24, &parm);
-	if (present) {
-		update_power_state(codec, 0x14, AC_PWRST_D3);
-		update_power_state(codec, 0x34, AC_PWRST_D3);
-	} else {
-		update_power_state(codec, 0x14, AC_PWRST_D0);
-		update_power_state(codec, 0x34, AC_PWRST_D0);
-	}
-
-
-	/* Mono Out */
-	/* PW13 (31h), MW13(1ch), MUX13(3ch), MW14(3eh) */
-	present = snd_hda_jack_detect(codec, 0x28);
-
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x31, &parm);
-	if (present) {
-		update_power_state(codec, 0x1c, AC_PWRST_D3);
-		update_power_state(codec, 0x3c, AC_PWRST_D3);
-		update_power_state(codec, 0x3e, AC_PWRST_D3);
-	} else {
-		update_power_state(codec, 0x1c, AC_PWRST_D0);
-		update_power_state(codec, 0x3c, AC_PWRST_D0);
-		update_power_state(codec, 0x3e, AC_PWRST_D0);
-	}
-
-	/* PW15 (33h), MW15 (1dh), MUX15(3dh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x33, &parm);
-	update_power_state(codec, 0x1d, parm);
-	update_power_state(codec, 0x3d, parm);
-
-}
-
 /* patch for vt1812 */
 static int patch_vt1812(struct hda_codec *codec)
 {
@@ -1657,8 +1102,6 @@ static int patch_vt1812(struct hda_codec *codec)
 	spec->init_verbs[spec->num_iverbs++]  = vt1812_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state =  set_widgets_power_state_vt1812;
 	return 0;
 }
 
@@ -1674,84 +1117,6 @@ static const struct hda_verb vt3476_init_verbs[] = {
 	{ }
 };
 
-static void set_widgets_power_state_vt3476(struct hda_codec *codec)
-{
-	struct via_spec *spec = codec->spec;
-	int imux_is_smixer;
-	unsigned int parm, parm2;
-	/* MUX10 (1eh) = stereo mixer */
-	imux_is_smixer =
-	snd_hda_codec_read(codec, 0x1e, 0, AC_VERB_GET_CONNECT_SEL, 0x00) == 4;
-	/* inputs */
-	/* PW 5/6/7 (29h/2ah/2bh) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x29, &parm);
-	set_pin_power_state(codec, 0x2a, &parm);
-	set_pin_power_state(codec, 0x2b, &parm);
-	if (imux_is_smixer)
-		parm = AC_PWRST_D0;
-	/* MUX10/11 (1eh/1fh), AIW 0/1 (10h/11h) */
-	update_power_state(codec, 0x1e, parm);
-	update_power_state(codec, 0x1f, parm);
-	update_power_state(codec, 0x10, parm);
-	update_power_state(codec, 0x11, parm);
-
-	/* outputs */
-	/* PW3 (27h), MW3(37h), AOW3 (bh) */
-	if (spec->codec_type == VT1705CF) {
-		parm = AC_PWRST_D3;
-		update_power_state(codec, 0x27, parm);
-		update_power_state(codec, 0x37, parm);
-	}	else {
-		parm = AC_PWRST_D3;
-		set_pin_power_state(codec, 0x27, &parm);
-		update_power_state(codec, 0x37, parm);
-	}
-
-	/* PW2 (26h), MW2(36h), AOW2 (ah) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x26, &parm);
-	update_power_state(codec, 0x36, parm);
-	if (smart51_enabled(codec)) {
-		/* PW7(2bh), MW7(3bh), MUX7(1Bh) */
-		set_pin_power_state(codec, 0x2b, &parm);
-		update_power_state(codec, 0x3b, parm);
-		update_power_state(codec, 0x1b, parm);
-	}
-	update_conv_power_state(codec, 0xa, parm, 2);
-
-	/* PW1 (25h), MW1(35h), AOW1 (9h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x25, &parm);
-	update_power_state(codec, 0x35, parm);
-	if (smart51_enabled(codec)) {
-		/* PW6(2ah), MW6(3ah), MUX6(1ah) */
-		set_pin_power_state(codec, 0x2a, &parm);
-		update_power_state(codec, 0x3a, parm);
-		update_power_state(codec, 0x1a, parm);
-	}
-	update_conv_power_state(codec, 0x9, parm, 1);
-
-	/* PW4 (28h), MW4 (38h), MUX4(18h), AOW3(bh)/AOW0(8h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x28, &parm);
-	update_power_state(codec, 0x38, parm);
-	update_power_state(codec, 0x18, parm);
-	if (spec->gen.indep_hp_enabled)
-		update_conv_power_state(codec, 0xb, parm, 3);
-	parm2 = parm; /* for pin 0x0b */
-
-	/* PW0 (24h), MW0(34h), MW9(3fh), AOW0 (8h) */
-	parm = AC_PWRST_D3;
-	set_pin_power_state(codec, 0x24, &parm);
-	update_power_state(codec, 0x34, parm);
-	if (!spec->gen.indep_hp_enabled && parm2 != AC_PWRST_D3)
-		parm = parm2;
-	update_conv_power_state(codec, 0x8, parm, 0);
-	/* MW9 (21h), Mw2 (1ah), AOW0 (8h) */
-	update_power_state(codec, 0x3f, imux_is_smixer ? AC_PWRST_D0 : parm);
-}
-
 static int patch_vt3476(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -1775,9 +1140,6 @@ static int patch_vt3476(struct hda_codec *codec)
 	spec->init_verbs[spec->num_iverbs++] = vt3476_init_verbs;
 
 	codec->patch_ops = via_patch_ops;
-
-	spec->set_widgets_power_state = set_widgets_power_state_vt3476;
-
 	return 0;
 }
 
-- 
2.3.3
