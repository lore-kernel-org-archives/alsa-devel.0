From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: ADC: stm32-dfsdm: remove unused variable
	again" to the asoc tree
Date: Thu, 18 Jan 2018 11:22:44 +0000
Message-ID: <E1ec8HM-0003j8-Hq@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C659266A74
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 12:22:45 +0100 (CET)
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

   IIO: ADC: stm32-dfsdm: remove unused variable again

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

>From 166a5a33d5a7bfa62c039eb10e69589b09fd0557 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 12:17:47 +0100
Subject: [PATCH] IIO: ADC: stm32-dfsdm: remove unused variable again

The merge between commit abaca806fd13 ("IIO: ADC: stm32-dfsdm: code
optimization") and commit 2353758bc2d4 ("IIO: ADC: stm32-dfsdm: avoid
unused-variable warning") left one variable behind that is no longer
needed and can be removed, as shown by the gcc warning:

drivers/iio/adc/stm32-dfsdm-core.c: In function 'stm32_dfsdm_probe':
drivers/iio/adc/stm32-dfsdm-core.c:245:29: error: unused variable 'of_id' [-Werror=unused-variable]

Fixes: d84b4c7c706f ("Merge branch 'topic/iio' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into asoc-st-dfsdm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 84277bcc465f..6290332cfd3f 100644
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
-- 
2.15.1
