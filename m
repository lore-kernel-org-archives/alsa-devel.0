From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - check NULL pointer when creating
	SPDIF PCM switch
Date: Thu,  7 Mar 2013 14:11:05 -0500
Message-ID: <1362683465-19150-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DC6265D07
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 07:10:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

If the new control cannot be created, this function will return to avoid
snd_hda_ctl_add dereferencing a NULL control pointer.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 3dc6566..97c68dd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3433,11 +3433,16 @@ static struct snd_kcontrol_new spdif_share_sw = {
 int snd_hda_create_spdif_share_sw(struct hda_codec *codec,
 				  struct hda_multi_out *mout)
 {
+	struct snd_kcontrol *kctl;
+
 	if (!mout->dig_out_nid)
 		return 0;
+
+	kctl = snd_ctl_new1(&spdif_share_sw, mout);
+	if (!kctl)
+		return -ENOMEM;
 	/* ATTENTION: here mout is passed as private_data, instead of codec */
-	return snd_hda_ctl_add(codec, mout->dig_out_nid,
-			      snd_ctl_new1(&spdif_share_sw, mout));
+	return snd_hda_ctl_add(codec, mout->dig_out_nid, kctl);
 }
 EXPORT_SYMBOL_HDA(snd_hda_create_spdif_share_sw);
 
-- 
1.7.10.4
