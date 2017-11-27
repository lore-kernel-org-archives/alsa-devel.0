From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: Delete an error message for a failed memory allocation in wm0010_boot()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:05 +0000
Message-ID: <E1eJOWf-0007AM-Rf@debutante>
References: <fcfdbb1f-5b43-f430-dee9-61b86d6cfc79@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fcfdbb1f-5b43-f430-dee9-61b86d6cfc79@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Corentin Labbe <clabbe.montjoie@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: Delete an error message for a failed memory allocation in wm0010_boot()

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

>From 316c85c3db55588893f51907de3424f85020f0eb Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 17:17:48 +0100
Subject: [PATCH] ASoC: wm0010: Delete an error message for a failed memory
 allocation in wm0010_boot()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4f5f5710b569..0147d2fb7b0a 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -655,11 +655,8 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 		ret = -ENOMEM;
 		len = pll_rec.length + 8;
 		out = kzalloc(len, GFP_KERNEL | GFP_DMA);
-		if (!out) {
-			dev_err(codec->dev,
-				"Failed to allocate RX buffer\n");
+		if (!out)
 			goto abort;
-		}
 
 		img_swap = kzalloc(len, GFP_KERNEL | GFP_DMA);
 		if (!img_swap)
-- 
2.15.0
