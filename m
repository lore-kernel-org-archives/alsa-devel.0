From: Mark Brown <broonie@kernel.org>
Subject: Applied "IIO: ADC: stm32-dfsdm: fix static check
	warning" to the asoc tree
Date: Tue, 16 Jan 2018 13:57:08 +0000
Message-ID: <E1ebRjg-0005BJ-UA@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A67EC266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:57:14 +0100 (CET)
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

   IIO: ADC: stm32-dfsdm: fix static check warning

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

>From 1175d0f9f4031ce02845f6f843f58a9caaee7817 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 15 Jan 2018 10:00:26 +0100
Subject: [PATCH] IIO: ADC: stm32-dfsdm: fix static check warning

iio_priv does not return an error pointer, so check is not valid.
Patch suppresses it.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 3fe9b34ac6af..daa026d6a94f 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1099,10 +1099,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	}
 
 	adc = iio_priv(iio);
-	if (IS_ERR(adc)) {
-		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
-		return PTR_ERR(adc);
-	}
 	adc->dfsdm = dev_get_drvdata(dev->parent);
 
 	iio->dev.parent = dev;
-- 
2.15.1
