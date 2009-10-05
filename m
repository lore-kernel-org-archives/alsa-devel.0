From: Li Bo <liboat@gmail.com>
Subject: [PATCH 9/31] HDA patch_via.c: Rewrite
	via_independent_hp_put
Date: Mon, 5 Oct 2009 22:25:21 +0800
Message-ID: <16685ee0910050725x5002c835tee182ff500a2f3fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A694103875
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:25:21 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2789765fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:25:21 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Rewrite via_independent_hp_put

Use hp_independent_mode_index to store hp index, and simplify function
via_independent_hp_put with it.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:09:33.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:09:46.000000000 +0800
@@ -252,6 +252,7 @@
 	/* HP mode source */
 	const struct hda_input_mux *hp_mux;
 	unsigned int hp_independent_mode;
+	unsigned int hp_independent_mode_index;

 	enum VIA_HDA_CODEC codec_type;

@@ -589,6 +590,30 @@
 	return 0;
 }

+static int update_side_mute_status(struct hda_codec *codec)
+{
+	/* mute side channel */
+	struct via_spec *spec = codec->spec;
+	unsigned int parm = spec->hp_independent_mode
+		? AMP_OUT_MUTE : AMP_OUT_UNMUTE;
+	hda_nid_t nids_sw3[CODEC_TYPES] = {
+		[VT1708] = 0x1b,
+		[VT1709_10CH] = 0x29,
+		[VT1709_6CH] = 0,
+		[VT1708B_8CH] = 0x27,
+		[VT1708B_4CH] = 0,
+		[VT1708S] = 0x27,
+		[VT1702] = 0,
+	};
+
+	if (!nids_sw3[spec->codec_type])
+		return 0;
+
+	snd_hda_codec_write(codec, nids_sw3[spec->codec_type], 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, parm);
+	return 0;
+}
+
 static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
@@ -596,47 +621,19 @@
 	struct via_spec *spec = codec->spec;
 	hda_nid_t nid = spec->autocfg.hp_pins[0];
 	unsigned int pinsel = ucontrol->value.enumerated.item[0];
-	unsigned int con_nid = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;

-	if (con_nid == spec->multiout.hp_nid) {
-		if (pinsel == 0) {
-			if (!spec->hp_independent_mode) {
-				if (spec->multiout.num_dacs > 1)
-					spec->multiout.num_dacs -= 1;
-				spec->hp_independent_mode = 1;
-			}
-		} else if (pinsel == 1) {
-		       if (spec->hp_independent_mode) {
-				if (spec->multiout.num_dacs > 1)
-					spec->multiout.num_dacs += 1;
-				spec->hp_independent_mode = 0;
-		       }
-		}
-	} else {
-		if (pinsel == 0) {
-			if (spec->hp_independent_mode) {
-				if (spec->multiout.num_dacs > 1)
-					spec->multiout.num_dacs += 1;
-				spec->hp_independent_mode = 0;
-			}
-		} else if (pinsel == 1) {
-		       if (!spec->hp_independent_mode) {
-				if (spec->multiout.num_dacs > 1)
-					spec->multiout.num_dacs -= 1;
-				spec->hp_independent_mode = 1;
-		       }
-		}
-	}
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
-			    pinsel);
-
-	if (spec->multiout.hp_nid &&
-	    spec->multiout.hp_nid != spec->multiout.dac_nids[HDA_FRONT])
-			snd_hda_codec_setup_stream(codec,
-						   spec->multiout.hp_nid,
-						   0, 0, 0);
+	/* Get Independent Mode index of headphone pin widget */
+	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
+		? 1 : 0;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL, pinsel);
+
+	if (spec->multiout.hp_nid && spec->multiout.hp_nid
+	    != spec->multiout.dac_nids[HDA_FRONT])
+		snd_hda_codec_setup_stream(codec, spec->multiout.hp_nid,
+					   0, 0, 0);

+	update_side_mute_status(codec);
 	return 0;
 }

@@ -1444,6 +1441,7 @@
 		return 0;

 	spec->multiout.hp_nid = VT1708_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -1979,6 +1977,7 @@
 		spec->multiout.hp_nid = VT1709_HP_DAC_NID;
 	else if (spec->multiout.num_dacs == 3) /* 6 channels */
 		spec->multiout.hp_nid = 0;
+	spec->hp_independent_mode_index = 1;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -2538,6 +2537,7 @@
 		return 0;

 	spec->multiout.hp_nid = VT1708B_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -3008,6 +3008,7 @@
 		return 0;

 	spec->multiout.hp_nid = VT1708S_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -3367,6 +3368,7 @@
 	if (!pin)
 		return 0;
 	spec->multiout.hp_nid = 0x1D;
+	spec->hp_independent_mode_index = 0;

 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
