From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: mark SACNT register volatile"
	to the asoc tree
Date: Sun, 10 Jan 2016 12:22:27 +0000
Message-ID: <E1aIF0t-0008P0-4k@debutante>
References: <56770FE1.4060202@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 660EC260631
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:37 +0100 (CET)
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: mark SACNT register volatile

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

>From 3f1c241f0f5f90046258e6b8d4aeb6463ffdc08e Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sun, 20 Dec 2015 21:30:25 +0100
Subject: [PATCH] ASoC: fsl_ssi: mark SACNT register volatile

SACNT register should be marked volatile since
its WR and RD bits are cleared by SSI after
completing the relevant operation.
This unbreaks AC'97 register access.

Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e3abad5f980a..cc22354d7758 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -146,6 +146,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SRX1:
 	case CCSR_SSI_SISR:
 	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_SACNT:
 	case CCSR_SSI_SACADD:
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
@@ -239,8 +240,9 @@ struct fsl_ssi_private {
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
 
-	/*regcache for SFCSR*/
+	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
+	u32 regcache_sacnt;
 
 	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -1587,6 +1589,8 @@ static int fsl_ssi_suspend(struct device *dev)
 
 	regmap_read(regs, CCSR_SSI_SFCSR,
 			&ssi_private->regcache_sfcsr);
+	regmap_read(regs, CCSR_SSI_SACNT,
+			&ssi_private->regcache_sacnt);
 
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
@@ -1605,6 +1609,8 @@ static int fsl_ssi_resume(struct device *dev)
 			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
 			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
 			ssi_private->regcache_sfcsr);
+	regmap_write(regs, CCSR_SSI_SACNT,
+			ssi_private->regcache_sacnt);
 
 	return regcache_sync(regs);
 }
-- 
2.7.0.rc3
