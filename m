From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Move one-time configurations
	to probe()" to the asoc tree
Date: Thu, 22 Feb 2018 13:16:30 +0000
Message-ID: <E1eoqje-0006HV-Sj@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C2BF267737
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:16:32 +0100 (CET)
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
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Move one-time configurations to probe()

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

>From a1d154ac2765cf982be0d4d378bc6ba342c467a3 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:20 -0800
Subject: [PATCH] ASoC: fsl_ssi: Move one-time configurations to probe()

The probe() could handle some one-time configurations since
they will not be changed once being configured.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7e15b30d4f94..36f3d51c5c43 100644
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
 
@@ -1248,6 +1235,29 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
 	.write = fsl_ssi_ac97_write,
 };
 
+/**
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
 /**
  * Make every character in a string lower-case
  */
@@ -1533,6 +1543,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ssi->dai_fmt)
 		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
 
+	/* Initially configures SSI registers */
+	fsl_ssi_hw_init(ssi);
+
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
-- 
2.16.1
