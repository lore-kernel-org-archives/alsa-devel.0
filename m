From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: Add compatible string for imx6ull" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:51 +0100 (BST)
Message-ID: <20190812130951.2CA162740CBD@ypsilon.sirena.org.uk>
References: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.orgMark Brown <broonie@kernel.org>, mark.rutland@arm.com, nicoleotsuka@gmail.comNicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_esai: Add compatible string for imx6ull

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 9c2806c4941641a6c75736f8c4303c89d2013cc4 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 9 Aug 2019 18:27:46 +0800
Subject: [PATCH] ASoC: fsl_esai: Add compatible string for imx6ull

Add compatible string for imx6ull, from imx6ull platform,
the issue of channel swap after xrun is fixed in hardware.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5832144beb9f..a78e4ab478df 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1049,6 +1049,7 @@ static int fsl_esai_remove(struct platform_device *pdev)
 static const struct of_device_id fsl_esai_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esai", },
 	{ .compatible = "fsl,vf610-esai", },
+	{ .compatible = "fsl,imx6ull-esai", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
-- 
2.20.1
