From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8903: Improve two size determinations in wm8903_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:13 +0000
Message-ID: <E1eJOXl-0007VV-Aq@debutante>
References: <013d9ad7-a8ff-6fad-ba82-40e68cf0a601@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <013d9ad7-a8ff-6fad-ba82-40e68cf0a601@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8903: Improve two size determinations in wm8903_i2c_probe()

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

>From 017b9b35cb107c0aeaad2ad770460c49e3f71395 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 10:40:43 +0100
Subject: [PATCH] ASoC: wm8903: Improve two size determinations in
 wm8903_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8903.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 51eb7d61d446..cba90f21161f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1995,8 +1995,7 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 	unsigned int val, irq_pol;
 	int ret, i;
 
-	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
-			      GFP_KERNEL);
+	wm8903 = devm_kzalloc(&i2c->dev, sizeof(*wm8903), GFP_KERNEL);
 	if (wm8903 == NULL)
 		return -ENOMEM;
 
@@ -2017,9 +2016,8 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 	if (pdata) {
 		wm8903->pdata = pdata;
 	} else {
-		wm8903->pdata = devm_kzalloc(&i2c->dev,
-					sizeof(struct wm8903_platform_data),
-					GFP_KERNEL);
+		wm8903->pdata = devm_kzalloc(&i2c->dev, sizeof(*wm8903->pdata),
+					     GFP_KERNEL);
 		if (!wm8903->pdata)
 			return -ENOMEM;
 
-- 
2.15.0
