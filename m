From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l52: Delete an error message for a failed memory allocation in cs42l52_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:39 +0000
Message-ID: <E1eJOXD-0007MN-Jr@debutante>
References: <0c7a61a4-580e-e7ae-acef-047f8cff24ca@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c7a61a4-580e-e7ae-acef-047f8cff24ca@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l52: Delete an error message for a failed memory allocation in cs42l52_i2c_probe()

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

>From e04db58c1252305e8a4d4178a3cfdbef802cff74 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 22:08:06 +0100
Subject: [PATCH] ASoC: cs42l52: Delete an error message for a failed memory
 allocation in cs42l52_i2c_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l52.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 0d9c4a57301b..e8645f2ac0d9 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1118,10 +1118,9 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		pdata = devm_kzalloc(&i2c_client->dev,
 				     sizeof(struct cs42l52_platform_data),
 				GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&i2c_client->dev, "could not allocate pdata\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
+
 		if (i2c_client->dev.of_node) {
 			if (of_property_read_bool(i2c_client->dev.of_node,
 				"cirrus,mica-differential-cfg"))
-- 
2.15.0
