From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec: fix crash on module
	removal" to the asoc tree
Date: Fri,  9 Nov 2018 15:58:16 +0000 (GMT)
Message-ID: <20181109155816.C5B581124E6F@debutante.sirena.org.uk>
References: <20181109043135.26200-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B180F267B1D
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 16:58:20 +0100 (CET)
In-Reply-To: <20181109043135.26200-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun8i-codec: fix crash on module removal

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

>From 278df5e5527b633f4882f1680ad58b62a7c07bfe Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 8 Nov 2018 20:31:35 -0800
Subject: [PATCH] ASoC: sun8i-codec: fix crash on module removal

drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
when calling snd_soc_card_get_drvdata().

Drop card and scodec vars anyway since we don't need to
disable/unprepare clocks - it's already done by calling
runtime_suspend()

Drop clk_disable_unprepare() calls for the same reason.

Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 522a72fde78d..c4196d4e5915 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -605,16 +605,10 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 
 static int sun8i_codec_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct sun8i_codec *scodec = snd_soc_card_get_drvdata(card);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun8i_codec_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(scodec->clk_module);
-	clk_disable_unprepare(scodec->clk_bus);
-
 	return 0;
 }
 
-- 
2.19.0.rc2
