From: Li Bo <liboat@gmail.com>
Subject: [PATCH 20/31] HDA patch_via.c: Modify
	vt1709_auto_create_multi_out_ctls.
Date: Mon, 5 Oct 2009 22:27:52 +0800
Message-ID: <16685ee0910050727u5368e250gaaf0682c4b39e552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8404B1038A5
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:52 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so1164658fge.2
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:52 -0700 (PDT)
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

[ALSA] HDA VIA: Modify vt1709_auto_create_multi_out_ctls.

Rewrite nid_vol/mute assignment for clearity, and check line connection
before adding control for it.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:11:06.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:11:08.000000000 +0800
@@ -2133,7 +2133,7 @@
 {
 	char name[32];
 	static const char *chname[4] = { "Front", "Surround", "C/LFE", "Side" };
-	hda_nid_t nid = 0;
+	hda_nid_t nid, nid_vol, nid_vols[] = {0x18, 0x1a, 0x1b, 0x29};
 	int i, err;

 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
@@ -2142,43 +2142,45 @@
 		if (!nid)	
 			continue;

+		nid_vol = nid_vols[i];
+
 		if (i == AUTO_SEQ_CENLFE) {
 			/* Center/LFE */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Center Playback Volume",
-					      HDA_COMPOSE_AMP_VAL(0x1b, 1, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 1, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "LFE Playback Volume",
-					      HDA_COMPOSE_AMP_VAL(0x1b, 2, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 2, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
 					      "Center Playback Switch",
-					      HDA_COMPOSE_AMP_VAL(0x1b, 1, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 1, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
 					      "LFE Playback Switch",
-					      HDA_COMPOSE_AMP_VAL(0x1b, 2, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 2, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 		} else if (i == AUTO_SEQ_FRONT){
-			/* add control to mixer index 0 */
+			/* ADD control to mixer index 0 */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Master Front Playback Volume",
-					      HDA_COMPOSE_AMP_VAL(0x18, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
 					      "Master Front Playback Switch",
-					      HDA_COMPOSE_AMP_VAL(0x18, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
@@ -2199,26 +2201,26 @@
 		} else if (i == AUTO_SEQ_SURROUND) {
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
-					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			sprintf(name, "%s Playback Switch", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
-					      HDA_COMPOSE_AMP_VAL(0x1a, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 		} else if (i == AUTO_SEQ_SIDE) {
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
-					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			sprintf(name, "%s Playback Switch", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
-					      HDA_COMPOSE_AMP_VAL(0x29, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_OUTPUT));
 			if (err < 0)
 				return err;
