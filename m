From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: wm8510: Convert to devm_kzalloc()
Date: Wed, 12 Sep 2012 09:32:54 +0800
Message-ID: <1347413580-11137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C1C72615E3
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 03:33:35 +0200 (CEST)
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
 sound/soc/codecs/wm8510.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 56a0495..98f28a0 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -592,7 +592,8 @@ static int __devinit wm8510_spi_probe(struct spi_device *spi)
 	struct wm8510_priv *wm8510;
 	int ret;
 
-	wm8510 = kzalloc(sizeof(struct wm8510_priv), GFP_KERNEL);
+	wm8510 = devm_kzalloc(&spi->dev, sizeof(struct wm8510_priv),
+			      GFP_KERNEL);
 	if (wm8510 == NULL)
 		return -ENOMEM;
 
@@ -601,8 +602,7 @@ static int __devinit wm8510_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_wm8510, &wm8510_dai, 1);
-	if (ret < 0)
-		kfree(wm8510);
+
 	return ret;
 }
 
@@ -630,7 +630,8 @@ static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
 	struct wm8510_priv *wm8510;
 	int ret;
 
-	wm8510 = kzalloc(sizeof(struct wm8510_priv), GFP_KERNEL);
+	wm8510 = devm_kzalloc(&i2c->dev, sizeof(struct wm8510_priv),
+			      GFP_KERNEL);
 	if (wm8510 == NULL)
 		return -ENOMEM;
 
@@ -639,8 +640,7 @@ static __devinit int wm8510_i2c_probe(struct i2c_client *i2c,
 
 	ret =  snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8510, &wm8510_dai, 1);
-	if (ret < 0)
-		kfree(wm8510);
+
 	return ret;
 }
 
-- 
1.7.10.4
