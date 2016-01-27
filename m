From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-spdif: Fix crash on suspend" to the
	asoc tree
Date: Wed, 27 Jan 2016 18:37:39 +0000
Message-ID: <E1aOUyJ-000886-M7@debutante>
References: <569412C1.6090308@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ECCF72654B3
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:48 +0100 (CET)
In-Reply-To: <569412C1.6090308@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-spdif: Fix crash on suspend

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

>From 9954859185c6e8359e71121037b627f1e294057d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 26 Jan 2016 13:54:15 +0100
Subject: [PATCH] ASoC: imx-spdif: Fix crash on suspend

When registering a ASoC card the driver data of the parent device is set to
point to the card. This driver data is used in the
snd_soc_suspend()/resume() callbacks.

The imx-spdif driver overwrites the driver data with custom data which
causes snd_soc_suspend() to crash.  Since the custom driver is not used
anywhere simply deleting the line which sets the custom driver data fixes
the issue.

Fixes: 43ac946922b3 ("ASoC: imx-spdif: add snd_soc_pm_ops for spdif machine driver")
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-spdif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index a407e833c612..fb896b2c9ba3 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -72,8 +72,6 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 		goto end;
 	}
 
-	platform_set_drvdata(pdev, data);
-
 end:
 	of_node_put(spdif_np);
 
-- 
2.7.0.rc3
