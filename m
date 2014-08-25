From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3] ASoC: fsl-sai: rename big_endian_data to is_lsb_first.
Date: Mon, 25 Aug 2014 15:03:11 +0800
Message-ID: <1408950191-15809-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, nicoleotsuka@gmail.com, timur@tabi.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: galak@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
 sound/soc/fsl/fsl_sai.c                             | 6 +++---
 sound/soc/fsl/fsl_sai.h                             | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 06a405e..929ca74 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -20,9 +20,9 @@ Required properties:
   See ../pinctrl/pinctrl-bindings.txt for details of the property values.
 - big-endian: Boolean property, required if all the FTM_PWM registers
   are big-endian rather than little-endian.
-- big-endian-data: If this property is absent, the little endian mode will
-  be in use as default, or the big endian mode will be in use for all the
-  fifo data.
+- lsb-first: Configures whether the LSB or the MSB is transmitted first for
+  the fifo data. If this property is absent, the LSB is transmitted first as
+  default, or the MSB is transmitted first.
 - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
   that SAI will work in the synchronous mode (sync Tx with Rx) which means
   both the transimitter and receiver will send and receive data by following
@@ -53,5 +53,5 @@ sai2: sai@40031000 {
 	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
 		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
 	      big-endian;
-	      big-endian-data;
+	      lsb-first;
 };
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a6eb784..7eeb1dd 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -175,7 +175,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	bool tx = fsl_dir == FSL_FMT_TRANSMITTER;
 	u32 val_cr2 = 0, val_cr4 = 0;
 
-	if (!sai->big_endian_data)
+	if (!sai->is_lsb_first)
 		val_cr4 |= FSL_SAI_CR4_MF;
 
 	/* DAI mode */
@@ -304,7 +304,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
 
-	if (sai->big_endian_data)
+	if (sai->is_lsb_first)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 	else
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
@@ -573,7 +573,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
 		sai->sai_on_imx = true;
 
-	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
+	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 2cded44..3466720 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -132,7 +132,7 @@ struct fsl_sai {
 	struct clk *bus_clk;
 	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
 
-	bool big_endian_data;
+	bool is_lsb_first;
 	bool is_dsp_mode;
 	bool sai_on_imx;
 	bool synchronous[2];
-- 
1.8.5
