From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8804: Use devm_regulator_bulk_get()
Date: Wed, 30 Apr 2014 09:50:39 -0300
Message-ID: <1398862240-4432-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f170.google.com (mail-yk0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E3B83261AA4
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 14:50:51 +0200 (CEST)
Received: by mail-yk0-f170.google.com with SMTP id 79so1432821ykr.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 05:50:50 -0700 (PDT)
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
 sound/soc/codecs/wm8804.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 589455c..bbcad9f 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -535,7 +535,6 @@ static int wm8804_remove(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); ++i)
 		regulator_unregister_notifier(wm8804->supplies[i].consumer,
 					      &wm8804->disable_nb[i]);
-	regulator_bulk_free(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
 	return 0;
 }
 
@@ -549,7 +548,7 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8804->supplies); i++)
 		wm8804->supplies[i].supply = wm8804_supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8804->supplies),
+	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8804->supplies),
 				 wm8804->supplies);
 	if (ret) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
@@ -574,7 +573,7 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 				    wm8804->supplies);
 	if (ret) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_reg_get;
+		return ret;
 	}
 
 	id1 = snd_soc_read(codec, WM8804_RST_DEVID1);
@@ -619,8 +618,6 @@ static int wm8804_probe(struct snd_soc_codec *codec)
 
 err_reg_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
-err_reg_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8804->supplies), wm8804->supplies);
 	return ret;
 }
 
-- 
1.8.3.2
