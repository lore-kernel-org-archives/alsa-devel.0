From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2000: Improve a size determination in wm2000_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:54:32 +0000
Message-ID: <E1eJOY4-0007Xr-IK@debutante>
References: <a6e50094-3d1c-6ad4-67e4-377036f5ccd6@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a6e50094-3d1c-6ad4-67e4-377036f5ccd6@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2000: Improve a size determination in wm2000_i2c_probe()

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

>From bf0842ba3afa85d37b35e65dedec9a994988e346 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 08:18:14 +0100
Subject: [PATCH] ASoC: wm2000: Improve a size determination in
 wm2000_i2c_probe()

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 480ceb07c3ed..abfa052c07d8 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -826,8 +826,7 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 	int reg;
 	u16 id;
 
-	wm2000 = devm_kzalloc(&i2c->dev, sizeof(struct wm2000_priv),
-			      GFP_KERNEL);
+	wm2000 = devm_kzalloc(&i2c->dev, sizeof(*wm2000), GFP_KERNEL);
 	if (!wm2000)
 		return -ENOMEM;
 
-- 
2.15.0
