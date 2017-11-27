From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Improve two size
	determinations in cs42l56_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:42 +0000
Message-ID: <E1eJOXG-0007NP-J5@debutante>
References: <8c36fc94-1f7d-5d22-7d3a-f2f6117199aa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A0BDC26767A
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:53:58 +0100 (CET)
In-Reply-To: <8c36fc94-1f7d-5d22-7d3a-f2f6117199aa@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Improve two size determinations in cs42l56_i2c_probe()

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

>From e8d8b98c0a6edab5d6cc0292e1ed603d8d4ff5b6 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Nov 2017 09:33:15 +0100
Subject: [PATCH] ASoC: cs42l56: Improve two size determinations in
 cs42l56_i2c_probe()

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 13ee46217d78..fd7b8d32c2b2 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1190,9 +1190,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	unsigned int alpha_rev, metal_rev;
 	unsigned int reg;
 
-	cs42l56 = devm_kzalloc(&i2c_client->dev,
-			       sizeof(struct cs42l56_private),
-			       GFP_KERNEL);
+	cs42l56 = devm_kzalloc(&i2c_client->dev, sizeof(*cs42l56), GFP_KERNEL);
 	if (cs42l56 == NULL)
 		return -ENOMEM;
 	cs42l56->dev = &i2c_client->dev;
@@ -1207,8 +1205,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 	if (pdata) {
 		cs42l56->pdata = *pdata;
 	} else {
-		pdata = devm_kzalloc(&i2c_client->dev,
-				     sizeof(struct cs42l56_platform_data),
+		pdata = devm_kzalloc(&i2c_client->dev, sizeof(*pdata),
 				     GFP_KERNEL);
 		if (!pdata)
 			return -ENOMEM;
-- 
2.15.0
