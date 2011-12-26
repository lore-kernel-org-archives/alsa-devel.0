From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 02/10] ASoC: Convert ad1836 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:50:02 +0800
Message-ID: <1324903802.26543.2.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 96C2510384C
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:50:09 +0100 (CET)
Received: by iaae16 with SMTP id e16so18093631iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:50:08 -0800 (PST)
In-Reply-To: <1324903728.26543.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ad1836.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 919322d..982d201 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -341,7 +341,8 @@ static int __devinit ad1836_spi_probe(struct spi_device *spi)
 	struct ad1836_priv *ad1836;
 	int ret;
 
-	ad1836 = kzalloc(sizeof(struct ad1836_priv), GFP_KERNEL);
+	ad1836 = devm_kzalloc(&spi->dev, sizeof(struct ad1836_priv),
+			      GFP_KERNEL);
 	if (ad1836 == NULL)
 		return -ENOMEM;
 
@@ -351,17 +352,15 @@ static int __devinit ad1836_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_ad1836, &ad183x_dais[ad1836->type], 1);
-	if (ret < 0)
-		kfree(ad1836);
 	return ret;
 }
 
 static int __devexit ad1836_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
+
 static const struct spi_device_id ad1836_ids[] = {
 	{ "ad1835", AD1835 },
 	{ "ad1836", AD1836 },
-- 
1.7.5.4
