From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 011/112] ALSA: hda/realtek - Check amp
	capabilities of aa-mixer widget
Date: Tue,  8 Jan 2013 12:38:04 +0100
Message-ID: <1357645185-7645-12-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 061F9265138
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 2347CA51F7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

For handling the analog-loopback paths more generically, check the amp
capabilities of the aa-mixer widget, and create only the appropriate
mixer elements.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6b3e67c..1abcd8e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2672,6 +2672,10 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 	struct nid_path *path;
 	int err, idx;
 
+	if (!nid_has_volume(codec, mix_nid, HDA_INPUT) &&
+	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
+		return 0; /* no need for analog loopback */
+
 	path = snd_array_new(&spec->loopback_path);
 	if (!path)
 		return -ENOMEM;
@@ -2680,14 +2684,20 @@ static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
 		return -EINVAL;
 
 	idx = path->idx[path->depth - 1];
-	err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, ctlname, ctlidx,
+	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
+		err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL, ctlname, ctlidx,
 			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
-	if (err < 0)
-		return err;
-	err = __add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, ctlname, ctlidx,
+		if (err < 0)
+			return err;
+	}
+
+	if (nid_has_mute(codec, mix_nid, HDA_INPUT)) {
+		err = __add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_MUTE, ctlname, ctlidx,
 			  HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT));
-	if (err < 0)
-		return err;
+		if (err < 0)
+			return err;
+	}
+
 	add_loopback_list(spec, mix_nid, idx);
 	return 0;
 }
-- 
1.8.0.1
