From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH 02/02] asoc: machines - add Digital Audio
	Interface (DAI)	control functions.
Date: Tue, 08 Jul 2008 13:19:18 +0100
Message-ID: <1215519558.4882.209.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A93A7243BD
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 14:19:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds several functions for DAI control and config
and replaces the current method of calling function pointers within
the DAI struct within the machine drivers.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/at32/playpaq_wm8510.c    |   16 ++++-----
 sound/soc/at91/eti_b1_wm8731.c     |   18 +++++-----
 sound/soc/davinci/davinci-evm.c    |    6 ++--
 sound/soc/fsl/mpc8610_hpcd.c       |   58 +++++++++++++++---------------------
 sound/soc/omap/n810.c              |    6 ++--
 sound/soc/pxa/corgi.c              |    8 ++--
 sound/soc/pxa/poodle.c             |    8 ++--
 sound/soc/pxa/spitz.c              |    8 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c |   26 ++++++++--------
 9 files changed, 71 insertions(+), 83 deletions(-)

diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
index 18ac7d7..fd62f25 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -210,14 +210,14 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 	/*
 	 * set CPU and CODEC DAI configuration
 	 */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, fmt);
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: "
 			   "Failed to set CODEC DAI format (%d)\n",
 			   ret);
 		return ret;
 	}
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, fmt);
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: "
 			   "Failed to set CPU DAI format (%d)\n",
@@ -233,14 +233,13 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 	cd = playpaq_wm8510_calc_ssc_clock(params, cpu_dai);
 	pr_debug("playpaq_wm8510: cmr_div = %d, period = %d\n",
 		 cd.cmr_div, cd.period);
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
-					  AT32_SSC_CMR_DIV, cd.cmr_div);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_CMR_DIV, cd.cmr_div);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: Failed to set CPU CMR_DIV (%d)\n",
 			   ret);
 		return ret;
 	}
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT32_SSC_TCMR_PERIOD,
 					  cd.period);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: "
@@ -260,7 +259,7 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 
 
 #if !defined CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE
-	ret = codec_dai->dai_ops.set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_BCLKDIV, bclk);
 	if (ret < 0) {
 		pr_warning
 		    ("playpaq_wm8510: Failed to set CODEC DAI BCLKDIV (%d)\n",
@@ -270,7 +269,7 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 #endif /* CONFIG_SND_AT32_SOC_PLAYPAQ_SLAVE */
 
 
-	ret = codec_dai->dai_ops.set_pll(codec_dai, 0,
+	ret = snd_soc_dai_set_pll(codec_dai, 0,
 					 clk_get_rate(CODEC_CLK), pll_out);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: Failed to set CODEC DAI PLL (%d)\n",
@@ -279,8 +278,7 @@ static int playpaq_wm8510_hw_params(struct snd_pcm_substream *substream,
 	}
 
 
-	ret = codec_dai->dai_ops.set_clkdiv(codec_dai,
-					    WM8510_MCLKDIV, mclk_div);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8510_MCLKDIV, mclk_div);
 	if (ret < 0) {
 		pr_warning("playpaq_wm8510: Failed to set CODEC MCLKDIV (%d)\n",
 			   ret);
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index 9d42139..d532de9 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -58,13 +58,13 @@ static int eti_b1_startup(struct snd_pcm_substream *substream)
 	int ret;
 
 	/* cpu clock is the AT91 master clock sent to the SSC */
-	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, AT91_SYSCLK_MCK,
+	ret = snd_soc_dai_set_sysclk(cpu_dai, AT91_SYSCLK_MCK,
 		60000000, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* codec system clock is supplied by PCK1, set to 12MHz */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8731_SYSCLK,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
 		12000000, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
@@ -96,13 +96,13 @@ static int eti_b1_hw_params(struct snd_pcm_substream *substream,
 	int cmr_div, period;
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
@@ -141,17 +141,17 @@ static int eti_b1_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set the MCK divider for BCLK */
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, AT91SSC_CMR_DIV, cmr_div);
 	if (ret < 0)
 		return ret;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* set the BCLK divider for DACLRC */
-		ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
 						AT91SSC_TCMR_PERIOD, period);
 	} else {
 		/* set the BCLK divider for ADCLRC */
-		ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai,
+		ret = snd_soc_dai_set_clkdiv(cpu_dai,
 						AT91SSC_RCMR_PERIOD, period);
 	}
 	if (ret < 0)
@@ -163,13 +163,13 @@ static int eti_b1_hw_params(struct snd_pcm_substream *substream,
 	 */
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 4249e6a..5e2c306 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -38,19 +38,19 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 					 SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_CBM_CFM |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_CBM_CFM |
 				       SND_SOC_DAIFMT_IB_NF);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0, EVM_CODEC_CLOCK,
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, EVM_CODEC_CLOCK,
 					    SND_SOC_CLOCK_OUT);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 59d7e49..4bdc9d8 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -103,55 +103,45 @@ static int mpc8610_hpcd_startup(struct snd_pcm_substream *substream)
 	int ret = 0;
 
 	/* Tell the CPU driver what the serial protocol is. */
-	if (cpu_dai->dai_ops.set_fmt) {
-		ret = cpu_dai->dai_ops.set_fmt(cpu_dai,
-			machine_data->dai_format);
-		if (ret < 0) {
-			dev_err(substream->pcm->card->dev,
-				"could not set CPU driver audio format\n");
-			return ret;
-		}
+	ret = snd_soc_dai_set_fmt(cpu_dai, machine_data->dai_format);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set CPU driver audio format\n");
+		return ret;
 	}
 
 	/* Tell the codec driver what the serial protocol is. */
-	if (codec_dai->dai_ops.set_fmt) {
-		ret = codec_dai->dai_ops.set_fmt(codec_dai,
-			machine_data->dai_format);
-		if (ret < 0) {
-			dev_err(substream->pcm->card->dev,
-				"could not set codec driver audio format\n");
-			return ret;
-		}
+	ret = snd_soc_dai_set_fmt(codec_dai, machine_data->dai_format);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set codec driver audio format\n");
+		return ret;
 	}
 
 	/*
 	 * Tell the CPU driver what the clock frequency is, and whether it's a
 	 * slave or master.
 	 */
-	if (cpu_dai->dai_ops.set_sysclk) {
-		ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, 0,
-			machine_data->clk_frequency,
-			machine_data->cpu_clk_direction);
-		if (ret < 0) {
-			dev_err(substream->pcm->card->dev,
-				"could not set CPU driver clock parameters\n");
-			return ret;
-		}
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0,
+					machine_data->clk_frequency,
+					machine_data->cpu_clk_direction);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set CPU driver clock parameters\n");
+		return ret;
 	}
 
 	/*
 	 * Tell the codec driver what the MCLK frequency is, and whether it's
 	 * a slave or master.
 	 */
-	if (codec_dai->dai_ops.set_sysclk) {
-		ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0,
-			machine_data->clk_frequency,
-			machine_data->codec_clk_direction);
-		if (ret < 0) {
-			dev_err(substream->pcm->card->dev,
-				"could not set codec driver clock params\n");
-			return ret;
-		}
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
+					machine_data->clk_frequency,
+					machine_data->codec_clk_direction);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev,
+			"could not set codec driver clock params\n");
+		return ret;
 	}
 
 	return 0;
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index d1233c0..e53c055 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -91,7 +91,7 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	/* Set codec DAI configuration */
-	err = codec_dai->dai_ops.set_fmt(codec_dai,
+	err = snd_soc_dai_set_fmt(codec_dai,
 					 SND_SOC_DAIFMT_I2S |
 					 SND_SOC_DAIFMT_NB_NF |
 					 SND_SOC_DAIFMT_CBM_CFM);
@@ -99,7 +99,7 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	/* Set cpu DAI configuration */
-	err = cpu_dai->dai_ops.set_fmt(cpu_dai,
+	err = snd_soc_dai_set_fmt(cpu_dai,
 				       SND_SOC_DAIFMT_I2S |
 				       SND_SOC_DAIFMT_NB_NF |
 				       SND_SOC_DAIFMT_CBM_CFM);
@@ -107,7 +107,7 @@ static int n810_hw_params(struct snd_pcm_substream *substream,
 		return err;
 
 	/* Set the codec system clock for DAC and ADC */
-	err = codec_dai->dai_ops.set_sysclk(codec_dai, 0, 12000000,
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000,
 					    SND_SOC_CLOCK_IN);
 
 	return err;
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 782afbf..c029446 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -143,25 +143,25 @@ static int corgi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8731_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* set the I2S system clock as input (unused) */
-	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index ce25b6b..65a4e9a 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -122,25 +122,25 @@ static int poodle_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8731_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* set the I2S system clock as input (unused) */
-	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index fd1abc7..6438579 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -141,25 +141,25 @@ static int spitz_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* set the I2S system clock as input (unused) */
-	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
+	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 51a4ce3..4d7a9aa 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -108,44 +108,44 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai,
+	ret = snd_soc_dai_set_fmt(codec_dai,
 		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
 	/* set cpu DAI configuration */
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai,
+	ret = snd_soc_dai_set_fmt(cpu_dai,
 		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		SND_SOC_DAIFMT_CBM_CFM);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8753_MCLK, pll_out,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_MCLK, pll_out,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* set MCLK division for sample rate */
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
 		S3C2410_IISMOD_32FS);
 	if (ret < 0)
 		return ret;
 
 	/* set codec BCLK division for sample rate */
-	ret = codec_dai->dai_ops.set_clkdiv(codec_dai, WM8753_BCLKDIV, bclk);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_BCLKDIV, bclk);
 	if (ret < 0)
 		return ret;
 
 	/* set prescaler division for sample rate */
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
 		S3C24XX_PRESCALE(4, 4));
 	if (ret < 0)
 		return ret;
 
 	/* codec PLL input is PCLK/4 */
-	ret = codec_dai->dai_ops.set_pll(codec_dai, WM8753_PLL1,
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL1,
 		iis_clkrate / 4, pll_out);
 	if (ret < 0)
 		return ret;
@@ -161,7 +161,7 @@ static int neo1973_hifi_hw_free(struct snd_pcm_substream *substream)
 	DBG("Entered %s\n", __func__);
 
 	/* disable the PLL */
-	return codec_dai->dai_ops.set_pll(codec_dai, WM8753_PLL1, 0, 0);
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL1, 0, 0);
 }
 
 /*
@@ -194,24 +194,24 @@ static int neo1973_voice_hw_params(struct snd_pcm_substream *substream,
 
 	/* todo: gg check mode (DSP_B) against CSR datasheet */
 	/* set codec DAI configuration */
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_B |
 		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, WM8753_PCMCLK, 12288000,
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8753_PCMCLK, 12288000,
 		SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
 	/* set codec PCM division for sample rate */
-	ret = codec_dai->dai_ops.set_clkdiv(codec_dai, WM8753_PCMDIV, pcmdiv);
+	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8753_PCMDIV, pcmdiv);
 	if (ret < 0)
 		return ret;
 
 	/* configue and enable PLL for 12.288MHz output */
-	ret = codec_dai->dai_ops.set_pll(codec_dai, WM8753_PLL2,
+	ret = snd_soc_dai_set_pll(codec_dai, WM8753_PLL2,
 		iis_clkrate / 4, 12288000);
 	if (ret < 0)
 		return ret;
@@ -227,7 +227,7 @@ static int neo1973_voice_hw_free(struct snd_pcm_substream *substream)
 	DBG("Entered %s\n", __func__);
 
 	/* disable the PLL */
-	return codec_dai->dai_ops.set_pll(codec_dai, WM8753_PLL2, 0, 0);
+	return snd_soc_dai_set_pll(codec_dai, WM8753_PLL2, 0, 0);
 }
 
 static struct snd_soc_ops neo1973_voice_ops = {
-- 
1.5.4.2
