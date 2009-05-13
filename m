From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: add controls to toggle DC
 bias on mic ports
Date: Wed, 13 May 2009 19:12:35 +0000
Message-ID: <4A0B1BA3.2090903@gmail.com>
References: <4A0B14B8.2030705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010209050002080609070708"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 0828C24351
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 04:03:44 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so524126ana.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 19:03:44 -0700 (PDT)
In-Reply-To: <4A0B14B8.2030705@gmail.com>
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
--------------010209050002080609070708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

attached: version WITHOUT word wrap.  I apologize for the last email.

Nick

--------------010209050002080609070708
Content-Type: text/plain;
 name="snd-hda-intel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-hda-intel.patch"

diff -urpN alsa-driver/sound/pci/hda/patch_sigmatel.c alsa-driver.a/sound/pci/hda/patch_sigmatel.c
--- alsa-driver/sound/pci/hda/patch_sigmatel.c	2009-05-12 22:05:31.000000000 +0000
+++ alsa-driver.a/sound/pci/hda/patch_sigmatel.c	2009-05-13 12:24:17.000000000 +0000
@@ -634,6 +634,96 @@ static int stac92xx_smux_enum_put(struct
 	return 0;
 }
 
+static unsigned int stac92xx_vref_set(struct hda_codec *codec,
+					hda_nid_t nid, unsigned int new_vref)
+{
+	unsigned int error;
+	unsigned int pincfg;
+	pincfg = snd_hda_codec_read(codec, nid, 0,
+				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+
+	pincfg &= 0xff;
+	pincfg &= ~(AC_PINCTL_VREFEN | AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN);
+	pincfg |= new_vref;
+
+	if (new_vref == AC_PINCTL_VREF_HIZ)
+		pincfg |= AC_PINCTL_OUT_EN;
+	else
+		pincfg |= AC_PINCTL_IN_EN;
+
+	error = snd_hda_codec_write_cache(codec, nid, 0,
+					AC_VERB_SET_PIN_WIDGET_CONTROL, pincfg);
+	if (error < 0)
+		return error;
+	else
+		return 1;
+}
+
+static unsigned int stac92xx_vref_get(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int vref;
+	vref = snd_hda_codec_read(codec, nid, 0,
+				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	vref &= AC_PINCTL_VREFEN;
+	return vref;
+}
+
+static int stac92xx_dc_bias_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int new_vref;
+	unsigned int error;
+
+	if (ucontrol->value.enumerated.item[0] == 0)
+		new_vref = AC_PINCTL_VREF_80;
+	else if (ucontrol->value.enumerated.item[0] == 1)
+		new_vref = AC_PINCTL_VREF_GRD;
+	else
+		new_vref = AC_PINCTL_VREF_HIZ;
+
+	if (new_vref != stac92xx_vref_get(codec, kcontrol->private_value)) {
+		error = stac92xx_vref_set(codec,
+					kcontrol->private_value, new_vref);
+		return error;
+	}
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int vref = stac92xx_vref_get(codec, kcontrol->private_value);
+	if (vref == AC_PINCTL_VREF_80)
+		ucontrol->value.enumerated.item[0] = 0;
+	else if (vref == AC_PINCTL_VREF_GRD)
+		ucontrol->value.enumerated.item[0] = 1;
+	else if (vref == AC_PINCTL_VREF_HIZ)
+		ucontrol->value.enumerated.item[0] = 2;
+
+	return 0;
+}
+
+static int stac92xx_dc_bias_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = {
+		"Mic In", "Line In", "Line Out"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->value.enumerated.items = 3;
+	uinfo->count = 1;
+	if (uinfo->value.enumerated.item >= 3)
+		uinfo->value.enumerated.item = 2;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
@@ -995,6 +1085,17 @@ static struct hda_verb stac9205_core_ini
 		.private_value = verb_read | (verb_write << 16), \
 	}
 
+#define DC_BIAS(xname, idx, nid) \
+	{ \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.index = idx, \
+		.info = stac92xx_dc_bias_info, \
+		.get = stac92xx_dc_bias_get, \
+		.put = stac92xx_dc_bias_put, \
+		.private_value = nid, \
+	}
+
 static struct snd_kcontrol_new stac9200_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
@@ -2702,7 +2803,8 @@ enum {
 	STAC_CTL_WIDGET_AMP_VOL,
 	STAC_CTL_WIDGET_HP_SWITCH,
 	STAC_CTL_WIDGET_IO_SWITCH,
-	STAC_CTL_WIDGET_CLFE_SWITCH
+	STAC_CTL_WIDGET_CLFE_SWITCH,
+	STAC_CTL_WIDGET_DC_BIAS
 };
 
 static struct snd_kcontrol_new stac92xx_control_templates[] = {
@@ -2714,6 +2816,7 @@ static struct snd_kcontrol_new stac92xx_
 	STAC_CODEC_HP_SWITCH(NULL),
 	STAC_CODEC_IO_SWITCH(NULL, 0),
 	STAC_CODEC_CLFE_SWITCH(NULL, 0),
+	DC_BIAS(NULL, 0, 0),
 };
 
 /* add dynamic controls */
@@ -3165,9 +3268,9 @@ static int stac92xx_auto_create_multi_ou
 	}
 
 	if (spec->mic_switch) {
-		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_IO_SWITCH,
-					   "Mic as Output Switch",
-					   (spec->mic_switch << 8) | 1);
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_DC_BIAS,
+					   "Mic Jack Mode",
+					   spec->mic_switch);
 		if (err < 0)
 			return err;
 	}

--------------010209050002080609070708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010209050002080609070708--
