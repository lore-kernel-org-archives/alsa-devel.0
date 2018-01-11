From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: ADC: stm32-dfsdm: avoid unused-variable
	warning" to the asoc tree
Date: Thu, 11 Jan 2018 12:30:57 +0000
Message-ID: <E1eZc0X-0007OX-Q5@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F1671266E3A
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 13:30:58 +0100 (CET)
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   IIO: ADC: stm32-dfsdm: avoid unused-variable warning

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

>From 25140717414c319bcc44b5aac39357a52d0bc8e0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Jan 2018 11:34:46 +0100
Subject: [PATCH] IIO: ADC: stm32-dfsdm: avoid unused-variable warning

Building with CONFIG_OF disabled produces a compiler warning:

drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
drivers/iio/adc/stm32-dfsdm-core.c:245:22: error: unused variable 'pnode' [-Werror=unused-variable]

This removes the variable and open-codes it in the only place
it gets used to avoid that warning.

Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 72427414db7f..6cd655f8239b 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	struct device_node *pnode = pdev->dev.of_node;
 	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
@@ -254,7 +253,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 
 	priv->pdev = pdev;
 
-	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
+	of_id = of_match_node(stm32_dfsdm_of_match, pdev->dev.of_node);
 	if (!of_id->data) {
 		dev_err(&pdev->dev, "Data associated to device is missing\n");
 		return -EINVAL;
-- 
2.15.1
