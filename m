From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8995: Fix setting sysclk for
 WM8995_SYSCLK_MCLK2 case
Date: Tue, 16 Jun 2015 19:39:09 +0800
Message-ID: <1434454749.12886.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id D1857261721
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 13:39:17 +0200 (CEST)
Received: by pdjn11 with SMTP id n11so12739781pdj.0
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 04:39:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix trivial typo.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Charles and Dimitris,
This looks like a typo. Can you confirm?
Thanks,
Axel.

 sound/soc/codecs/wm8995.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index 687c4dd..505b65f 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -1930,7 +1930,7 @@ static int wm8995_set_dai_sysclk(struct snd_soc_dai *dai,
 			dai->id + 1, freq);
 		break;
 	case WM8995_SYSCLK_MCLK2:
-		wm8995->sysclk[dai->id] = WM8995_SYSCLK_MCLK1;
+		wm8995->sysclk[dai->id] = WM8995_SYSCLK_MCLK2;
 		wm8995->mclk[1] = freq;
 		dev_dbg(dai->dev, "AIF%d using MCLK2 at %uHz\n",
 			dai->id + 1, freq);
-- 
2.1.0
