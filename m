From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v3 12/17] ASoC: fsl_ssi: Move one-time configurations to probe()
Date: Sun, 14 Jan 2018 20:21:22 -0800
Message-ID: <1515990087-11598-13-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The probe() could handle some one-time configurations since
they will not be changed once being configured.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
Changelog
v2
 * Moved all to fsl_ssi_hw_init() in platform probe()

 sound/soc/fsl/fsl_ssi.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e1fe511..50648f5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -865,7 +865,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 {
 	struct regmap *regs = ssi->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
-	u8 wm;
 
 	ssi->dai_fmt = fmt;
 
@@ -874,8 +873,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_regvals(ssi);
-
 	regmap_read(regs, REG_SSI_SCR, &scr);
 	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
@@ -990,16 +987,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	wm = ssi->fifo_watermark;
-
-	regmap_write(regs, REG_SSI_SFCSR,
-		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
-		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
-
-	if (ssi->use_dual_fifo)
-		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
-
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi);
 
@@ -1249,6 +1236,29 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
 };
 
 /**
+ * Initialize SSI registers
+ */
+static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
+{
+	u32 wm = ssi->fifo_watermark;
+
+	/* Initialize regvals */
+	fsl_ssi_setup_regvals(ssi);
+
+	/* Set watermarks */
+	regmap_write(ssi->regs, REG_SSI_SFCSR,
+		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
+		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
+
+	/* Enable Dual FIFO mode */
+	if (ssi->use_dual_fifo)
+		regmap_update_bits(ssi->regs, REG_SSI_SCR,
+				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
+
+	return 0;
+}
+
+/**
  * Make every character in a string lower-case
  */
 static void make_lowercase(char *s)
@@ -1533,6 +1543,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ssi->dai_fmt)
 		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
 
+	/* Initially configures SSI registers */
+	fsl_ssi_hw_init(ssi);
+
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
-- 
2.7.4
