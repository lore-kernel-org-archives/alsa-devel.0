From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: ADC: fix return value check in
	stm32_dfsdm_adc_probe()" to the asoc tree
Date: Thu, 11 Jan 2018 12:30:55 +0000
Message-ID: <E1eZc0V-0007No-DJ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7FE2678BD
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 13:30:59 +0100 (CET)
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
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   IIO: ADC: fix return value check in stm32_dfsdm_adc_probe()

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

>From d5ff18bcd4b5e66396eab7e8271172157ee1253e Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 11 Jan 2018 11:12:41 +0000
Subject: [PATCH] IIO: ADC: fix return value check in stm32_dfsdm_adc_probe()

In case of error, the function devm_iio_device_alloc() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index e628d04d5c77..5e871404f565 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1100,9 +1100,9 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
-	if (IS_ERR(iio)) {
+	if (!iio) {
 		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
-		return PTR_ERR(iio);
+		return -ENOMEM;
 	}
 
 	adc = iio_priv(iio);
-- 
2.15.1
