From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Maintain a mask of active
	streams" to the asoc tree
Date: Thu, 22 Feb 2018 13:17:00 +0000
Message-ID: <E1eoqk8-0006Qq-HP@debutante>
References: <1515990087-11598-5-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B16112677AE
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:17:10 +0100 (CET)
In-Reply-To: <1515990087-11598-5-git-send-email-nicoleotsuka@gmail.com>
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
Cc: alsa-devel@alsa-project.org, arnaud.mouiche@invoxia.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name, caleb@crome.org, timur@tabi.org, broonie@kernel.org, kernel@pengutronix.de, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Maintain a mask of active streams

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

>From e0582731abe004163e78ad2dac4cd1196db0908f Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:12 -0800
Subject: [PATCH] ASoC: fsl_ssi: Maintain a mask of active streams

Checking TE and RE bits in SCR register doesn't work for AC97 mode
which enables SSIEN, TE and RE in the fsl_ssi_setup_ac97() that's
called during probe().

So when running into the trigger(), it will always get the result
of both TE and RE being enabled already, even if actually there is
no active stream.

This patch fixes this issue by adding a variable to log the active
streams manually.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 14046c32dc07..b277a563ff48 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -205,6 +205,7 @@ struct fsl_ssi_soc_data {
  * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
+ * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
@@ -249,6 +250,7 @@ struct fsl_ssi {
 	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
+	u8 streams;
 	u8 i2s_net;
 	bool use_dma;
 	bool use_dual_fifo;
@@ -444,15 +446,14 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
+	int dir = (&ssi->regvals[TX] == vals) ? TX : RX;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
 	int nr_active_streams;
-	u32 scr;
 	int keep_active;
 
-	regmap_read(regs, REG_SSI_SCR, &scr);
-
-	nr_active_streams = !!(scr & SSI_SCR_TE) + !!(scr & SSI_SCR_RE);
+	nr_active_streams = !!(ssi->streams & BIT(TX)) +
+			    !!(ssi->streams & BIT(RX));
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -474,6 +475,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 					      keep_active);
 		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
+
+		/* Log the disabled stream to the mask */
+		ssi->streams &= ~BIT(dir);
 	}
 
 	/*
@@ -549,6 +553,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		}
 		/* Enable all remaining bits */
 		regmap_update_bits(regs, REG_SSI_SCR, vals->scr, vals->scr);
+
+		/* Log the enabled stream to the mask */
+		ssi->streams |= BIT(dir);
 	}
 }
 
-- 
2.16.1
