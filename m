From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: add of_match data" to the asoc
	tree
Date: Mon, 22 Jul 2019 13:22:07 +0100 (BST)
Message-ID: <20190722122207.AC08727429D9@ypsilon.sirena.org.uk>
References: <20190717105635.18514-2-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E844F800E8
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 14:22:10 +0200 (CEST)
In-Reply-To: <20190717105635.18514-2-l.stach@pengutronix.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Angus Ainslie <angus@akkea.ca>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: add of_match data

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

>From 5442954f20d9f0fbc0f29a69a2fe0f70aa11273e Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Wed, 17 Jul 2019 12:56:33 +0200
Subject: [PATCH] ASoC: fsl_sai: add of_match data

New revisions of the SAI IP block have even more differences that need
be taken into account by the driver. To avoid sprinking compatible
checks all over the driver move the current differences into of_match_data.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190717105635.18514-2-l.stach@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------
 sound/soc/fsl/fsl_sai.h |  6 +++++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d58cc3ae90d8..ed0432e7327a 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -788,10 +789,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sai->pdev = pdev;
-
-	if (of_device_is_compatible(np, "fsl,imx6sx-sai") ||
-	    of_device_is_compatible(np, "fsl,imx6ul-sai"))
-		sai->sai_on_imx = true;
+	sai->soc_data = of_device_get_match_data(&pdev->dev);
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
 
@@ -900,7 +898,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (sai->sai_on_imx)
+	if (sai->soc_data->use_imx_pcm)
 		return imx_pcm_dma_init(pdev, IMX_SAI_DMABUF_SIZE);
 	else
 		return devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
@@ -913,10 +911,18 @@ static int fsl_sai_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
+	.use_imx_pcm = false,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
+	.use_imx_pcm = true,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
-	{ .compatible = "fsl,vf610-sai", },
-	{ .compatible = "fsl,imx6sx-sai", },
-	{ .compatible = "fsl,imx6ul-sai", },
+	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
+	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
+	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 24cb156bf995..83e2bfe05b1b 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -126,6 +126,10 @@
 #define FSL_SAI_MAXBURST_TX 6
 #define FSL_SAI_MAXBURST_RX 6
 
+struct fsl_sai_soc_data {
+	bool use_imx_pcm;
+};
+
 struct fsl_sai {
 	struct platform_device *pdev;
 	struct regmap *regmap;
@@ -135,7 +139,6 @@ struct fsl_sai {
 	bool is_slave_mode;
 	bool is_lsb_first;
 	bool is_dsp_mode;
-	bool sai_on_imx;
 	bool synchronous[2];
 
 	unsigned int mclk_id[2];
@@ -143,6 +146,7 @@ struct fsl_sai {
 	unsigned int slots;
 	unsigned int slot_width;
 
+	const struct fsl_sai_soc_data *soc_data;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
-- 
2.20.1
