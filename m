From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/ca0132 - Convert leftover pr_info()
	and pr_err()
Date: Mon, 26 Oct 2015 16:56:31 +0100
Message-ID: <1445874991-19481-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 24A802606E0
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 16:56:33 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AF8C8AAF4
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 15:56:22 +0000 (UTC)
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

Use codec_*() macro instead of pr_*() for improving the log
information.  The current form even slips from alsa-info.sh.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 3a02e5c14d09..f8a12ca477f1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2673,13 +2673,13 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 
 	do {
 		if (dspload_is_loaded(codec)) {
-			pr_info("ca0132 DOWNLOAD OK :-) DSP IS RUNNING.\n");
+			codec_info(codec, "ca0132 DSP downloaded and running\n");
 			return true;
 		}
 		msleep(20);
 	} while (time_before(jiffies, timeout));
 
-	pr_err("ca0132 DOWNLOAD FAILED!!! DSP IS NOT RUNNING.\n");
+	codec_err(codec, "ca0132 failed to download DSP\n");
 	return false;
 }
 
@@ -4375,7 +4375,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 
 	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
 	if (dspload_image(codec, dsp_os_image, 0, 0, true, 0)) {
-		pr_err("ca0132 dspload_image failed.\n");
+		codec_err(codec, "ca0132 DSP load image failed\n");
 		goto exit_download;
 	}
 
-- 
2.6.2
