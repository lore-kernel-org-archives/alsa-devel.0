From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: No need to initialize
	max_xx_thres when it is not used" to the asoc tree
Date: Tue, 13 Nov 2018 18:29:11 +0000 (GMT)
Message-ID: <20181113182911.CAA59440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DFCFE2677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:29:18 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: No need to initialize max_xx_thres when it is not used

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

>From f15c19af929d380d0acb2a8d8277d688351bd5de Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 8 Nov 2018 09:30:00 +0200
Subject: [PATCH] ASoC: omap-mcbsp: No need to initialize max_xx_thres when it
 is not used

Initializing to -EINVAL is not correct as the variables are unsigned and
if buffer_size is 0 then they are not used anyway.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-mcbsp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8cab1151d3bb..e0ef4774c710 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -727,9 +727,6 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 				"Unable to create additional controls\n");
 			goto err_thres;
 		}
-	} else {
-		mcbsp->max_tx_thres = -EINVAL;
-		mcbsp->max_rx_thres = -EINVAL;
 	}
 
 	ret = omap_mcbsp_st_init(pdev);
-- 
2.19.1
