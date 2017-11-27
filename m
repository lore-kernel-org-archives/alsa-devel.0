From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l52: Improve two size determinations in cs42l52_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:34 +0000
Message-ID: <E1eJOX8-0007LK-PK@debutante>
References: <d02ceefc-8918-f24d-6de7-8c6f348d5ed9@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d02ceefc-8918-f24d-6de7-8c6f348d5ed9@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l52: Improve two size determinations in cs42l52_i2c_probe()

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

>From cd9e0b8282653d8bdc2c8b799eeb26ee034cdd06 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 22:11:30 +0100
Subject: [PATCH] ASoC: cs42l52: Improve two size determinations in
 cs42l52_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l52.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index e8645f2ac0d9..9731e5dff291 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1100,8 +1100,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int reg;
 	u32 val32;
 
-	cs42l52 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l52_private),
-			       GFP_KERNEL);
+	cs42l52 = devm_kzalloc(&i2c_client->dev, sizeof(*cs42l52), GFP_KERNEL);
 	if (cs42l52 == NULL)
 		return -ENOMEM;
 	cs42l52->dev = &i2c_client->dev;
@@ -1115,9 +1114,8 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs42l52->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs42l52_platform_data),
-				GFP_KERNEL);
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
+				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
 
-- 
2.15.0
