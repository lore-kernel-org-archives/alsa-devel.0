From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: fix register setting issue in
	RIGHT_J mode" to the asoc tree
Date: Tue, 19 Feb 2019 11:47:04 +0000 (GMT)
Message-ID: <20190219114704.99DD511284A6@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E423E265532
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 12:47:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

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

>From cc29ea007347f39f4c5a4d27b0b555955a0277f9 Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Mon, 18 Feb 2019 08:29:11 +0000
Subject: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
wrong register, correct it.

Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 57b484768a58..afe67c865330 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -398,7 +398,8 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		/* Data on rising edge of bclk, frame high, right aligned */
-		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
+		xccr |= ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
+		xcr  |= ESAI_xCR_xWA;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
@@ -455,12 +456,12 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR;
+	mask = ESAI_xCR_xFSL | ESAI_xCR_xFSR | ESAI_xCR_xWA;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, xcr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR, mask, xcr);
 
 	mask = ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCCR_xFSP |
-		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD | ESAI_xCR_xWA;
+		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR, mask, xccr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR, mask, xccr);
 
-- 
2.20.1
