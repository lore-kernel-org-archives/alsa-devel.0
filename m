From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Setup AC97 in
	fsl_ssi_hw_init()" to the asoc tree
Date: Thu, 22 Feb 2018 13:16:28 +0000
Message-ID: <E1eoqjc-0006Gi-N5@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B25926772F
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:16:30 +0100 (CET)
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

   ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()

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

>From 37ac30a4bdc397cf1311111264ac35dc8473e1de Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:21 -0800
Subject: [PATCH] ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()

AC97 configures most of registers earlier to start a communication
with CODECs in order to successfully initialize CODEC. Currently,
_fsl_ssi_set_dai_fmt() and fsl_ssi_setup_ac97() are called to get
all SSI registers properly set.

Since now the driver has a fsl_ssi_hw_init() to handle all register
initial settings, this patch moves those register settings of AC97
to the fsl_ssi_hw_init() as well.

Meanwhile it applies _fsl_ssi_set_dai_fmt() call to AC97 only since
other formats would be configured via normal set_dai_fmt() directly.

This patch also adds fsl_ssi_hw_clean() to cleanup control bits for
AC97 in the platform remote() function.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 36f3d51c5c43..dfb0da3cedda 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -987,9 +987,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi);
-
 	return 0;
 }
 
@@ -1255,9 +1252,33 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 
+	/* AC97 should start earlier to communicate with CODECs */
+	if (fsl_ssi_is_ac97(ssi)) {
+		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		fsl_ssi_setup_ac97(ssi);
+	}
+
 	return 0;
 }
 
+/**
+ * Clear SSI registers
+ */
+static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
+{
+	/* Disable registers for AC97 */
+	if (fsl_ssi_is_ac97(ssi)) {
+		/* Disable TE and RE bits first */
+		regmap_update_bits(ssi->regs, REG_SSI_SCR,
+				   SSI_SCR_TE | SSI_SCR_RE, 0);
+		/* Disable AC97 mode */
+		regmap_write(ssi->regs, REG_SSI_SACNT, 0);
+		/* Unset WAIT bits */
+		regmap_write(ssi->regs, REG_SSI_SOR, 0);
+		/* Disable SSI -- software reset */
+		regmap_update_bits(ssi->regs, REG_SSI_SCR, SSI_SCR_SSIEN, 0);
+	}
+}
 /**
  * Make every character in a string lower-case
  */
@@ -1540,9 +1561,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
-
 	/* Initially configures SSI registers */
 	fsl_ssi_hw_init(ssi);
 
@@ -1592,6 +1610,9 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi->pdev)
 		platform_device_unregister(ssi->pdev);
 
+	/* Clean up SSI registers */
+	fsl_ssi_hw_clean(ssi);
+
 	if (ssi->soc->imx)
 		fsl_ssi_imx_clean(pdev, ssi);
 
-- 
2.16.1
