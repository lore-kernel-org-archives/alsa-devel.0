From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin: fix DAI/SPORT config
	dependency issues
Date: Tue, 11 Jan 2011 20:04:28 -0500
Message-ID: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BEF8410387E
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 01:56:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

While I2S/TDM/AC97 DAI is built-in, others are compiled as modules,
SND_BF5XX_SOC_SPORT will be module, then DAI can't get some symbols.
Except that, SND_BF5XX_AC97 depends on SND_BF5XX_SOC_AC97 too.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 3abeedd..ae40359 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -1,6 +1,7 @@
 config SND_BF5XX_I2S
 	tristate "SoC I2S Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
+	select SND_BF5XX_SOC_SPORT
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Blackfin SPORT (synchronous serial ports) interface in I2S
@@ -35,6 +36,7 @@ config SND_BFIN_AD73311_SE
 config SND_BF5XX_TDM
 	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
 	depends on (BLACKFIN && SND_SOC)
+	select SND_BF5XX_SOC_SPORT
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Blackfin SPORT (synchronous serial ports) interface in TDM
@@ -61,6 +63,10 @@ config SND_BF5XX_SOC_AD193X
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
+	select AC97_BUS
+	select SND_SOC_AC97_BUS
+	select SND_BF5XX_SOC_SPORT
+	select SND_BF5XX_SOC_AC97
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Blackfin SPORT (synchronous serial ports) interface in slot 16
@@ -122,17 +128,12 @@ config SND_BF5XX_SOC_SPORT
 
 config SND_BF5XX_SOC_I2S
 	tristate
-	select SND_BF5XX_SOC_SPORT
 
 config SND_BF5XX_SOC_TDM
 	tristate
-	select SND_BF5XX_SOC_SPORT
 
 config SND_BF5XX_SOC_AC97
 	tristate
-	select AC97_BUS
-	select SND_SOC_AC97_BUS
-	select SND_BF5XX_SOC_SPORT
 
 config SND_BF5XX_SPORT_NUM
 	int "Set a SPORT for Sound chip"
-- 
1.7.4.rc1
