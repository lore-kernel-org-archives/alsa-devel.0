From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 20/31] HDA patch_via.c: Modify
	vt1709_auto_create_multi_out_ctls.
Date: Thu, 8 Oct 2009 13:46:46 +0800
Message-ID: <16685ee0910072246o1ce3c933pf9c7f0206c509d2@mail.gmail.com>
References: <16685ee0910050727u5368e250gaaf0682c4b39e552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 3811D1039B0
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:46:47 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1482790bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:46:47 -0700 (PDT)
In-Reply-To: <16685ee0910050727u5368e250gaaf0682c4b39e552@mail.gmail.com>
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

---
 sound/pci/hda/patch_via.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -2175,7 +2175,7 @@
 {
 	char name[32];
 	static const char *chname[4] = { "Front", "Surround", "C/LFE", "Side" };
-	hda_nid_t nid = 0;
+	hda_nid_t nid, nid_vol, nid_vols[] = {0x18, 0x1a, 0x1b, 0x29};
 	int i, err;

 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
@@ -2184,43 +2184,45 @@
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
@@ -2241,26 +2243,26 @@
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
