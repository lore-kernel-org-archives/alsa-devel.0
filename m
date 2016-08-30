From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Don't change the FLLn_GAIN
	before entering FREERUN
Date: Tue, 30 Aug 2016 10:30:40 +0100
Message-ID: <1472549440-4155-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D4B266B4F
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 11:30:32 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, nariman@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>

When reclocking an active FLL, to ensure a clean transition, do
not change the gain setting until we have entered free run.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ecfdbfc..0fc3b4b 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2218,11 +2218,11 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 
 	if (already_enabled) {
 		/* Facilitate smooth refclk across the transition */
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
-					 ARIZONA_FLL1_GAIN_MASK, 0);
 		regmap_update_bits(fll->arizona->regmap, fll->base + 1,
 				   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
 		udelay(32);
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
+					 ARIZONA_FLL1_GAIN_MASK, 0);
 	}
 
 	/*
-- 
2.1.4
