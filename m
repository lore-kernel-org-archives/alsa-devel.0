From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 9/9] ASoC: Fix L3 bus handling in Kconfig
Date: Fri, 23 Jan 2009 17:18:40 +0000
Message-ID: <1232731120-6144-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EFC352449A
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-8-git-send-email-broonie@opensource.wolfsonmicro.com>
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

It has no external dependencies but needs to be selected for L3 based
codecs to work.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    1 +
 sound/soc/s3c24xx/Kconfig |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 656f180..a195303 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -10,6 +10,7 @@ config SND_SOC_I2C_AND_SPI
 
 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
+	select SND_SOC_L3
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311 if I2C
diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index fcd03ac..e05a710 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -48,4 +48,5 @@ config SND_S3C24XX_SOC_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
        	depends on SND_S3C24XX_SOC
        	select SND_S3C24XX_SOC_I2S
+	select SND_SOC_L3
        	select SND_SOC_UDA134X
-- 
1.5.6.5
