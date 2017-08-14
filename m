From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: Delete an error message for a failed memory allocation in fsi_probe()" to the asoc tree
Date: Mon, 14 Aug 2017 17:42:40 +0100
Message-ID: <E1dhIRs-000578-E6@finisterre>
References: <c78da5a0-fd60-b9fd-7607-51995c1fee8c@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c78da5a0-fd60-b9fd-7607-51995c1fee8c@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsi: Delete an error message for a failed memory allocation in fsi_probe()

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

>From dd80627d0688709a77233787a9c9d7e1f8e419ac Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 18:18:20 +0200
Subject: [PATCH] ASoC: fsi: Delete an error message for a failed memory
 allocation in fsi_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 005b21506556..1f41cf1ff830 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1962,10 +1962,8 @@ static int fsi_probe(struct platform_device *pdev)
 	}
 
 	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
-	if (!master) {
-		dev_err(&pdev->dev, "Could not allocate master\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	master->base = devm_ioremap_nocache(&pdev->dev,
 					    res->start, resource_size(res));
-- 
2.13.2
