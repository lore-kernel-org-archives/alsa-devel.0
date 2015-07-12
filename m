From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 3/3] ASoC: max98357a: Do not print error
	message on asoc/gpio errors
Date: Sun, 12 Jul 2015 08:14:21 -0700
Message-ID: <1436714061-18618-3-git-send-email-anatol.pomozov@gmail.com>
References: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E0BC2605C7
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 17:14:47 +0200 (CEST)
Received: by pdjr16 with SMTP id r16so48469483pdj.3
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:14:45 -0700 (PDT)
In-Reply-To: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lars@metafoo.de, kwestfie@codeaurora.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

gpiolib/asoc system already prints enough info if there are any problems.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/max98357a.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index b9e1131..e88119a 100644
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
2.4.5
