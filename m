From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio" to the asoc tree
Date: Wed, 12 Jun 2019 16:59:26 +0100 (BST)
Message-ID: <20190612155927.04CC7440046@finisterre.sirena.org.uk>
References: <20190611122941.10708-3-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611122941.10708-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, jsarha@ti.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, misael.lopez@ti.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 764958f2b5239cbf174e70cad4c3f19a8c1081ba Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 11 Jun 2019 15:29:41 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio

When McASP is bus master and it's AUXCLK clock is not static, but it is
a multiple of the frame sync the constraint rules should take it account
when validating possible stream formats.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 52 ++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 9fbc759fdefe..a8378d223a9e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -100,6 +100,7 @@ struct davinci_mcasp {
 
 	int	sysclk_freq;
 	bool	bclk_master;
+	u32	auxclk_fs_ratio;
 
 	unsigned long pdir; /* Pin direction bitfield */
 
@@ -1064,13 +1065,13 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
 }
 
 static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
+				      unsigned int sysclk_freq,
 				      unsigned int bclk_freq, bool set)
 {
-	int error_ppm;
-	unsigned int sysclk_freq = mcasp->sysclk_freq;
 	u32 reg = mcasp_get_reg(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG);
 	int div = sysclk_freq / bclk_freq;
 	int rem = sysclk_freq % bclk_freq;
+	int error_ppm;
 	int aux_div = 1;
 
 	if (div > (ACLKXDIV_MASK + 1)) {
@@ -1175,7 +1176,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		if (mcasp->slot_width)
 			sbits = mcasp->slot_width;
 
-		davinci_mcasp_calc_clk_div(mcasp, rate * sbits * slots, true);
+		davinci_mcasp_calc_clk_div(mcasp, mcasp->sysclk_freq,
+					   rate * sbits * slots, true);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
@@ -1282,12 +1284,19 @@ static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
 
 	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
 		if (snd_interval_test(ri, davinci_mcasp_dai_rates[i])) {
-			uint bclk_freq = sbits*slots*
-				davinci_mcasp_dai_rates[i];
+			uint bclk_freq = sbits * slots *
+					 davinci_mcasp_dai_rates[i];
+			unsigned int sysclk_freq;
 			int ppm;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq,
-							 false);
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  davinci_mcasp_dai_rates[i] *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
+							 bclk_freq, false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
 				if (range.empty) {
 					range.min = davinci_mcasp_dai_rates[i];
@@ -1321,12 +1330,19 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (snd_mask_test(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
+			unsigned int sysclk_freq;
 			int ppm;
 
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  rate *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
 			if (rd->mcasp->slot_width)
 				sbits = rd->mcasp->slot_width;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp,
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
 							 sbits * slots * rate,
 							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
@@ -1991,6 +2007,22 @@ static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 }
 #endif /* CONFIG_GPIOLIB */
 
+static int davinci_mcasp_get_dt_params(struct davinci_mcasp *mcasp)
+{
+	struct device_node *np = mcasp->dev->of_node;
+	int ret;
+	u32 val;
+
+	if (!np)
+		return 0;
+
+	ret = of_property_read_u32(np, "auxclk-fs-ratio", &val);
+	if (ret >= 0)
+		mcasp->auxclk_fs_ratio = val;
+
+	return 0;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2224,6 +2256,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	ret = davinci_mcasp_get_dt_params(mcasp);
+	if (ret)
+		return -EINVAL;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
2.20.1
