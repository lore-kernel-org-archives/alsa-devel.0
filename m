From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda - Create Capture Source enum
	even for auto-mic mode
Date: Fri, 30 Nov 2012 09:15:59 +0100
Message-ID: <1354263363-25398-2-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354263363-25398-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 99B5E265CAD
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:16:22 +0100 (CET)
In-Reply-To: <1354263363-25398-1-git-send-email-tiwai@suse.de>
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

Create "Capture Source" control even when the driver is running in the
auto-mic mode.  This allows user to switch to the non-standard input
source.

When the input source is changed automatically via jack detection, the
value change is notified to this control as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d3a4c2ca..909a623 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -349,7 +349,7 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 
 /* select the given imux item; either unmute exclusively or select the route */
 static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
-			  unsigned int idx, bool force)
+			  unsigned int idx, bool force, bool notify)
 {
 	struct alc_spec *spec = codec->spec;
 	const struct hda_input_mux *imux;
@@ -404,6 +404,16 @@ static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
 					  imux->items[idx].index);
 	}
 	alc_inv_dmic_sync(codec, true);
+
+	if (notify) {
+		struct snd_ctl_elem_id id;
+		memset(&id, 0, sizeof(id));
+		id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		strcpy(id.name, "Capture Source");
+		snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &id);
+	}
+
 	return 1;
 }
 
@@ -413,7 +423,7 @@ static int alc_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	return alc_mux_select(codec, adc_idx,
-			      ucontrol->value.enumerated.item[0], false);
+			      ucontrol->value.enumerated.item[0], false, false);
 }
 
 /*
@@ -653,11 +663,12 @@ static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 
 	for (i = spec->am_num_entries - 1; i > 0; i--) {
 		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
-			alc_mux_select(codec, 0, spec->am_entry[i].idx, false);
+			alc_mux_select(codec, 0, spec->am_entry[i].idx, false,
+				       true);
 			return;
 		}
 	}
-	alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
+	alc_mux_select(codec, 0, spec->am_entry[0].idx, false, true);
 }
 
 /* update the master volume per volume-knob's unsol event */
@@ -1655,7 +1666,7 @@ static int alc_cap_sw_put(struct snd_kcontrol *kcontrol,
 	{ \
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 		/* .name = "Capture Source", */ \
-		.name = "Input Source", \
+		.name = num == 1 ? "Capture Source" : "Input Source", \
 		.count = num, \
 		.info = alc_mux_enum_info, \
 		.get = alc_mux_enum_get, \
@@ -4103,7 +4114,7 @@ static void alc_auto_init_input_src(struct hda_codec *codec)
 	else
 		nums = spec->num_adc_nids;
 	for (c = 0; c < nums; c++)
-		alc_mux_select(codec, c, spec->cur_mux[c], true);
+		alc_mux_select(codec, c, spec->cur_mux[c], true, false);
 }
 
 /* add mic boosts if needed */
@@ -4217,11 +4228,10 @@ static void set_capture_mixer(struct hda_codec *codec)
 
 		if (spec->input_mux && spec->input_mux->num_items > 1)
 			mux = 1;
-		if (spec->auto_mic) {
-			num_adcs = 1;
-			mux = 0;
-		} else if (spec->dyn_adc_switch)
+		if (spec->auto_mic || spec->dyn_adc_switch) {
 			num_adcs = 1;
+			mux = 1;
+		}
 		if (!num_adcs) {
 			if (spec->num_adc_nids > 3)
 				spec->num_adc_nids = 3;
@@ -6000,7 +6010,7 @@ static void alc221_shared_fmic_hp_mode_update(struct hda_codec *codec)
 		pinctl = PIN_HP;
 		mute = AMP_OUT_UNMUTE;
 		spec->auto_mic = 0;
-		alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
+		alc_mux_select(codec, 0, spec->am_entry[0].idx, false, true);
 		/* choose the same DAC as the primary HP output */
 		idx = snd_hda_codec_read(codec, spec->autocfg.hp_pins[0], 0,
 					 AC_VERB_GET_CONNECT_SEL, 0);
-- 
1.8.0.1
