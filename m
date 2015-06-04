From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/23] ASoC: tas2552: Rename mclk parameter
	to pll_clkin to match with the datasheet
Date: Thu, 4 Jun 2015 16:04:20 +0300
Message-ID: <1433423075-14142-9-git-send-email-peter.ujfalusi@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B95CB26653B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:04:58 +0200 (CEST)
In-Reply-To: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MCLK is one of the possible source for the pll_clkin frequency. Make this
clear by renaming the variable.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 61419e2f833b..e29b29b279d9 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -75,7 +75,7 @@ struct tas2552_data {
 	struct regulator_bulk_data supplies[TAS2552_NUM_SUPPLIES];
 	struct gpio_desc *enable_gpio;
 	unsigned char regs[TAS2552_VBAT_DATA];
-	unsigned int mclk;
+	unsigned int pll_clkin;
 };
 
 /* Input mux controls */
@@ -141,13 +141,13 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 	int d;
 	u8 p, j;
 
-	if (!tas2552->mclk)
+	if (!tas2552->pll_clkin)
 		return -EINVAL;
 
 	snd_soc_update_bits(codec, TAS2552_CFG_2, TAS2552_PLL_ENABLE, 0);
 
-	if (tas2552->mclk == TAS2552_245MHZ_CLK ||
-		tas2552->mclk == TAS2552_225MHZ_CLK) {
+	if (tas2552->pll_clkin == TAS2552_245MHZ_CLK ||
+	    tas2552->pll_clkin == TAS2552_225MHZ_CLK) {
 		/* By pass the PLL configuration */
 		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_2,
 				    TAS2552_PLL_BYPASS_MASK,
@@ -171,8 +171,8 @@ static int tas2552_hw_params(struct snd_pcm_substream *substream,
 			return -EINVAL;
 		}
 
-		j = (pll_clk * 2 * (1 << p)) / tas2552->mclk;
-		d = (pll_clk * 2 * (1 << p)) % tas2552->mclk;
+		j = (pll_clk * 2 * (1 << p)) / tas2552->pll_clkin;
+		d = (pll_clk * 2 * (1 << p)) % tas2552->pll_clkin;
 
 		snd_soc_update_bits(codec, TAS2552_PLL_CTRL_1,
 				TAS2552_PLL_J_MASK, j);
@@ -245,7 +245,7 @@ static int tas2552_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct snd_soc_codec *codec = dai->codec;
 	struct tas2552_data *tas2552 = dev_get_drvdata(codec->dev);
 
-	tas2552->mclk = freq;
+	tas2552->pll_clkin = freq;
 
 	return 0;
 }
-- 
2.4.2
