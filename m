From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ALSA: ASoC: Sort Kconfig and Makefile
	entries for codecs
Date: Mon,  8 Sep 2008 16:13:53 +0100
Message-ID: <1220886834-14504-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080908151250.GA14434@rakim.wolfsonmicro.main>
	<1220886834-14504-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59AAA243D0
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:13:55 +0200 (CEST)
In-Reply-To: <1220886834-14504-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hopefully this will make merges a little bit easier.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |   64 ++++++++++++++++++++++----------------------
 sound/soc/codecs/Makefile |   16 +++++-----
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8b4bb5c..27f2dfa 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -4,7 +4,10 @@ config SND_SOC_ALL_CODECS
 	select SPI
 	select SPI_MASTER
 	select SND_SOC_AK4535
+	select SND_SOC_CS4270
 	select SND_SOC_SSM2602
+	select SND_SOC_TLV320AIC26
+	select SND_SOC_TLV320AIC3X
 	select SND_SOC_UDA1380
 	select SND_SOC_WM8510
 	select SND_SOC_WM8580
@@ -14,9 +17,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8900
 	select SND_SOC_WM8903
 	select SND_SOC_WM8990
-	select SND_SOC_CS4270
-	select SND_SOC_TLV320AIC26
-	select SND_SOC_TLV320AIC3X
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -36,6 +36,35 @@ config SND_SOC_AD1980
 config SND_SOC_AK4535
 	tristate
 
+# Cirrus Logic CS4270 Codec
+config SND_SOC_CS4270
+	tristate
+
+# Cirrus Logic CS4270 Codec Hardware Mute Support
+# Select if you have external muting circuitry attached to your CS4270.
+config SND_SOC_CS4270_HWMUTE
+	bool
+	depends on SND_SOC_CS4270
+
+# Cirrus Logic CS4270 Codec VD = 3.3V Errata
+# Select if you are affected by the errata where the part will not function
+# if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
+# not select any sample rates that require MCLK to be divided by 1.5.
+config SND_SOC_CS4270_VD33_ERRATA
+	bool
+	depends on SND_SOC_CS4270
+
+config SND_SOC_SSM2602
+	tristate
+
+config SND_SOC_TLV320AIC26
+	tristate "TI TLV320AIC26 Codec support"
+	depends on SND_SOC && SPI
+
+config SND_SOC_TLV320AIC3X
+	tristate
+	depends on I2C
+
 config SND_SOC_UDA1380
         tristate
 
@@ -68,32 +97,3 @@ config SND_SOC_WM9712
 
 config SND_SOC_WM9713
 	tristate
-
-# Cirrus Logic CS4270 Codec
-config SND_SOC_CS4270
-	tristate
-
-# Cirrus Logic CS4270 Codec Hardware Mute Support
-# Select if you have external muting circuitry attached to your CS4270.
-config SND_SOC_CS4270_HWMUTE
-	bool
-	depends on SND_SOC_CS4270
-
-# Cirrus Logic CS4270 Codec VD = 3.3V Errata
-# Select if you are affected by the errata where the part will not function
-# if MCLK divide-by-1.5 is selected and VD is set to 3.3V.  The driver will
-# not select any sample rates that require MCLK to be divided by 1.5.
-config SND_SOC_CS4270_VD33_ERRATA
-	bool
-	depends on SND_SOC_CS4270
-
-config SND_SOC_TLV320AIC26
-	tristate "TI TLV320AIC26 Codec support"
-	depends on SND_SOC && SPI
-
-config SND_SOC_TLV320AIC3X
-	tristate
-	depends on I2C
-
-config SND_SOC_SSM2602
-	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0cd55ee..c2b8783 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,6 +1,10 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ak4535-objs := ak4535.o
+snd-soc-cs4270-objs := cs4270.o
+snd-soc-ssm2602-objs := ssm2602.o
+snd-soc-tlv320aic26-objs := tlv320aic26.o
+snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wm8510-objs := wm8510.o
 snd-soc-wm8580-objs := wm8580.o
@@ -12,14 +16,14 @@ snd-soc-wm8903-objs := wm8903.o
 snd-soc-wm8990-objs := wm8990.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
-snd-soc-cs4270-objs := cs4270.o
-snd-soc-tlv320aic26-objs := tlv320aic26.o
-snd-soc-tlv320aic3x-objs := tlv320aic3x.o
-snd-soc-ssm2602-objs := ssm2602.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
+obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
+obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
+obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
+obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
 obj-$(CONFIG_SND_SOC_WM8580)	+= snd-soc-wm8580.o
@@ -31,7 +35,3 @@ obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
-obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
-obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
-obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
-obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
-- 
1.5.6.5
