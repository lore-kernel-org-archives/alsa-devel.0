From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Improve a size determination in da7218_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:56 +0000
Message-ID: <E1eJOXU-0007Ry-N8@debutante>
References: <8f6b7c8c-f1eb-47c7-c11f-731aa8051863@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8f6b7c8c-f1eb-47c7-c11f-731aa8051863@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, support.opensource@diasemi.comAdam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Improve a size determination in da7218_i2c_probe()

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

>From 392b79e20b41cfdc174d31bd4b004bbd874de4d9 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 20:50:44 +0100
Subject: [PATCH] ASoC: da7218: Improve a size determination in
 da7218_i2c_probe()

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 25ab7443d803..96c644a15b11 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -3269,8 +3269,7 @@ static int da7218_i2c_probe(struct i2c_client *i2c,
 	struct da7218_priv *da7218;
 	int ret;
 
-	da7218 = devm_kzalloc(&i2c->dev, sizeof(struct da7218_priv),
-			      GFP_KERNEL);
+	da7218 = devm_kzalloc(&i2c->dev, sizeof(*da7218), GFP_KERNEL);
 	if (!da7218)
 		return -ENOMEM;
 
-- 
2.15.0
