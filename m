From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: Improve two size determinations in cs42l73_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:08 +0000
Message-ID: <E1eJOWi-0007BO-Qa@debutante>
References: <7229b291-d1e3-6269-4c68-435bbdffb0fd@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7229b291-d1e3-6269-4c68-435bbdffb0fd@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: Improve two size determinations in cs42l73_i2c_probe()

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

>From 68fa08c665e51b2fe100876692e57bca3aea7711 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 16:07:42 +0100
Subject: [PATCH] ASoC: cs42l73: Improve two size determinations in
 cs42l73_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 978cfbbad408..dde37e569ade 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1289,8 +1289,7 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int reg;
 	u32 val32;
 
-	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l73_private),
-			       GFP_KERNEL);
+	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(*cs42l73), GFP_KERNEL);
 	if (!cs42l73)
 		return -ENOMEM;
 
@@ -1304,9 +1303,8 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs42l73->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs42l73_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
2.15.0
