From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nuc900: Fix platform_get_irq() error checking some more" to the asoc tree
Date: Mon, 11 Dec 2017 12:14:27 +0000
Message-ID: <E1eOMyZ-0004f5-IZ@debutante>
References: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171209115203.pdtdfnmzwz6zpjqs@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nuc900: Fix platform_get_irq() error checking some more

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

>From cd430a244cd5d3ca0f4053718eabdf42bc12c517 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 9 Dec 2017 14:52:03 +0300
Subject: [PATCH] ASoC: nuc900: Fix platform_get_irq() error checking some more

The error handling doesn't work here because "nuc900_audio->irq_num" is
unsigned.  Also we should be checking for < 0 and not <= 0 but I believe
that's harmless.  The platform_get_irq() comments don't talk about the
return values...

Fixes: fa8cc38165c2 ("ASoC: nuc900: Fix platform_get_irq's error checking")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/nuc900/nuc900-ac97.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index 5e4fbd2d3479..71fce7c85c93 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 		goto out;
 	}
 
-	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (nuc900_audio->irq_num <= 0) {
-		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto out;
-	}
+	nuc900_audio->irq_num = ret;
 
 	nuc900_ac97_data = nuc900_audio;
 
-- 
2.15.1

