From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: codecs: Remove "select
	REGMAP_SPI/REGMAP_I2C"
Date: Thu, 16 Jun 2016 22:00:12 +0300
Message-ID: <1466103612-8424-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 235BD265795
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 21:00:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

REGMAP_SPI and REGMAP_I2C is selected automatically by SND_SOC,
so no additional actions is required.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/codecs/Kconfig | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4d82a58..1e03fa0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -288,12 +288,10 @@ config SND_SOC_ADAU1761
 config SND_SOC_ADAU1761_I2C
 	tristate
 	select SND_SOC_ADAU1761
-	select REGMAP_I2C
 
 config SND_SOC_ADAU1761_SPI
 	tristate
 	select SND_SOC_ADAU1761
-	select REGMAP_SPI
 
 config SND_SOC_ADAU1781
 	select SND_SOC_ADAU17X1
@@ -302,12 +300,10 @@ config SND_SOC_ADAU1781
 config SND_SOC_ADAU1781_I2C
 	tristate
 	select SND_SOC_ADAU1781
-	select REGMAP_I2C
 
 config SND_SOC_ADAU1781_SPI
 	tristate
 	select SND_SOC_ADAU1781
-	select REGMAP_SPI
 
 config SND_SOC_ADAU1977
 	tristate
@@ -315,12 +311,10 @@ config SND_SOC_ADAU1977
 config SND_SOC_ADAU1977_SPI
 	tristate
 	select SND_SOC_ADAU1977
-	select REGMAP_SPI
 
 config SND_SOC_ADAU1977_I2C
 	tristate
 	select SND_SOC_ADAU1977
-	select REGMAP_I2C
 
 config SND_SOC_ADAV80X
 	tristate
@@ -403,7 +397,6 @@ config SND_SOC_CS42L73
 config SND_SOC_CS4265
 	tristate "Cirrus Logic CS4265 CODEC"
 	depends on I2C
-	select REGMAP_I2C
 
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
@@ -425,13 +418,11 @@ config SND_SOC_CS4271_I2C
 	tristate "Cirrus Logic CS4271 CODEC (I2C)"
 	depends on I2C
 	select SND_SOC_CS4271
-	select REGMAP_I2C
 
 config SND_SOC_CS4271_SPI
 	tristate "Cirrus Logic CS4271 CODEC (SPI)"
 	depends on SPI_MASTER
 	select SND_SOC_CS4271
-	select REGMAP_SPI
 
 config SND_SOC_CS42XX8
 	tristate
@@ -440,7 +431,6 @@ config SND_SOC_CS42XX8_I2C
 	tristate "Cirrus Logic CS42448/CS42888 CODEC (I2C)"
 	depends on I2C
 	select SND_SOC_CS42XX8
-	select REGMAP_I2C
 
 # Cirrus Logic CS4349 HiFi DAC
 config SND_SOC_CS4349
@@ -580,13 +570,11 @@ config SND_SOC_PCM3168A_I2C
 	tristate "Texas Instruments PCM3168A CODEC - I2C"
 	depends on I2C
 	select SND_SOC_PCM3168A
-	select REGMAP_I2C
 
 config SND_SOC_PCM3168A_SPI
 	tristate "Texas Instruments PCM3168A CODEC - SPI"
 	depends on SPI_MASTER
 	select SND_SOC_PCM3168A
-	select REGMAP_SPI
 
 config SND_SOC_PCM5102A
 	tristate
@@ -598,13 +586,11 @@ config SND_SOC_PCM512x_I2C
 	tristate "Texas Instruments PCM512x CODECs - I2C"
 	depends on I2C
 	select SND_SOC_PCM512x
-	select REGMAP_I2C
 
 config SND_SOC_PCM512x_SPI
 	tristate "Texas Instruments PCM512x CODECs - SPI"
 	depends on SPI_MASTER
 	select SND_SOC_PCM512x
-	select REGMAP_SPI
 
 config SND_SOC_RL6231
 	tristate
@@ -668,7 +654,6 @@ config SND_SOC_RT5670
 
 config SND_SOC_RT5677
 	tristate
-	select REGMAP_I2C
 	select REGMAP_IRQ
 
 config SND_SOC_RT5677_SPI
@@ -715,13 +700,11 @@ config SND_SOC_SSM2602_SPI
 	tristate "Analog Devices SSM2602 CODEC - SPI"
 	depends on SPI_MASTER
 	select SND_SOC_SSM2602
-	select REGMAP_SPI
 
 config SND_SOC_SSM2602_I2C
 	tristate "Analog Devices SSM2602 CODEC - I2C"
 	depends on I2C
 	select SND_SOC_SSM2602
-	select REGMAP_I2C
 
 config SND_SOC_SSM4567
 	tristate "Analog Devices ssm4567 amplifier driver support"
@@ -730,7 +713,6 @@ config SND_SOC_SSM4567
 config SND_SOC_STA32X
 	tristate "STA326, STA328 and STA329 speaker amplifier"
 	depends on I2C
-	select REGMAP_I2C
 
 config SND_SOC_STA350
 	tristate "STA350 speaker amplifier"
@@ -788,7 +770,6 @@ config SND_SOC_TLV320AIC26
 config SND_SOC_TLV320AIC31XX
 	tristate "Texas Instruments TLV320AIC31xx CODECs"
 	depends on I2C
-	select REGMAP_I2C
 
 config SND_SOC_TLV320AIC32X4
 	tristate
@@ -918,13 +899,11 @@ config SND_SOC_WM8804_I2C
 	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver I2C"
 	depends on I2C
 	select SND_SOC_WM8804
-	select REGMAP_I2C
 
 config SND_SOC_WM8804_SPI
 	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver SPI"
 	depends on SPI_MASTER
 	select SND_SOC_WM8804
-	select REGMAP_SPI
 
 config SND_SOC_WM8900
 	tristate
-- 
2.4.9
