From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of spdif in driver
Date: Tue, 16 Sep 2014 19:46:34 +0800
Message-ID: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The spdif root clock may be used by other module or defined with
CLK_SET_RATE_GATE, so we can't change the clock rate in driver.
In this patch remove the clk_set_rate and clk_round_rate to protect the
clock.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c |   24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 70acfe4..f2e4595 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -377,7 +377,6 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	unsigned long csfs = 0;
 	u32 stc, mask, rate;
 	u8 clk, txclk_df, sysclk_df;
-	int ret;
 
 	switch (sample_rate) {
 	case 32000:
@@ -419,21 +418,6 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 
 	sysclk_df = spdif_priv->sysclk_df[rate];
 
-	/* Don't mess up the clocks from other modules */
-	if (clk != STC_TXCLK_SPDIF_ROOT)
-		goto clk_set_bypass;
-
-	/*
-	 * The S/PDIF block needs a clock of 64 * fs * txclk_df.
-	 * So request 64 * fs * (txclk_df + 1) to get rounded.
-	 */
-	ret = clk_set_rate(spdif_priv->txclk[rate], 64 * sample_rate * (txclk_df + 1));
-	if (ret) {
-		dev_err(&pdev->dev, "failed to set tx clock rate\n");
-		return ret;
-	}
-
-clk_set_bypass:
 	dev_dbg(&pdev->dev, "expected clock rate = %d\n",
 			(64 * sample_rate * txclk_df * sysclk_df));
 	dev_dbg(&pdev->dev, "actual clock rate = %ld\n",
@@ -1056,7 +1040,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 {
 	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk == spdif_priv->sysclk;
-	u64 rate_ideal, rate_actual, sub;
+	u64 rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
 	u32 txclk_df, sysclk_df, arate;
 
@@ -1066,11 +1050,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 
 	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
 		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
-			rate_ideal = rate[index] * (txclk_df + 1) * 64;
-			if (round)
-				rate_actual = clk_round_rate(clk, rate_ideal);
-			else
-				rate_actual = clk_get_rate(clk);
+			rate_actual = clk_get_rate(clk);
 
 			arate = rate_actual / 64;
 			arate /= txclk_df * sysclk_df;
-- 
1.7.9.5
