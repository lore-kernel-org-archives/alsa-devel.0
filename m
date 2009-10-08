From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 19/31] HDA patch_via.c: Modify
	vt1708_auto_create_multi_out_ctls.
Date: Thu, 8 Oct 2009 13:46:29 +0800
Message-ID: <16685ee0910072246l60a4a349re36a64a2a598d661@mail.gmail.com>
References: <16685ee0910050727u7a074b26n91c1d496c7691947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 65643103962
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:46:29 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5188489fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:46:29 -0700 (PDT)
In-Reply-To: <16685ee0910050727u7a074b26n91c1d496c7691947@mail.gmail.com>
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

[ALSA] HDA VIA: Modify vt1708_auto_create_multi_out_ctls.

Rewrite nid_vol/mute assignment for clearity, and check line connection
before adding control for it.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1568,7 +1568,7 @@
 {
 	char name[32];
 	static const char *chname[4] = { "Front", "Surround", "C/LFE", "Side" };
-	hda_nid_t nid, nid_vol = 0;
+	hda_nid_t nid, nid_vol, nid_vols[] = {0x17, 0x19, 0x1a, 0x1b};
 	int i, err;

 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
@@ -1577,8 +1577,7 @@
 		if (!nid)
 			continue;
 		
-		if (i != AUTO_SEQ_FRONT)
-			nid_vol = 0x18 + i;
+		nid_vol = nid_vols[i];

 		if (i == AUTO_SEQ_CENLFE) {
 			/* Center/LFE */
@@ -1610,13 +1609,13 @@
 			/* add control to mixer index 0 */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Master Front Playback Volume",
-					      HDA_COMPOSE_AMP_VAL(0x17, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
 					      "Master Front Playback Switch",
-					      HDA_COMPOSE_AMP_VAL(0x17, 3, 0,
+					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
