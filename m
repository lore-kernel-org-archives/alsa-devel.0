From: lydiawang <lydiawang@viatech.com.cn>
Subject: [PATCH 2/3] ALSA: VIA HDA: Mute/unmute mixer conncted
 to Headphone for VT1718S.
Date: Mon, 20 Jun 2011 14:16:33 +0800
Message-ID: <4DFEE5C1.2040703@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id D04B1103865
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 08:16:36 +0200 (CEST)
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
Cc: tiwai@suse.de, haraldwelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Mute/unmute mixer conncted to Headphone for VT1718S.

When switch HP independent mode, mute/unmute connctions of mixer  which is 
connected to headphone for VT1718S.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2011-06-20 13:41:04.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2011-06-20 13:48:07.000000000 +0800
@@ -745,12 +745,23 @@
 	struct via_spec *spec = codec->spec;
 	hda_nid_t nid = kcontrol->private_value;
 	unsigned int pinsel = ucontrol->value.enumerated.item[0];
+	unsigned int parm0, parm1;
 	/* Get Independent Mode index of headphone pin widget */
 	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
 		? 1 : 0;
-	if (spec->codec_type == VT1718S)
+	if (spec->codec_type == VT1718S) {
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+		/* Set correct mute switch for MW3 */
+		parm0 = spec->hp_independent_mode ?
+			       AMP_IN_UNMUTE(0) : AMP_IN_MUTE(0);
+		parm1 = spec->hp_independent_mode ?
+			       AMP_IN_MUTE(1) : AMP_IN_UNMUTE(1);
+		snd_hda_codec_write(codec, 0x1b, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, parm0);
+		snd_hda_codec_write(codec, 0x1b, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, parm1);
+	}
 	else
 		snd_hda_codec_write(codec, nid, 0,
 				    AC_VERB_SET_CONNECT_SEL, pinsel);
