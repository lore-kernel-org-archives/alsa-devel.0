From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 10/16] ALSA: VIA HDA: Add support for VT1705
Date: Mon, 21 Mar 2011 15:32:26 +0800
Message-ID: <4D86FF0A.4090107@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BD79243E0
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:32:29 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Add support for VT1705.

Add support for VT1705 codec, which is similiar with VT1708S.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |  179 +++++++++++++++++++++++++++++--
 1 file changed, 172 insertions(+), 7 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3253,6 +3253,16 @@
 				    AC_VERB_SET_POWER_STATE, parm);
 		snd_hda_codec_write(codec, 0x24, 0,
 				    AC_VERB_SET_POWER_STATE, parm);
+	} else if (codec->vendor_id == 0x11064397) {
+		/* PW7(23h), SW2(27h), AOW2(25h) */
+		parm = AC_PWRST_D3;
+		set_pin_power_state(codec, 0x23, &parm);
+		if (spec->smart51_enabled)
+			set_pin_power_state(codec, 0x1a, &parm);
+		snd_hda_codec_write(codec, 0x27, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
+		snd_hda_codec_write(codec, 0x25, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
 	}
 
 	/* PW 3/4/7 (1ch/1dh/23h) */
@@ -3272,7 +3282,9 @@
 				    AC_VERB_SET_POWER_STATE, parm);
 		snd_hda_codec_write(codec, 0x27, 0,
 				    AC_VERB_SET_POWER_STATE, parm);
-	}
+	} else if (codec->vendor_id == 0x11064397 && spec->hp_independent_mode)
+		snd_hda_codec_write(codec, 0x25, 0,
+				    AC_VERB_SET_POWER_STATE, parm);
 }
 
 static int patch_vt1708S(struct hda_codec *codec);
@@ -3447,6 +3459,18 @@
 	{ }
 };
 
+static struct hda_verb vt1705_uniwill_init_verbs[] = {
+	{0x1d, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1e, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x23, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{ }
+};
+
 static struct hda_pcm_stream vt1708S_pcm_analog_playback = {
 	.substreams = 2,
 	.channels_min = 2,
@@ -3460,6 +3484,19 @@
 	},
 };
 
+static struct hda_pcm_stream vt1705_pcm_analog_playback = {
+	.substreams = 2,
+	.channels_min = 2,
+	.channels_max = 6,
+	.nid = 0x10, /* NID to query formats and rates */
+	.ops = {
+		.open = via_playback_pcm_open,
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close
+	},
+};
+
 static struct hda_pcm_stream vt1708S_pcm_analog_capture = {
 	.substreams = 2,
 	.channels_min = 2,
@@ -3506,7 +3543,10 @@
 				spec->multiout.dac_nids[i] = 0x10;
 				break;
 			case AUTO_SEQ_CENLFE:
-				spec->multiout.dac_nids[i] = 0x24;
+				if (spec->codec->vendor_id == 0x11064397)
+					spec->multiout.dac_nids[i] = 0x25;
+				else
+					spec->multiout.dac_nids[i] = 0x24;
 				break;
 			case AUTO_SEQ_SURROUND:
 				spec->multiout.dac_nids[i] = 0x11;
@@ -3522,7 +3562,10 @@
 	if (cfg->line_outs == 1) {
 		spec->multiout.num_dacs = 3;
 		spec->multiout.dac_nids[AUTO_SEQ_SURROUND] = 0x11;
-		spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x24;
+		if (spec->codec->vendor_id == 0x11064397)
+			spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x25;
+		else
+			spec->multiout.dac_nids[AUTO_SEQ_CENLFE] = 0x24;
 	}
 
 	return 0;
@@ -3628,6 +3671,104 @@
 	return 0;
 }
 
+/* add playback controls from the parsed DAC table */
+static int vt1705_auto_create_multi_out_ctls(struct via_spec *spec,
+					     const struct auto_pin_cfg *cfg)
+{
+	char name[32];
+	static const char * const chname[3] = { "Front", "Surround", "C/LFE" };
+	hda_nid_t nid_vols[] = {0x10, 0x11, 0x25};
+	hda_nid_t nid_mutes[] = {0x1C, 0x18, 0x27};
+	hda_nid_t nid, nid_vol, nid_mute;
+	int i, err;
+
+	for (i = 0; i < AUTO_SEQ_SIDE; i++) {
+		nid = cfg->line_out_pins[i];
+
+		/* for Smart 5.1, there are always at least six channels */
+		if (!nid && i > AUTO_SEQ_CENLFE)
+			continue;
+
+		nid_vol = nid_vols[i];
+		nid_mute = nid_mutes[i];
+
+		if (i == AUTO_SEQ_CENLFE) {
+			/* Center/LFE */
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "Center Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 1, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "LFE Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 2, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "Center Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  1, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "LFE Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  2, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		} else if (i == AUTO_SEQ_FRONT) {
+			/* add control to mixer index 0 */
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
+					      "Master Front Playback Volume",
+					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
+					      "Master Front Playback Switch",
+					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
+								  HDA_INPUT));
+			if (err < 0)
+				return err;
+
+			/* Front */
+			sprintf(name, "%s Playback Volume", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		} else {
+			sprintf(name, "%s Playback Volume", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+			sprintf(name, "%s Playback Switch", chname[i]);
+			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+					      HDA_COMPOSE_AMP_VAL(nid_mute,
+								  3, 0,
+								  HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int vt1708S_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
 {
 	int err;
@@ -3703,7 +3844,10 @@
 	if (!spec->autocfg.line_outs && !spec->autocfg.hp_pins[0])
 		return 0; /* can't find valid BIOS pin config */
 
-	err = vt1708S_auto_create_multi_out_ctls(spec, &spec->autocfg);
+	if (codec->vendor_id == 0x11064397)
+		err = vt1705_auto_create_multi_out_ctls(spec, &spec->autocfg);
+	else
+		err = vt1708S_auto_create_multi_out_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
 	err = vt1708S_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
@@ -3770,17 +3914,30 @@
 	}
 
 	spec->init_verbs[spec->num_iverbs++] = vt1708S_volume_init_verbs;
-	spec->init_verbs[spec->num_iverbs++] = vt1708S_uniwill_init_verbs;
+	if (codec->vendor_id == 0x11064397)
+		spec->init_verbs[spec->num_iverbs++] =
+			vt1705_uniwill_init_verbs;
+	else
+		spec->init_verbs[spec->num_iverbs++] =
+			vt1708S_uniwill_init_verbs;
 
 	if (codec->vendor_id == 0x11060440)
 		spec->stream_name_analog = "VT1818S Analog";
+	else if (codec->vendor_id == 0x11064397)
+		spec->stream_name_analog = "VT1705 Analog";
 	else
 		spec->stream_name_analog = "VT1708S Analog";
-	spec->stream_analog_playback = &vt1708S_pcm_analog_playback;
+
+	if (codec->vendor_id == 0x11064397)
+		spec->stream_analog_playback = &vt1705_pcm_analog_playback;
+	else
+		spec->stream_analog_playback = &vt1708S_pcm_analog_playback;
 	spec->stream_analog_capture = &vt1708S_pcm_analog_capture;
 
 	if (codec->vendor_id == 0x11060440)
 		spec->stream_name_digital = "VT1818S Digital";
+	else if (codec->vendor_id == 0x11064397)
+		spec->stream_name_digital = "VT1705 Digital";
 	else
 		spec->stream_name_digital = "VT1708S Digital";
 	spec->stream_digital_playback = &vt1708S_pcm_digital_playback;
@@ -3813,6 +3970,14 @@
 		spec->stream_name_analog = "VT1708BCE Analog";
 		spec->stream_name_digital = "VT1708BCE Digital";
 	}
+	/* correct names for VT1705 */
+	if (codec->vendor_id == 0x11064397)	{
+		kfree(codec->chip_name);
+		codec->chip_name = kstrdup("VT1705", GFP_KERNEL);
+		snprintf(codec->bus->card->mixername,
+			 sizeof(codec->bus->card->mixername),
+			 "%s %s", codec->vendor_name, codec->chip_name);
+	}
 	spec->set_widgets_power_state =  set_widgets_power_state_vt1708B;
 	return 0;
 }
@@ -6164,7 +6329,7 @@
 	  .patch = patch_vt1708S},
 	{ .id = 0x11063397, .name = "VT1708S",
 	  .patch = patch_vt1708S},
-	{ .id = 0x11064397, .name = "VT1708S",
+	{ .id = 0x11064397, .name = "VT1705",
 	  .patch = patch_vt1708S},
 	{ .id = 0x11065397, .name = "VT1708S",
 	  .patch = patch_vt1708S},
