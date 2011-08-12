From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/3] soc/soc-io.c: Use regmap_init_{i2c,
	spi} only if it's available
Date: Fri, 12 Aug 2011 17:52:58 +0300
Message-ID: <1313160780-20633-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A3ACF1037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 16:54:03 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2506462fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2011 07:54:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we get linker error like:
ERROR: "regmap_init_spi" [sound/soc/snd-soc-core.ko] undefined!

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/soc-io.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index e471ed6..c1565e4 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -122,16 +122,18 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	config.val_bits = data_bits;
 
 	switch (control) {
+#ifdef CONFIG_REGMAP_I2C
 	case SND_SOC_I2C:
 		codec->control_data = regmap_init_i2c(to_i2c_client(codec->dev),
 						      &config);
 		break;
-
+#endif
+#ifdef CONFIG_REGMAP_SPI
 	case SND_SOC_SPI:
 		codec->control_data = regmap_init_spi(to_spi_device(codec->dev),
 						      &config);
 		break;
-
+#endif
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
 		break;
-- 
1.7.5.rc3
