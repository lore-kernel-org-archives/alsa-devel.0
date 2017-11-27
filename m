From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl4030: Delete an error message for a failed memory allocation in twl4030_get_pdata()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:04 +0000
Message-ID: <E1eJOXc-0007U4-Uk@debutante>
References: <5e96623c-ad1f-5260-2580-f487e64abaf8@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e96623c-ad1f-5260-2580-f487e64abaf8@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl4030: Delete an error message for a failed memory allocation in twl4030_get_pdata()

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

>From 2dbb29cd977fc281f71f8895abce7e382efe77e1 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 21:30:07 +0100
Subject: [PATCH] ASoC: twl4030: Delete an error message for a failed memory
 allocation in twl4030_get_pdata()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl4030.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index cfe72b9d4356..90691701b082 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -240,7 +240,6 @@ static struct twl4030_codec_data *twl4030_get_pdata(struct snd_soc_codec *codec)
 				     sizeof(struct twl4030_codec_data),
 				     GFP_KERNEL);
 		if (!pdata) {
-			dev_err(codec->dev, "Can not allocate memory\n");
 			of_node_put(twl4030_codec_node);
 			return NULL;
 		}
-- 
2.15.0
