From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Relocate my e-mail to .com domain zone" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Message-ID: <20190710153449.52CE3D02DA0@fitzroy.sirena.org.uk>
References: <20190710055135.21377-1-kmarinushkin@birdec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710055135.21377-1-kmarinushkin@birdec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Relocate my e-mail to .com domain zone

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9e944c9be2456159fb8c36b0ba3170b2f01c3887 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.com>
Date: Wed, 10 Jul 2019 07:51:35 +0200
Subject: [PATCH] ASoC: Relocate my e-mail to .com domain zone

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
Link: https://lore.kernel.org/r/20190710055135.21377-1-kmarinushkin@birdec.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                    | 2 +-
 sound/soc/codecs/pcm3060-i2c.c | 4 ++--
 sound/soc/codecs/pcm3060-spi.c | 4 ++--
 sound/soc/codecs/pcm3060.c     | 4 ++--
 sound/soc/codecs/pcm3060.h     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e75361f9b3b..11db05b56744 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15795,7 +15795,7 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/netcp*
 
 TI PCM3060 ASoC CODEC DRIVER
-M:	Kirill Marinushkin <kmarinushkin@birdec.tech>
+M:	Kirill Marinushkin <kmarinushkin@birdec.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/pcm3060.txt
diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index cdc8314882bc..abcdeb922201 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 I2C driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -56,5 +56,5 @@ static struct i2c_driver pcm3060_i2c_driver = {
 module_i2c_driver(pcm3060_i2c_driver);
 
 MODULE_DESCRIPTION("PCM3060 I2C driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index f6f19fa80932..3b79734b832b 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 SPI driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
@@ -55,5 +55,5 @@ static struct spi_driver pcm3060_spi_driver = {
 module_spi_driver(pcm3060_spi_driver);
 
 MODULE_DESCRIPTION("PCM3060 SPI driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 32b26f1c2282..b2358069cf9b 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -2,7 +2,7 @@
 //
 // PCM3060 codec driver
 //
-// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
@@ -342,5 +342,5 @@ int pcm3060_probe(struct device *dev)
 EXPORT_SYMBOL(pcm3060_probe);
 
 MODULE_DESCRIPTION("PCM3060 codec driver");
-MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 75931c9a9d85..18d51e5dac2c 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -2,7 +2,7 @@
 /*
  * PCM3060 codec driver
  *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.com>
  */
 
 #ifndef _SND_SOC_PCM3060_H
-- 
2.20.1
