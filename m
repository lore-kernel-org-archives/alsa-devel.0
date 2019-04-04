From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 1/2] ASoC: tlv320aic32x4: Change author's name
Date: Wed,  3 Apr 2019 21:17:15 -0700
Message-ID: <20190404041716.29896-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.iad3b.emailsrvr.com (smtp121.iad3b.emailsrvr.com
 [146.20.161.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B11AF8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 06:17:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

The author of these files has changed her name.  Update
instances in the code of her dead name to current legal
name.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
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
2.19.1
