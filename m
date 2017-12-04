From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 08/10] ASoC: fsl_ssi: Rename cpu_dai parameter to dai
Date: Mon,  4 Dec 2017 12:46:41 -0800
Message-ID: <1512420403-10164-9-git-send-email-nicoleotsuka@gmail.com>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Shortens the variable name to save space, useful for dev_err outputs.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e1c985b..10f6b63 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -661,10 +661,10 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  *       (In 2-channel I2S Master mode, slot_width is fixed 32)
  */
 static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *cpu_dai,
+			    struct snd_soc_dai *dai,
 			    struct snd_pcm_hw_params *hw_params)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
@@ -694,7 +694,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	 * never greater than 1/5 IPG clock rate
 	 */
 	if (freq * 5 > clk_get_rate(ssi->clk)) {
-		dev_err(cpu_dai->dev, "bitclk > ipgclk / 5\n");
+		dev_err(dai->dev, "bitclk > ipgclk / 5\n");
 		return -EINVAL;
 	}
 
@@ -743,7 +743,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 
 	/* No proper pm found if it is still remaining the initial value */
 	if (pm == 999) {
-		dev_err(cpu_dai->dev, "failed to handle the required sysclk\n");
+		dev_err(dai->dev, "failed to handle the required sysclk\n");
 		return -EINVAL;
 	}
 
@@ -759,7 +759,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
 		if (ret) {
-			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
+			dev_err(dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
 	}
@@ -777,9 +777,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
  */
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params,
-			     struct snd_soc_dai *cpu_dai)
+			     struct snd_soc_dai *dai)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size = params_width(hw_params);
@@ -796,7 +796,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 
 	if (fsl_ssi_is_i2s_master(ssi)) {
-		ret = fsl_ssi_set_bclk(substream, cpu_dai, hw_params);
+		ret = fsl_ssi_set_bclk(substream, dai, hw_params);
 		if (ret)
 			return ret;
 
@@ -834,7 +834,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 }
 
 static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *cpu_dai)
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
@@ -998,29 +998,29 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 /**
  * Configure Digital Audio Interface (DAI) Format
  */
-static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 
 	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi, fmt);
+	return _fsl_ssi_set_dai_fmt(dai->dev, ssi, fmt);
 }
 
 /**
  * Set TDM slot number and slot width
  */
-static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 				    u32 rx_mask, int slots, int slot_width)
 {
-	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	u32 val;
 
 	/* The word length should be 8, 10, 12, 16, 18, 20, 22 or 24 */
 	if (slot_width & 1 || slot_width < 8 || slot_width > 24) {
-		dev_err(cpu_dai->dev, "invalid slot width: %d\n", slot_width);
+		dev_err(dai->dev, "invalid slot width: %d\n", slot_width);
 		return -EINVAL;
 	}
 
@@ -1028,7 +1028,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_read(regs, REG_SSI_SCR, &val);
 	val &= SSI_SCR_I2S_MODE_MASK | SSI_SCR_NET;
 	if (val && slots < 2) {
-		dev_err(cpu_dai->dev, "slot number should be >= 2 in I2S or NET\n");
+		dev_err(dai->dev, "slot number should be >= 2 in I2S or NET\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4
