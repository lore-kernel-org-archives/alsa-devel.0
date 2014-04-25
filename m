From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 22:27:04 -0300
Message-ID: <1398389226-18569-2-git-send-email-festevam@gmail.com>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B511265327
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 03:27:28 +0200 (CEST)
Received: by mail-yh0-f45.google.com with SMTP id a41so3001041yho.32
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 18:27:28 -0700 (PDT)
In-Reply-To: <1398389226-18569-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
do not need to call regulator_bulk_free() in the error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/c.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 763b265..5ada616 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -586,7 +586,7 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8731->supplies); i++)
 		wm8731->supplies[i].supply = wm8731_supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8731->supplies),
+	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8731->supplies),
 				 wm8731->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
@@ -597,7 +597,7 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 				    wm8731->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_regulator_get;
+		return ret;
 	}
 
 	ret = wm8731_reset(codec);
@@ -624,8 +624,6 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 
 err_regulator_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-err_regulator_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
 	return ret;
 }
@@ -638,7 +636,6 @@ static int wm8731_remove(struct snd_soc_codec *codec)
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-	regulator_bulk_free(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
 	return 0;
 }
-- 
1.8.3.2
