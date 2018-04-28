From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 1/5] ASoC: cirrus: i2s: Fix LRCLK configuration
Date: Sat, 28 Apr 2018 22:51:38 +0200
Message-ID: <20180428205142.31921-2-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Ryan Mallon <rmallon@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The bit responsible for LRCLK polarity is i2s_tlrs (0), not i2s_trel (2)
(refer to "EP93xx User's Guide").

Previously card drivers which specified SND_SOC_DAIFMT_NB_IF actually got
SND_SOC_DAIFMT_NB_NF, an adaptation is necessary to retain the old
behavior.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/edb93xx.c     | 2 +-
 sound/soc/cirrus/ep93xx-i2s.c  | 8 ++++----
 sound/soc/cirrus/snappercl15.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/cirrus/edb93xx.c b/sound/soc/cirrus/edb93xx.c
index c53bd6f2c2d7..3d011abaa266 100644
--- a/sound/soc/cirrus/edb93xx.c
+++ b/sound/soc/cirrus/edb93xx.c
@@ -67,7 +67,7 @@ static struct snd_soc_dai_link edb93xx_dai = {
 	.cpu_dai_name	= "ep93xx-i2s",
 	.codec_name	= "spi0.0",
 	.codec_dai_name	= "cs4271-hifi",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &edb93xx_ops,
 };
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 934f8aefdd90..38c240c97041 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -213,24 +213,24 @@ static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/* Negative bit clock, lrclk low on left word */
-		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL);
+		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS);
 		break;
 
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Negative bit clock, lrclk low on right word */
 		clk_cfg &= ~EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Positive bit clock, lrclk low on left word */
 		clk_cfg |= EP93XX_I2S_CLKCFG_CKP;
-		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_LRS;
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Positive bit clock, lrclk low on right word */
-		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL;
+		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_LRS;
 		break;
 	}
 
diff --git a/sound/soc/cirrus/snappercl15.c b/sound/soc/cirrus/snappercl15.c
index 2334ec19e7eb..11ff7b2672b2 100644
--- a/sound/soc/cirrus/snappercl15.c
+++ b/sound/soc/cirrus/snappercl15.c
@@ -72,7 +72,7 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.codec_dai_name	= "tlv320aic23-hifi",
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	= "ep93xx-i2s",
-	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
 };
-- 
2.16.2
