From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Wait for resume before enabling FLL
Date: Thu, 25 Aug 2016 11:39:32 +0100
Message-ID: <1472121572-13020-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

When enabling an FLL use pm_runtime_get_sync() instead of
pm_runtime_get() to ensure that all the register settings
have been written out and the codec is powered-up before
we write the enable bit.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ecfdbfc..8b8f2d2 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2268,7 +2268,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 					 ARIZONA_FLL1_SYNC_BW);
 
 	if (!already_enabled)
-		pm_runtime_get(arizona->dev);
+		pm_runtime_get_sync(arizona->dev);
 
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-- 
1.9.1
