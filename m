From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 1/3] ALSA: hda/ca0132 - Check if dspload_image
	succeeded.
Date: Thu, 14 Mar 2013 17:27:44 -0700
Message-ID: <1363307266-30055-2-git-send-email-dgreid@chromium.org>
References: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f73.google.com (mail-vb0-f73.google.com
 [209.85.212.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A8926161F
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 01:27:57 +0100 (CET)
Received: by mail-vb0-f73.google.com with SMTP id fj18so283589vbb.4
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:27:56 -0700 (PDT)
In-Reply-To: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, chee_kin@ctl.creative.com, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

If dspload_image() fails, it was ignored and dspload_wait_loaded() was
still called.  dsp_loaded should never be set to true in this case,
skip it.  The check in dspload_wait_loaded() return true if the DSP is
loaded or if it never started.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index eefc456..cf24b75 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4351,12 +4351,16 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 		return false;
 
 	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
-	dspload_image(codec, dsp_os_image, 0, 0, true, 0);
+	if (dspload_image(codec, dsp_os_image, 0, 0, true, 0)) {
+		pr_err("ca0132 dspload_image failed.\n");
+		goto exit_download;
+	}
+
 	dsp_loaded = dspload_wait_loaded(codec);
 
+exit_download:
 	release_firmware(fw_entry);
 
-
 	return dsp_loaded;
 }
 
-- 
1.8.1.3.605.g02339dd
