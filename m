From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: arizona: FLL freerun only required
	whilst disabling
Date: Wed,  9 Jul 2014 17:41:48 +0100
Message-ID: <1404924109-1750-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 251952650D1
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:34 +0200 (CEST)
In-Reply-To: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

The FLL freerun is only required whilst we disable the FLL not the
entire time the FLL is disabled. This patch moves the FLL freerun
disable from the enable sequence to the disable sequence.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 1daa5cc..a044e29 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1837,8 +1837,6 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	try_wait_for_completion(&fll->ok);
 
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
-				 ARIZONA_FLL1_FREERUN, 0);
-	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 	if (use_sync)
 		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
@@ -1864,6 +1862,8 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 				 ARIZONA_FLL1_ENA, 0, &change);
 	regmap_update_bits(arizona->regmap, fll->base + 0x11,
 			   ARIZONA_FLL1_SYNC_ENA, 0);
+	regmap_update_bits_async(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_FREERUN, 0);
 
 	if (change)
 		pm_runtime_put_autosuspend(arizona->dev);
-- 
1.7.2.5
