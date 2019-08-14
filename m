From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: fsl_sai: Add support for imx8qm
Date: Wed, 14 Aug 2019 11:29:10 +0300
Message-ID: <20190814082911.665-2-daniel.baluta@nxp.com>
References: <20190814082911.665-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814082911.665-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

SAI module on imx8qm features a register map similar with imx6 series
(it doesn't have VERID and PARAM registers at the beginning
of address spece).

Also, it has one FIFO which can help up to 64 * 32 bit samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 69cf3678c859..168e1c9cda5c 100644
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
2.17.1
