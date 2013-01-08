From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 004/112] ALSA: hda/realtek - Manage mixer
	controls in out_path list
Date: Tue,  8 Jan 2013 12:37:57 +0100
Message-ID: <1357645185-7645-5-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A504F2615BF
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 13103A51CB
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

As we parse the output paths more precisely now, we can use this path
list for parsing the widgets for volume and mute mixer controls.
The spec->vol_ctls[] and sw_ctls[] bitmasks are replaced with the
ctls[] in each output path instance.

Interestingly, this move alone automagically fixes some bugs that the
conflicting volume or mute NIDs weren't properly detected.
Also, by parsing the whole path, there are more chances to get a free
widget for volume/mute controls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 230 ++++++++++++++++++++++++------------------
 1 file changed, 131 insertions(+), 99 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9e0516d..298e046 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -116,6 +116,8 @@ struct nid_path {
 	unsigned int ctls[2]; /* 0 = volume, 1 = mute */
 };
 
+enum { NID_PATH_VOL_CTL = 0, NID_PATH_MUTE_CTL = 1 };
+
 struct alc_spec {
 	struct hda_gen_spec gen;
 
@@ -150,8 +152,6 @@ struct alc_spec {
 	const hda_nid_t *capsrc_nids;
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
-	DECLARE_BITMAP(vol_ctls, MAX_VOL_NIDS << 1);
-	DECLARE_BITMAP(sw_ctls, MAX_VOL_NIDS << 1);
 
 	/* capture setup for dynamic dual-adc switch */
 	hda_nid_t cur_adc;
@@ -2886,22 +2886,6 @@ static hda_nid_t alc_go_down_to_selector(struct hda_codec *codec, hda_nid_t pin)
 	return srcs[0];
 }
 
-/* get MIX nid connected to the given pin targeted to DAC */
-static hda_nid_t alc_auto_dac_to_mix(struct hda_codec *codec, hda_nid_t pin,
-				   hda_nid_t dac)
-{
-	hda_nid_t mix[5];
-	int i, num;
-
-	pin = alc_go_down_to_selector(codec, pin);
-	num = snd_hda_get_connections(codec, pin, mix, ARRAY_SIZE(mix));
-	for (i = 0; i < num; i++) {
-		if (alc_auto_mix_to_dac(codec, mix[i]) == dac)
-			return mix[i];
-	}
-	return 0;
-}
-
 /* select the connection from pin to DAC if needed */
 static int alc_auto_select_dac(struct hda_codec *codec, hda_nid_t pin,
 			       hda_nid_t dac)
@@ -3049,29 +3033,28 @@ static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 	return nid_found;
 }
 
-/* mark up volume and mute control NIDs: used during badness parsing and
- * at creating actual controls
- */
-static inline unsigned int get_ctl_pos(unsigned int data)
+static bool is_ctl_used(struct hda_codec *codec, unsigned int val, int type)
 {
-	hda_nid_t nid = get_amp_nid_(data);
-	unsigned int dir;
-	if (snd_BUG_ON(nid >= MAX_VOL_NIDS))
-		return 0;
-	dir = get_amp_direction_(data);
-	return (nid << 1) | dir;
-}
+	struct alc_spec *spec = codec->spec;
+	int i;
 
-#define is_ctl_used(bits, data) \
-	test_bit(get_ctl_pos(data), bits)
-#define mark_ctl_usage(bits, data) \
-	set_bit(get_ctl_pos(data), bits)
+	for (i = 0; i < spec->out_path.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+		if (path->ctls[type] == val)
+			return true;
+	}
+	return false;
+}
 
 static void clear_vol_marks(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	memset(spec->vol_ctls, 0, sizeof(spec->vol_ctls));
-	memset(spec->sw_ctls, 0, sizeof(spec->sw_ctls));
+	int i;
+
+	for (i = 0; i < spec->out_path.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+		path->ctls[0] = path->ctls[1] = 0;
+	}
 }
 
 /* badness definition */
@@ -3097,9 +3080,9 @@ enum {
 };
 
 static hda_nid_t alc_look_for_out_mute_nid(struct hda_codec *codec,
-					   hda_nid_t pin, hda_nid_t dac);
+					   struct nid_path *path);
 static hda_nid_t alc_look_for_out_vol_nid(struct hda_codec *codec,
-					  hda_nid_t pin, hda_nid_t dac);
+					  struct nid_path *path);
 
 static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
 			     hda_nid_t dac)
@@ -3118,34 +3101,56 @@ static bool add_new_out_path(struct hda_codec *codec, hda_nid_t pin,
 	return false;
 }
 
+/* get the path pointing from the given dac to pin;
+ * passing 0 to either @pin or @dac behaves as a wildcard
+ */
+static struct nid_path *get_out_path(struct hda_codec *codec, hda_nid_t pin,
+				     hda_nid_t dac)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->out_path.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->out_path, i);
+		if (path->depth <= 0)
+			continue;
+		if ((!dac || path->path[0] == dac) &&
+		    (!pin || path->path[path->depth - 1] == pin))
+			return path;
+	}
+	return NULL;
+}
+
 static int eval_shared_vol_badness(struct hda_codec *codec, hda_nid_t pin,
 				   hda_nid_t dac)
 {
-	struct alc_spec *spec = codec->spec;
+	struct nid_path *path = get_out_path(codec, pin, dac);
 	hda_nid_t nid;
 	unsigned int val;
 	int badness = 0;
 
-	nid = alc_look_for_out_vol_nid(codec, pin, dac);
+	if (!path)
+		return BAD_SHARED_VOL * 2;
+	nid = alc_look_for_out_vol_nid(codec, path);
 	if (nid) {
 		val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
-		if (is_ctl_used(spec->vol_ctls, nid))
+		if (is_ctl_used(codec, val, NID_PATH_VOL_CTL))
 			badness += BAD_SHARED_VOL;
 		else
-			mark_ctl_usage(spec->vol_ctls, val);
+			path->ctls[NID_PATH_VOL_CTL] = val;
 	} else
 		badness += BAD_SHARED_VOL;
-	nid = alc_look_for_out_mute_nid(codec, pin, dac);
+	nid = alc_look_for_out_mute_nid(codec, path);
 	if (nid) {
 		unsigned int wid_type = get_wcaps_type(get_wcaps(codec, nid));
 		if (wid_type == AC_WID_PIN || wid_type == AC_WID_AUD_OUT)
 			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
 		else
 			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
-		if (is_ctl_used(spec->sw_ctls, val))
+		if (is_ctl_used(codec, val, NID_PATH_MUTE_CTL))
 			badness += BAD_SHARED_VOL;
 		else
-			mark_ctl_usage(spec->sw_ctls, val);
+			path->ctls[NID_PATH_MUTE_CTL] = val;
 	} else
 		badness += BAD_SHARED_VOL;
 	return badness;
@@ -3279,7 +3284,6 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	memset(spec->multiout.extra_out_nid, 0, sizeof(spec->multiout.extra_out_nid));
 	spec->multi_ios = 0;
 	snd_array_free(&spec->out_path);
-	clear_vol_marks(codec);
 	badness = 0;
 
 	/* fill hard-wired DACs first */
@@ -3521,10 +3525,13 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 		      cfg->line_out_type, best_wired, best_mio);
 	debug_show_configs(spec, cfg);
 
-	if (cfg->line_out_pins[0])
-		spec->vmaster_nid =
-			alc_look_for_out_vol_nid(codec, cfg->line_out_pins[0],
-						 spec->multiout.dac_nids[0]);
+	if (cfg->line_out_pins[0]) {
+		struct nid_path *path = get_out_path(codec,
+						     cfg->line_out_pins[0],
+						     spec->multiout.dac_nids[0]);
+		if (path)
+			spec->vmaster_nid = alc_look_for_out_vol_nid(codec, path);
+	}
 
 	/* clear the bitmap flags for creating controls */
 	clear_vol_marks(codec);
@@ -3533,43 +3540,43 @@ static int alc_auto_fill_dac_nids(struct hda_codec *codec)
 }
 
 static int alc_auto_add_vol_ctl(struct hda_codec *codec,
-			      const char *pfx, int cidx,
-			      hda_nid_t nid, unsigned int chs)
+				const char *pfx, int cidx,
+				hda_nid_t nid, unsigned int chs,
+				struct nid_path *path)
 {
-	struct alc_spec *spec = codec->spec;
 	unsigned int val;
-	if (!nid)
+	if (!nid || !path)
 		return 0;
 	val = HDA_COMPOSE_AMP_VAL(nid, chs, 0, HDA_OUTPUT);
-	if (is_ctl_used(spec->vol_ctls, val) && chs != 2) /* exclude LFE */
+	if (is_ctl_used(codec, val, NID_PATH_VOL_CTL) && chs != 2) /* exclude LFE */
 		return 0;
-	mark_ctl_usage(spec->vol_ctls, val);
+	path->ctls[NID_PATH_VOL_CTL] = val;
 	return __add_pb_vol_ctrl(codec->spec, ALC_CTL_WIDGET_VOL, pfx, cidx,
 				 val);
 }
 
 static int alc_auto_add_stereo_vol(struct hda_codec *codec,
 				   const char *pfx, int cidx,
-				   hda_nid_t nid)
+				   hda_nid_t nid, struct nid_path *path)
 {
 	int chs = 1;
 	if (get_wcaps(codec, nid) & AC_WCAP_STEREO)
 		chs = 3;
-	return alc_auto_add_vol_ctl(codec, pfx, cidx, nid, chs);
+	return alc_auto_add_vol_ctl(codec, pfx, cidx, nid, chs, path);
 }
 
 /* create a mute-switch for the given mixer widget;
  * if it has multiple sources (e.g. DAC and loopback), create a bind-mute
  */
 static int alc_auto_add_sw_ctl(struct hda_codec *codec,
-			     const char *pfx, int cidx,
-			     hda_nid_t nid, unsigned int chs)
+			       const char *pfx, int cidx,
+			       hda_nid_t nid, unsigned int chs,
+			       struct nid_path *path)
 {
-	struct alc_spec *spec = codec->spec;
 	int wid_type;
 	int type;
 	unsigned long val;
-	if (!nid)
+	if (!nid || !path)
 		return 0;
 	wid_type = get_wcaps_type(get_wcaps(codec, nid));
 	if (wid_type == AC_WID_PIN || wid_type == AC_WID_AUD_OUT) {
@@ -3582,44 +3589,46 @@ static int alc_auto_add_sw_ctl(struct hda_codec *codec,
 		type = ALC_CTL_BIND_MUTE;
 		val = HDA_COMPOSE_AMP_VAL(nid, chs, 2, HDA_INPUT);
 	}
-	if (is_ctl_used(spec->sw_ctls, val) && chs != 2) /* exclude LFE */
+	if (is_ctl_used(codec, val, NID_PATH_MUTE_CTL) && chs != 2) /* exclude LFE */
 		return 0;
-	mark_ctl_usage(spec->sw_ctls, val);
+	path->ctls[NID_PATH_MUTE_CTL] = val;
 	return __add_pb_sw_ctrl(codec->spec, type, pfx, cidx, val);
 }
 
 static int alc_auto_add_stereo_sw(struct hda_codec *codec, const char *pfx,
-				  int cidx, hda_nid_t nid)
+				  int cidx, hda_nid_t nid,
+				  struct nid_path *path)
 {
 	int chs = 1;
 	if (get_wcaps(codec, nid) & AC_WCAP_STEREO)
 		chs = 3;
-	return alc_auto_add_sw_ctl(codec, pfx, cidx, nid, chs);
+	return alc_auto_add_sw_ctl(codec, pfx, cidx, nid, chs, path);
 }
 
 static hda_nid_t alc_look_for_out_mute_nid(struct hda_codec *codec,
-					   hda_nid_t pin, hda_nid_t dac)
+					   struct nid_path *path)
 {
-	hda_nid_t mix = alc_auto_dac_to_mix(codec, pin, dac);
-	if (nid_has_mute(codec, pin, HDA_OUTPUT))
-		return pin;
-	else if (mix && nid_has_mute(codec, mix, HDA_INPUT))
-		return mix;
-	else if (nid_has_mute(codec, dac, HDA_OUTPUT))
-		return dac;
+	int i;
+
+	for (i = path->depth - 1; i >= 0; i--) {
+		if (nid_has_mute(codec, path->path[i], HDA_OUTPUT))
+			return path->path[i];
+		if (i != path->depth - 1 && i != 0 &&
+		    nid_has_mute(codec, path->path[i], HDA_INPUT))
+			return path->path[i];
+	}
 	return 0;
 }
 
 static hda_nid_t alc_look_for_out_vol_nid(struct hda_codec *codec,
-					  hda_nid_t pin, hda_nid_t dac)
-{
-	hda_nid_t mix = alc_auto_dac_to_mix(codec, pin, dac);
-	if (nid_has_volume(codec, dac, HDA_OUTPUT))
-		return dac;
-	else if (nid_has_volume(codec, mix, HDA_OUTPUT))
-		return mix;
-	else if (nid_has_volume(codec, pin, HDA_OUTPUT))
-		return pin;
+					  struct nid_path *path)
+{
+	int i;
+
+	for (i = path->depth - 1; i >= 0; i--) {
+		if (nid_has_volume(codec, path->path[i], HDA_OUTPUT))
+			return path->path[i];
+	}
 	return 0;
 }
 
@@ -3639,6 +3648,7 @@ static int alc_auto_create_multi_out_ctls(struct hda_codec *codec,
 		int index;
 		hda_nid_t dac, pin;
 		hda_nid_t sw, vol;
+		struct nid_path *path;
 
 		dac = spec->multiout.dac_nids[i];
 		if (!dac)
@@ -3652,27 +3662,36 @@ static int alc_auto_create_multi_out_ctls(struct hda_codec *codec,
 			name = alc_get_line_out_pfx(spec, i, true, &index);
 		}
 
-		sw = alc_look_for_out_mute_nid(codec, pin, dac);
-		vol = alc_look_for_out_vol_nid(codec, pin, dac);
+		path = get_out_path(codec, pin, dac);
+		if (!path)
+			continue;
+		sw = alc_look_for_out_mute_nid(codec, path);
+		vol = alc_look_for_out_vol_nid(codec, path);
 		if (!name || !strcmp(name, "CLFE")) {
 			/* Center/LFE */
-			err = alc_auto_add_vol_ctl(codec, "Center", 0, vol, 1);
+			err = alc_auto_add_vol_ctl(codec, "Center", 0, vol, 1,
+						   path);
 			if (err < 0)
 				return err;
-			err = alc_auto_add_vol_ctl(codec, "LFE", 0, vol, 2);
+			err = alc_auto_add_vol_ctl(codec, "LFE", 0, vol, 2,
+						   path);
 			if (err < 0)
 				return err;
-			err = alc_auto_add_sw_ctl(codec, "Center", 0, sw, 1);
+			err = alc_auto_add_sw_ctl(codec, "Center", 0, sw, 1,
+						  path);
 			if (err < 0)
 				return err;
-			err = alc_auto_add_sw_ctl(codec, "LFE", 0, sw, 2);
+			err = alc_auto_add_sw_ctl(codec, "LFE", 0, sw, 2,
+						  path);
 			if (err < 0)
 				return err;
 		} else {
-			err = alc_auto_add_stereo_vol(codec, name, index, vol);
+			err = alc_auto_add_stereo_vol(codec, name, index, vol,
+						      path);
 			if (err < 0)
 				return err;
-			err = alc_auto_add_stereo_sw(codec, name, index, sw);
+			err = alc_auto_add_stereo_sw(codec, name, index, sw,
+						     path);
 			if (err < 0)
 				return err;
 		}
@@ -3685,9 +3704,14 @@ static int alc_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 				     int cidx)
 {
 	struct alc_spec *spec = codec->spec;
+	struct nid_path *path;
 	hda_nid_t sw, vol;
 	int err;
 
+	path = get_out_path(codec, pin, dac);
+	if (!path)
+		return 0;
+
 	if (!dac) {
 		unsigned int val;
 		/* the corresponding DAC is already occupied */
@@ -3695,18 +3719,18 @@ static int alc_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 			return 0; /* no way */
 		/* create a switch only */
 		val = HDA_COMPOSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT);
-		if (is_ctl_used(spec->sw_ctls, val))
+		if (is_ctl_used(codec, val, NID_PATH_MUTE_CTL))
 			return 0; /* already created */
-		mark_ctl_usage(spec->sw_ctls, val);
+		path->ctls[NID_PATH_MUTE_CTL] = val;
 		return __add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, pfx, cidx, val);
 	}
 
-	sw = alc_look_for_out_mute_nid(codec, pin, dac);
-	vol = alc_look_for_out_vol_nid(codec, pin, dac);
-	err = alc_auto_add_stereo_vol(codec, pfx, cidx, vol);
+	sw = alc_look_for_out_mute_nid(codec, path);
+	vol = alc_look_for_out_vol_nid(codec, path);
+	err = alc_auto_add_stereo_vol(codec, pfx, cidx, vol, path);
 	if (err < 0)
 		return err;
-	err = alc_auto_add_stereo_sw(codec, pfx, cidx, sw);
+	err = alc_auto_add_stereo_sw(codec, pfx, cidx, sw, path);
 	if (err < 0)
 		return err;
 	return 0;
@@ -3780,9 +3804,13 @@ static int alc_auto_create_extra_outs(struct hda_codec *codec, int num_pins,
 	n = 0;
 	for (i = 0; i < num_pins; i++) {
 		hda_nid_t vol;
+		struct nid_path *path;
 		if (!pins[i] || !dacs[i])
 			continue;
-		vol = alc_look_for_out_vol_nid(codec, pins[i], dacs[i]);
+		path = get_out_path(codec, pins[i], dacs[i]);
+		if (!path)
+			continue;
+		vol = alc_look_for_out_vol_nid(codec, path);
 		if (vol)
 			ctl->values[n++] =
 				HDA_COMPOSE_AMP_VAL(vol, 3, 0, HDA_OUTPUT);
@@ -3821,6 +3849,7 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 	int i, num;
 	hda_nid_t nid, mix = 0;
 	hda_nid_t srcs[HDA_MAX_CONNECTIONS];
+	struct nid_path *path;
 
 	alc_set_pin_output(codec, pin, pin_type);
 	nid = alc_go_down_to_selector(codec, pin);
@@ -3845,13 +3874,16 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 			    AMP_IN_UNMUTE(1));
 	}
 	/* initialize volume */
-	nid = alc_look_for_out_vol_nid(codec, pin, dac);
+	path = get_out_path(codec, pin, dac);
+	if (!path)
+		return;
+	nid = alc_look_for_out_vol_nid(codec, path);
 	if (nid)
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 				    AMP_OUT_ZERO);
 
 	/* unmute DAC if it's not assigned to a mixer */
-	nid = alc_look_for_out_mute_nid(codec, pin, dac);
+	nid = alc_look_for_out_mute_nid(codec, path);
 	if (nid == mix && nid_has_mute(codec, dac, HDA_OUTPUT))
 		snd_hda_codec_write(codec, dac, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 				    AMP_OUT_ZERO);
-- 
1.8.0.1
