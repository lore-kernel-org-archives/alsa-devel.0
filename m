From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: wm8804: Use devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 22:27:05 -0300
Message-ID: <1398389226-18569-3-git-send-email-festevam@gmail.com>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f47.google.com (mail-yh0-f47.google.com
 [209.85.213.47])
 by alsa0.perex.cz (Postfix) with ESMTP id E2576265328
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 03:27:30 +0200 (CEST)
Received: by mail-yh0-f47.google.com with SMTP id 29so2971626yhl.20
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 18:27:30 -0700 (PDT)
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
