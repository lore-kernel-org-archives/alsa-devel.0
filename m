From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()' function name
Date: Wed, 24 Jul 2019 07:26:32 +0200
Message-ID: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, gustavo@embeddedor.com, patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

This should be 'wm8955_pll_factors()' instead.
Fix it and use it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/wm8955.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index cd204f79647d..ec82a8fafdf6 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -143,7 +143,7 @@ struct pll_factors {
  * to allow rounding later */
 #define FIXED_FLL_SIZE ((1 << 22) * 10)
 
-static int wm8995_pll_factors(struct device *dev,
+static int wm8955_pll_factors(struct device *dev,
 			      int Fref, int Fout, struct pll_factors *pll)
 {
 	u64 Kpart;
@@ -282,7 +282,7 @@ static int wm8955_configure_clocking(struct snd_soc_component *component)
 
 		/* Use the last divider configuration we saw for the
 		 * sample rate. */
-		ret = wm8995_pll_factors(component->dev, wm8955->mclk_rate,
+		ret = wm8955_pll_factors(component->dev, wm8955->mclk_rate,
 					 clock_cfgs[sr].mclk, &pll);
 		if (ret != 0) {
 			dev_err(component->dev,
-- 
2.20.1
