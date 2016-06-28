From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Remove unnecessary free_irq
	call" to the asoc tree
Date: Tue, 28 Jun 2016 20:56:23 +0100
Message-ID: <E1bHz7P-0005YY-Ug@debutante>
References: <1467103218.25747.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 627572673AB
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 21:56:35 +0200 (CEST)
In-Reply-To: <1467103218.25747.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: Remove unnecessary free_irq call

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From beefe4a9f45a745d8518872596e8e3271dbf426b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 28 Jun 2016 16:40:18 +0800
Subject: [PATCH] ASoC: cs35l33: Remove unnecessary free_irq call

Current code uses devm_request_threaded_irq() so it does not need to
explicitly call free_irq() in .probe error path and .remove.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 55c1f758c110..90dc743a8378 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1195,7 +1195,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev,
 			"Failed to enable core supplies: %d\n",
 			ret);
-		goto err_irq;
+		return ret;
 	}
 
 	if (cs35l33->reset_gpio)
@@ -1251,7 +1251,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "%s: Register codec failed\n",
 			__func__);
-		goto err_irq;
+		goto err_enable;
 	}
 
 	return 0;
@@ -1259,8 +1259,6 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 err_enable:
 	regulator_bulk_disable(cs35l33->num_core_supplies,
 			       cs35l33->core_supplies);
-err_irq:
-	free_irq(i2c_client->irq, cs35l33);
 
 	return ret;
 }
@@ -1277,7 +1275,6 @@ static int cs35l33_i2c_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(cs35l33->num_core_supplies,
 		cs35l33->core_supplies);
-	free_irq(client->irq, cs35l33);
 
 	return 0;
 }
-- 
2.8.1
