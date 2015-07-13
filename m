From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: Do not print error message
	on asoc/gpio errors" to the asoc tree
Date: Mon, 13 Jul 2015 19:14:20 +0100
Message-ID: <E1ZEiFA-000333-NO@debutante>
References: <1436714061-18618-3-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42808261AE7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 20:14:28 +0200 (CEST)
In-Reply-To: <1436714061-18618-3-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: Do not print error message on asoc/gpio errors

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

>From 4ab0c591c1482c90d14c1d11bf4b469c54a31ecc Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Sun, 12 Jul 2015 08:14:21 -0700
Subject: [PATCH] ASoC: max98357a: Do not print error message on asoc/gpio
 errors

gpiolib/asoc system already prints enough info if there are any problems.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index b9e1131bab74..e88119a71b84 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -63,11 +63,9 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
 	struct gpio_desc *sdmode;
 
 	sdmode = devm_gpiod_get_optional(codec->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode)) {
-		dev_err(codec->dev, "%s() unable to get sdmode GPIO: %ld\n",
-				__func__, PTR_ERR(sdmode));
+	if (IS_ERR(sdmode))
 		return PTR_ERR(sdmode);
-	}
+
 	snd_soc_codec_set_drvdata(codec, sdmode);
 
 	return 0;
@@ -106,15 +104,8 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = snd_soc_register_codec(&pdev->dev, &max98357a_codec_driver,
+	return snd_soc_register_codec(&pdev->dev, &max98357a_codec_driver,
 			&max98357a_dai_driver, 1);
-	if (ret)
-		dev_err(&pdev->dev, "%s() error registering codec driver: %d\n",
-				__func__, ret);
-
-	return ret;
 }
 
 static int max98357a_platform_remove(struct platform_device *pdev)
-- 
2.1.4
