From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add 32uS delay after putting
	FLL into freerun
Date: Mon, 30 Nov 2015 17:37:28 +0000
Message-ID: <1448905048-13862-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E80012617B8
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 18:37:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

When switching between two clock sources using the FLL freerun to smooth
the transition we should wait 32uS after putting the FLL into freerun
before we proceed. In practice we appear to be getting enough delay from
the surrounding code, but better to make it explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e76ecc7..a23f7d1 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2212,9 +2212,9 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 		/* Facilitate smooth refclk across the transition */
 		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
 					 ARIZONA_FLL1_GAIN_MASK, 0);
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
-					 ARIZONA_FLL1_FREERUN,
-					 ARIZONA_FLL1_FREERUN);
+		regmap_update_bits(fll->arizona->regmap, fll->base + 1,
+				   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
+		udelay(32);
 	}
 
 	/*
-- 
2.1.4
