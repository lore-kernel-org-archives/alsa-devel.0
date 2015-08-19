From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix gain settings of FLL in
	free-run mode
Date: Wed, 19 Aug 2015 16:02:24 +0100
Message-ID: <1439996544-21354-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 61051265054
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 17:23:01 +0200 (CEST)
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
Cc: nikesh.oswal@wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>

The wrong register was used to set the gain of ref loop, when changing
the FLL output on an active FLL. This patch corrects the offset of the
gain register.

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e759d39..42b2021 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2058,7 +2058,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 
 	if (already_enabled) {
 		/* Facilitate smooth refclk across the transition */
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x7,
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
 					 ARIZONA_FLL1_GAIN_MASK, 0);
 		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
 					 ARIZONA_FLL1_FREERUN,
-- 
1.7.2.5
