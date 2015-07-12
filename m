From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 3/3] ASoC: max98357a: Do not print error
	message on gpio get
Date: Sat, 11 Jul 2015 23:56:42 -0700
Message-ID: <1436684202-16461-3-git-send-email-anatol.pomozov@gmail.com>
References: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D79D426064F
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:57:20 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so14755090pac.3
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 23:57:20 -0700 (PDT)
In-Reply-To: <1436684202-16461-1-git-send-email-anatol.pomozov@gmail.com>
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

gpiolib system already prints enough info if there are any problems with
the gpio.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/max98357a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 0d87d35..d669b0c 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -64,11 +64,9 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
 	struct gpio_desc *sdmode;
 
 	sdmode = devm_gpiod_get(codec->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode) && (PTR_ERR(sdmode) != -ENOENT)) {
-		dev_err(codec->dev, "%s() unable to get sdmode GPIO: %ld\n",
-				__func__, PTR_ERR(sdmode));
+	if (IS_ERR(sdmode) && (PTR_ERR(sdmode) != -ENOENT))
 		return PTR_ERR(sdmode);
-	}
+
 	snd_soc_codec_set_drvdata(codec, sdmode);
 
 	return 0;
-- 
2.4.5
