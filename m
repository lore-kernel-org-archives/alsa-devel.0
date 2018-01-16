From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: ADC: stm32-dfsdm: code optimization" to
	the asoc tree
Date: Tue, 16 Jan 2018 13:57:11 +0000
Message-ID: <E1ebRjj-0005C6-Eu@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AFA1267721
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:57:16 +0100 (CET)
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
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: alsa-devel@alsa-project.org

The patch

   IIO: ADC: stm32-dfsdm: code optimization

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From abaca806fd13afd069e04e883de8ec75924b0598 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 15 Jan 2018 09:57:39 +0100
Subject: [PATCH] IIO: ADC: stm32-dfsdm: code optimization

Use of_device_get_match_data to optimize the source code.
No check is needed on dev_data as match table is defined in driver.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c  | 9 +--------
 drivers/iio/adc/stm32-dfsdm-core.c | 8 +-------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 5e871404f565..3fe9b34ac6af 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1087,18 +1087,11 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct iio_dev *iio;
-	const struct of_device_id *of_id;
 	char *name;
 	int ret, irq, val;
 
-	of_id = of_match_node(stm32_dfsdm_adc_match, np);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
-
-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 
+	dev_data = of_device_get_match_data(dev);
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!iio) {
 		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 6cd655f8239b..6290332cfd3f 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
 	int ret;
@@ -253,13 +252,8 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 
 	priv->pdev = pdev;
 
-	of_id = of_match_node(stm32_dfsdm_of_match, pdev->dev.of_node);
-	if (!of_id->data) {
-		dev_err(&pdev->dev, "Data associated to device is missing\n");
-		return -EINVAL;
-	}
+	dev_data = of_device_get_match_data(&pdev->dev);
 
-	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 	dfsdm = &priv->dfsdm;
 	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
 				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
-- 
2.15.1
