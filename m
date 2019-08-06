From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 4/5] ASoC: fsl_sai: Add support for imx7ulp/imx8mq
Date: Tue,  6 Aug 2019 18:12:13 +0300
Message-ID: <20190806151214.6783-5-daniel.baluta@nxp.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806151214.6783-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

SAI module on imx7ulp/imx8m features 2 new registers (VERID and PARAM)
at the beginning of register address space.

On imx7ulp FIFOs can held up to 16 x 32 bit samples.
On imx8mq FIFOs can held up to 128 x 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 291f414c41c6..857438146dae 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1021,10 +1021,24 @@ static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.reg_offset = 0,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 16,
+	.reg_offset = 8,
+};
+
+static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
+	.use_imx_pcm = true,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+};
+
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
 	{ .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
 	{ .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
+	{ .compatible = "fsl,imx7ulp-sai", .data = &fsl_sai_imx7ulp_data },
+	{ .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8mq_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.17.1
