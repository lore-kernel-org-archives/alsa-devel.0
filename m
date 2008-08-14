From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: dynamically create capture mux contols
Date: Thu, 14 Aug 2008 12:03:32 -0400
Message-ID: <48A45754.3040504@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id BD76B244D0
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 18:03:44 +0200 (CEST)
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

Dynamically create capture mux volume controls when a output amp is detected.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index ff56432..621cc48 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -794,7 +794,9 @@ static struct snd_kcontrol_new stac9200_mixer[] = {
 	STAC_INPUT_SOURCE(1),
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	*/
 	{ } /* end */
 };

@@ -908,14 +910,15 @@ static struct snd_kcontrol_new
stac92hd71bxx_analog_mixer[] = {

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
+	*/

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
-	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
-
 	/* analog pc-beep replaced with digital beep support */
 	/*
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("PC Beep Volume", 0x17, 0x2, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
 	*/
@@ -931,11 +934,15 @@ static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
+	*/

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+	*/
 	{ } /* end */
 };

@@ -943,7 +950,9 @@ static struct snd_kcontrol_new stac925x_mixer[] = {
 	STAC_INPUT_SOURCE(1),
 	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x14, 0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
+	*/
 	{ } /* end */
 };

@@ -957,8 +966,9 @@ static struct snd_kcontrol_new stac9205_mixer[] = {

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1c, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1e, 0x0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x1, 0x1A, 0x0, HDA_OUTPUT),
-
+	*/
 	{ } /* end */
 };

@@ -971,7 +981,9 @@ static struct snd_kcontrol_new stac922x_mixer[] = {

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x18, 0x0, HDA_INPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x1, 0x13, 0x0, HDA_OUTPUT),
+	*/
 	{ } /* end */
 };

@@ -990,7 +1002,9 @@ static struct snd_kcontrol_new stac927x_mixer[] = {

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x2, 0x1A, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x2, 0x1d, 0x0, HDA_OUTPUT),
+	/*
 	HDA_CODEC_VOLUME_IDX("Mux Capture Volume", 0x2, 0x17, 0x0, HDA_OUTPUT),
+	*/
 	{ } /* end */
 };

@@ -2780,6 +2794,35 @@ static int stac92xx_auto_create_beep_ctls(struct
hda_codec *codec,
 	return 0;
 }

+/* labels for mux inputs */
+static const char *stac92xx_mux_labels[4] = {
+	"Capture Mux 1", "Capture Mux 2", "Capture Mux 3",
+	"Capture Mux 4"
+};
+
+static int stac92xx_auto_create_mux_input_ctls(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int wcaps, nid, i, err = 0;
+	char name[32];
+
+	for (i = 0; i < spec->num_muxes; i++) {
+		nid = spec->mux_nids[i];
+		wcaps = get_wcaps(codec, nid);
+
+		if (wcaps & AC_WCAP_OUT_AMP) {
+			sprintf(name, "%s Capture Volume",
+				stac92xx_mux_labels[i]);
+			err = stac92xx_add_control(spec,
+				STAC_CTL_WIDGET_VOL, name,
+				HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+};
+
 /* labels for dmic mux inputs */
 static const char *stac92xx_dmic_labels[5] = {
 	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
@@ -3078,6 +3121,11 @@ static int stac92xx_parse_auto_config(struct hda_codec
*codec, hda_nid_t dig_out
 		if ((err = stac92xx_auto_create_dmic_input_ctls(codec,
 						&spec->autocfg)) < 0)
 			return err;
+	if (spec->num_muxes > 0) {
+		err = stac92xx_auto_create_mux_input_ctls(codec);
+		if (err < 0)
+			return err;
+	}

 	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
 	if (spec->multiout.max_channels > 2)
