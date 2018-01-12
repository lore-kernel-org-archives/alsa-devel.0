From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: Remove trailing semicolon" to the asoc tree
Date: Fri, 12 Jan 2018 21:09:11 +0000
Message-ID: <E1ea6Zb-0003Cp-Gl@debutante>
References: <20180111162704.25246-1-luisbg@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111162704.25246-1-luisbg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luisbg@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: Remove trailing semicolon

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

>From ef3d687c795c82c44aef1bf25fcd4900ba60be9a Mon Sep 17 00:00:00 2001
From: Luis de Bethencourt <luisbg@kernel.org>
Date: Thu, 11 Jan 2018 16:27:04 +0000
Subject: [PATCH] ASoC: cs42l73: Remove trailing semicolon

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index dde37e569ade..aebaa97490b6 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1355,7 +1355,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	ret = regmap_read(cs42l73->regmap, CS42L73_REVID, &reg);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "Get Revision ID failed\n");
-		return ret;;
+		return ret;
 	}
 
 	dev_info(&i2c_client->dev,
-- 
2.15.1
