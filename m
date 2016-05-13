From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Save a dev reference for
	dev_err() purpose." to the asoc tree
Date: Fri, 13 May 2016 13:26:12 +0100
Message-ID: <E1b1CAW-0007Mu-CH@finisterre>
References: <1448546842-4584-3-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B048C2668F7
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:26:35 +0200 (CEST)
In-Reply-To: <1448546842-4584-3-git-send-email-arnaud.mouiche@invoxia.com>
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

   ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.

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

>From 0096b693962d3abde4f41b13cf03c765f33e9d8d Mon Sep 17 00:00:00 2001
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Date: Tue, 3 May 2016 14:13:57 +0200
Subject: [PATCH] ASoC: fsl_ssi: Save a dev reference for dev_err() purpose.

Most of functions only receive the ssi_private reference and don't have
a knowledge of 'dev' pointer, even for debug purpose.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Tested-by: Caleb Crome <caleb@crome.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 86229c8902d2..149df3ca4f5e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -261,6 +261,7 @@ struct fsl_ssi_private {
 	struct fsl_ssi_dbg dbg_stats;
 
 	const struct fsl_ssi_soc_data *soc;
+	struct device *dev;
 };
 
 /*
@@ -1404,6 +1405,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi_private->soc = of_id->data;
+	ssi_private->dev = &pdev->dev;
 
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
-- 
2.8.1
