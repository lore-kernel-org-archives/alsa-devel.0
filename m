From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Fix SND_SOC_ALL_CODECS handling of
	dual SPI and I2C control buses
Date: Tue,  6 Jan 2009 15:00:04 +0000
Message-ID: <1231254004-13002-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090106145837.GB12803@rakim.wolfsonmicro.main>
	<1231254004-13002-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8F78103813
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 16:00:05 +0100 (CET)
In-Reply-To: <1231254004-13002-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

For codecs that have both SPI and I2C support we need to ensure that we
don't try to make the codec driver built in when I2C is modular since
that won't link.  Do this by creating a helper variable which uses
conditional defaults to pick up the correct value for all combinations.

We don't need to do anything special for I2C-only codecs since a
conditional select passes on the full value for a tristate.

Reported-by: Ingo Molnar <mingo@elte.hu>
Tested-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c41289b..d0e0d69 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1,3 +1,13 @@
+# Helper to resolve issues with configs that have SPI enabled but I2C
+# modular, meaning we can't build the codec driver in with I2C support.
+# We use an ordered list of conditional defaults to pick the appropriate
+# setting - SPI can't be modular so that case doesn't need to be covered.
+config SND_SOC_I2C_AND_SPI
+	tristate
+	default m if I2C=m
+	default y if I2C=y
+	default y if SPI_MASTER=y
+
 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
@@ -14,12 +24,12 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
-	select SND_SOC_WM8510 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8510 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8580 if I2C
-	select SND_SOC_WM8728 if (I2C || SPI_MASTER)
-	select SND_SOC_WM8731 if (I2C || SPI_MASTER)
-	select SND_SOC_WM8750 if (I2C || SPI_MASTER)
-	select SND_SOC_WM8753 if (I2C || SPI_MASTER)
+	select SND_SOC_WM8728 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8731 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8750 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_WM8753 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8900 if I2C
 	select SND_SOC_WM8903 if I2C
 	select SND_SOC_WM8971 if I2C
-- 
1.5.6.5
