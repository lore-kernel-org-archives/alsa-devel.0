From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA: Fix headphone mute issue on non-eapd Conexant
	systems.
Date: Wed, 16 May 2007 17:15:33 -0700
Message-ID: <1179360933.4415.254.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dXfmXfBtlTpER/lZb6rY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id EA304243E9
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 02:15:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-dXfmXfBtlTpER/lZb6rY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes an automute code issue for systems that do not rely on
eapd support.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-dXfmXfBtlTpER/lZb6rY
Content-Disposition: attachment; filename=conexant-test22.patch
Content-Type: text/x-patch; name=conexant-test22.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 5bd948503866 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Tue May 15 11:47:48 2007 +0200
+++ b/pci/hda/patch_conexant.c	Wed May 16 11:12:18 2007 -0700
@@ -705,6 +705,17 @@ static struct snd_kcontrol_new cxt5045_t
 		.get = conexant_mux_enum_get,
 		.put = conexant_mux_enum_put,
 	},
+	/* Audio input controls */
+	HDA_CODEC_VOLUME("Input-1 Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-1 Switch", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-2 Volume", 0x1a, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-2 Switch", 0x1a, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-3 Volume", 0x1a, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-3 Switch", 0x1a, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-4 Volume", 0x1a, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-4 Switch", 0x1a, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Input-5 Volume", 0x1a, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Input-5 Switch", 0x1a, 0x4, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -947,6 +958,23 @@ static void cxt5047_hp_automute(struct h
 	snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0x80, bits);
 }
 
+/* mute internal speaker if HP is plugged */
+static void cxt5047_hp2_automute(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	unsigned int bits;
+
+	spec->hp_present = snd_hda_codec_read(codec, 0x13, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+
+	bits = spec->hp_present ? 0x80 : 0;
+	snd_hda_codec_amp_update(codec, 0x1d, 0, HDA_OUTPUT, 0, 0x80, bits);
+	snd_hda_codec_amp_update(codec, 0x1d, 1, HDA_OUTPUT, 0, 0x80, bits);
+	/* Mute/Unmute PCM 2 for good measure - some systems need this */
+	snd_hda_codec_amp_update(codec, 0x1c, 0, HDA_OUTPUT, 0, 0x80, bits);
+	snd_hda_codec_amp_update(codec, 0x1c, 1, HDA_OUTPUT, 0, 0x80, bits);
+}
+
 /* toggle input of built-in and mic jack appropriately */
 static void cxt5047_hp_automic(struct hda_codec *codec)
 {
@@ -978,6 +1006,21 @@ static void cxt5047_hp_unsol_event(struc
 	switch (res) {
 	case CONEXANT_HP_EVENT:
 		cxt5047_hp_automute(codec);
+		break;
+	case CONEXANT_MIC_EVENT:
+		cxt5047_hp_automic(codec);
+		break;
+	}
+}
+
+/* unsolicited event for HP jack sensing - non-EAPD systems */
+static void cxt5047_hp2_unsol_event(struct hda_codec *codec,
+				  unsigned int res)
+{
+	res >>= 26;
+	switch (res) {
+	case CONEXANT_HP_EVENT:
+		cxt5047_hp2_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
 		cxt5047_hp_automic(codec);
@@ -1300,19 +1343,20 @@ static int patch_cxt5047(struct hda_code
 	spec->channel_mode = cxt5047_modes,
 
 	codec->patch_ops = conexant_patch_ops;
-	codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
 
 	board_config = snd_hda_check_board_config(codec, CXT5047_MODELS,
 						  cxt5047_models,
 						  cxt5047_cfg_tbl);
 	switch (board_config) {
 	case CXT5047_LAPTOP:
+		codec->patch_ops.unsol_event = cxt5047_hp2_unsol_event;
 		break;
 	case CXT5047_LAPTOP_HP:
 		spec->input_mux = &cxt5047_hp_capture_source;
 		spec->num_init_verbs = 2;
 		spec->init_verbs[1] = cxt5047_hp_init_verbs;
 		spec->mixers[0] = cxt5047_hp_mixers;
+		codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
 		codec->patch_ops.init = cxt5047_hp_init;
 		break;
 	case CXT5047_LAPTOP_EAPD:
@@ -1320,12 +1364,14 @@ static int patch_cxt5047(struct hda_code
 		spec->num_init_verbs = 2;
 		spec->init_verbs[1] = cxt5047_toshiba_init_verbs;
 		spec->mixers[0] = cxt5047_toshiba_mixers;
+		codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
 		break;
 #ifdef CONFIG_SND_DEBUG
 	case CXT5047_TEST:
 		spec->input_mux = &cxt5047_test_capture_source;
 		spec->mixers[0] = cxt5047_test_mixer;
 		spec->init_verbs[0] = cxt5047_test_init_verbs;
+		codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
 #endif	
 	}
 	return 0;

--=-dXfmXfBtlTpER/lZb6rY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-dXfmXfBtlTpER/lZb6rY--
