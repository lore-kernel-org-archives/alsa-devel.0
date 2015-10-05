From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: support dw i2s in slave mode" to
	the asoc tree
Date: Mon, 05 Oct 2015 16:36:52 +0100
Message-ID: <E1Zj7oq-0001uV-8T@finisterre>
References: <1443217704-28814-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 815DA2606DE
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:37:27 +0200 (CEST)
In-Reply-To: <1443217704-28814-2-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: support dw i2s in slave mode

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

>From 1d957d862ac782eaf5803d4d4cf167708e4dc147 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 25 Sep 2015 17:48:22 -0400
Subject: [PATCH] ASoC: dwc: support dw i2s in slave mode

dw i2s controller can work in slave mode, codec being master.
dw i2s is made to support master/slave operation, by reading dwc
register.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/designware_i2s.h |  2 +
 sound/soc/dwc/designware_i2s.c | 92 +++++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 3a8fca9..8966ba7 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -38,6 +38,8 @@ struct i2s_clk_config_data {
 struct i2s_platform_data {
 	#define DWC_I2S_PLAY	(1 << 0)
 	#define DWC_I2S_RECORD	(1 << 1)
+	#define DW_I2S_SLAVE	(1 << 2)
+	#define DW_I2S_MASTER	(1 << 3)
 	unsigned int cap;
 	int channel;
 	u32 snd_fmts;
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index a3e97b4..3a52f82 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -273,23 +273,25 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	config->sample_rate = params_rate(params);
 
-	if (dev->i2s_clk_cfg) {
-		ret = dev->i2s_clk_cfg(config);
-		if (ret < 0) {
-			dev_err(dev->dev, "runtime audio clk config fail\n");
-			return ret;
-		}
-	} else {
-		u32 bitclk = config->sample_rate * config->data_width * 2;
-
-		ret = clk_set_rate(dev->clk, bitclk);
-		if (ret) {
-			dev_err(dev->dev, "Can't set I2S clock rate: %d\n",
-				ret);
-			return ret;
+	if (dev->capability & DW_I2S_MASTER) {
+		if (dev->i2s_clk_cfg) {
+			ret = dev->i2s_clk_cfg(config);
+			if (ret < 0) {
+				dev_err(dev->dev, "runtime audio clk config fail\n");
+				return ret;
+			}
+		} else {
+			u32 bitclk = config->sample_rate *
+					config->data_width * 2;
+
+			ret = clk_set_rate(dev->clk, bitclk);
+			if (ret) {
+				dev_err(dev->dev, "Can't set I2S clock rate: %d\n",
+					ret);
+				return ret;
+			}
 		}
 	}
-
 	return 0;
 }
 
@@ -357,7 +359,8 @@ static int dw_i2s_suspend(struct snd_soc_dai *dai)
 {
 	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable(dev->clk);
+	if (dev->capability & DW_I2S_MASTER)
+		clk_disable(dev->clk);
 	return 0;
 }
 
@@ -365,7 +368,8 @@ static int dw_i2s_resume(struct snd_soc_dai *dai)
 {
 	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 
-	clk_enable(dev->clk);
+	if (dev->capability & DW_I2S_MASTER)
+		clk_enable(dev->clk);
 	return 0;
 }
 
@@ -443,6 +447,14 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 		dw_i2s_dai->capture.rates = rates;
 	}
 
+	if (COMP1_MODE_EN(comp1)) {
+		dev_dbg(dev->dev, "designware: i2s master mode supported\n");
+		dev->capability |= DW_I2S_MASTER;
+	} else {
+		dev_dbg(dev->dev, "designware: i2s slave mode supported\n");
+		dev->capability |= DW_I2S_SLAVE;
+	}
+
 	return 0;
 }
 
@@ -529,6 +541,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 	struct snd_soc_dai_driver *dw_i2s_dai;
+	const char *clk_id;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev) {
@@ -550,32 +563,35 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(dev->i2s_base);
 
 	dev->dev = &pdev->dev;
+
 	if (pdata) {
+		dev->capability = pdata->cap;
+		clk_id = NULL;
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
-		if (ret < 0)
-			return ret;
+	} else {
+		clk_id = "i2sclk";
+		ret = dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
+	}
+	if (ret < 0)
+		return ret;
 
-		dev->capability = pdata->cap;
-		dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
-		if (!dev->i2s_clk_cfg) {
-			dev_err(&pdev->dev, "no clock configure method\n");
-			return -ENODEV;
+	if (dev->capability & DW_I2S_MASTER) {
+		if (pdata) {
+			dev->i2s_clk_cfg = pdata->i2s_clk_cfg;
+			if (!dev->i2s_clk_cfg) {
+				dev_err(&pdev->dev, "no clock configure method\n");
+				return -ENODEV;
+			}
 		}
+		dev->clk = devm_clk_get(&pdev->dev, clk_id);
 
-		dev->clk = devm_clk_get(&pdev->dev, NULL);
-	} else {
-		ret = dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
+		if (IS_ERR(dev->clk))
+			return PTR_ERR(dev->clk);
+
+		ret = clk_prepare_enable(dev->clk);
 		if (ret < 0)
 			return ret;
-
-		dev->clk = devm_clk_get(&pdev->dev, "i2sclk");
 	}
-	if (IS_ERR(dev->clk))
-		return PTR_ERR(dev->clk);
-
-	ret = clk_prepare_enable(dev->clk);
-	if (ret < 0)
-		return ret;
 
 	dev_set_drvdata(&pdev->dev, dev);
 	ret = devm_snd_soc_register_component(&pdev->dev, &dw_i2s_component,
@@ -597,7 +613,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	clk_disable_unprepare(dev->clk);
+	if (dev->capability & DW_I2S_MASTER)
+		clk_disable_unprepare(dev->clk);
 	return ret;
 }
 
@@ -605,7 +622,8 @@ static int dw_i2s_remove(struct platform_device *pdev)
 {
 	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 
-	clk_disable_unprepare(dev->clk);
+	if (dev->capability & DW_I2S_MASTER)
+		clk_disable_unprepare(dev->clk);
 
 	return 0;
 }
-- 
2.5.0
