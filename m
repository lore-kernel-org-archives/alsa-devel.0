From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: samsung: Replace depends on REGMAP_I2C
	with depends on I2C
Date: Fri, 16 Jan 2015 20:04:16 +0100
Message-ID: <1421435056-29413-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-013.synserver.de (smtp-out-013.synserver.de
 [212.40.185.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 674D4260444
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 20:04:31 +0100 (CET)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

regmap is a library function that gets selected by drivers that need it. No
driver modules should depend on it, since this can create dependency loops.

E.g. if machine driver depends on REGMAP_I2C and selects the CODEC driver
and the CODEC driver selects REGMAP_I2C, then the machine driver selects by
extension one of its dependencies.

The proper way to handle this is for machine drivers to depend on the same
dependencies as the CODEC driver they select. In this case it is I2C.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index fc67f97..e817a2f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -54,7 +54,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
-	depends on REGMAP_I2C
+	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
@@ -167,7 +167,7 @@ config SND_SOC_SAMSUNG_SMDK_SPDIF
 config SND_SOC_SMDK_WM8580_PCM
 	tristate "SoC PCM Audio support for WM8580 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKV210 || MACH_SMDKC110)
-	depends on REGMAP_I2C
+	depends on I2C
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_PCM
 	help
-- 
1.8.0
