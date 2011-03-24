From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 1/6] ALSA: VIA HDA: Fix side channel mute
	invalid issue
Date: Thu, 24 Mar 2011 12:39:05 +0800
Message-ID: <4D8ACAE9.8040206@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EBE9103948
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 05:39:13 +0100 (CET)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Fix side channel mute invalid issue.

Modify side_mute_channel() and update_side_mute_status() functions 
to fix invalid side channel mute issue of VT2002P, VT1812 and VT1802 
codecs.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -708,6 +708,9 @@
 	case VT1709_10CH:	return 0x29;
 	case VT1708B_8CH:	/* fall thru */
 	case VT1708S:		return 0x27;
+	case VT2002P:		return 0x19;
+	case VT1802:		return 0x15;
+	case VT1812:		return 0x15;
 	default:		return 0;
 	}
 }
@@ -716,13 +719,22 @@
 {
 	/* mute side channel */
 	struct via_spec *spec = codec->spec;
-	unsigned int parm = spec->hp_independent_mode
-		? AMP_OUT_MUTE : AMP_OUT_UNMUTE;
+	unsigned int parm;
 	hda_nid_t sw3 = side_mute_channel(spec);
 
-	if (sw3)
-		snd_hda_codec_write(codec, sw3, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    parm);
+	if (sw3) {
+		if (VT2002P_COMPATIBLE(spec))
+			parm = spec->hp_independent_mode ?
+			       AMP_IN_MUTE(1) : AMP_IN_UNMUTE(1);
+		else
+			parm = spec->hp_independent_mode ?
+			       AMP_OUT_MUTE : AMP_OUT_UNMUTE;
+		snd_hda_codec_write(codec, sw3, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, parm);
+		if (spec->codec_type == VT1812)
+			snd_hda_codec_write(codec, 0x1d, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE, parm);
+	}
 	return 0;
 }
