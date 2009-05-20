From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: [PATCH] snd-hda-intel: Jack Mode changes for Sigmatel
	boards
Date: Wed, 20 May 2009 12:35:41 +0000
Message-ID: <4A13F91D.8010102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060602020602070005060800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ECB6243EE
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 21:26:28 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so392671qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 20 May 2009 12:26:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Matthew Ranostay <mranostay@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060602020602070005060800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch changes Line In as Out Switch and Mic In as Out Switch to
enums for consistency, and causes all mic ports to be probed and
controls to be added appropriately.

Signed-off-by:  Nickolas Lloyd <ultrageek.lloyd@gmail.com>

Note:  diffed against alsa-driver-20090520
----

--- alsa-driver/sound/pci/hda/patch_sigmatel.c    2009-05-19
22:05:02.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c    2009-05-20
12:17:49.000000000 +0000
@@ -668,62 +668,6 @@ static unsigned int stac92xx_vref_get(st
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
@@ -2695,7 +2639,93 @@ static int stac92xx_hp_switch_put(struct
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
+    if (kcontrol->private_value & 0x100)
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
+    hda_nid_t nid = kcontrol->private_value & 0x0ff;
+    unsigned int vref = stac92xx_vref_get(codec, nid);
+
+    if (vref == stac92xx_get_vref(codec, nid))
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
+    hda_nid_t nid = (kcontrol->private_value & 0x0ff);
+
+    if (ucontrol->value.enumerated.item[0] == 0)
+        new_vref = stac92xx_get_vref(codec, nid);
+    else if (ucontrol->value.enumerated.item[0] == 1)
+        new_vref = AC_PINCTL_VREF_GRD;
+    else if (ucontrol->value.enumerated.item[0] == 2)
+        new_vref = AC_PINCTL_VREF_HIZ;
+    else
+        return 1;
+
+    if (new_vref != stac92xx_vref_get(codec, nid)) {
+        error = stac92xx_vref_set(codec, nid, new_vref);
+        return error;
+    }
+
+    return 0;
+}
+
+
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol,
+                struct snd_ctl_elem_info *uinfo)
+{
+    static char *texts[2];
+    if (kcontrol->private_value & 0xff)
+        texts[0] = "Mic In";
+    else
+        texts[0] = "Line In";
+    texts[1] = "Line Out";
+    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->value.enumerated.items = 2;
+    uinfo->count = 1;
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
@@ -2703,7 +2733,7 @@ static int stac92xx_io_switch_get(struct
     struct sigmatel_spec *spec = codec->spec;
     int io_idx = kcontrol-> private_value & 0xff;
 
-    ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+    ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
     return 0;
 }
 
@@ -2713,7 +2743,7 @@ static int stac92xx_io_switch_put(struct
     struct sigmatel_spec *spec = codec->spec;
         hda_nid_t nid = kcontrol->private_value >> 8;
     int io_idx = kcontrol-> private_value & 0xff;
-    unsigned short val = !!ucontrol->value.integer.value[0];
+    unsigned short val = !!ucontrol->value.enumerated.item[0];
 
     spec->io_switch[io_idx] = val;
 
@@ -3242,7 +3272,10 @@ static int stac92xx_auto_create_multi_ou
                            const struct auto_pin_cfg *cfg)
 {
     struct sigmatel_spec *spec = codec->spec;
+    hda_nid_t nid;
+    int def_conf;
     int err;
+    int idx;
 
     err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
                     spec->multiout.dac_nids,
@@ -3261,18 +3294,34 @@ static int stac92xx_auto_create_multi_ou
 
     if (spec->line_switch) {
         err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-                       "Line In as Output Switch",
+                       "Line In Jack Mode",
                        spec->line_switch << 8);
         if (err < 0)
             return err;
     }
 
-    if (spec->mic_switch) {
-        err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-                       "Mic Jack Mode",
-                       spec->mic_switch);
-        if (err < 0)
-            return err;
+    nid = cfg->input_pins[AUTO_PIN_MIC];
+    idx = 0;
+again:
+    if (nid) {
+        def_conf = snd_hda_codec_get_pincfg(codec, nid);
+        if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+            if (snd_hda_query_pin_caps(codec, nid)
+                & (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+                stac92xx_add_control_idx(spec,
+                    STAC_CTL_WIDGET_DC_BIAS, idx++,
+                    "Mic Jack Mode", nid
+                    | ((nid == spec->mic_switch)
+                    ? 0x100 : 0));
+            else if (nid == spec->mic_switch)
+                stac92xx_add_control_idx(spec,
+                    STAC_CTL_WIDGET_IO_SWITCH, idx++,
+                    "Mic Jack Mode", ((nid << 8) | 1));
+        }
+    }
+    if (nid == cfg->input_pins[AUTO_PIN_MIC]) {
+        nid = cfg->input_pins[AUTO_PIN_FRONT_MIC];
+        goto again;
     }
 
     return 0;

--------------060602020602070005060800
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

--- alsa-driver/sound/pci/hda/patch_sigmatel.c	2009-05-19 22:05:02.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c	2009-05-20 12:17:49.000000000 +0000
@@ -668,62 +668,6 @@ static unsigned int stac92xx_vref_get(st
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
@@ -2695,7 +2639,93 @@ static int stac92xx_hp_switch_put(struct
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
+	if (kcontrol->private_value & 0x100)
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
+	hda_nid_t nid = kcontrol->private_value & 0x0ff;
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
+	hda_nid_t nid = (kcontrol->private_value & 0x0ff);
+
+	if (ucontrol->value.enumerated.item[0] == 0)
+		new_vref = stac92xx_get_vref(codec, nid);
+	else if (ucontrol->value.enumerated.item[0] == 1)
+		new_vref = AC_PINCTL_VREF_GRD;
+	else if (ucontrol->value.enumerated.item[0] == 2)
+		new_vref = AC_PINCTL_VREF_HIZ;
+	else
+		return 1;
+
+	if (new_vref != stac92xx_vref_get(codec, nid)) {
+		error = stac92xx_vref_set(codec, nid, new_vref);
+		return error;
+	}
+
+	return 0;
+}
+
+
+
+static int stac92xx_io_switch_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2];
+	if (kcontrol->private_value & 0xff)
+		texts[0] = "Mic In";
+	else
+		texts[0] = "Line In";
+	texts[1] = "Line Out";
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = 2;
+	uinfo->count = 1;
+	if (uinfo->value.enumerated.item >= 2)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
 
 static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
@@ -2703,7 +2733,7 @@ static int stac92xx_io_switch_get(struct
 	struct sigmatel_spec *spec = codec->spec;
 	int io_idx = kcontrol-> private_value & 0xff;
 
-	ucontrol->value.integer.value[0] = spec->io_switch[io_idx];
+	ucontrol->value.enumerated.item[0] = spec->io_switch[io_idx];
 	return 0;
 }
 
@@ -2713,7 +2743,7 @@ static int stac92xx_io_switch_put(struct
 	struct sigmatel_spec *spec = codec->spec;
         hda_nid_t nid = kcontrol->private_value >> 8;
 	int io_idx = kcontrol-> private_value & 0xff;
-	unsigned short val = !!ucontrol->value.integer.value[0];
+	unsigned short val = !!ucontrol->value.enumerated.item[0];
 
 	spec->io_switch[io_idx] = val;
 
@@ -3242,7 +3272,10 @@ static int stac92xx_auto_create_multi_ou
 					       const struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	hda_nid_t nid;
+	int def_conf;
 	int err;
+	int idx;
 
 	err = create_multi_out_ctls(codec, cfg->line_outs, cfg->line_out_pins,
 				    spec->multiout.dac_nids,
@@ -3261,18 +3294,34 @@ static int stac92xx_auto_create_multi_ou
 
 	if (spec->line_switch) {
 		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-					   "Line In as Output Switch",
+					   "Line In Jack Mode",
 					   spec->line_switch << 8);
 		if (err < 0)
 			return err;
 	}
 
-	if (spec->mic_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
-					   "Mic Jack Mode",
-					   spec->mic_switch);
-		if (err < 0)
-			return err;
+	nid = cfg->input_pins[AUTO_PIN_MIC];
+	idx = 0;
+again:
+	if (nid) {
+		def_conf = snd_hda_codec_get_pincfg(codec, nid);
+		if (!((get_defcfg_connect(def_conf)) & AC_JACK_PORT_FIXED)) {
+			if (snd_hda_query_pin_caps(codec, nid)
+				& (AC_PINCAP_VREF_GRD << AC_PINCAP_VREF_SHIFT))
+				stac92xx_add_control_idx(spec,
+					STAC_CTL_WIDGET_DC_BIAS, idx++,
+					"Mic Jack Mode", nid
+					| ((nid == spec->mic_switch)
+					? 0x100 : 0));
+			else if (nid == spec->mic_switch)
+				stac92xx_add_control_idx(spec,
+					STAC_CTL_WIDGET_IO_SWITCH, idx++,
+					"Mic Jack Mode", ((nid << 8) | 1));
+		}
+	}
+	if (nid == cfg->input_pins[AUTO_PIN_MIC]) {
+		nid = cfg->input_pins[AUTO_PIN_FRONT_MIC];
+		goto again;
 	}
 
 	return 0;

--------------060602020602070005060800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060602020602070005060800--
