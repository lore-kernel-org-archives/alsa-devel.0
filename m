From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 017/112] ALSA: hda/realtek - Add path active
	flag
Date: Tue,  8 Jan 2013 12:38:10 +0100
Message-ID: <1357645185-7645-18-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF39265197
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 3BD6AA5204
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

... and rewrite the initialization of output paths as a generic
function that is applicable for both i/o directions.

The new flag, active, is introduced to each nid_path entry.  This
indicates whether the given path is active, and it's used for checking
whether a certain widget can be turned off or changed when a path is
no longer used or newly enabled.

It's still used only in the output paths.  More wider adaption for
input and loopback paths will be achieved in the later patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_local.h     |   3 +-
 sound/pci/hda/patch_realtek.c | 261 ++++++++++++++++++++++++++++--------------
 2 files changed, 176 insertions(+), 88 deletions(-)

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index e38519b..ff56da8 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -598,7 +598,8 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 #define get_amp_channels(kc)	(((kc)->private_value >> 16) & 0x3)
 #define get_amp_direction_(pv)	(((pv) >> 18) & 0x1)
 #define get_amp_direction(kc)	get_amp_direction_((kc)->private_value)
-#define get_amp_index(kc)	(((kc)->private_value >> 19) & 0xf)
+#define get_amp_index_(pv)	(((pv) >> 19) & 0xf)
+#define get_amp_index(kc)	get_amp_index_((kc)->private_value)
 #define get_amp_offset(kc)	(((kc)->private_value >> 23) & 0x3f)
 #define get_amp_min_mute(kc)	(((kc)->private_value >> 29) & 0x1)
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d964c88..84f6781 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -112,6 +112,7 @@ struct nid_path {
 	unsigned char idx[MAX_NID_PATH_DEPTH];
 	unsigned char multi[MAX_NID_PATH_DEPTH];
 	unsigned int ctls[2]; /* 0 = volume, 1 = mute */
+	bool active;
 };
 
 enum { NID_PATH_VOL_CTL = 0, NID_PATH_MUTE_CTL = 1 };
@@ -2853,16 +2854,6 @@ static int alc_auto_create_shared_input(struct hda_codec *codec)
 	return 0;
 }
 
-static void alc_set_pin_output(struct hda_codec *codec, hda_nid_t nid,
-			       unsigned int pin_type)
-{
-	snd_hda_set_pin_ctl(codec, nid, pin_type);
-	/* unmute pin */
-	if (nid_has_mute(codec, nid, HDA_OUTPUT))
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-			    AMP_OUT_UNMUTE);
-}
-
 static int get_pin_type(int line_out_type)
 {
 	if (line_out_type == AUTO_PIN_HP_OUT)
@@ -3824,23 +3815,21 @@ static int alc_auto_create_speaker_out(struct hda_codec *codec)
 					  "Speaker");
 }
 
-/* is a volume or mute control already present? */
-static bool __is_out_ctl_present(struct hda_codec *codec,
-				 struct nid_path *exclude_path,
-				 hda_nid_t nid, int dir, int types)
+static bool is_ctl_associated_in_list(struct snd_array *array, hda_nid_t nid,
+				      int dir, int idx, int types)
 {
-	struct alc_spec *spec = codec->spec;
 	int i, type;
 
-	for (i = 0; i < spec->out_path.used; i++) {
-		struct nid_path *p = snd_array_elem(&spec->out_path, i);
-		if (p == exclude_path || p->depth <= 0)
+	for (i = 0; i < array->used; i++) {
+		struct nid_path *p = snd_array_elem(array, i);
+		if (p->depth <= 0)
 			continue;
 		for (type = 0; type < 2; type++) {
 			if (types & (1 << type)) {
 				unsigned int val = p->ctls[type];
 				if (get_amp_nid_(val) == nid &&
-				    get_amp_direction_(val) == dir)
+				    get_amp_direction_(val) == dir &&
+				    get_amp_index_(val) == idx)
 					return true;
 			}
 		}
@@ -3848,85 +3837,183 @@ static bool __is_out_ctl_present(struct hda_codec *codec,
 	return false;
 }
 
-#define is_out_ctl_present(codec, path, nid, dir) \
-	__is_out_ctl_present(codec, path, nid, dir, 3) /* check both types */
-#define is_out_vol_ctl_present(codec, nid, dir) \
-	__is_out_ctl_present(codec, NULL, nid, dir, 1 << NID_PATH_VOL_CTL)
-#define is_out_mute_ctl_present(codec, nid, dir) \
-	__is_out_ctl_present(codec, NULL, nid, dir, 1 << NID_PATH_MUTE_CTL)
+/* check whether a control with the given (nid, dir, idx) was assigned */
+static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
+			      int dir, int idx)
+{
+	struct alc_spec *spec = codec->spec;
+	return is_ctl_associated_in_list(&spec->out_path, nid, dir, idx, 3) ||
+		is_ctl_associated_in_list(&spec->in_path, nid, dir, idx, 3) ||
+		is_ctl_associated_in_list(&spec->loopback_path, nid, dir, idx, 3);
+}
 
-static int get_default_amp_val(struct hda_codec *codec, hda_nid_t nid, int dir)
+/* can have the amp-in capability? */
+static bool has_amp_in(struct hda_codec *codec, struct nid_path *path, int idx)
 {
-	unsigned int caps, offset;
+	hda_nid_t nid = path->path[idx];
+	unsigned int caps = get_wcaps(codec, nid);
+	unsigned int type = get_wcaps_type(caps);
+
+	if (!(caps & AC_WCAP_IN_AMP))
+		return false;
+	if (type == AC_WID_PIN && idx > 0) /* only for input pins */
+		return false;
+	return true;
+}
+
+/* can have the amp-out capability? */
+static bool has_amp_out(struct hda_codec *codec, struct nid_path *path, int idx)
+{
+	hda_nid_t nid = path->path[idx];
+	unsigned int caps = get_wcaps(codec, nid);
+	unsigned int type = get_wcaps_type(caps);
+
+	if (!(caps & AC_WCAP_OUT_AMP))
+		return false;
+	if (type == AC_WID_PIN && !idx) /* only for output pins */
+		return false;
+	return true;
+}
+
+static bool is_active_in_list(struct hda_codec *codec, struct snd_array *array,
+			      hda_nid_t nid, int dir, int idx)
+{
+	int i, n;
+
+	for (n = 0; n < array->used; n++) {
+		struct nid_path *path = snd_array_elem(array, n);
+		if (!path->active)
+			continue;
+		for (i = 0; i < path->depth; i++) {
+			if (path->path[i] == nid) {
+				if (dir == HDA_OUTPUT || path->idx[i] == idx)
+					return true;
+				break;
+			}
+		}
+	}
+	return false;
+}
+
+/* check whether the given (nid,dir,idx) is active */
+static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned int idx, unsigned int dir)
+{
+	struct alc_spec *spec = codec->spec;
+	return is_active_in_list(codec, &spec->out_path, nid, idx, dir) ||
+		is_active_in_list(codec, &spec->in_path, nid, idx, dir) ||
+		is_active_in_list(codec, &spec->loopback_path, nid, idx, dir);
+}
+
+/* get the default amp value for the target state */
+static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
+				   int dir, bool enable)
+{
+	unsigned int caps;
 	unsigned int val = 0;
 
 	caps = query_amp_caps(codec, nid, dir);
 	if (caps & AC_AMPCAP_NUM_STEPS) {
-		offset = (caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
-		/* if a volume control is assigned, set the lowest level
-		 * as default; otherwise set to 0dB
-		 */
-		if (is_out_vol_ctl_present(codec, nid, dir))
-			val = 0;
-		else
-			val = offset;
+		/* set to 0dB */
+		if (enable)
+			val = (caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
 	}
 	if (caps & AC_AMPCAP_MUTE) {
-		/* if a mute control is assigned, mute as default */
-		if (is_out_mute_ctl_present(codec, nid, dir))
+		if (!enable)
 			val |= HDA_AMP_MUTE;
 	}
 	return val;
 }
 
-/* configure the path from the given dac to the pin as the proper output */
-static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
-					   hda_nid_t pin, int pin_type,
-					   hda_nid_t dac, bool force)
+/* initialize the amp value (only at the first time) */
+static void init_amp(struct hda_codec *codec, hda_nid_t nid, int dir, int idx)
+{
+	int val = get_amp_val_to_activate(codec, nid, dir, false);
+	snd_hda_codec_amp_init_stereo(codec, nid, dir, idx, 0xff, val);
+}
+
+static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
+			 int idx, bool enable)
+{
+	int val;
+	if (is_ctl_associated(codec, nid, dir, idx) ||
+	    is_active_nid(codec, nid, dir, idx))
+		return;
+	val = get_amp_val_to_activate(codec, nid, dir, enable);
+	snd_hda_codec_amp_stereo(codec, nid, dir, idx, 0xff, val);
+}
+
+static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
+			     int i, bool enable)
+{
+	hda_nid_t nid = path->path[i];
+	init_amp(codec, nid, HDA_OUTPUT, 0);
+	activate_amp(codec, nid, HDA_OUTPUT, 0, enable);
+}
+
+static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
+			    int i, bool enable)
 {
 	struct alc_spec *spec = codec->spec;
-	int i, val;
-	struct nid_path *path;
+	hda_nid_t conn[16];
+	int n, nums;
+	hda_nid_t nid = path->path[i];
 
-	alc_set_pin_output(codec, pin, pin_type);
-	path = get_out_path(codec, pin, dac);
-	if (!path)
+	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
+	for (n = 0; n < nums; n++)
+		init_amp(codec, nid, HDA_INPUT, n);
+
+	if (is_ctl_associated(codec, nid, HDA_INPUT, path->idx[i]))
 		return;
 
+	/* here is a little bit tricky in comparison with activate_amp_out();
+	 * when aa-mixer is available, we need to enable the path as well
+	 */
+	for (n = 0; n < nums; n++) {
+		if (n != path->idx[i] && conn[n] != spec->mixer_nid)
+			continue;
+		activate_amp(codec, nid, HDA_INPUT, n, enable);
+	}
+}
+
+static void activate_path(struct hda_codec *codec, struct nid_path *path,
+			  bool enable)
+{
+	int i;
+
+	if (path->active == enable)
+		return;
+
+	if (!enable)
+		path->active = false;
+
 	for (i = path->depth - 1; i >= 0; i--) {
-		hda_nid_t nid = path->path[i];
 		if (path->multi[i])
-			snd_hda_codec_write(codec, nid, 0,
+			snd_hda_codec_write_cache(codec, path->path[i], 0,
 					    AC_VERB_SET_CONNECT_SEL,
 					    path->idx[i]);
-
-		if (i != 0 && i != path->depth - 1 &&
-		    (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) &&
-		    (force || !is_out_ctl_present(codec, path, nid,
-						  HDA_INPUT))) {
-			hda_nid_t conn[16];
-			int n, nums;
-			nums = snd_hda_get_connections(codec, nid, conn,
-						       ARRAY_SIZE(conn));
-			val = get_default_amp_val(codec, nid, HDA_INPUT);
-			for (n = 0; n < nums; n++) {
-				if (n != path->idx[i] &&
-				    conn[n] != spec->mixer_nid)
-					continue;
-				snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_UNMUTE(n) | val);
-			}
-		}
-		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
-		    (force || !is_out_ctl_present(codec, path, nid,
-						  HDA_OUTPUT))) {
-			val = get_default_amp_val(codec, nid, HDA_OUTPUT);
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_UNMUTE | val);
-		}
+		if (has_amp_in(codec, path, i))
+			activate_amp_in(codec, path, i, enable);
+		if (has_amp_out(codec, path, i))
+			activate_amp_out(codec, path, i, enable);
 	}
+
+	if (enable)
+		path->active = true;
+}
+
+/* configure the path from the given dac to the pin as the proper output */
+static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
+					   hda_nid_t pin, int pin_type,
+					   hda_nid_t dac)
+{
+	struct nid_path *path;
+
+	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
+	path = get_out_path(codec, pin, dac);
+	if (!path)
+		return;
+	activate_path(codec, path, true);
 }
 
 static void alc_auto_init_multi_out(struct hda_codec *codec)
@@ -3939,7 +4026,7 @@ static void alc_auto_init_multi_out(struct hda_codec *codec)
 		hda_nid_t nid = spec->autocfg.line_out_pins[i];
 		if (nid)
 			alc_auto_set_output_and_unmute(codec, nid, pin_type,
-					spec->multiout.dac_nids[i], true);
+					spec->multiout.dac_nids[i]);
 
 	}
 }
@@ -3963,7 +4050,7 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 			else
 				dac = spec->multiout.dac_nids[0];
 		}
-		alc_auto_set_output_and_unmute(codec, pin, PIN_HP, dac, true);
+		alc_auto_set_output_and_unmute(codec, pin, PIN_HP, dac);
 	}
 	for (i = 0; i < spec->autocfg.speaker_outs; i++) {
 		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
@@ -3978,7 +4065,7 @@ static void alc_auto_init_extra_out(struct hda_codec *codec)
 			else
 				dac = spec->multiout.dac_nids[0];
 		}
-		alc_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac, true);
+		alc_auto_set_output_and_unmute(codec, pin, PIN_OUT, dac);
 	}
 }
 
@@ -4129,22 +4216,22 @@ static int alc_set_multi_io(struct hda_codec *codec, int idx, bool output)
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t nid = spec->multi_io[idx].pin;
+	struct nid_path *path;
+
+	path = get_out_path(codec, nid, spec->multi_io[idx].dac);
+	if (!path)
+		return -EINVAL;
 
 	if (!spec->multi_io[idx].ctl_in)
 		spec->multi_io[idx].ctl_in =
-			snd_hda_codec_read(codec, nid, 0,
+			snd_hda_codec_update_cache(codec, nid, 0,
 					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+
 	if (output) {
 		snd_hda_set_pin_ctl_cache(codec, nid, PIN_OUT);
-		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
-			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-						 HDA_AMP_MUTE, 0);
-		alc_auto_set_output_and_unmute(codec, nid, PIN_OUT,
-					       spec->multi_io[idx].dac, false);
+		activate_path(codec, path, true);
 	} else {
-		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
-			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-						 HDA_AMP_MUTE, HDA_AMP_MUTE);
+		activate_path(codec, path, false);
 		snd_hda_set_pin_ctl_cache(codec, nid,
 					  spec->multi_io[idx].ctl_in);
 	}
-- 
1.8.0.1
