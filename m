From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l34: Improve two size determinations in cs35l34_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:53 +0000
Message-ID: <E1eJOWT-00075X-RW@debutante>
References: <044cfc92-158f-3bff-a2e6-4993a9070e13@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <044cfc92-158f-3bff-a2e6-4993a9070e13@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l34: Improve two size determinations in cs35l34_i2c_probe()

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

>From 7f9f3abd285433e224faaf854b165b189270c923 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 21:17:42 +0100
Subject: [PATCH] ASoC: cs35l34: Improve two size determinations in
 cs35l34_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l34.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 6cbdbbe53940..0600d5264c4c 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -1004,9 +1004,7 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int devid = 0;
 	unsigned int reg;
 
-	cs35l34 = devm_kzalloc(&i2c_client->dev,
-			       sizeof(struct cs35l34_private),
-			       GFP_KERNEL);
+	cs35l34 = devm_kzalloc(&i2c_client->dev, sizeof(*cs35l34), GFP_KERNEL);
 	if (!cs35l34)
 		return -ENOMEM;
 
@@ -1042,9 +1040,8 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs35l34->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				sizeof(struct cs35l34_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
2.15.0
