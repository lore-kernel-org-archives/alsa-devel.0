From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8903: Delete an error message for a failed memory allocation in wm8903_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:16 +0000
Message-ID: <E1eJOXo-0007Wb-Ba@debutante>
References: <52cba9de-be47-1518-20fc-897967686bf8@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52cba9de-be47-1518-20fc-897967686bf8@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8903: Delete an error message for a failed memory allocation in wm8903_i2c_probe()

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

>From cce7c0ac44832225ca86afff308cf6a5fb19cf2c Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 10:05:43 +0100
Subject: [PATCH] ASoC: wm8903: Delete an error message for a failed memory
 allocation in wm8903_i2c_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8903.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 237eeb9a8b97..51eb7d61d446 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -2020,10 +2020,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 		wm8903->pdata = devm_kzalloc(&i2c->dev,
 					sizeof(struct wm8903_platform_data),
 					GFP_KERNEL);
-		if (wm8903->pdata == NULL) {
-			dev_err(&i2c->dev, "Failed to allocate pdata\n");
+		if (!wm8903->pdata)
 			return -ENOMEM;
-		}
 
 		if (i2c->irq) {
 			ret = wm8903_set_pdata_irq_trigger(i2c, wm8903->pdata);
-- 
2.15.0
