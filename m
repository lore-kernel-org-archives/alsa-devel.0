From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7213: Fix incorrect usage of bitwise '&' operator for
 SRM check
Date: Wed, 3 May 2017 16:15:53 +0100
Message-ID: <20170503151553.AC3FE3FB6C@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

In the SRM lock check section of code the '&' bitwise operator is
used as part of checking lock status. Functionally the code works
as intended, but the conditional statement is a boolean comparison
so should really use '&&' logical operator instead. This commit
rectifies this discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 12da558..d114f33 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -771,7 +771,7 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7213_SRM_CHECK_RETRIES) & (!srm_lock));
+		} while ((i < DA7213_SRM_CHECK_RETRIES) && (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(codec->dev, "SRM failed to lock\n");
-- 
1.9.1
