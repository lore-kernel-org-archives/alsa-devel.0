From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 6/16] ALSA: VIA HDA: Fix independent headphone
	no sound issue
Date: Mon, 21 Mar 2011 15:28:04 +0800
Message-ID: <4D86FE04.4040605@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 6478E243DF
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:28:09 +0100 (CET)
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
 sound/pci/hda/patch_via.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -740,8 +740,15 @@
 	/* Get Independent Mode index of headphone pin widget */
 	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
 		? 1 : 0;
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL, pinsel);
-
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
@@ -761,6 +768,8 @@
 		activate_ctl(codec, "Headphone Playback Switch",
 			     spec->hp_independent_mode);
 	}
+	/* update jack power state */
+	set_widgets_power_state(codec);
 	return 0;
 }
