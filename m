From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: Drop __func__ usage from log
	prints" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:18 +0000
Message-ID: <E1cYfni-0000p9-Ok@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10DE12673D6
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:26 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: Drop __func__ usage from log prints

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b6e643adfd68258e16babaf36353c9668384350f Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 30 Jan 2017 13:03:37 -0800
Subject: [PATCH] ASoC: qcom: Drop __func__ usage from log prints

The combination of dev_err() and __func__ make most of these log prints
over 100 chars long. Remove the usage of __func__ to clean the kernel
log and as the usage is not necessary to identify the individual log
prints.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-apq8016.c  |  15 +++---
 sound/soc/qcom/lpass-cpu.c      |  86 ++++++++++++++------------------
 sound/soc/qcom/lpass-platform.c | 106 ++++++++++++++++++++--------------------
 sound/soc/qcom/storm.c          |  22 +++------
 4 files changed, 103 insertions(+), 126 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 3eef0c37ba50..8aed72be3224 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -175,29 +175,28 @@ static int apq8016_lpass_init(struct platform_device *pdev)
 
 	drvdata->pcnoc_mport_clk = devm_clk_get(dev, "pcnoc-mport-clk");
 	if (IS_ERR(drvdata->pcnoc_mport_clk)) {
-		dev_err(&pdev->dev, "%s() error getting pcnoc-mport-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->pcnoc_mport_clk));
+		dev_err(&pdev->dev, "error getting pcnoc-mport-clk: %ld\n",
+			PTR_ERR(drvdata->pcnoc_mport_clk));
 		return PTR_ERR(drvdata->pcnoc_mport_clk);
 	}
 
 	ret = clk_prepare_enable(drvdata->pcnoc_mport_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() Error enabling pcnoc-mport-clk: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "Error enabling pcnoc-mport-clk: %d\n",
+			ret);
 		return ret;
 	}
 
 	drvdata->pcnoc_sway_clk = devm_clk_get(dev, "pcnoc-sway-clk");
 	if (IS_ERR(drvdata->pcnoc_sway_clk)) {
-		dev_err(&pdev->dev, "%s() error getting pcnoc-sway-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->pcnoc_sway_clk));
+		dev_err(&pdev->dev, "error getting pcnoc-sway-clk: %ld\n",
+			PTR_ERR(drvdata->pcnoc_sway_clk));
 		return PTR_ERR(drvdata->pcnoc_sway_clk);
 	}
 
 	ret = clk_prepare_enable(drvdata->pcnoc_sway_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() Error enabling pcnoc_sway_clk: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "Error enabling pcnoc_sway_clk: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 1b912a9bb791..5202a584e0c6 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -35,8 +35,8 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
 	if (ret)
-		dev_err(dai->dev, "%s() error setting mi2s osrclk to %u: %d\n",
-				__func__, freq, ret);
+		dev_err(dai->dev, "error setting mi2s osrclk to %u: %d\n",
+			freq, ret);
 
 	return ret;
 }
@@ -49,15 +49,13 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 
 	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->driver->id]);
 	if (ret) {
-		dev_err(dai->dev, "%s() error in enabling mi2s osr clk: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error in enabling mi2s osr clk: %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
 	if (ret) {
-		dev_err(dai->dev, "%s() error in enabling mi2s bit clk: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
 		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
 		return ret;
 	}
@@ -87,8 +85,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
-		dev_err(dai->dev, "%s() invalid bit width given: %d\n",
-				__func__, bitwidth);
+		dev_err(dai->dev, "invalid bit width given: %d\n", bitwidth);
 		return bitwidth;
 	}
 
@@ -106,8 +103,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 		regval |= LPAIF_I2SCTL_BITWIDTH_32;
 		break;
 	default:
-		dev_err(dai->dev, "%s() invalid bitwidth given: %d\n",
-				__func__, bitwidth);
+		dev_err(dai->dev, "invalid bitwidth given: %d\n", bitwidth);
 		return -EINVAL;
 	}
 
@@ -134,8 +130,8 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 			regval |= LPAIF_I2SCTL_SPKMONO_STEREO;
 			break;
 		default:
-			dev_err(dai->dev, "%s() invalid channels given: %u\n",
-					__func__, channels);
+			dev_err(dai->dev, "invalid channels given: %u\n",
+				channels);
 			return -EINVAL;
 		}
 	} else {
@@ -161,8 +157,8 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 			regval |= LPAIF_I2SCTL_MICMONO_STEREO;
 			break;
 		default:
-			dev_err(dai->dev, "%s() invalid channels given: %u\n",
-					__func__, channels);
+			dev_err(dai->dev, "invalid channels given: %u\n",
+				channels);
 			return -EINVAL;
 		}
 	}
@@ -171,16 +167,15 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
 			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
 			   regval);
 	if (ret) {
-		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 		return ret;
 	}
 
 	ret = clk_set_rate(drvdata->mi2s_bit_clk[dai->driver->id],
 			   rate * bitwidth * 2);
 	if (ret) {
-		dev_err(dai->dev, "%s() error setting mi2s bitclk to %u: %d\n",
-				__func__, rate * bitwidth * 2, ret);
+		dev_err(dai->dev, "error setting mi2s bitclk to %u: %d\n",
+			rate * bitwidth * 2, ret);
 		return ret;
 	}
 
@@ -197,8 +192,7 @@ static int lpass_cpu_daiops_hw_free(struct snd_pcm_substream *substream,
 			   LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
 			   0);
 	if (ret)
-		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 
 	return ret;
 }
@@ -222,8 +216,7 @@ static int lpass_cpu_daiops_prepare(struct snd_pcm_substream *substream,
 			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id),
 			mask, val);
 	if (ret)
-		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 
 	return ret;
 }
@@ -252,8 +245,8 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 						dai->driver->id),
 				mask, val);
 		if (ret)
-			dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-					__func__, ret);
+			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
+				ret);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
@@ -271,8 +264,8 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 						dai->driver->id),
 				mask, val);
 		if (ret)
-			dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-					__func__, ret);
+			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
+				ret);
 		break;
 	}
 
@@ -299,8 +292,7 @@ int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai)
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_I2SCTL_REG(drvdata->variant, dai->driver->id), 0);
 	if (ret)
-		dev_err(dai->dev, "%s() error writing to i2sctl reg: %d\n",
-				__func__, ret);
+		dev_err(dai->dev, "error writing to i2sctl reg: %d\n", ret);
 
 	return ret;
 }
@@ -442,8 +434,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
 	if (dsp_of_node) {
-		dev_err(&pdev->dev, "%s() DSP exists and holds audio resources\n",
-				__func__);
+		dev_err(&pdev->dev, "DSP exists and holds audio resources\n");
 		return -EBUSY;
 	}
 
@@ -464,8 +455,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	drvdata->lpaif = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR((void const __force *)drvdata->lpaif)) {
-		dev_err(&pdev->dev, "%s() error mapping reg resource: %ld\n",
-				__func__,
+		dev_err(&pdev->dev, "error mapping reg resource: %ld\n",
 				PTR_ERR((void const __force *)drvdata->lpaif));
 		return PTR_ERR((void const __force *)drvdata->lpaif);
 	}
@@ -477,8 +467,8 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 	drvdata->lpaif_map = devm_regmap_init_mmio(&pdev->dev, drvdata->lpaif,
 			&lpass_cpu_regmap_config);
 	if (IS_ERR(drvdata->lpaif_map)) {
-		dev_err(&pdev->dev, "%s() error initializing regmap: %ld\n",
-				__func__, PTR_ERR(drvdata->lpaif_map));
+		dev_err(&pdev->dev, "error initializing regmap: %ld\n",
+			PTR_ERR(drvdata->lpaif_map));
 		return PTR_ERR(drvdata->lpaif_map);
 	}
 
@@ -496,8 +486,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 								clk_name);
 		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
 			dev_warn(&pdev->dev,
-				"%s() error getting optional mi2s-osr-clk: %ld\n",
-				__func__,
+				"error getting optional mi2s-osr-clk: %ld\n",
 				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
 
 			drvdata->mi2s_osr_clk[dai_id] = NULL;
@@ -512,8 +501,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 							    clk_name);
 		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
 			dev_err(&pdev->dev,
-				"%s() error getting mi2s-bit-clk: %ld\n",
-				__func__,
+				"error getting mi2s-bit-clk: %ld\n",
 				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
 			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
 		}
@@ -521,24 +509,23 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 
 	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
 	if (IS_ERR(drvdata->ahbix_clk)) {
-		dev_err(&pdev->dev, "%s() error getting ahbix-clk: %ld\n",
-				__func__, PTR_ERR(drvdata->ahbix_clk));
+		dev_err(&pdev->dev, "error getting ahbix-clk: %ld\n",
+			PTR_ERR(drvdata->ahbix_clk));
 		return PTR_ERR(drvdata->ahbix_clk);
 	}
 
 	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error setting rate on ahbix_clk: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error setting rate on ahbix_clk: %d\n",
+			ret);
 		return ret;
 	}
-	dev_dbg(&pdev->dev, "%s() set ahbix_clk rate to %lu\n", __func__,
-			clk_get_rate(drvdata->ahbix_clk));
+	dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
+		clk_get_rate(drvdata->ahbix_clk));
 
 	ret = clk_prepare_enable(drvdata->ahbix_clk);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error enabling ahbix_clk: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error enabling ahbix_clk: %d\n", ret);
 		return ret;
 	}
 
@@ -547,15 +534,14 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 					      variant->dai_driver,
 					      variant->num_dai);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error registering cpu driver: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error registering cpu driver: %d\n", ret);
 		goto err_clk;
 	}
 
 	ret = asoc_qcom_lpass_platform_register(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error registering platform driver: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error registering platform driver: %d\n",
+			ret);
 		goto err_clk;
 	}
 
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index dd5bdd0da730..7aabf08de3d4 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -89,8 +89,7 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 			LPAIF_DMACTL_REG(v, dma_ch, dir), 0);
 	if (ret) {
 		dev_err(soc_runtime->dev,
-			"%s() error writing to rdmactl reg: %d\n",
-			__func__, ret);
+			"error writing to rdmactl reg: %d\n", ret);
 			return ret;
 	}
 
@@ -103,8 +102,8 @@ static int lpass_platform_pcmops_open(struct snd_pcm_substream *substream)
 	ret = snd_pcm_hw_constraint_integer(runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0) {
-		dev_err(soc_runtime->dev, "%s() setting constraints failed: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "setting constraints failed: %d\n",
+			ret);
 		return -EINVAL;
 	}
 
@@ -151,8 +150,8 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
-		dev_err(soc_runtime->dev, "%s() invalid bit width given: %d\n",
-				__func__, bitwidth);
+		dev_err(soc_runtime->dev, "invalid bit width given: %d\n",
+				bitwidth);
 		return bitwidth;
 	}
 
@@ -177,8 +176,9 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 			regval |= LPAIF_DMACTL_WPSCNT_FOUR;
 			break;
 		default:
-			dev_err(soc_runtime->dev, "%s() invalid PCM config given: bw=%d, ch=%u\n",
-					__func__, bitwidth, channels);
+			dev_err(soc_runtime->dev,
+				"invalid PCM config given: bw=%d, ch=%u\n",
+				bitwidth, channels);
 			return -EINVAL;
 		}
 		break;
@@ -201,22 +201,23 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 			regval |= LPAIF_DMACTL_WPSCNT_EIGHT;
 			break;
 		default:
-			dev_err(soc_runtime->dev, "%s() invalid PCM config given: bw=%d, ch=%u\n",
-					__func__, bitwidth, channels);
+			dev_err(soc_runtime->dev,
+				"invalid PCM config given: bw=%d, ch=%u\n",
+				bitwidth, channels);
 			return -EINVAL;
 		}
 		break;
 	default:
-		dev_err(soc_runtime->dev, "%s() invalid PCM config given: bw=%d, ch=%u\n",
-				__func__, bitwidth, channels);
+		dev_err(soc_runtime->dev, "invalid PCM config given: bw=%d, ch=%u\n",
+			bitwidth, channels);
 		return -EINVAL;
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_DMACTL_REG(v, ch, dir), regval);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmactl reg: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -237,8 +238,8 @@ static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 	reg = LPAIF_DMACTL_REG(v, pcm_data->dma_ch, substream->stream);
 	ret = regmap_write(drvdata->lpaif_map, reg, 0);
 	if (ret)
-		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmactl reg: %d\n",
+			ret);
 
 	return ret;
 }
@@ -260,8 +261,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 			LPAIF_DMABASE_REG(v, ch, dir),
 			runtime->dma_addr);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmabase reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmabase reg: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -269,8 +270,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 			LPAIF_DMABUFF_REG(v, ch, dir),
 			(snd_pcm_lib_buffer_bytes(substream) >> 2) - 1);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmabuff reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmabuff reg: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -278,8 +279,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 			LPAIF_DMAPER_REG(v, ch, dir),
 			(snd_pcm_lib_period_bytes(substream) >> 2) - 1);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmaper reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmaper reg: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -287,8 +288,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 			LPAIF_DMACTL_REG(v, ch, dir),
 			LPAIF_DMACTL_ENABLE_MASK, LPAIF_DMACTL_ENABLE_ON);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev, "error writing to rdmactl reg: %d\n",
+			ret);
 		return ret;
 	}
 
@@ -317,8 +318,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ALL(ch));
 		if (ret) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
-					__func__, ret);
+			dev_err(soc_runtime->dev,
+				"error writing to irqclear reg: %d\n", ret);
 			return ret;
 		}
 
@@ -327,8 +328,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 				LPAIF_IRQ_ALL(ch),
 				LPAIF_IRQ_ALL(ch));
 		if (ret) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
-					__func__, ret);
+			dev_err(soc_runtime->dev,
+				"error writing to irqen reg: %d\n", ret);
 			return ret;
 		}
 
@@ -337,8 +338,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 				LPAIF_DMACTL_ENABLE_MASK,
 				LPAIF_DMACTL_ENABLE_ON);
 		if (ret) {
-			dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
-					__func__, ret);
+			dev_err(soc_runtime->dev,
+				"error writing to rdmactl reg: %d\n", ret);
 			return ret;
 		}
 		break;
@@ -350,8 +351,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 				LPAIF_DMACTL_ENABLE_MASK,
 				LPAIF_DMACTL_ENABLE_OFF);
 		if (ret) {
-			dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
-					__func__, ret);
+			dev_err(soc_runtime->dev,
+				"error writing to rdmactl reg: %d\n", ret);
 			return ret;
 		}
 
@@ -359,8 +360,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 				LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ALL(ch), 0);
 		if (ret) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
-					__func__, ret);
+			dev_err(soc_runtime->dev,
+				"error writing to irqen reg: %d\n", ret);
 			return ret;
 		}
 		break;
@@ -386,16 +387,16 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	ret = regmap_read(drvdata->lpaif_map,
 			LPAIF_DMABASE_REG(v, ch, dir), &base_addr);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error reading from rdmabase reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev,
+			"error reading from rdmabase reg: %d\n", ret);
 		return ret;
 	}
 
 	ret = regmap_read(drvdata->lpaif_map,
 			LPAIF_DMACURR_REG(v, ch, dir), &curr_addr);
 	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error reading from rdmacurr reg: %d\n",
-				__func__, ret);
+		dev_err(soc_runtime->dev,
+			"error reading from rdmacurr reg: %d\n", ret);
 		return ret;
 	}
 
@@ -439,8 +440,8 @@ static irqreturn_t lpass_dma_interrupt_handler(
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_PER(chan));
 		if (rv) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
-					__func__, rv);
+			dev_err(soc_runtime->dev,
+				"error writing to irqclear reg: %d\n", rv);
 			return IRQ_NONE;
 		}
 		snd_pcm_period_elapsed(substream);
@@ -452,11 +453,11 @@ static irqreturn_t lpass_dma_interrupt_handler(
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_XRUN(chan));
 		if (rv) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
-					__func__, rv);
+			dev_err(soc_runtime->dev,
+				"error writing to irqclear reg: %d\n", rv);
 			return IRQ_NONE;
 		}
-		dev_warn(soc_runtime->dev, "%s() xrun warning\n", __func__);
+		dev_warn(soc_runtime->dev, "xrun warning\n");
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 		ret = IRQ_HANDLED;
 	}
@@ -466,11 +467,11 @@ static irqreturn_t lpass_dma_interrupt_handler(
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
 				LPAIF_IRQ_ERR(chan));
 		if (rv) {
-			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
-					__func__, rv);
+			dev_err(soc_runtime->dev,
+				"error writing to irqclear reg: %d\n", rv);
 			return IRQ_NONE;
 		}
-		dev_err(soc_runtime->dev, "%s() bus access error\n", __func__);
+		dev_err(soc_runtime->dev, "bus access error\n");
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
 		ret = IRQ_HANDLED;
 	}
@@ -488,8 +489,7 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	rv = regmap_read(drvdata->lpaif_map,
 			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
 	if (rv) {
-		pr_err("%s() error reading from irqstat reg: %d\n",
-				__func__, rv);
+		pr_err("error reading from irqstat reg: %d\n", rv);
 		return IRQ_NONE;
 	}
 
@@ -571,8 +571,8 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 
 	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
 	if (drvdata->lpaif_irq < 0) {
-		dev_err(&pdev->dev, "%s() error getting irq handle: %d\n",
-				__func__, drvdata->lpaif_irq);
+		dev_err(&pdev->dev, "error getting irq handle: %d\n",
+			drvdata->lpaif_irq);
 		return -ENODEV;
 	}
 
@@ -580,8 +580,7 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error writing to irqen reg: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error writing to irqen reg: %d\n", ret);
 		return ret;
 	}
 
@@ -589,8 +588,7 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 			lpass_platform_lpaif_irq, IRQF_TRIGGER_RISING,
 			"lpass-irq-lpaif", drvdata);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() irq request failed: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "irq request failed: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index 8fcac2ac3aa6..c5207af14104 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -36,8 +36,7 @@ static int storm_ops_hw_params(struct snd_pcm_substream *substream,
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
-		dev_err(card->dev, "%s() invalid bit width given: %d\n",
-				__func__, bitwidth);
+		dev_err(card->dev, "invalid bit width given: %d\n", bitwidth);
 		return bitwidth;
 	}
 
@@ -50,8 +49,8 @@ static int storm_ops_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(soc_runtime->cpu_dai, 0, sysclk_freq, 0);
 	if (ret) {
-		dev_err(card->dev, "%s() error setting sysclk to %u: %d\n",
-				__func__, sysclk_freq, ret);
+		dev_err(card->dev, "error setting sysclk to %u: %d\n",
+			sysclk_freq, ret);
 		return ret;
 	}
 
@@ -76,16 +75,14 @@ static int storm_parse_of(struct snd_soc_card *card)
 
 	dai_link->cpu_of_node = of_parse_phandle(np, "cpu", 0);
 	if (!dai_link->cpu_of_node) {
-		dev_err(card->dev, "%s() error getting cpu phandle\n",
-				__func__);
+		dev_err(card->dev, "error getting cpu phandle\n");
 		return -EINVAL;
 	}
 	dai_link->platform_of_node = dai_link->cpu_of_node;
 
 	dai_link->codec_of_node = of_parse_phandle(np, "codec", 0);
 	if (!dai_link->codec_of_node) {
-		dev_err(card->dev, "%s() error getting codec phandle\n",
-				__func__);
+		dev_err(card->dev, "error getting codec phandle\n");
 		return -EINVAL;
 	}
 
@@ -106,8 +103,7 @@ static int storm_platform_probe(struct platform_device *pdev)
 
 	ret = snd_soc_of_parse_card_name(card, "qcom,model");
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error parsing card name: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error parsing card name: %d\n", ret);
 		return ret;
 	}
 
@@ -116,15 +112,13 @@ static int storm_platform_probe(struct platform_device *pdev)
 
 	ret = storm_parse_of(card);
 	if (ret) {
-		dev_err(&pdev->dev, "%s() error resolving dai links: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error resolving dai links: %d\n", ret);
 		return ret;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
-		dev_err(&pdev->dev, "%s() error registering soundcard: %d\n",
-				__func__, ret);
+		dev_err(&pdev->dev, "error registering soundcard: %d\n", ret);
 
 	return ret;
 
-- 
2.11.0
