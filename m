From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Change author's name" to
	the asoc tree
Date: Thu,  4 Apr 2019 13:04:30 +0700 (+07)
Message-ID: <20190404060430.CA83A441D3C@finisterre.ee.mobilebroadband>
References: <20190404041716.29896-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E486DF8971F
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 08:04:34 +0200 (CEST)
In-Reply-To: <20190404041716.29896-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: team@nwdigitalradio.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Change author's name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7297ba6c74c5b9e78d8e936af82eecfcf7d32dfb Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Wed, 3 Apr 2019 21:17:15 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Change author's name

The author of these files has changed her name.  Update
instances in the code of her dead name to current legal
name.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4-i2c.c | 4 ++--
 sound/soc/codecs/tlv320aic32x4-spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 385fa2e9525a..22c3a6bc0b6c 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -3,7 +3,7 @@
  *
  * Copyright 2011 NW Digital Radio
  *
- * Author: Jeremy McDermond <nh6z@nh6z.net>
+ * Author: Annaliese McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
  *
@@ -72,5 +72,5 @@ static struct i2c_driver aic32x4_i2c_driver = {
 module_i2c_driver(aic32x4_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC TLV320AIC32x4 codec driver I2C");
-MODULE_AUTHOR("Jeremy McDermond <nh6z@nh6z.net>");
+MODULE_AUTHOR("Annaliese McDermond <nh6z@nh6z.net>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index 07d78ae51e05..aa5b7ba0254b 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -3,7 +3,7 @@
  *
  * Copyright 2011 NW Digital Radio
  *
- * Author: Jeremy McDermond <nh6z@nh6z.net>
+ * Author: Annaliese McDermond <nh6z@nh6z.net>
  *
  * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
  *
@@ -74,5 +74,5 @@ static struct spi_driver aic32x4_spi_driver = {
 module_spi_driver(aic32x4_spi_driver);
 
 MODULE_DESCRIPTION("ASoC TLV320AIC32x4 codec driver SPI");
-MODULE_AUTHOR("Jeremy McDermond <nh6z@nh6z.net>");
+MODULE_AUTHOR("Annaliese McDermond <nh6z@nh6z.net>");
 MODULE_LICENSE("GPL");
-- 
2.20.1
