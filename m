From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Add DAIFMT define for AC97" to
	the asoc tree
Date: Thu, 22 Feb 2018 13:16:43 +0000
Message-ID: <E1eoqjr-0006MG-1N@debutante>
References: <1513702819-42310-7-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D78C26778B
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:16:54 +0100 (CET)
In-Reply-To: <1513702819-42310-7-git-send-email-nicoleotsuka@gmail.com>
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

   ASoC: fsl_ssi: Add DAIFMT define for AC97

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

>From b6c93f7f60a0d0b61c1fce2872b9d4f7263d6ec2 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:16 -0800
Subject: [PATCH] ASoC: fsl_ssi: Add DAIFMT define for AC97

The _fsl_ssi_set_dai_fmt() bypasses an undefined format for AC97
mode. However, it's not really necessary if AC97 has its complete
format defined.

So this patch adds a DAIFMT macro of complete format including a
clock direction and polarity.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 9f024a9afaa5..fc5768d243d1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -90,6 +90,16 @@
 	 SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
+/*
+ * In AC97 mode, TXDIR bit is forced to 0 and TFDIR bit is forced to 1:
+ *  - SSI inputs external bit clock and outputs frame sync clock -- CBM_CFS
+ *  - Also have NB_NF to mark these two clocks will not be inverted
+ */
+#define FSLSSI_AC97_DAIFMT \
+	(SND_SOC_DAIFMT_AC97 | \
+	 SND_SOC_DAIFMT_CBM_CFS | \
+	 SND_SOC_DAIFMT_NB_NF)
+
 #define FSLSSI_SIER_DBG_RX_FLAGS \
 	(SSI_SIER_RFF0_EN | \
 	 SSI_SIER_RLS_EN | \
@@ -964,8 +974,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		if (!fsl_ssi_is_ac97(ssi))
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	stcr |= strcr;
@@ -1372,7 +1381,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
-			ssi->dai_fmt = SND_SOC_DAIFMT_AC97;
+			ssi->dai_fmt = FSLSSI_AC97_DAIFMT;
 	}
 
 	/* Select DMA or FIQ */
-- 
2.16.1
