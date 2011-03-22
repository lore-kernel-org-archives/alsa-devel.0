From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 3/8] ALSA: VIA HDA: Fix independent headphone
	no sound issue
Date: Tue, 22 Mar 2011 14:30:06 +0800
Message-ID: <4D8841EE.1050705@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DDF6103826
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:30:10 +0100 (CET)
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
Subject: ALSA: VIA HDA: Fix independent headphone no sound issue.

Modify via_independent_hp_put() function to support VT1718S and VT1812 
codecs, and fix independent headphone no sound issue.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -723,8 +723,16 @@
 	/* Get Independent Mode index of headphone pin widget */
 	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
 		? 1 : 0;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL, pinsel);
+	if (spec->codec_type == VT1718S)
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+	else
+		snd_hda_codec_write(codec, nid, 0,
+				    AC_VERB_SET_CONNECT_SEL, pinsel);
 
+	if (spec->codec_type == VT1812)
+		snd_hda_codec_write(codec, 0x35, 0,
+				    AC_VERB_SET_CONNECT_SEL, pinsel);
 	if (spec->multiout.hp_nid && spec->multiout.hp_nid
 	    != spec->multiout.dac_nids[HDA_FRONT])
 		snd_hda_codec_setup_stream(codec, spec->multiout.hp_nid,
@@ -743,6 +751,8 @@
 		activate_ctl(codec, "Headphone Playback Switch",
 			     spec->hp_independent_mode);
 	}
+	/* update jack power state */
+	set_widgets_power_state(codec);
 	return 0;
 }
