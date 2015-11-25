From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: spba clk is needed by spdif
	device" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:04 +0000
Message-ID: <E1a1Zg4-0002q2-29@debutante>
References: <02a93459781754faa531e37abb74470f9c90fafd.1448356624.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87E8D261583
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:13 +0100 (CET)
In-Reply-To: <02a93459781754faa531e37abb74470f9c90fafd.1448356624.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_spdif: spba clk is needed by spdif device

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

>From 0bc5680af8c436d292797d58991b83bca570d079 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@freescale.com>
Date: Tue, 24 Nov 2015 17:19:33 +0800
Subject: [PATCH] ASoC: fsl_spdif: spba clk is needed by spdif device

SPDIF need to enable the spba clock, when sdma is using share peripheral
script. In this case, there is two spba master port is used, if don't
enable the clock, the spba bus will have arbitration issue, which may
cause read/write wrong data from/to SPDIF registers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
 sound/soc/fsl/fsl_spdif.c                             | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index b5ee32ee3706..4ca39ddc0417 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -27,6 +27,11 @@ Required properties:
 			  Transceiver Clock Diagram" of SoC reference manual.
 			  It can also be referred to TxClk_Source bit of
 			  register SPDIF_STC.
+	"spba"		  The spba clock is required when SPDIF is placed as a
+			  bus slave of the Shared Peripheral Bus and when two
+			  or more bus masters (CPU, DMA or DSP) try to access
+			  it. This property is optional depending on the SoC
+			  design.
 
    - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3d59bb6719f2..fa36e6753799 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -88,6 +88,7 @@ struct spdif_mixer_control {
  * @rxclk: rx clock sources for capture
  * @coreclk: core clock for register access via DMA
  * @sysclk: system clock for rx clock rate measurement
+ * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
  */
@@ -106,6 +107,7 @@ struct fsl_spdif_priv {
 	struct clk *rxclk;
 	struct clk *coreclk;
 	struct clk *sysclk;
+	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	/* regcache for SRPC */
@@ -474,6 +476,14 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
+		if (!IS_ERR(spdif_priv->spbaclk)) {
+			ret = clk_prepare_enable(spdif_priv->spbaclk);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to enable spba clock\n");
+				goto err_spbaclk;
+			}
+		}
+
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
@@ -515,6 +525,9 @@ disable_txclk:
 	for (i--; i >= 0; i--)
 		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
+	if (!IS_ERR(spdif_priv->spbaclk))
+		clk_disable_unprepare(spdif_priv->spbaclk);
+err_spbaclk:
 	clk_disable_unprepare(spdif_priv->coreclk);
 
 	return ret;
@@ -548,6 +561,8 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
+		if (!IS_ERR(spdif_priv->spbaclk))
+			clk_disable_unprepare(spdif_priv->spbaclk);
 		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
@@ -1261,6 +1276,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif_priv->coreclk);
 	}
 
+	spdif_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
+	if (IS_ERR(spdif_priv->spbaclk))
+		dev_warn(&pdev->dev, "no spba clock in devicetree\n");
+
 	/* Select clock source for rx/tx clock */
 	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
 	if (IS_ERR(spdif_priv->rxclk)) {
-- 
2.6.2
