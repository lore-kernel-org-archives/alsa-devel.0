From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: Convert to use devm_* API"
	to the asoc tree
Date: Thu, 14 Jul 2016 17:32:30 +0100
Message-ID: <E1bNjYs-0001ac-IG@debutante>
References: <1466038700.8790.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B38266738
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:42 +0200 (CEST)
In-Reply-To: <1466038700.8790.1.camel@ingics.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: Convert to use devm_* API

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

>From e9802c579399904bfef828e1a77b777b96ea33db Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 14 Jul 2016 16:57:05 +0800
Subject: [PATCH] ASoC: rt5514-spi: Convert to use devm_* API

Use devm_* API to simplify the code.
This patch also fixes the return value in probe error paths.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 743f509d48b7..77ff8ebe6dfb 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -410,33 +410,21 @@ static int rt5514_spi_probe(struct spi_device *spi)
 
 	rt5514_spi = spi;
 
-	ret = snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
+	ret = devm_snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register platform.\n");
-		goto err_plat;
+		return ret;
 	}
 
-	ret = snd_soc_register_component(&spi->dev, &rt5514_spi_dai_component,
-					 &rt5514_spi_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+					      &rt5514_spi_dai_component,
+					      &rt5514_spi_dai, 1);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register component.\n");
-		goto err_comp;
+		return ret;
 	}
 
 	return 0;
-err_comp:
-	snd_soc_unregister_platform(&spi->dev);
-err_plat:
-
-	return 0;
-}
-
-static int rt5514_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_component(&spi->dev);
-	snd_soc_unregister_platform(&spi->dev);
-
-	return 0;
 }
 
 static const struct of_device_id rt5514_of_match[] = {
@@ -451,7 +439,6 @@ static struct spi_driver rt5514_spi_driver = {
 		.of_match_table = of_match_ptr(rt5514_of_match),
 	},
 	.probe = rt5514_spi_probe,
-	.remove = rt5514_spi_remove,
 };
 module_spi_driver(rt5514_spi_driver);
 
-- 
2.8.1
