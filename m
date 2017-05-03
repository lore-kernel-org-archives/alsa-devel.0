From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7218: Fix incorrect usage of bitwise
 '&' operator for SRM check
Date: Wed, 3 May 2017 14:54:06 +0100
Message-ID: <20170503135406.5EA1E3FB6C@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.140])
 by alsa0.perex.cz (Postfix) with ESMTP id E779F2667FE
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 15:54:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In the SRM lock check section of code the '&' bitwise operator is
used as part of checking lock status. Functionally the code works
as intended, but the conditional statement is a boolean comparison
so should really use '&&' logical operator instead. This commit
rectifies this discrepancy.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index d256ebf..6e1940e 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -1457,7 +1457,7 @@ static int da7218_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(DA7218_SRM_CHECK_DELAY);
 			}
-		} while ((i < DA7218_SRM_CHECK_TRIES) & (!success));
+		} while ((i < DA7218_SRM_CHECK_TRIES) && (!success));
 
 		if (!success)
 			dev_warn(codec->dev, "SRM failed to lock\n");
-- 
1.9.1
