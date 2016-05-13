From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Fix samples being dropped at
	Playback startup" to the asoc tree
Date: Fri, 13 May 2016 13:26:06 +0100
Message-ID: <E1b1CAQ-0007MI-7n@finisterre>
References: <1448546842-4584-4-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0427B26058D
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:26:26 +0200 (CEST)
In-Reply-To: <1448546842-4584-4-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Caleb Crome <caleb@crome.org>, Markus Pargmann <mpa@pengutronix.de>, broonie@kernel.org, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Fix samples being dropped at Playback startup

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

>From d9f2a202877c15818d98268f47d6b4bcfcb84437 Mon Sep 17 00:00:00 2001
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date: Tue, 3 May 2016 14:13:58 +0200
Subject: [PATCH] ASoC: fsl_ssi: Fix samples being dropped at Playback startup

If the capture is already running while playback is started, it is highly
probable (>80% in a 8 channels scenario) that samples are lost between
the DMA and TX fifo.

The reason is that SIER.TDMAE is set before STCR.TFEN0, leaving a time
window where the FIFO doesn't receive the samples written by the DMA.

This particular case happened only if capture is already enabled as
SCR.SSIEN is already set at the playback startup instant.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 149df3ca4f5e..47ebb835f3f5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -475,9 +475,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
-		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
+		regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
 	} else {
 		u32 sier;
 		u32 srcr;
-- 
2.8.1
