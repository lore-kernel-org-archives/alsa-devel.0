From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Fix channel slipping in
	Playback at startup" to the asoc tree
Date: Fri, 13 May 2016 13:25:59 +0100
Message-ID: <E1b1CAJ-0007Le-5W@finisterre>
References: <1448550341-11765-6-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 426F92605F1
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:26:26 +0200 (CEST)
In-Reply-To: <1448550341-11765-6-git-send-email-arnaud.mouiche@invoxia.com>
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

   ASoC: fsl_ssi: Fix channel slipping in Playback at startup

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

>From 61fcf10a0ee44763e0347b297a377137f8950772 Mon Sep 17 00:00:00 2001
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date: Tue, 3 May 2016 14:13:59 +0200
Subject: [PATCH] ASoC: fsl_ssi: Fix channel slipping in Playback at startup

Previously, SCR.SSIEN and SCR.TE were enabled at once if no capture
stream was also running.
This may not give a chance for the DMA to write the first sample in
TX FIFO before the streaming starts on the PCM bus, inserting void
samples first.
Those void samples are then responsible for slipping the channels.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Caleb Crome <caleb@crome.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 47ebb835f3f5..8944af542b4f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -507,8 +507,40 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
 config_done:
 	/* Enabling of subunits is done after configuration */
-	if (enable)
+	if (enable) {
+		if (ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
+			/*
+			 * Be sure the Tx FIFO is filled when TE is set.
+			 * Otherwise, there are some chances to start the
+			 * playback with some void samples inserted first,
+			 * generating a channel slip.
+			 *
+			 * First, SSIEN must be set, to let the FIFO be filled.
+			 *
+			 * Notes:
+			 * - Limit this fix to the DMA case until FIQ cases can
+			 *   be tested.
+			 * - Limit the length of the busy loop to not lock the
+			 *   system too long, even if 1-2 loops are sufficient
+			 *   in general.
+			 */
+			int i;
+			int max_loop = 100;
+			regmap_update_bits(regs, CCSR_SSI_SCR,
+					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
+			for (i = 0; i < max_loop; i++) {
+				u32 sfcsr;
+				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
+				if (CCSR_SSI_SFCSR_TFCNT0(sfcsr))
+					break;
+			}
+			if (i == max_loop) {
+				dev_err(ssi_private->dev,
+					"Timeout waiting TX FIFO filling\n");
+			}
+		}
 		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
+	}
 }
 
 
-- 
2.8.1
