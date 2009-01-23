From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/9] ASoC: Fix spurious codec driver
	dependencies
Date: Fri, 23 Jan 2009 17:18:37 +0000
Message-ID: <1232731120-6144-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EDB7E24499
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Kbuild ignores dependency from things that are themselves selected so
ASoC machine drivers need to ensure that the control bus is being built.
This also avoids issues where multiple buses are supported by a given
codec.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |    4 ----
 sound/soc/omap/Kconfig   |    4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb5fcd6..656f180 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -91,7 +91,6 @@ config SND_SOC_SSM2602
 
 config SND_SOC_TLV320AIC23
 	tristate
-	depends on I2C
 
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support" if SND_SOC_OF_SIMPLE
@@ -99,15 +98,12 @@ config SND_SOC_TLV320AIC26
 
 config SND_SOC_TLV320AIC3X
 	tristate
-	depends on I2C
 
 config SND_SOC_TWL4030
 	tristate
-	depends on TWL4030_CORE
 
 config SND_SOC_UDA134X
        tristate
-       select SND_SOC_L3
 
 config SND_SOC_UDA1380
         tristate
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index ccd8973..675732e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -8,7 +8,7 @@ config SND_OMAP_SOC_MCBSP
 
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
-	depends on SND_OMAP_SOC && MACH_NOKIA_N810
+	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
 	select SND_OMAP_SOC_MCBSP
 	select OMAP_MUX
 	select SND_SOC_TLV320AIC3X
@@ -17,7 +17,7 @@ config SND_OMAP_SOC_N810
 
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
-	depends on SND_OMAP_SOC && MACH_OMAP_OSK
+	depends on SND_OMAP_SOC && MACH_OMAP_OSK && I2C
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC23
 	help
-- 
1.5.6.5
