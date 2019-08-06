From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't override global PCM hw info
	flag
Date: Tue,  6 Aug 2019 17:07:34 +0200
Message-ID: <20190806150734.24610-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5BABF800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 17:07:38 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D1810AF4C
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 15:07:36 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The commit bfcba288b97f ("ALSA - hda: Add support for link audio time
reporting") introduced the conditional PCM hw info setup, but it
overwrites the global azx_pcm_hw object.  This will cause a problem if
any other HD-audio controller, as it'll inherit the same bit flag
although another controller doesn't support that feature.

Fix the bug by setting the PCM hw info flag locally.

Fixes: bfcba288b97f ("ALSA - hda: Add support for link audio time reporting")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index c8d1b4316245..2fbdde239936 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -598,11 +598,9 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	}
 	runtime->private_data = azx_dev;
 
-	if (chip->gts_present)
-		azx_pcm_hw.info = azx_pcm_hw.info |
-			SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
-
 	runtime->hw = azx_pcm_hw;
+	if (chip->gts_present)
+		runtime->hw.info |= SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME;
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
 	runtime->hw.formats = hinfo->formats;
-- 
2.16.4
