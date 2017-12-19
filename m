From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Define ternary macros to
	simplify code" to the asoc tree
Date: Tue, 19 Dec 2017 10:59:01 +0000
Message-ID: <E1eRFbx-0000oI-5a@debutante>
References: <1513146874-25476-12-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B5FC267688
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:59:10 +0100 (CET)
In-Reply-To: <1513146874-25476-12-git-send-email-nicoleotsuka@gmail.com>
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
Cc: mail@maciej.szmigiero.name, arnaud.mouiche@invoxia.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@tabi.org, caleb@crome.org, lgirdwood@gmail.com, broonie@kernel.org, kernel@pengutronix.de, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Define ternary macros to simplify code

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

>From 52eee84e815e0fbaf9ada848ab5646314a529b61 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:10 -0800
Subject: [PATCH] ASoC: fsl_ssi: Define ternary macros to simplify code

Some regmap code looks redudant. So simplify it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++----------------
 sound/soc/fsl/fsl_ssi.h |  4 ++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 2b3915c45199..aecd00f7929d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -408,13 +408,10 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
  */
 static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
-	if (is_rx) {
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_RX_CLR, SSI_SOR_RX_CLR);
-	} else {
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_TX_CLR, SSI_SOR_TX_CLR);
-	}
+	bool tx = !is_rx;
+
+	regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 }
 
 /**
@@ -681,6 +678,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai,
 			    struct snd_pcm_hw_params *hw_params)
 {
+	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
@@ -768,10 +766,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		(psr ? SSI_SxCCR_PSR : 0);
 	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
-		regmap_update_bits(regs, REG_SSI_STCCR, mask, stccr);
-	else
-		regmap_update_bits(regs, REG_SSI_SRCCR, mask, stccr);
+	/* STCCR is used for RX in synchronous mode */
+	tx2 = tx || synchronous;
+	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), mask, stccr);
 
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
@@ -799,6 +796,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params,
 			     struct snd_soc_dai *dai)
 {
+	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
@@ -849,11 +847,8 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
-	    ssi->cpu_dai_drv.symmetric_rates)
-		regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_WL_MASK, wl);
-	else
-		regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_WL_MASK, wl);
+	tx2 = tx || ssi->cpu_dai_drv.symmetric_rates;
+	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index b61008779e3c..de2fdc5db726 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -35,10 +35,12 @@
 #define REG_SSI_STCR			0x1c
 /* SSI Receive Configuration Register */
 #define REG_SSI_SRCR			0x20
+#define REG_SSI_SxCR(tx)		((tx) ? REG_SSI_STCR : REG_SSI_SRCR)
 /* SSI Transmit Clock Control Register */
 #define REG_SSI_STCCR			0x24
 /* SSI Receive Clock Control Register */
 #define REG_SSI_SRCCR			0x28
+#define REG_SSI_SxCCR(tx)		((tx) ? REG_SSI_STCCR : REG_SSI_SRCCR)
 /* SSI FIFO Control/Status Register */
 #define REG_SSI_SFCSR			0x2c
 /*
@@ -67,6 +69,7 @@
 #define REG_SSI_STMSK			0x48
 /* SSI  Receive Time Slot Mask Register */
 #define REG_SSI_SRMSK			0x4c
+#define REG_SSI_SxMSK(tx)		((tx) ? REG_SSI_STMSK : REG_SSI_SRMSK)
 /*
  * SSI AC97 Channel Status Register
  *
@@ -249,6 +252,7 @@
 #define SSI_SOR_CLKOFF			0x00000040
 #define SSI_SOR_RX_CLR			0x00000020
 #define SSI_SOR_TX_CLR			0x00000010
+#define SSI_SOR_xX_CLR(tx)		((tx) ? SSI_SOR_TX_CLR : SSI_SOR_RX_CLR)
 #define SSI_SOR_INIT			0x00000008
 #define SSI_SOR_WAIT_SHIFT		1
 #define SSI_SOR_WAIT_MASK		0x00000006
-- 
2.15.1
