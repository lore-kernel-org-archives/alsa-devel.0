From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 007/112] ALSA: hda/realtek - Simplify the
	output volume initialization
Date: Tue,  8 Jan 2013 12:38:00 +0100
Message-ID: <1357645185-7645-8-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F23962615F2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 192F5A51F4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Simplify the output path initialization using the existing path
information instead of assuming the topology specific to Realtek
codecs.  This is also implicitly a fix for some amp values on output
pins where the old parser missed (e.g. ALC260 output pins).

The same function alc_auto_set_output_and_unmute() can be used now for
the multi-io activation, since the output selection means nothing but
activating the given output path.

And, finally at this stage, we can get rid of alc_go_down_to_selector()
and other functions that are codec really specifically to Realtek
codecs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 182 +++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 89 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f8dd753..a7899d1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2858,55 +2858,6 @@ static void alc_auto_init_analog_input(struct hda_codec *codec)
 	}
 }
 
-/* convert from MIX nid to DAC */
-static hda_nid_t alc_auto_mix_to_dac(struct hda_codec *codec, hda_nid_t nid)
-{
-	hda_nid_t list[5];
-	int i, num;
-
-	if (get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_AUD_OUT)
-		return nid;
-	num = snd_hda_get_connections(codec, nid, list, ARRAY_SIZE(list));
-	for (i = 0; i < num; i++) {
-		if (get_wcaps_type(get_wcaps(codec, list[i])) == AC_WID_AUD_OUT)
-			return list[i];
-	}
-	return 0;
-}
-
-/* go down to the selector widget before the mixer */
-static hda_nid_t alc_go_down_to_selector(struct hda_codec *codec, hda_nid_t pin)
-{
-	hda_nid_t srcs[5];
-	int num = snd_hda_get_connections(codec, pin, srcs,
-					  ARRAY_SIZE(srcs));
-	if (num != 1 ||
-	    get_wcaps_type(get_wcaps(codec, srcs[0])) != AC_WID_AUD_SEL)
-		return pin;
-	return srcs[0];
-}
-
-/* select the connection from pin to DAC if needed */
-static int alc_auto_select_dac(struct hda_codec *codec, hda_nid_t pin,
-			       hda_nid_t dac)
-{
-	hda_nid_t mix[5];
-	int i, num;
-
-	pin = alc_go_down_to_selector(codec, pin);
-	num = snd_hda_get_connections(codec, pin, mix, ARRAY_SIZE(mix));
-	if (num < 2)
-		return 0;
-	for (i = 0; i < num; i++) {
-		if (alc_auto_mix_to_dac(codec, mix[i]) == dac) {
-			snd_hda_codec_update_cache(codec, pin, 0,
-						   AC_VERB_SET_CONNECT_SEL, i);
-			return 0;
-		}
-	}
-	return 0;
-}
-
 static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct alc_spec *spec = codec->spec;
@@ -3825,51 +3776,102 @@ static int alc_auto_create_speaker_out(struct hda_codec *codec)
 					  "Speaker");
 }
 
-static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
-					      hda_nid_t pin, int pin_type,
-					      hda_nid_t dac)
+/* is a volume or mute control already present? */
+static bool __is_out_ctl_present(struct hda_codec *codec,
+				 struct nid_path *exclude_path,
+				 hda_nid_t nid, int dir, int types)
 {
-	int i, num;
-	hda_nid_t nid, mix = 0;
-	hda_nid_t srcs[HDA_MAX_CONNECTIONS];
-	struct nid_path *path;
+	struct alc_spec *spec = codec->spec;
+	int i, type;
 
-	alc_set_pin_output(codec, pin, pin_type);
-	nid = alc_go_down_to_selector(codec, pin);
-	num = snd_hda_get_connections(codec, nid, srcs, ARRAY_SIZE(srcs));
-	for (i = 0; i < num; i++) {
-		if (alc_auto_mix_to_dac(codec, srcs[i]) != dac)
+	for (i = 0; i < spec->out_path.used; i++) {
+		struct nid_path *p = snd_array_elem(&spec->out_path, i);
+		if (p == exclude_path || p->depth <= 0)
 			continue;
-		mix = srcs[i];
-		break;
+		for (type = 0; type < 2; type++) {
+			if (types & (1 << type)) {
+				unsigned int val = p->ctls[type];
+				if (get_amp_nid_(val) == nid &&
+				    get_amp_direction_(val) == dir)
+					return true;
+			}
+		}
 	}
-	if (!mix)
-		return;
+	return false;
+}
+
+#define is_out_ctl_present(codec, path, nid, dir) \
+	__is_out_ctl_present(codec, path, nid, dir, 3) /* check both types */
+#define is_out_vol_ctl_present(codec, nid, dir) \
+	__is_out_ctl_present(codec, NULL, nid, dir, 1 << NID_PATH_VOL_CTL)
+#define is_out_mute_ctl_present(codec, nid, dir) \
+	__is_out_ctl_present(codec, NULL, nid, dir, 1 << NID_PATH_MUTE_CTL)
+
+static int get_default_amp_val(struct hda_codec *codec, hda_nid_t nid, int dir)
+{
+	unsigned int caps, offset;
+	unsigned int val = 0;
+
+	caps = query_amp_caps(codec, nid, dir);
+	if (caps & AC_AMPCAP_NUM_STEPS) {
+		offset = (caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
+		/* if a volume control is assigned, set the lowest level
+		 * as default; otherwise set to 0dB
+		 */
+		if (is_out_vol_ctl_present(codec, nid, dir))
+			val = 0;
+		else
+			val = offset;
+	}
+	if (caps & AC_AMPCAP_MUTE) {
+		/* if a mute control is assigned, mute as default */
+		if (is_out_mute_ctl_present(codec, nid, dir))
+			val |= HDA_AMP_MUTE;
+	}
+	return val;
+}
+
+/* configure the path from the given dac to the pin as the proper output */
+static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
+					   hda_nid_t pin, int pin_type,
+					   hda_nid_t dac, bool force)
+{
+	int i, val;
+	struct nid_path *path;
 
-	/* need the manual connection? */
-	if (num > 1)
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL, i);
-	/* unmute mixer widget inputs */
-	if (nid_has_mute(codec, mix, HDA_INPUT)) {
-		snd_hda_codec_write(codec, mix, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-			    AMP_IN_UNMUTE(0));
-		snd_hda_codec_write(codec, mix, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-			    AMP_IN_UNMUTE(1));
-	}
-	/* initialize volume */
+	alc_set_pin_output(codec, pin, pin_type);
 	path = get_out_path(codec, pin, dac);
 	if (!path)
 		return;
-	nid = alc_look_for_out_vol_nid(codec, path);
-	if (nid)
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_OUT_ZERO);
 
-	/* unmute DAC if it's not assigned to a mixer */
-	nid = alc_look_for_out_mute_nid(codec, path);
-	if (nid == mix && nid_has_mute(codec, dac, HDA_OUTPUT))
-		snd_hda_codec_write(codec, dac, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_OUT_ZERO);
+	for (i = path->depth - 1; i >= 0; i--) {
+		hda_nid_t nid = path->path[i];
+		if (i > 0 && path->multi[i - 1])
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_CONNECT_SEL,
+					    path->idx[i - 1]);
+
+		if (i != 0 && i != path->depth - 1 &&
+		    (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) &&
+		    (force || !is_out_ctl_present(codec, path, nid,
+						  HDA_INPUT))) {
+			val = get_default_amp_val(codec, nid, HDA_INPUT);
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_UNMUTE(0) | val);
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_IN_UNMUTE(1) | val);
+		}
+		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
+		    (force || !is_out_ctl_present(codec, path, nid,
+						  HDA_OUTPUT))) {
+			val = get_default_amp_val(codec, nid, HDA_OUTPUT);
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_UNMUTE | val);
+		}
+	}
 }
 
 static void alc_auto_init_multi_out(struct hda_codec *codec)
@@ -3882,7 +3884,8 @@ static void alc_auto_init_multi_out(struct hda_codec *codec)
 		hda_nid_t nid = spec->autocfg.line_out_pins[i];
 		if (nid)
 			alc_auto_set_output_and_unmute(codec, nid, pin_type,
-					spec->multiout.dac_nids[i]);
+					spec->multiout.dac_nids[i], true);
+
 	}
 }
 
@@ -3905,7 +3908,7 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 			else
 				dac = spec->multiout.dac_nids[0];
 		}
-		alc_auto_set_output_and_unmute(codec, pin, PIN_HP, dac);
+		alc_auto_set_output_and_unmute(codec, pin, PIN_HP, dac, true);
 	}
 	for (i = 0; i < spec->autocfg.speaker_outs; i++) {
 		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
@@ -3920,7 +3923,7 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 			else
 				dac = spec->multiout.dac_nids[0];
 		}
-		alc_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac);
+		alc_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac, true);
 	}
 }
 
@@ -4081,7 +4084,8 @@ static int alc_set_multi_io(struct hda_codec *codec, int idx, bool output)
 		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
 						 HDA_AMP_MUTE, 0);
-		alc_auto_select_dac(codec, nid, spec->multi_io[idx].dac);
+		alc_auto_set_output_and_unmute(codec, nid, PIN_OUT,
+					       spec->multi_io[idx].dac, false);
 	} else {
 		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
 			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-- 
1.8.0.1
