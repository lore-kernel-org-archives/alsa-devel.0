From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - check NULL pointer when creating
	SPDIF controls
Date: Thu,  7 Mar 2013 14:10:25 -0500
Message-ID: <1362683425-19113-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2152615B6
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 07:10:18 +0100 (CET)
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

If the SPDIF control array cannot be reallocated, the function
will return to avoid dereferencing a NULL pointer.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 04b5738..3dc6566 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3334,6 +3334,8 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 		return -EBUSY;
 	}
 	spdif = snd_array_new(&codec->spdif_out);
+	if (!spdif)
+		return -ENOMEM;
 	for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
 		kctl = snd_ctl_new1(dig_mix, codec);
 		if (!kctl)
-- 
1.7.10.4
