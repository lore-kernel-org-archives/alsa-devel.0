From: <LoganLi@viatech.com.cn>
Subject: [PATCH 18/30] ALSA: HDA VIA: Modify
	vt1708_auto_create_multi_out_ctls.
Date: Fri, 9 Oct 2009 18:40:53 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C3F@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id A4AB4103AA2
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:47 +0200 (CEST)
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
Subject: ALSA: HDA VIA: Modify vt1708_auto_create_multi_out_ctls.

Rewrite nid_vol/mute assignment for clearity, and check line connection
before adding control for it.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -1570,7 +1570,7 @@
 {
 	char name[32];
 	static const char *chname[4] = { "Front", "Surround", "C/LFE",
"Side" };
-	hda_nid_t nid, nid_vol = 0;
+	hda_nid_t nid, nid_vol, nid_vols[] = {0x17, 0x19, 0x1a, 0x1b};
 	int i, err;
 
 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
@@ -1579,8 +1579,7 @@
 		if (!nid)
 			continue;
 		
-		if (i != AUTO_SEQ_FRONT)
-			nid_vol = 0x18 + i;
+		nid_vol = nid_vols[i];
 
 		if (i == AUTO_SEQ_CENLFE) {
 			/* Center/LFE */
@@ -1612,13 +1611,13 @@
 			/* add control to mixer index 0 */
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL,
 					      "Master Front Playback
Volume",
-					      HDA_COMPOSE_AMP_VAL(0x17,
3, 0,
+
HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 
HDA_INPUT));
 			if (err < 0)
 				return err;
 			err = via_add_control(spec, VIA_CTL_WIDGET_MUTE,
 					      "Master Front Playback
Switch",
-					      HDA_COMPOSE_AMP_VAL(0x17,
3, 0,
+
HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
 
HDA_INPUT));
 			if (err < 0)
 				return err;
