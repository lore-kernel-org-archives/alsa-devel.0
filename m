From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fsl_spdif: Check for
	clk_prepare_enable() error" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:58 +0100
Message-ID: <E1ZCTNm-0005Yx-0p@finisterre>
References: <1434835086-27176-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F137B2656F0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:10 +0200 (CEST)
In-Reply-To: <1434835086-27176-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fsl_spdif: Check for clk_prepare_enable() error

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

>From fa3be9208dcb21ae4185f6122137fe7d5cf29d74 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Sat, 20 Jun 2015 18:18:06 -0300
Subject: [PATCH] ASoC: fsl: fsl_spdif: Check for clk_prepare_enable() error

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e93221..489fa86 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -482,13 +482,18 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 		mask = SCR_TXFIFO_AUTOSYNC_MASK | SCR_TXFIFO_CTRL_MASK |
 			SCR_TXSEL_MASK | SCR_USRC_SEL_MASK |
 			SCR_TXFIFO_FSEL_MASK;
-		for (i = 0; i < SPDIF_TXRATE_MAX; i++)
-			clk_prepare_enable(spdif_priv->txclk[i]);
+		for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
+			ret = clk_prepare_enable(spdif_priv->txclk[i]);
+			if (ret)
+				goto disable_txclk;
+		}
 	} else {
 		scr = SCR_RXFIFO_FSEL_IF8 | SCR_RXFIFO_AUTOSYNC;
 		mask = SCR_RXFIFO_FSEL_MASK | SCR_RXFIFO_AUTOSYNC_MASK|
 			SCR_RXFIFO_CTL_MASK | SCR_RXFIFO_OFF_MASK;
-		clk_prepare_enable(spdif_priv->rxclk);
+		ret = clk_prepare_enable(spdif_priv->rxclk);
+		if (ret)
+			goto err;
 	}
 	regmap_update_bits(regmap, REG_SPDIF_SCR, mask, scr);
 
@@ -497,6 +502,9 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 
+disable_txclk:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
 	clk_disable_unprepare(spdif_priv->coreclk);
 
-- 
2.1.4
