From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: Improve two size determinations in cs35l32_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:59 +0000
Message-ID: <E1eJOWZ-00077Z-Qt@debutante>
References: <521550ca-c13e-e647-5bbe-d8b172a6445b@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <521550ca-c13e-e647-5bbe-d8b172a6445b@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l32: Improve two size determinations in cs35l32_i2c_probe()

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

>From b28ad41ec831b099dccac1f84a9cfb40b0650724 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 20:40:47 +0100
Subject: [PATCH] ASoC: cs35l32: Improve two size determinations in
 cs35l32_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index e41d8ebe6eea..bc3a72e4c4ed 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -355,9 +355,7 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int devid = 0;
 	unsigned int reg;
 
-
-	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs35l32_private),
-			       GFP_KERNEL);
+	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(*cs35l32), GFP_KERNEL);
 	if (!cs35l32)
 		return -ENOMEM;
 
@@ -373,9 +371,8 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs35l32->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs35l32_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
2.15.0
