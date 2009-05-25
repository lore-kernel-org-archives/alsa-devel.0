From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: Jack Mode changes for
	Sigmatel boards
Date: Mon, 25 May 2009 19:18:44 +0000
Message-ID: <4A1AEF14.1090608@gmail.com>
References: <4A13F91D.8010102@gmail.com> <s5hvdnp5wdv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000903080707040202090802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D870244E1
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 04:09:19 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so2603328ywq.2
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 19:09:17 -0700 (PDT)
In-Reply-To: <s5hvdnp5wdv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000903080707040202090802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch changes Line In as Out Switch and Mic In as Out Switch to
enums for consistency, and causes all mic ports to be probed and
controls to be added appropriately.

Signed-off-by:  Nickolas Lloyd <ultrageek.lloyd@gmail.com>

Note:  diffed against alsa-driver-20090526
----

--- alsa-driver/sound/pci/hda/patch_sigmatel.c	2009-05-25 22:05:02.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c	2009-05-25 19:11:45.000000000 +0000
@@ -669,62 +669,6 @@ static unsigned int stac92xx_vref_get(st
 	return vref;
 }
 
-static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int new_vref;
-	unsigned int error;
-
-	if (ucontrol->value.enumerated.item[0] == 0)
-		new_vref = AC_PINCTL_VREF_80;
-	else if (ucontrol->value.enumerated.item[0] == 1)
-		new_vref = AC_PINCTL_VREF_GRD;
-	else
-		new_vref = AC_PINCTL_VREF_HIZ;
-
-	if (new_vref != stac92xx_vref_get(codec, kcontrol->private_value)) {
-		error = stac92xx_vref_set(codec,
-					kcontrol->private_value, new_vref);
-		return error;
-	}
-
-	return 0;
-}
-
-static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int vref = stac92xx_vref_get(codec, kcontrol->private_value);
-	if (vref == AC_PINCTL_VREF_80)
-		ucontrol->value.enumerated.item[0] = 0;
-	else if (vref == AC_PINCTL_VREF_GRD)
-		ucontrol->value.enumerated.item[0] = 1;
-	else if (vref == AC_PINCTL_VREF_HIZ)
-		ucontrol->value.enumerated.item[0] = 2;
-
-	return 0;
-}
-
-static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info *uinfo)
-{
-	static char *texts[] = {
-		"Mic In", "Line In", "Line Out"
-	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->value.enumerated.items = 3;
-	uinfo->count = 1;
-	if (uinfo->value.enumerated.item >= 3)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-
-	return 0;
-}
-
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -2705,15 +2649,108 @@ static int stac92xx_hp_switch_put(struct
 	return 1;
 }
 
-#define stac92xx_io_switch_info		snd_ctl_boolean_mono_info
+static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	int i;
+	static char *texts[] = {
+		"Mic In", "Line In", "Line Out"
+	};
+
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = kcontrol->private_value;
+
+	if (nid == spec->mic_switch)
+		i = 3;
+	else
+		i = 2;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = i;
+	uinfo->count = 1;
+	if (uinfo->value.enumerated.item >= i)
+		uinfo->value.enumerated.item = i-1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value;
+	unsigned int vref = stac92xx_vref_get(codec, nid);
+
+	if (vref == stac92xx_get_vref(codec, nid))
+		ucontrol->value.enumerated.item[0] = 0;
+	else if (vref == AC_PINCTL_VREF_GRD)
+		ucontrol->value.enumerated.item[0] = 1;
+	else if (vref == AC_PINCTL_VREF_HIZ)
+		ucontrol->value.enumerated.item[0] = 2;
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int new_vref = 0;
+	unsigned int error;
+	hda_nid_t nid = kcontrol->private_value;
+
+	if (ucontrol->value.enumerated.item[0] == 0)
+		new_vref = stac92xx_get_vref(codec, nid);
+	else if (ucontrol->value.enumerated.item[0] == 1)
+		new_vref = AC_PINCTL_VREF_GRD;
+	else if (ucontrol->value.enumerated.item[0] == 2)
+		new_vref = AC_PINCTL_VREF_HIZ;
+	else
+		return 0;
+
+	if (new_vref != stac92xx_vref_get(codec, nid)) {
+		error = stac92xx_vref_set(codec, nid, new_vref);
+		return error;
+	}
+
+	return 0;
+}
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2];
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (kcontrol->private_value == spec->line_switch)
+		texts[0] = "Line In";
+	else
+		texts[0] = "Mic In";
+	texts[1] = "Line Out";
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = 2;
+	uinfo->count = 1;
+
+	if (uinfo->value.enumerated.item >= 2)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-	int io_idx = kcontrol-> private_value & 0xff;
+	hda_nid_t nid = kcontrol->private_value >> 8;
+	int io_idx = (nid == spec->mic_switch) ? 1 : 0;
 
-	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+	ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
 	return 0;
 }
 
@@ -2721,9 +2758,9 @@ static int stac92xx_io_switch_put(struct
 {
         struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-        hda_nid_t nid = kcontrol->private_value >> 8;
-	int io_idx = kcontrol-> private_value & 0xff;
-	unsigned short val = !!ucontrol->value.integer.value[0];
+	hda_nid_t nid = kcontrol->private_value;
+	int io_idx = (nid == spec->mic_switch) ? 1 : 0;
+	unsigned short val = !!ucontrol->value.enumerated.item[0];
 
 	spec->io_switch[io_idx] = val;
 
@@ -2890,6 +2927,28 @@ static struct snd_kcontrol_new stac_inpu
 	.put = stac92xx_mux_enum_put,
 };
 
+static inline int stac92xx_add_mic_jack_control(struct hda_codec *codec,
+						hda_nid_t nid, int idx)
+{
+	int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+	int control = 0;
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+		if (snd_hda_query_pin_caps(codec, nid)
+			& (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+			control = STAC_CTL_WIDGET_DC_BIAS;
+		else if (nid == spec->mic_switch)
+			control = STAC_CTL_WIDGET_IO_SWITCH;
+	}
+
+	if (control)
+		return stac92xx_add_control_idx(codec->spec, control,
+						idx, "Mic Jack Mode" , nid);
+
+	return 1;
+}
+
 static int stac92xx_add_input_source(struct sigmatel_spec *spec)
 {
 	struct snd_kcontrol_new *knew;
@@ -3252,7 +3311,9 @@ static int stac92xx_auto_create_multi_ou
 					       const struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid;
 	int err;
+	int idx;
 
 	err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
 				    spec->multiout.dac_nids,
@@ -3271,18 +3332,27 @@ static int stac92xx_auto_create_multi_ou
 
 	if (spec->line_switch) {
 		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-					   "Line In as Output Switch",
-					   spec->line_switch << 8);
+					   "Line In Jack Mode",
+					   spec->line_switch);
 		if (err < 0)
 			return err;
 	}
 
-	if (spec->mic_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-					   "Mic Jack Mode",
-					   spec->mic_switch);
+	nid = cfg->input_pins[AUTO_PIN_MIC];
+	idx = 0;
+
+again:
+	if (nid) {
+		err = stac92xx_add_mic_jack_control(codec, nid, idx);
 		if (err < 0)
 			return err;
+		else if (!err)
+			idx++;
+	}
+
+	if (nid == cfg->input_pins[AUTO_PIN_MIC]) {
+		nid = cfg->input_pins[AUTO_PIN_FRONT_MIC];
+		goto again;
 	}
 
 	return 0;


--------------000903080707040202090802
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

--- alsa-driver/sound/pci/hda/patch_sigmatel.c	2009-05-25 22:05:02.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c	2009-05-25 19:11:45.000000000 +0000
@@ -669,62 +669,6 @@ static unsigned int stac92xx_vref_get(st
 	return vref;
 }
 
-static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int new_vref;
-	unsigned int error;
-
-	if (ucontrol->value.enumerated.item[0] == 0)
-		new_vref = AC_PINCTL_VREF_80;
-	else if (ucontrol->value.enumerated.item[0] == 1)
-		new_vref = AC_PINCTL_VREF_GRD;
-	else
-		new_vref = AC_PINCTL_VREF_HIZ;
-
-	if (new_vref != stac92xx_vref_get(codec, kcontrol->private_value)) {
-		error = stac92xx_vref_set(codec,
-					kcontrol->private_value, new_vref);
-		return error;
-	}
-
-	return 0;
-}
-
-static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int vref = stac92xx_vref_get(codec, kcontrol->private_value);
-	if (vref == AC_PINCTL_VREF_80)
-		ucontrol->value.enumerated.item[0] = 0;
-	else if (vref == AC_PINCTL_VREF_GRD)
-		ucontrol->value.enumerated.item[0] = 1;
-	else if (vref == AC_PINCTL_VREF_HIZ)
-		ucontrol->value.enumerated.item[0] = 2;
-
-	return 0;
-}
-
-static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_info *uinfo)
-{
-	static char *texts[] = {
-		"Mic In", "Line In", "Line Out"
-	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->value.enumerated.items = 3;
-	uinfo->count = 1;
-	if (uinfo->value.enumerated.item >= 3)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name,
-		texts[uinfo->value.enumerated.item]);
-
-	return 0;
-}
-
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -2705,15 +2649,108 @@ static int stac92xx_hp_switch_put(struct
 	return 1;
 }
 
-#define stac92xx_io_switch_info		snd_ctl_boolean_mono_info
+static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	int i;
+	static char *texts[] = {
+		"Mic In", "Line In", "Line Out"
+	};
+
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid = kcontrol->private_value;
+
+	if (nid == spec->mic_switch)
+		i = 3;
+	else
+		i = 2;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = i;
+	uinfo->count = 1;
+	if (uinfo->value.enumerated.item >= i)
+		uinfo->value.enumerated.item = i-1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value;
+	unsigned int vref = stac92xx_vref_get(codec, nid);
+
+	if (vref == stac92xx_get_vref(codec, nid))
+		ucontrol->value.enumerated.item[0] = 0;
+	else if (vref == AC_PINCTL_VREF_GRD)
+		ucontrol->value.enumerated.item[0] = 1;
+	else if (vref == AC_PINCTL_VREF_HIZ)
+		ucontrol->value.enumerated.item[0] = 2;
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int new_vref = 0;
+	unsigned int error;
+	hda_nid_t nid = kcontrol->private_value;
+
+	if (ucontrol->value.enumerated.item[0] == 0)
+		new_vref = stac92xx_get_vref(codec, nid);
+	else if (ucontrol->value.enumerated.item[0] == 1)
+		new_vref = AC_PINCTL_VREF_GRD;
+	else if (ucontrol->value.enumerated.item[0] == 2)
+		new_vref = AC_PINCTL_VREF_HIZ;
+	else
+		return 0;
+
+	if (new_vref != stac92xx_vref_get(codec, nid)) {
+		error = stac92xx_vref_set(codec, nid, new_vref);
+		return error;
+	}
+
+	return 0;
+}
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2];
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (kcontrol->private_value == spec->line_switch)
+		texts[0] = "Line In";
+	else
+		texts[0] = "Mic In";
+	texts[1] = "Line Out";
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = 2;
+	uinfo->count = 1;
+
+	if (uinfo->value.enumerated.item >= 2)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-	int io_idx = kcontrol-> private_value & 0xff;
+	hda_nid_t nid = kcontrol->private_value >> 8;
+	int io_idx = (nid == spec->mic_switch) ? 1 : 0;
 
-	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+	ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
 	return 0;
 }
 
@@ -2721,9 +2758,9 @@ static int stac92xx_io_switch_put(struct
 {
         struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct sigmatel_spec *spec = codec->spec;
-        hda_nid_t nid = kcontrol->private_value >> 8;
-	int io_idx = kcontrol-> private_value & 0xff;
-	unsigned short val = !!ucontrol->value.integer.value[0];
+	hda_nid_t nid = kcontrol->private_value;
+	int io_idx = (nid == spec->mic_switch) ? 1 : 0;
+	unsigned short val = !!ucontrol->value.enumerated.item[0];
 
 	spec->io_switch[io_idx] = val;
 
@@ -2890,6 +2927,28 @@ static struct snd_kcontrol_new stac_inpu
 	.put = stac92xx_mux_enum_put,
 };
 
+static inline int stac92xx_add_mic_jack_control(struct hda_codec *codec,
+						hda_nid_t nid, int idx)
+{
+	int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+	int control = 0;
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+		if (snd_hda_query_pin_caps(codec, nid)
+			& (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+			control = STAC_CTL_WIDGET_DC_BIAS;
+		else if (nid == spec->mic_switch)
+			control = STAC_CTL_WIDGET_IO_SWITCH;
+	}
+
+	if (control)
+		return stac92xx_add_control_idx(codec->spec, control,
+						idx, "Mic Jack Mode" , nid);
+
+	return 1;
+}
+
 static int stac92xx_add_input_source(struct sigmatel_spec *spec)
 {
 	struct snd_kcontrol_new *knew;
@@ -3252,7 +3311,9 @@ static int stac92xx_auto_create_multi_ou
 					       const struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid;
 	int err;
+	int idx;
 
 	err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
 				    spec->multiout.dac_nids,
@@ -3271,18 +3332,27 @@ static int stac92xx_auto_create_multi_ou
 
 	if (spec->line_switch) {
 		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-					   "Line In as Output Switch",
-					   spec->line_switch << 8);
+					   "Line In Jack Mode",
+					   spec->line_switch);
 		if (err < 0)
 			return err;
 	}
 
-	if (spec->mic_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-					   "Mic Jack Mode",
-					   spec->mic_switch);
+	nid = cfg->input_pins[AUTO_PIN_MIC];
+	idx = 0;
+
+again:
+	if (nid) {
+		err = stac92xx_add_mic_jack_control(codec, nid, idx);
 		if (err < 0)
 			return err;
+		else if (!err)
+			idx++;
+	}
+
+	if (nid == cfg->input_pins[AUTO_PIN_MIC]) {
+		nid = cfg->input_pins[AUTO_PIN_FRONT_MIC];
+		goto again;
 	}
 
 	return 0;

--------------000903080707040202090802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000903080707040202090802--
