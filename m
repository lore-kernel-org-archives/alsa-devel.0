From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Use finer grained dependencies in
	SND_SOC_ALL_CODECS
Date: Thu, 30 Oct 2008 15:58:28 +0000
Message-ID: <1225382309-1827-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030155718.GA1418@rakim.wolfsonmicro.main>
	<1225382309-1827-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225382309-1827-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B80324495
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 16:58:32 +0100 (CET)
In-Reply-To: <1225382309-1827-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Move the bus dependencies in SND_SOC_ALL_CODECS into the individual
codec options rather than have them centrally. This allows the
inclusion of AC97 codecs when testing on platforms with AC97 support
and will also handle codecs on multi-function devices more gracefully.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 38a0e3b..3c76cae 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1,31 +1,35 @@
 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
-	depends on I2C
-	select SPI
-	select SPI_MASTER
-	select SND_SOC_AD73311
-	select SND_SOC_AK4535
-	select SND_SOC_CS4270
-	select SND_SOC_SSM2602
-	select SND_SOC_TLV320AIC23
-	select SND_SOC_TLV320AIC26
-	select SND_SOC_TLV320AIC3X
-	select SND_SOC_UDA1380
-	select SND_SOC_WM8510
-	select SND_SOC_WM8580
-	select SND_SOC_WM8731
-	select SND_SOC_WM8750
-	select SND_SOC_WM8753
-	select SND_SOC_WM8900
-	select SND_SOC_WM8903
-	select SND_SOC_WM8971
-	select SND_SOC_WM8990
+	select SND_SOC_AC97 if SND_SOC_AC97_BUS
+	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
+	select SND_SOC_AD73311 if I2C
+	select SND_SOC_AK4535 if I2C
+	select SND_SOC_CS4270 if I2C
+	select SND_SOC_SSM2602 if I2C
+	select SND_SOC_TLV320AIC23 if I2C
+	select SND_SOC_TLV320AIC26 if SPI_MASTER
+	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_UDA1380 if I2C
+	select SND_SOC_WM8510 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8580 if I2C
+	select SND_SOC_WM8731 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8750 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8753 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8900 if I2C
+	select SND_SOC_WM8903 if I2C
+	select SND_SOC_WM8971 if I2C
+	select SND_SOC_WM8990 if I2C
+	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
+	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
           driver.  Selecting this option will allow these drivers to be built
           without an explicit machine driver for test and development purposes.
 
+	  Support for the bus types used to access the codecs to be built must
+	  be selected separately.
+
           If unsure select "N".
 
 
-- 
1.5.6.5
