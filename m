From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: Jack Mode changes for
	Sigmatel boards
Date: Fri, 29 May 2009 16:41:38 +0000
Message-ID: <4A201042.4000507@gmail.com>
References: <4A13F91D.8010102@gmail.com>	<s5hvdnp5wdv.wl%tiwai@suse.de>	<4A1AEF14.1090608@gmail.com>	<s5hy6sj9fl0.wl%tiwai@suse.de>	<4A1D4AB0.40904@gmail.com>
	<s5hy6sgv2cd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030103060503090606050905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id B46BF1037ED
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 01:32:03 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so4503748ywq.2
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2009 16:32:02 -0700 (PDT)
In-Reply-To: <s5hy6sgv2cd.wl%tiwai@suse.de>
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
--------------030103060503090606050905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The (hopefully) final version of the patch.

This patch changes Line In as Out Switch and Mic In as Out Switch to
enums for consistency, and causes all mic and line in ports to be probed
and controls to be added appropriately.

Signed-off-by:  Nickolas Lloyd <ultrageek.lloyd@gmail.com>

Note: diffed against alsa-driver-20090529

----

--- alsa-driver/sound/pci/hda/patch_sigmatel.c    2009-05-28
18:12:15.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c    2009-05-29
12:53:28.000000000 +0000
@@ -670,62 +670,6 @@ static unsigned int stac92xx_vref_get(st
     return vref;
 }
 
-static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
-                struct snd_ctl_elem_value *ucontrol)
-{
-    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-    unsigned int new_vref;
-    unsigned int error;
-
-    if (ucontrol->value.enumerated.item[0] == 0)
-        new_vref = AC_PINCTL_VREF_80;
-    else if (ucontrol->value.enumerated.item[0] == 1)
-        new_vref = AC_PINCTL_VREF_GRD;
-    else
-        new_vref = AC_PINCTL_VREF_HIZ;
-
-    if (new_vref != stac92xx_vref_get(codec, kcontrol->private_value)) {
-        error = stac92xx_vref_set(codec,
-                    kcontrol->private_value, new_vref);
-        return error;
-    }
-
-    return 0;
-}
-
-static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
-                struct snd_ctl_elem_value *ucontrol)
-{
-    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-    unsigned int vref = stac92xx_vref_get(codec, kcontrol->private_value);
-    if (vref == AC_PINCTL_VREF_80)
-        ucontrol->value.enumerated.item[0] = 0;
-    else if (vref == AC_PINCTL_VREF_GRD)
-        ucontrol->value.enumerated.item[0] = 1;
-    else if (vref == AC_PINCTL_VREF_HIZ)
-        ucontrol->value.enumerated.item[0] = 2;
-
-    return 0;
-}
-
-static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
-                struct snd_ctl_elem_info *uinfo)
-{
-    static char *texts[] = {
-        "Mic In", "Line In", "Line Out"
-    };
-
-    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-    uinfo->value.enumerated.items = 3;
-    uinfo->count = 1;
-    if (uinfo->value.enumerated.item >= 3)
-        uinfo->value.enumerated.item = 2;
-    strcpy(uinfo->value.enumerated.name,
-        texts[uinfo->value.enumerated.item]);
-
-    return 0;
-}
-
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_info *uinfo)
 {
     struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -2652,7 +2596,8 @@ static int stac92xx_build_pcms(struct hd
     return 0;
 }
 
-static unsigned int stac92xx_get_vref(struct hda_codec *codec,
hda_nid_t nid)
+static unsigned int stac92xx_get_default_vref(struct hda_codec *codec,
+                    hda_nid_t nid)
 {
     unsigned int pincap = snd_hda_query_pin_caps(codec, nid);
     pincap = (pincap & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
@@ -2706,15 +2651,108 @@ static int stac92xx_hp_switch_put(struct
     return 1;
 }
 
-#define stac92xx_io_switch_info        snd_ctl_boolean_mono_info
+static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
+                struct snd_ctl_elem_info *uinfo)
+{
+    int i;
+    static char *texts[] = {
+        "Mic In", "Line In", "Line Out"
+    };
+
+    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+    struct sigmatel_spec *spec = codec->spec;
+    hda_nid_t nid = kcontrol->private_value;
+
+    if (nid == spec->mic_switch || nid == spec->line_switch)
+        i = 3;
+    else
+        i = 2;
+
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->value.enumerated.items = i;
+    uinfo->count = 1;
+    if (uinfo->value.enumerated.item >= i)
+        uinfo->value.enumerated.item = i-1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+
+    return 0;
+}
+
+static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
+                struct snd_ctl_elem_value *ucontrol)
+{
+    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+    hda_nid_t nid = kcontrol->private_value;
+    unsigned int vref = stac92xx_vref_get(codec, nid);
+
+    if (vref == stac92xx_get_default_vref(codec, nid))
+        ucontrol->value.enumerated.item[0] = 0;
+    else if (vref == AC_PINCTL_VREF_GRD)
+        ucontrol->value.enumerated.item[0] = 1;
+    else if (vref == AC_PINCTL_VREF_HIZ)
+        ucontrol->value.enumerated.item[0] = 2;
+
+    return 0;
+}
+
+static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
+                struct snd_ctl_elem_value *ucontrol)
+{
+    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+    unsigned int new_vref = 0;
+    unsigned int error;
+    hda_nid_t nid = kcontrol->private_value;
+
+    if (ucontrol->value.enumerated.item[0] == 0)
+        new_vref = stac92xx_get_default_vref(codec, nid);
+    else if (ucontrol->value.enumerated.item[0] == 1)
+        new_vref = AC_PINCTL_VREF_GRD;
+    else if (ucontrol->value.enumerated.item[0] == 2)
+        new_vref = AC_PINCTL_VREF_HIZ;
+    else
+        return 0;
+
+    if (new_vref != stac92xx_vref_get(codec, nid)) {
+        error = stac92xx_vref_set(codec, nid, new_vref);
+        return error;
+    }
+
+    return 0;
+}
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol,
+                struct snd_ctl_elem_info *uinfo)
+{
+    static char *texts[2];
+    struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+    struct sigmatel_spec *spec = codec->spec;
+
+    if (kcontrol->private_value == spec->line_switch)
+        texts[0] = "Line In";
+    else
+        texts[0] = "Mic In";
+    texts[1] = "Line Out";
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->value.enumerated.items = 2;
+    uinfo->count = 1;
+
+    if (uinfo->value.enumerated.item >= 2)
+        uinfo->value.enumerated.item = 1;
+    strcpy(uinfo->value.enumerated.name,
+        texts[uinfo->value.enumerated.item]);
+
+    return 0;
+}
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
 {
     struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
     struct sigmatel_spec *spec = codec->spec;
-    int io_idx = kcontrol-> private_value & 0xff;
+    hda_nid_t nid = kcontrol->private_value;
+    int io_idx = (nid == spec->mic_switch) ? 1 : 0;
 
-    ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+    ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
     return 0;
 }
 
@@ -2722,9 +2760,9 @@ static int stac92xx_io_switch_put(struct
 {
         struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
     struct sigmatel_spec *spec = codec->spec;
-        hda_nid_t nid = kcontrol->private_value >> 8;
-    int io_idx = kcontrol-> private_value & 0xff;
-    unsigned short val = !!ucontrol->value.integer.value[0];
+    hda_nid_t nid = kcontrol->private_value;
+    int io_idx = (nid == spec->mic_switch) ? 1 : 0;
+    unsigned short val = !!ucontrol->value.enumerated.item[0];
 
     spec->io_switch[io_idx] = val;
 
@@ -2733,7 +2771,7 @@ static int stac92xx_io_switch_put(struct
     else {
         unsigned int pinctl = AC_PINCTL_IN_EN;
         if (io_idx) /* set VREF for mic */
-            pinctl |= stac92xx_get_vref(codec, nid);
+            pinctl |= stac92xx_get_default_vref(codec, nid);
         stac92xx_auto_set_pinctl(codec, nid, pinctl);
     }
 
@@ -2891,6 +2929,34 @@ static struct snd_kcontrol_new stac_inpu
     .put = stac92xx_mux_enum_put,
 };
 
+static inline int stac92xx_add_jack_mode_control(struct hda_codec *codec,
+                        hda_nid_t nid, int idx)
+{
+    int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+    int control = 0;
+    struct sigmatel_spec *spec = codec->spec;
+    char name[22];
+
+    if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+        if (stac92xx_get_default_vref(codec, nid) == AC_PINCTL_VREF_GRD
+            && nid == spec->line_switch)
+            control = STAC_CTL_WIDGET_IO_SWITCH;
+        else if (snd_hda_query_pin_caps(codec, nid)
+            & (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+            control = STAC_CTL_WIDGET_DC_BIAS;
+        else if (nid == spec->mic_switch)
+            control = STAC_CTL_WIDGET_IO_SWITCH;
+    }
+
+    if (control) {
+        strcpy(name, auto_pin_cfg_labels[idx]);
+        return stac92xx_add_control(codec->spec, control,
+                    strcat(name, " Jack Mode"), nid);
+    }
+
+    return 0;
+}
+
 static int stac92xx_add_input_source(struct sigmatel_spec *spec)
 {
     struct snd_kcontrol_new *knew;
@@ -3253,7 +3319,9 @@ static int stac92xx_auto_create_multi_ou
                            const struct auto_pin_cfg *cfg)
 {
     struct sigmatel_spec *spec = codec->spec;
+    hda_nid_t nid;
     int err;
+    int idx;
 
     err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
                     spec->multiout.dac_nids,
@@ -3270,20 +3338,13 @@ static int stac92xx_auto_create_multi_ou
             return err;
     }
 
-    if (spec->line_switch) {
-        err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-                       "Line In as Output Switch",
-                       spec->line_switch << 8);
-        if (err < 0)
-            return err;
-    }
-
-    if (spec->mic_switch) {
-        err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-                       "Mic Jack Mode",
-                       spec->mic_switch);
-        if (err < 0)
-            return err;
+    for (idx = AUTO_PIN_MIC; idx <= AUTO_PIN_FRONT_LINE; idx++) {
+        nid = cfg->input_pins[idx];
+        if (nid) {
+            err = stac92xx_add_jack_mode_control(codec, nid, idx);
+            if (err < 0)
+                return err;
+        }
     }
 
     return 0;
@@ -4193,7 +4254,7 @@ static int stac92xx_init(struct hda_code
             unsigned int pinctl, conf;
             if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC) {
                 /* for mic pins, force to initialize */
-                pinctl = stac92xx_get_vref(codec, nid);
+                pinctl = stac92xx_get_default_vref(codec, nid);
                 pinctl |= AC_PINCTL_IN_EN;
                 stac92xx_auto_set_pinctl(codec, nid, pinctl);
             } else {


--------------030103060503090606050905
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

--- alsa-driver/sound/pci/hda/patch_sigmatel.c	2009-05-28 18:12:15.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c	2009-05-29 12:53:28.000000000 +0000
@@ -670,62 +670,6 @@ static unsigned int stac92xx_vref_get(st
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
@@ -2652,7 +2596,8 @@ static int stac92xx_build_pcms(struct hd
 	return 0;
 }
 
-static unsigned int stac92xx_get_vref(struct hda_codec *codec, hda_nid_t nid)
+static unsigned int stac92xx_get_default_vref(struct hda_codec *codec,
+					hda_nid_t nid)
 {
 	unsigned int pincap = snd_hda_query_pin_caps(codec, nid);
 	pincap = (pincap & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
@@ -2706,15 +2651,108 @@ static int stac92xx_hp_switch_put(struct
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
+	if (nid == spec->mic_switch || nid == spec->line_switch)
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
+	if (vref == stac92xx_get_default_vref(codec, nid))
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
+		new_vref = stac92xx_get_default_vref(codec, nid);
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
+	hda_nid_t nid = kcontrol->private_value;
+	int io_idx = (nid == spec->mic_switch) ? 1 : 0;
 
-	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+	ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
 	return 0;
 }
 
@@ -2722,9 +2760,9 @@ static int stac92xx_io_switch_put(struct
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
 
@@ -2733,7 +2771,7 @@ static int stac92xx_io_switch_put(struct
 	else {
 		unsigned int pinctl = AC_PINCTL_IN_EN;
 		if (io_idx) /* set VREF for mic */
-			pinctl |= stac92xx_get_vref(codec, nid);
+			pinctl |= stac92xx_get_default_vref(codec, nid);
 		stac92xx_auto_set_pinctl(codec, nid, pinctl);
 	}
 
@@ -2891,6 +2929,34 @@ static struct snd_kcontrol_new stac_inpu
 	.put = stac92xx_mux_enum_put,
 };
 
+static inline int stac92xx_add_jack_mode_control(struct hda_codec *codec,
+						hda_nid_t nid, int idx)
+{
+	int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+	int control = 0;
+	struct sigmatel_spec *spec = codec->spec;
+	char name[22];
+
+	if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+		if (stac92xx_get_default_vref(codec, nid) == AC_PINCTL_VREF_GRD
+			&& nid == spec->line_switch)
+			control = STAC_CTL_WIDGET_IO_SWITCH;
+		else if (snd_hda_query_pin_caps(codec, nid)
+			& (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+			control = STAC_CTL_WIDGET_DC_BIAS;
+		else if (nid == spec->mic_switch)
+			control = STAC_CTL_WIDGET_IO_SWITCH;
+	}
+
+	if (control) {
+		strcpy(name, auto_pin_cfg_labels[idx]);
+		return stac92xx_add_control(codec->spec, control,
+					strcat(name, " Jack Mode"), nid);
+	}
+
+	return 0;
+}
+
 static int stac92xx_add_input_source(struct sigmatel_spec *spec)
 {
 	struct snd_kcontrol_new *knew;
@@ -3253,7 +3319,9 @@ static int stac92xx_auto_create_multi_ou
 					       const struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid;
 	int err;
+	int idx;
 
 	err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
 				    spec->multiout.dac_nids,
@@ -3270,20 +3338,13 @@ static int stac92xx_auto_create_multi_ou
 			return err;
 	}
 
-	if (spec->line_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-					   "Line In as Output Switch",
-					   spec->line_switch << 8);
-		if (err < 0)
-			return err;
-	}
-
-	if (spec->mic_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-					   "Mic Jack Mode",
-					   spec->mic_switch);
-		if (err < 0)
-			return err;
+	for (idx = AUTO_PIN_MIC; idx <= AUTO_PIN_FRONT_LINE; idx++) {
+		nid = cfg->input_pins[idx];
+		if (nid) {
+			err = stac92xx_add_jack_mode_control(codec, nid, idx);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	return 0;
@@ -4193,7 +4254,7 @@ static int stac92xx_init(struct hda_code
 			unsigned int pinctl, conf;
 			if (i == AUTO_PIN_MIC || i == AUTO_PIN_FRONT_MIC) {
 				/* for mic pins, force to initialize */
-				pinctl = stac92xx_get_vref(codec, nid);
+				pinctl = stac92xx_get_default_vref(codec, nid);
 				pinctl |= AC_PINCTL_IN_EN;
 				stac92xx_auto_set_pinctl(codec, nid, pinctl);
 			} else {

--------------030103060503090606050905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030103060503090606050905--
