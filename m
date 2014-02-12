From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: blackfin: Fix machine driver Kconfig
	dependencies
Date: Wed, 12 Feb 2014 17:11:22 +0100
Message-ID: <1392221482-16559-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-003.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id A7522265063
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 17:11:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the machine driver selects the CODEC driver we need to make sure that the
machine driver is only selectable if the CODEC driver can be build. This avoids
build errors under some configurations (which typically only result from
randconfig).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/Kconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 54f74f8..4544d8e 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -11,7 +11,7 @@ config SND_BF5XX_I2S
 
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio Codec Add-On Card support"
-	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
+	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S if !BF60x
 	select SND_BF6XX_SOC_I2S if BF60x
 	select SND_SOC_SSM2602
@@ -21,10 +21,9 @@ config SND_BF5XX_SOC_SSM2602
 
 config SND_SOC_BFIN_EVAL_ADAU1701
 	tristate "Support for the EVAL-ADAU1701MINIZ board on Blackfin eval boards"
-	depends on SND_BF5XX_I2S
+	depends on SND_BF5XX_I2S && I2C
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_ADAU1701
-	select I2C
 	help
 	  Say Y if you want to add support for the Analog Devices EVAL-ADAU1701MINIZ
 	  board connected to one of the Blackfin evaluation boards like the
@@ -45,7 +44,7 @@ config SND_SOC_BFIN_EVAL_ADAU1373
 
 config SND_SOC_BFIN_EVAL_ADAV80X
 	tristate "Support for the EVAL-ADAV80X boards on Blackfin eval boards"
-	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
+	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_ADAV80X
 	help
@@ -58,7 +57,7 @@ config SND_SOC_BFIN_EVAL_ADAV80X
 
 config SND_BF5XX_SOC_AD1836
 	tristate "SoC AD1836 Audio support for BF5xx"
-	depends on SND_BF5XX_I2S
+	depends on SND_BF5XX_I2S && SPI_MASTER
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_AD1836
 	help
@@ -66,7 +65,7 @@ config SND_BF5XX_SOC_AD1836
 
 config SND_BF5XX_SOC_AD193X
 	tristate "SoC AD193X Audio support for Blackfin"
-	depends on SND_BF5XX_I2S
+	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S
 	select SND_SOC_AD193X
 	help
-- 
1.8.0
