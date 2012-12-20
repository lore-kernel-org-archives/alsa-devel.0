From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Convert to
	devm_input_allocate_device()
Date: Thu, 20 Dec 2012 13:18:26 +0000
Message-ID: <1356009506-4766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 293782615FA
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 14:18:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 50b0983..1cee9b3 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3189,7 +3189,7 @@ static void wm8962_init_beep(struct snd_soc_codec *codec)
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	wm8962->beep = input_allocate_device();
+	wm8962->beep = devm_input_allocate_device(codec->dev);
 	if (!wm8962->beep) {
 		dev_err(codec->dev, "Failed to allocate beep device\n");
 		return;
@@ -3210,7 +3210,6 @@ static void wm8962_init_beep(struct snd_soc_codec *codec)
 
 	ret = input_register_device(wm8962->beep);
 	if (ret != 0) {
-		input_free_device(wm8962->beep);
 		wm8962->beep = NULL;
 		dev_err(codec->dev, "Failed to register beep device\n");
 	}
@@ -3227,7 +3226,6 @@ static void wm8962_free_beep(struct snd_soc_codec *codec)
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 
 	device_remove_file(codec->dev, &dev_attr_beep);
-	input_unregister_device(wm8962->beep);
 	cancel_work_sync(&wm8962->beep_work);
 	wm8962->beep = NULL;
 
-- 
1.7.10.4
