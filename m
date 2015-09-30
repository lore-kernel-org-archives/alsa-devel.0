From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: balance pm_runtime_enable" to
	the asoc tree
Date: Wed, 30 Sep 2015 20:32:18 +0100
Message-ID: <E1ZhN6w-00063j-UJ@finisterre>
References: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDBF326646A
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:32:26 +0200 (CEST)
In-Reply-To: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: balance pm_runtime_enable

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

>From 57622aef86d21d459e937c72f578050ff4a91af5 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Wed, 30 Sep 2015 13:54:13 +0900
Subject: [PATCH] ASoC: wm8962: balance pm_runtime_enable

pm_runtime_enable is called in probe to enable runtime PM
for wm8962 codec, but pm_runtime_disable isn't called in remove
callback, nor is called in error path if probe fails after runtime
PM is enabled, this causes unbalanced pm_runtime_enable.

This patch Adds pm_runtime_disable in remove callback and error path,
to balance pm_runtime_enable.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4eb975..85a2c54 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3759,7 +3759,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
 	if (ret < 0)
-		goto err_enable;
+		goto err_pm_runtime;
 
 	regcache_cache_only(wm8962->regmap, true);
 
@@ -3768,6 +3768,8 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 
 	return 0;
 
+err_pm_runtime:
+	pm_runtime_disable(&i2c->dev);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 err:
@@ -3777,6 +3779,7 @@ err:
 static int wm8962_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
+	pm_runtime_disable(&client->dev);
 	return 0;
 }
 
-- 
2.5.0
