From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fsl_spdif: signedness bug in
	fsl_spdif_startup()" to the asoc tree
Date: Wed, 15 Jul 2015 12:55:43 +0100
Message-ID: <E1ZFLHr-0006e7-3X@debutante>
References: <20150709082103.GA13462@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8305265A98
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:51 +0200 (CEST)
In-Reply-To: <20150709082103.GA13462@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fsl_spdif: signedness bug in fsl_spdif_startup()

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

>From 89e0e250f92b0b0233337043ddf76f261916036c Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 9 Jul 2015 11:21:03 +0300
Subject: [PATCH] ASoC: fsl: fsl_spdif: signedness bug in fsl_spdif_startup()

We need "i" to be signed or it leads to a forever loop in the error
handling.

Fixes: fa3be9208dcb ('ASoC: fsl: fsl_spdif: Check for clk_prepare_enable() error')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e932219cb3a..851b83373d4c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -454,7 +454,8 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct regmap *regmap = spdif_priv->regmap;
-	u32 scr, mask, i;
+	u32 scr, mask;
+	int i;
 	int ret;
 
 	/* Reset module and interrupts only for first initialization */
-- 
2.1.4
