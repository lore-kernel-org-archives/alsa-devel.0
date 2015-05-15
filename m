From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Drop unnecessary bias level check on
	resume
Date: Fri, 15 May 2015 12:41:30 +0200
Message-ID: <1431686490-13204-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EF2B2605B8
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 12:41:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The suspended flag will only be set if the CODEC bias level was either
STANDBY or OFF. This means we don't need to check for that on resume since
the condition will always be true.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2373252..95b5f03 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -750,23 +750,10 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		/* If the CODEC was idle over suspend then it will have been
-		 * left with bias OFF or STANDBY and suspended so we must now
-		 * resume.  Otherwise the suspend was suppressed.
-		 */
 		if (codec->suspended) {
-			switch (codec->dapm.bias_level) {
-			case SND_SOC_BIAS_STANDBY:
-			case SND_SOC_BIAS_OFF:
-				if (codec->driver->resume)
-					codec->driver->resume(codec);
-				codec->suspended = 0;
-				break;
-			default:
-				dev_dbg(codec->dev,
-					"ASoC: CODEC was on over suspend\n");
-				break;
-			}
+			if (codec->driver->resume)
+				codec->driver->resume(codec);
+			codec->suspended = 0;
 		}
 	}
 
-- 
1.8.0
