From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Delete an error message for a failed memory allocation in cs42l56_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:45 +0000
Message-ID: <E1eJOXJ-0007OU-Mg@debutante>
References: <23adac87-3c2b-a264-348a-aaf7cbba5420@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23adac87-3c2b-a264-348a-aaf7cbba5420@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Delete an error message for a failed memory allocation in cs42l56_i2c_probe()

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

>From 277631ccff503f2a8e8150574c9773a8383fc926 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 09:26:08 +0100
Subject: [PATCH] ASoC: cs42l56: Delete an error message for a failed memory
 allocation in cs42l56_i2c_probe()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index cb6ca85f1536..13ee46217d78 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1210,11 +1210,9 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 		pdata = devm_kzalloc(&i2c_client->dev,
 				     sizeof(struct cs42l56_platform_data),
 				     GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&i2c_client->dev,
-				"could not allocate pdata\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
+
 		if (i2c_client->dev.of_node) {
 			ret = cs42l56_handle_of_data(i2c_client,
 						     &cs42l56->pdata);
-- 
2.15.0
