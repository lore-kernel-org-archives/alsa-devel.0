From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Add support for imx8qm" to the asoc tree
Date: Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Message-ID: <20190821121532.E3E7D2742BAE@ypsilon.sirena.org.uk>
References: <20190814082911.665-2-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814082911.665-2-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com, perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Add support for imx8qm

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

>From 6eeb60be5ebb73b2e5911e26fb1aed02940b7d09 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 14 Aug 2019 11:29:10 +0300
Subject: [PATCH] ASoC: fsl_sai: Add support for imx8qm

SAI module on imx8qm features a register map similar with imx6 series
(it doesn't have VERID and PARAM registers at the beginning
of address spece).

Also, it has one FIFO which can help up to 64 * 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190814082911.665-2-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4a346fcb5630..728307acab90 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1031,12 +1031,19 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.reg_offset = 8,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 64,
+	.reg_offset = 0,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
 	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
+	{ .compatible = "fsl,imx8qm-sai", .data = &fsl_sai_imx8qm_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.20.1
