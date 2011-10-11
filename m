From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] ASoC: Fix typo in Kconfig symbol for
	tlv320aic32x4
Date: Tue, 11 Oct 2011 12:43:02 +0200
Message-ID: <1318329782-5701-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 11046103823
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 12:43:54 +0200 (CEST)
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
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

It is currently named "TVL" instead of "TLV".

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    4 ++--
 sound/soc/codecs/Makefile |    2 +-
 sound/soc/imx/Kconfig     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 665d924..d503764 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -47,7 +47,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
-	select SND_SOC_TVL320AIC32X4 if I2C
+	select SND_SOC_TLV320AIC32X4 if I2C
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -240,7 +240,7 @@ config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
 	depends on SPI
 
-config SND_SOC_TVL320AIC32X4
+config SND_SOC_TLV320AIC32X4
 	tristate
 
 config SND_SOC_TLV320AIC3X
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5119a7e..b89a82f 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -132,7 +132,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
-obj-$(CONFIG_SND_SOC_TVL320AIC32X4)     += snd-soc-tlv320aic32x4.o
+obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index bb699bb..62c223f 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -29,7 +29,7 @@ config SND_MXC_SOC_WM1133_EV1
 config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
 	depends on MACH_IMX27_VISSTRIM_M10
-	select SND_SOC_TVL320AIC32X4
+	select SND_SOC_TLV320AIC32X4
 	select SND_MXC_SOC_MX2
 	help
 	  Say Y if you want to add support for SoC audio on Visstrim SM10
-- 
1.7.6.3
