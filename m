From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-analog: clean
	parse_dt()" to the asoc tree
Date: Fri, 04 Nov 2016 10:47:57 -0600
Message-ID: <E1c2hen-0005q8-T9@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2079266623
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 17:48:16 +0100 (CET)
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-analog: clean parse_dt()

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

>From 4323ec250cbc675c7fc40edf5f791a736210747b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 4 Nov 2016 14:45:39 +0000
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: clean parse_dt()

Move the code which is not parsing dt from pm8916_wcd_analog_parse_dt()
to make it clear to reader.

No functional changes done.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d9f999b14b28..50ad75ab10ea 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -802,7 +802,6 @@ static struct snd_soc_codec_driver pm8916_wcd_analog = {
 static int pm8916_wcd_analog_parse_dt(struct device *dev,
 				       struct pm8916_wcd_analog_priv *priv)
 {
-	int ret, i;
 
 	if (of_property_read_bool(dev->of_node, "qcom,micbias1-ext-cap"))
 		priv->micbias1_cap_mode = MICB_1_EN_EXT_BYP_CAP;
@@ -814,21 +813,6 @@ static int pm8916_wcd_analog_parse_dt(struct device *dev,
 	else
 		priv->micbias2_cap_mode = MICB_1_EN_NO_EXT_BYP_CAP;
 
-	priv->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(priv->mclk)) {
-		dev_err(dev, "failed to get mclk\n");
-		return PTR_ERR(priv->mclk);
-	}
-	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-		priv->supplies[i].supply = supply_names[i];
-
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
-				    priv->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -836,7 +820,7 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 {
 	struct pm8916_wcd_analog_priv *priv;
 	struct device *dev = &pdev->dev;
-	int ret;
+	int ret, i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -846,6 +830,22 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	priv->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(priv->mclk)) {
+		dev_err(dev, "failed to get mclk\n");
+		return PTR_ERR(priv->mclk);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
+				    priv->supplies);
+	if (ret) {
+		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable mclk %d\n", ret);
-- 
2.10.1
