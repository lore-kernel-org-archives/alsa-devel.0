From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: fix no frame clk in master
	mode" to the asoc tree
Date: Fri, 18 Dec 2015 17:14:37 +0000
Message-ID: <E1a9yc1-0000aT-I7@debutante>
References: <4e56cafc5497654b0413418d41187e5b8f0023e3.1450428585.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F245A2658BD
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 18:14:48 +0100 (CET)
In-Reply-To: <4e56cafc5497654b0413418d41187e5b8f0023e3.1450428585.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: fix no frame clk in master mode

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

>From 3e3f8bd569558acefdfaae273d71f7a29b8c0b4f Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Dec 2015 16:53:41 +0800
Subject: [PATCH] ASoC: fsl_sai: fix no frame clk in master mode

After several open/close sai test with ctrl+c, there will be
I/O error. The SAI can't work anymore, can't recover. There
will be no frame clock. With adding the software reset in
trigger stop, the issue can be fixed.

This is a hardware bug/errata and reset is the only option.

According to the reference manual, the software reset doesn't
reset any control register but only internal hardware logics
such as bit clock generator, status flags, and FIFO pointers.
(Our purpose is just to reset the clock generator while the
software reset is the only way to do that.)

Since slave mode doesn't use the clock generator, only apply
the reset procedure to the master mode.

For asynchronous mode, TX will not be reset when RX is still
running. In this case, i can't reproduce this issue.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a4435f5e3be9..a31f0ba527eb 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -504,6 +504,24 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
 			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
+
+			/*
+			 * For sai master mode, after several open/close sai,
+			 * there will be no frame clock, and can't recover
+			 * anymore. Add software reset to fix this issue.
+			 * This is a hardware bug, and will be fix in the
+			 * next sai version.
+			 */
+			if (!sai->is_slave_mode) {
+				/* Software Reset for both Tx and Rx */
+				regmap_write(sai->regmap,
+					     FSL_SAI_TCSR, FSL_SAI_CSR_SR);
+				regmap_write(sai->regmap,
+					     FSL_SAI_RCSR, FSL_SAI_CSR_SR);
+				/* Clear SR bit to finish the reset */
+				regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
+				regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
+			}
 		}
 		break;
 	default:
-- 
2.6.2
