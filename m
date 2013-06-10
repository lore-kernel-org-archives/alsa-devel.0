From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: adav80x: Select SND_SOC_ADAV80X if
	SND_SOC_I2C_AND_SPI
Date: Mon, 10 Jun 2013 21:20:44 +0800
Message-ID: <1370870444.14367.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 583C72615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:20:50 +0200 (CEST)
Received: by mail-pa0-f50.google.com with SMTP id fb1so4416676pad.9
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 06:20:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Yi Li <yi.li@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This driver is useless if both SPI and I2C are not configured.
Thus don't build this driver if both SPI and I2C are not configured.

This patch silences below build warning if both SPI and I2C are not configured.

  CC      sound/soc/codecs/adav80x.o
sound/soc/codecs/adav80x.c:842:12: warning: 'adav80x_bus_probe' defined but not used [-Wunused-function]
sound/soc/codecs/adav80x.c:863:12: warning: 'adav80x_bus_remove' defined but not used [-Wunused-function]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c90d298..6234900 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -19,7 +19,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
-	select SND_SOC_ADAV80X
+	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
-- 
1.8.1.2
