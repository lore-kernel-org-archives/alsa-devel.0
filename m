From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 9/9] ARM: DaVinci: ASoC: Adds build support for
	DM646X audio driver
Date: Mon, 16 Mar 2009 08:06:27 -0400
Message-ID: <1237205187-30297-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 79C3C10385E
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:23:42 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCNaHY025881
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:23:41 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds build support for DM646X audio driver

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
 This patch applies on the ASoC tree available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032.

 sound/soc/codecs/Kconfig   |    3 +++
 sound/soc/codecs/Makefile  |    2 ++
 sound/soc/davinci/Kconfig  |   14 ++++++++++++++
 sound/soc/davinci/Makefile |    3 +++
 4 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9f33c07..d34b38b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -109,6 +109,9 @@ config SND_SOC_TLV320AIC23
 	tristate
 	depends on I2C
 
+config SND_SOC_CODEC_STUBS
+        tristate
+
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
 	depends on SPI
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9c61037..3d1d270 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -12,6 +12,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
+snd-soc-codec_stubs-objs := codec_stubs.o
 snd-soc-twl4030-objs := twl4030.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
@@ -54,6 +55,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
+obj-$(CONFIG_SND_SOC_CODEC_STUBS)       += snd-soc-codec_stubs.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index b502741..ec554c9 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -9,6 +9,9 @@ config SND_DAVINCI_SOC
 config SND_DAVINCI_SOC_I2S
 	tristate
 
+config SND_DAVINCI_SOC_I2S_MCASP
+        tristate
+
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci EVM"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_EVM
@@ -18,6 +21,17 @@ config SND_DAVINCI_SOC_EVM
 	  Say Y if you want to add support for SoC audio on TI
 	  DaVinci EVM platform.
 
+config  SND_DM6467_SOC_EVM
+        tristate "SoC Audio support for DaVinci DM6467 EVM"
+        depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM646X_EVM
+        select SND_DAVINCI_SOC_I2S_MCASP
+        select SND_SOC_TLV320AIC3X
+        select SND_SOC_CODEC_STUBS
+        help
+          Say Y if you want to add support for SoC audio on TI
+          DaVinci DM646x EVM platform.
+
+
 config SND_DAVINCI_SOC_SFFSDR
 	tristate "SoC Audio support for SFFSDR"
 	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index ca8bae1..152d59c 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -1,13 +1,16 @@
 # DAVINCI Platform Support
 snd-soc-davinci-objs := davinci-pcm.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
+snd-soc-davinci-i2s-mcasp-objs:= davinci-i2s-mcasp.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
+obj-$(CONFIG_SND_DAVINCI_SOC_I2S_MCASP) += snd-soc-davinci-i2s-mcasp.o
 
 # DAVINCI Machine Support
 snd-soc-evm-objs := davinci-evm.o
 snd-soc-sffsdr-objs := davinci-sffsdr.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC_EVM) += snd-soc-evm.o
+obj-$(CONFIG_SND_DM6467_SOC_EVM) += snd-soc-evm.o
 obj-$(CONFIG_SND_DAVINCI_SOC_SFFSDR) += snd-soc-sffsdr.o
-- 
1.5.6
