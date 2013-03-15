From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 3/3] ALSA: hda/ca0132 - Remove extra setting of
	dsp_state.
Date: Thu, 14 Mar 2013 17:27:46 -0700
Message-ID: <1363307266-30055-4-git-send-email-dgreid@chromium.org>
References: <1363307266-30055-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f202.google.com (mail-ve0-f202.google.com
 [209.85.128.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE6B261631
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 01:27:58 +0100 (CET)
Received: by mail-ve0-f202.google.com with SMTP id m1so291441ves.5
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:27:57 -0700 (PDT)
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

spec->dsp_state is initialized to DSP_DOWNLOAD_INIT, no need to reset
and check it in ca0132_download_dsp().

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 225d1d5..0792b57 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4372,16 +4372,13 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 #ifndef CONFIG_SND_HDA_CODEC_CA0132_DSP
 	return; /* NOP */
 #endif
-	spec->dsp_state = DSP_DOWNLOAD_INIT;
 
-	if (spec->dsp_state == DSP_DOWNLOAD_INIT) {
-		chipio_enable_clocks(codec);
-		spec->dsp_state = DSP_DOWNLOADING;
-		if (!ca0132_download_dsp_images(codec))
-			spec->dsp_state = DSP_DOWNLOAD_FAILED;
-		else
-			spec->dsp_state = DSP_DOWNLOADED;
-	}
+	chipio_enable_clocks(codec);
+	spec->dsp_state = DSP_DOWNLOADING;
+	if (!ca0132_download_dsp_images(codec))
+		spec->dsp_state = DSP_DOWNLOAD_FAILED;
+	else
+		spec->dsp_state = DSP_DOWNLOADED;
 
 	if (spec->dsp_state == DSP_DOWNLOADED)
 		ca0132_set_dsp_msr(codec, true);
-- 
1.8.1.3.605.g02339dd
