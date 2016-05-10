From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Add pm callbacks to
	platform driver" to the asoc tree
Date: Tue, 10 May 2016 19:50:08 +0100
Message-ID: <E1b0CjQ-0000JW-GA@debutante>
References: <1462790290-5346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E7D8267525
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 20:50:14 +0200 (CEST)
In-Reply-To: <1462790290-5346-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Add pm callbacks to platform driver

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

>From 7c3767115a04bc7aa87bdbd3352d1801d4bbeea4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 9 May 2016 13:38:10 +0300
Subject: [PATCH] ASoC: simple-card: Add pm callbacks to platform driver

Set snd_soc_pm_ops for the pm ops to make sure that the ASoC level of PM
operations are going to happen. This is needed to get suspend/resume
working correctly when the audio is using simple-card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2389ab47e25f..466492b7d4f5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -643,6 +643,7 @@ MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name = "asoc-simple-card",
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = asoc_simple_of_match,
 	},
 	.probe = asoc_simple_card_probe,
-- 
2.8.1
