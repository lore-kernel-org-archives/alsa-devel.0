From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Ensure i2s_reg_comp{1,
	2} is always initialised" to the asoc tree
Date: Tue, 02 Feb 2016 19:41:59 +0000
Message-ID: <E1aQgpr-0007t0-Ta@debutante>
References: <1454342077.16701.4.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB29265259
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:42:06 +0100 (CET)
In-Reply-To: <1454342077.16701.4.camel@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jon Medhurst <tixy@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Ensure i2s_reg_comp{1,2} is always initialised

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

>From d2f916aaccaf7b3bc27df2fd6cfc00f6cda2f78d Mon Sep 17 00:00:00 2001
From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Date: Mon, 1 Feb 2016 15:54:37 +0000
Subject: [PATCH] ASoC: dwc: Ensure i2s_reg_comp{1,2} is always initialised

In the case that the driver is configured from device-tree
i2s_reg_comp1 and i2s_reg_comp2 aren't initialised, breaking the driver.
Fix this by unconditionally setting these values before checking for quirks.

Fixes: a242cac1d3aa ("ASoC: dwc: add quirk to override COMP_PARAM_1 register")
Signed-off-by: Jon Medhurst <tixy@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index ce664c239be3..bff258d7bcea 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -645,6 +645,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 
 	dev->dev = &pdev->dev;
 
+	dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
+	dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
 	if (pdata) {
 		dev->capability = pdata->cap;
 		clk_id = NULL;
@@ -652,9 +654,6 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		if (dev->quirks & DW_I2S_QUIRK_COMP_REG_OFFSET) {
 			dev->i2s_reg_comp1 = pdata->i2s_reg_comp1;
 			dev->i2s_reg_comp2 = pdata->i2s_reg_comp2;
-		} else {
-			dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
-			dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
 		}
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else {
-- 
2.7.0.rc3
