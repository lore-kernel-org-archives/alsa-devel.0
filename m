From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cirrus: tlv320aic23 needs I2C
Date: Wed, 18 Feb 2015 21:43:13 +0100
Message-ID: <5891241.bLtA2KsrYg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 98432260431
 for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2015 21:43:16 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The tlv320aic23 codec is selected by the ep93xx snapper platform,
which are missing a dependency on I2C, and that can result in this
build error, as found during randconfig builds:

.../codecs/tlv320aic23-i2c.c: In function 'tlv320aic23_i2c_probe':
.../codecs/tlv320aic23-i2c.c:27:2: error: implicit declaration of function 'i2c_check_functionality' [-Werror=implicit-function-declaration]
  if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
  ^

This adds the missing dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index 7b7fbcd49e5e..c7cd60f009e9 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -16,7 +16,7 @@ config SND_EP93XX_SOC_AC97
 
 config SND_EP93XX_SOC_SNAPPERCL15
         tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
-        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
+        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15 && I2C
         select SND_EP93XX_SOC_I2S
         select SND_SOC_TLV320AIC23_I2C
         help
