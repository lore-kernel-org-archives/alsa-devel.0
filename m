From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 9/16] ALSA: VIA HDA: Fix invalid A-A path
	volume adjust issue
Date: Mon, 21 Mar 2011 15:31:30 +0800
Message-ID: <4D86FED2.4080001@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 02BFB243E0
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:31:36 +0100 (CET)
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
Subject: ALSA: VIA HDA: Fix invalid A-A path volume adjust issue.

Modify vt_auto_create_analog_input_ctls() function to fix invalid a-a path 
volume adjust issue for VT1708S, VT1702 and VT1716S codecs.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -2021,7 +2021,14 @@
 		else
 			type_idx = 0;
 		label = hda_get_autocfg_input_label(codec, cfg, i);
-		err = via_new_analog_input(spec, label, type_idx, idx, cap_nid);
+		if (spec->codec_type == VT1708S ||
+		    spec->codec_type == VT1702 ||
+		    spec->codec_type == VT1716S)
+			err = via_new_analog_input(spec, label, type_idx,
+						   idx+1, cap_nid);
+		else
+			err = via_new_analog_input(spec, label, type_idx,
+						   idx, cap_nid);
 		if (err < 0)
 			return err;
 		snd_hda_add_imux_item(imux, label, idx, NULL);
