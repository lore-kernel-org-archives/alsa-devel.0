From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: arizona: Avoid changing SYNC_ENA whilst the FLL_ENA is set
Date: Fri, 2 Sep 2016 16:52:45 +0100
Message-ID: <1472831568-466-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

For best performance changing the synchroniser state whilst the FLL is
running should be avoided. As this has been done fairly regularly in
practice rather than hard preventing this, simply improve the FLL enable
sequence and give a warning if the user changes the synchroniser state.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 463979f4..be24387 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2209,12 +2209,15 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	struct arizona *arizona = fll->arizona;
 	bool use_sync = false;
 	int already_enabled = arizona_is_enabled_fll(fll, fll->base);
+	int sync_enabled = arizona_is_enabled_fll(fll, fll->base + 0x10);
 	struct arizona_fll_cfg cfg;
 	int i;
 	unsigned int val;
 
 	if (already_enabled < 0)
 		return already_enabled;
+	if (sync_enabled < 0)
+		return sync_enabled;
 
 	if (already_enabled) {
 		/* Facilitate smooth refclk across the transition */
@@ -2259,6 +2262,9 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 		return -EINVAL;
 	}
 
+	if (already_enabled && !!sync_enabled != use_sync)
+		arizona_fll_warn(fll, "Synchroniser changed on active FLL\n");
+
 	/*
 	 * Increase the bandwidth if we're not using a low frequency
 	 * sync source.
@@ -2274,12 +2280,12 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	if (!already_enabled)
 		pm_runtime_get_sync(arizona->dev);
 
-	regmap_update_bits_async(arizona->regmap, fll->base + 1,
-				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 	if (use_sync)
 		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
 					 ARIZONA_FLL1_SYNC_ENA,
 					 ARIZONA_FLL1_SYNC_ENA);
+	regmap_update_bits_async(arizona->regmap, fll->base + 1,
+				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 
 	if (already_enabled)
 		regmap_update_bits_async(arizona->regmap, fll->base + 1,
-- 
2.1.4
