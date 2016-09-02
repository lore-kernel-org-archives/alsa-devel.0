From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: arizona: Allow specification of base for arizona_is_enabled_fll
Date: Fri, 2 Sep 2016 16:52:44 +0100
Message-ID: <1472831568-466-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

In preparation for future improvements allow a base to be passed to
arizona_is_enabled_fll, this will allow it to be used to check the state
of the synchroniser path as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ded235f..463979f4 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2188,13 +2188,13 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 				 ARIZONA_FLL1_CTRL_UPD | cfg->n);
 }
 
-static int arizona_is_enabled_fll(struct arizona_fll *fll)
+static int arizona_is_enabled_fll(struct arizona_fll *fll, int base)
 {
 	struct arizona *arizona = fll->arizona;
 	unsigned int reg;
 	int ret;
 
-	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
+	ret = regmap_read(arizona->regmap, base + 1, &reg);
 	if (ret != 0) {
 		arizona_fll_err(fll, "Failed to read current state: %d\n",
 				ret);
@@ -2208,7 +2208,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
 	bool use_sync = false;
-	int already_enabled = arizona_is_enabled_fll(fll);
+	int already_enabled = arizona_is_enabled_fll(fll, fll->base);
 	struct arizona_fll_cfg cfg;
 	int i;
 	unsigned int val;
-- 
2.1.4
