From: <LoganLi@viatech.com.cn>
Subject: [PATCH 9/30] ALSA: HDA VIA: Rewrite
	via_independent_hp_put
Date: Fri, 9 Oct 2009 18:40:22 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C36@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B3F3103A95
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:15 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Rewrite via_independent_hp_put

Use hp_independent_mode_index to store hp index, and simplify function
via_independent_hp_put with it.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   87
++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -252,6 +252,7 @@
 	/* HP mode source */
 	const struct hda_input_mux *hp_mux;
 	unsigned int hp_independent_mode;
+	unsigned int hp_independent_mode_index;
 
 	enum VIA_HDA_CODEC codec_type;
 
@@ -584,6 +585,36 @@
 	}
 }
 
+static int update_side_mute_status(struct hda_codec *codec)
+{
+	/* mute side channel */
+	struct via_spec *spec = codec->spec;
+	unsigned int parm = spec->hp_independent_mode
+		? AMP_OUT_MUTE : AMP_OUT_UNMUTE;
+	hda_nid_t sw3;
+
+	switch (spec->codec_type) {
+	case VT1708:
+		sw3 = 0x1b;
+		break;
+	case VT1709_10CH:
+		sw3 = 0x29;
+		break;
+	case VT1708B_8CH:
+	case VT1708S:
+		sw3 = 0x27;
+		break;
+	default:
+		sw3 = 0;
+		break;
+	}
+
+	if (sw3)
+		snd_hda_codec_write(codec, sw3, 0,
AC_VERB_SET_AMP_GAIN_MUTE,
+				    parm);
+	return 0;
+}
+
 static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
@@ -591,47 +622,18 @@
 	struct via_spec *spec = codec->spec;
 	hda_nid_t nid = spec->autocfg.hp_pins[0];
 	unsigned int pinsel = ucontrol->value.enumerated.item[0];
-	unsigned int con_nid = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_CONNECT_LIST, 0) &
0xff;
-
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
-
spec->multiout.hp_nid,
-						   0, 0, 0);
+	/* Get Independent Mode index of headphone pin widget */
+	spec->hp_independent_mode = spec->hp_independent_mode_index ==
pinsel
+		? 1 : 0;
+
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
pinsel);
+
+	if (spec->multiout.hp_nid && spec->multiout.hp_nid
+	    != spec->multiout.dac_nids[HDA_FRONT])
+		snd_hda_codec_setup_stream(codec, spec->multiout.hp_nid,
+					   0, 0, 0);
 
+	update_side_mute_status(codec);
 	/* update HP volume/swtich active state */
 	if (spec->codec_type == VT1708S
 	    || spec->codec_type == VT1702) {
@@ -1447,6 +1449,7 @@
 		return 0;
 
 	spec->multiout.hp_nid = VT1708_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -1981,6 +1984,7 @@
 		spec->multiout.hp_nid = VT1709_HP_DAC_NID;
 	else if (spec->multiout.num_dacs == 3) /* 6 channels */
 		spec->multiout.hp_nid = 0;
+	spec->hp_independent_mode_index = 1;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -2540,6 +2544,7 @@
 		return 0;
 
 	spec->multiout.hp_nid = VT1708B_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -3010,6 +3015,7 @@
 		return 0;
 
 	spec->multiout.hp_nid = VT1708S_HP_NID; /* AOW3 */
+	spec->hp_independent_mode_index = 1;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
@@ -3367,6 +3373,7 @@
 	if (!pin)
 		return 0;
 	spec->multiout.hp_nid = 0x1D;
+	spec->hp_independent_mode_index = 0;
 
 	err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",
