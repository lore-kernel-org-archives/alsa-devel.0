From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l32: Delete two error messages for
	a failed memory allocation in cs35l32_i2c_probe()" to the asoc tree
Date: Mon, 27 Nov 2017 18:53:02 +0000
Message-ID: <E1eJOWc-00079F-RT@debutante>
References: <8980f9c6-f559-816f-9ec8-e22194e0f3aa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C178267614
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:53:18 +0100 (CET)
In-Reply-To: <8980f9c6-f559-816f-9ec8-e22194e0f3aa@users.sourceforge.net>
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

   ASoC: cs35l32: Delete two error messages for a failed memory allocation in cs35l32_i2c_probe()

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

>From 410afed04b130fc1c22f82b10b20aed1636d2f15 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Nov 2017 20:35:06 +0100
Subject: [PATCH] ASoC: cs35l32: Delete two error messages for a failed memory
 allocation in cs35l32_i2c_probe()

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l32.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l32.c b/sound/soc/codecs/cs35l32.c
index 7e9806206648..e41d8ebe6eea 100644
--- a/sound/soc/codecs/cs35l32.c
+++ b/sound/soc/codecs/cs35l32.c
@@ -358,10 +358,8 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 
 	cs35l32 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs35l32_private),
 			       GFP_KERNEL);
-	if (!cs35l32) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
+	if (!cs35l32)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(i2c_client, cs35l32);
 
@@ -378,10 +376,9 @@ static int cs35l32_i2c_probe(struct i2c_client *i2c_client,
 		pdata = devm_kzalloc(&i2c_client->dev,
 				     sizeof(struct cs35l32_platform_data),
 				GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&i2c_client->dev, "could not allocate pdata\n");
+		if (!pdata)
 			return -ENOMEM;
-		}
+
 		if (i2c_client->dev.of_node) {
 			ret = cs35l32_handle_of_data(i2c_client,
 						     &cs35l32->pdata);
-- 
2.15.0
