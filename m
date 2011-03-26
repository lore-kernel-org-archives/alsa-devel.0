From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: ad193x: tweak style to match other codecs
Date: Sat, 26 Mar 2011 03:52:20 -0400
Message-ID: <1301125940-5693-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AA152449B
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:51:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Scott Jiang <scott.jiang@analog.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

From: Scott Jiang <scott.jiang@analog.com>

Rename the snd_soc_control_type field from "bus_type" to "control_type",
and drop the now unused "control_data" field.

Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad193x.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index da46479..824529d 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -23,8 +23,7 @@
 
 /* codec private data */
 struct ad193x_priv {
-	enum snd_soc_control_type bus_type;
-	void *control_data;
+	enum snd_soc_control_type control_type;
 	int sysclk;
 };
 
@@ -354,14 +353,12 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	codec->control_data = ad193x->control_data;
-	if (ad193x->bus_type == SND_SOC_I2C)
-		ret = snd_soc_codec_set_cache_io(codec, 8, 8, ad193x->bus_type);
+	if (ad193x->control_type == SND_SOC_I2C)
+		ret = snd_soc_codec_set_cache_io(codec, 8, 8, ad193x->control_type);
 	else
-		ret = snd_soc_codec_set_cache_io(codec, 16, 8, ad193x->bus_type);
+		ret = snd_soc_codec_set_cache_io(codec, 16, 8, ad193x->control_type);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to set cache I/O: %d\n",
-				ret);
+		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
@@ -408,8 +405,7 @@ static int __devinit ad193x_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ad193x);
-	ad193x->control_data = spi;
-	ad193x->bus_type = SND_SOC_SPI;
+	ad193x->control_type = SND_SOC_SPI;
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_ad193x, &ad193x_dai, 1);
@@ -454,8 +450,7 @@ static int __devinit ad193x_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, ad193x);
-	ad193x->control_data = client;
-	ad193x->bus_type = SND_SOC_I2C;
+	ad193x->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_ad193x, &ad193x_dai, 1);
-- 
1.7.4.1
