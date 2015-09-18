From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/3] ASoC: wm0010: disable regulator on error
Date: Fri, 18 Sep 2015 16:02:19 +0530
Message-ID: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have done regulator_bulk_enable() while booting the DSP but on the
error exit path we have not disbled it.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/wm0010.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 8434d45..79a7cd3 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -739,8 +739,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 abort:
 	/* Put the chip back into reset */
 	wm0010_halt(codec);
-	mutex_unlock(&wm0010->lock);
-	return ret;
 
 err_core:
 	mutex_unlock(&wm0010->lock);
-- 
1.9.1
