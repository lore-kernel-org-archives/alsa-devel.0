From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: codecs: Make OF supported CODECs visible
	in Kconfig
Date: Thu, 23 Jan 2014 12:59:07 +0000
Message-ID: <1390481947-4325-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8033B2625FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 13:59:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Now that we have a generic card driver we can't rely on the card driver
selecting the CODECs for us so make the CODECs that can be enabled with
OF directly selectable in Kconfig. For the platforms not using OF it's
not clear that we don't still want to have some board specific selection
since the kernel needs to contain code to register the devices; ACPI could
provide this from firmware does not yet support any kind of generic card.

It may also be desirable to hide these if OF is not enabled to reduce
noise.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig | 96 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fa989cb77fe4..e0c2febf3bc0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -191,8 +191,9 @@ config SND_SOC_AD73311
 	tristate
 
 config SND_SOC_ADAU1701
+	tristate "Analog Devices ADAU1701 CODEC"
+	depends on I2C
 	select SND_SOC_SIGMADSP
-	tristate
 
 config SND_SOC_ADAU1373
 	tristate
@@ -204,28 +205,31 @@ config SND_SOC_ADS117X
 	tristate
 
 config SND_SOC_AK4104
-	tristate
+	tristate "AKM AK4104 CODEC"
+	depends on SPI_MASTER
 
 config SND_SOC_AK4535
 	tristate
 
 config SND_SOC_AK4554
-	tristate
+	tristate "AKM AK4554 CODEC"
 
 config SND_SOC_AK4641
 	tristate
 
 config SND_SOC_AK4642
-	tristate
+	tristate "AKM AK4642 CODEC"
+	depends on I2C
 
 config SND_SOC_AK4671
 	tristate
 
 config SND_SOC_AK5386
-	tristate
+	tristate "AKM AK5638 CODEC"
 
 config SND_SOC_ALC5623
        tristate
+
 config SND_SOC_ALC5632
 	tristate
 
@@ -236,14 +240,17 @@ config SND_SOC_CS42L51
 	tristate
 
 config SND_SOC_CS42L52
-	tristate
+	tristate "Cirrus Logic CS42L52 CODEC"
+	depends on I2C
 
 config SND_SOC_CS42L73
-	tristate
+	tristate "Cirrus Logic CS42L73 CODEC"
+	depends on I2C
 
 # Cirrus Logic CS4270 Codec
 config SND_SOC_CS4270
-	tristate
+	tristate "Cirrus Logic CS4270 CODEC"
+	depends on I2C
 
 # Cirrus Logic CS4270 Codec VD = 3.3V Errata
 # Select if you are affected by the errata where the part will not function
@@ -254,7 +261,7 @@ config SND_SOC_CS4270_VD33_ERRATA
 	depends on SND_SOC_CS4270
 
 config SND_SOC_CS4271
-	tristate
+	tristate "Cirrus Logic CS4271 CODEC"
 
 config SND_SOC_CX20442
 	tristate
@@ -285,6 +292,9 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
+config SND_SOC_HDMI_CODEC
+       tristate "HDMI stub CODEC"
+
 config SND_SOC_ISABELLE
         tristate
 
@@ -303,14 +313,13 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX9850
 	tristate
 
-config SND_SOC_HDMI_CODEC
-       tristate
-
 config SND_SOC_PCM1681
-       tristate
+	tristate "Texas Instruments PCM1681 CODEC"
+	depends on I2C
 
 config SND_SOC_PCM1792A
-       tristate
+	tristate "Texas Instruments PCM1792A CODEC"
+	depends on SPI_MASTER
 
 config SND_SOC_PCM3008
        tristate
@@ -326,7 +335,8 @@ config SND_SOC_RT5640
 
 #Freescale sgtl5000 codec
 config SND_SOC_SGTL5000
-	tristate
+	tristate "Freescale SGTL5000 CODEC"
+	depends on I2C
 
 config SND_SOC_SI476X
 	tristate
@@ -339,7 +349,7 @@ config SND_SOC_SN95031
 	tristate
 
 config SND_SOC_SPDIF
-	tristate
+	tristate "S/PDIF CODEC"
 
 config SND_SOC_SSM2518
 	tristate
@@ -357,7 +367,8 @@ config SND_SOC_STAC9766
 	tristate
 
 config SND_SOC_TAS5086
-	tristate
+	tristate "Texas Instruments TAS5086 speaker amplifier"
+	depends on I2C
 
 config SND_SOC_TLV320AIC23
 	tristate
@@ -370,7 +381,8 @@ config SND_SOC_TLV320AIC32X4
 	tristate
 
 config SND_SOC_TLV320AIC3X
-	tristate
+	tristate "Texas Instruments TLV320AIC3x CODECs"
+	depends on I2C
 
 config SND_SOC_TLV320DAC33
 	tristate
@@ -419,55 +431,69 @@ config SND_SOC_WM8400
 	tristate
 
 config SND_SOC_WM8510
-	tristate
+	tristate "Wolfson Microelectronics WM8510 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8523
-	tristate
+	tristate "Wolfson Microelectronics WM8523 DAC"
+	depends on I2C
 
 config SND_SOC_WM8580
-	tristate
+	tristate "Wolfson Microelectronics WM8523 CODEC"
+	depends on I2C
 
 config SND_SOC_WM8711
-	tristate
+	tristate "Wolfson Microelectronics WM8711 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8727
 	tristate
 
 config SND_SOC_WM8728
-	tristate
+	tristate "Wolfson Microelectronics WM8728 DAC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8731
-	tristate
+	tristate "Wolfson Microelectronics WM8731 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8737
-	tristate
+	tristate "Wolfson Microelectronics WM8737 ADC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8741
-	tristate
+	tristate "Wolfson Microelectronics WM8737 DAC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8750
-	tristate
+	tristate "Wolfson Microelectronics WM8750 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8753
-	tristate
+	tristate "Wolfson Microelectronics WM8753 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8770
-	tristate
+	tristate "Wolfson Microelectronics WM8770 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8776
-	tristate
+	tristate "Wolfson Microelectronics WM8776 CODEC"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8782
 	tristate
 
 config SND_SOC_WM8804
-	tristate
+	tristate "Wolfson Microelectronics WM8804 S/PDIF transceiver"
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8900
 	tristate
 
 config SND_SOC_WM8903
-	tristate
+	tristate "Wolfson Microelectronics WM8903 CODEC"
+	depends on I2C
 
 config SND_SOC_WM8904
 	tristate
@@ -485,7 +511,8 @@ config SND_SOC_WM8961
 	tristate
 
 config SND_SOC_WM8962
-	tristate
+	tristate "Wolfson Microelectronics WM8962 CODEC"
+	depends on I2C
 
 config SND_SOC_WM8971
 	tristate
@@ -558,4 +585,5 @@ config SND_SOC_ML26124
 	tristate
 
 config SND_SOC_TPA6130A2
-	tristate
+	tristate "Texas Instruments TPA6130A2 headphone amplifier"
+	depends on I2C
-- 
1.8.5.3
