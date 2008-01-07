From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Dynamically create digital gain mixers
Date: Mon, 07 Jan 2008 15:18:38 -0500
Message-ID: <4782891E.9090407@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090607000301040300050802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.biz.mail.mud.yahoo.com (smtp107.biz.mail.mud.yahoo.com
	[68.142.200.255]) by alsa0.perex.cz (Postfix) with SMTP id C7BCF249D4
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 21:18:43 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090607000301040300050802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dynamically create digital gain mixers for dmics that have out-amp 
support. Also some 92HD73xx's codecs don't have DMIC gains, so this also 
prevents creating dead mixers.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------090607000301040300050802
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac_dmic_mixers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac_dmic_mixers.patch"

diff -r 37956a45462d pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Jan 07 15:16:37 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Jan 07 15:04:42 2008 -0500
@@ -463,9 +463,6 @@ static struct hda_verb stac92hd73xx_6ch_
 	/* setup adcs to point to mixer */
 	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
-	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
-	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
-	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
 	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -490,9 +487,6 @@ static struct hda_verb stac92hd73xx_8ch_
 	/* setup adcs to point to mixer */
 	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
-	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
-	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
-	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
 	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -519,9 +513,6 @@ static struct hda_verb stac92hd73xx_10ch
 	/* setup adcs to point to mixer */
 	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
 	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
-	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
-	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
-	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
 	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
@@ -635,10 +626,6 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd73xx_6ch_mixer[] = {
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 3),
 
-	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
-
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
 
@@ -665,10 +652,6 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd73xx_8ch_mixer[] = {
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 4),
 
-	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
-
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
 
@@ -695,10 +678,6 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd73xx_10ch_mixer[] = {
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 5),
 
-	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_INPUT),
-
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
 
@@ -725,10 +704,6 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 
-	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x18, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
-
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
@@ -745,10 +720,6 @@ static struct snd_kcontrol_new stac92hd7
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_INPUT_SOURCE(2),
 	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
-
-	/* hardware gain controls */
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x18, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
 
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -2313,15 +2284,18 @@ static int stac92xx_auto_create_dmic_inp
 	struct sigmatel_spec *spec = codec->spec;
 	struct hda_input_mux *dimux = &spec->private_dimux;
 	hda_nid_t con_lst[HDA_MAX_NUM_INPUTS];
-	int i, j;
+	int err, i, j;
+	char name[32];
 
 	dimux->items[dimux->num_items].label = stac92xx_dmic_labels[0];
 	dimux->items[dimux->num_items].index = 0;
 	dimux->num_items++;
 
 	for (i = 0; i < spec->num_dmics; i++) {
+		hda_nid_t nid;
 		int index;
 		int num_cons;
+		unsigned int wcaps;
 		unsigned int def_conf;
 
 		def_conf = snd_hda_codec_read(codec,
@@ -2332,17 +2306,32 @@ static int stac92xx_auto_create_dmic_inp
 		if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE)
 			continue;
 
+		nid = spec->dmic_nids[i];
 		num_cons = snd_hda_get_connections(codec,
 				spec->dmux_nids[0],
 				con_lst,
 				HDA_MAX_NUM_INPUTS);
 		for (j = 0; j < num_cons; j++)
-			if (con_lst[j] == spec->dmic_nids[i]) {
+			if (con_lst[j] == nid) {
 				index = j;
 				goto found;
 			}
 		continue;
 found:
+		wcaps = get_wcaps(codec, nid);
+
+		if (wcaps & AC_WCAP_OUT_AMP) {
+			sprintf(name, "%s Capture Volume",
+					stac92xx_dmic_labels[dimux->num_items]);
+
+			err = stac92xx_add_control(spec,
+				STAC_CTL_WIDGET_VOL,
+				name,
+				HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		}
+
 		dimux->items[dimux->num_items].label =
 			stac92xx_dmic_labels[dimux->num_items];
 		dimux->items[dimux->num_items].index = index;

--------------090607000301040300050802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090607000301040300050802--
