From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: ux500: Don't make the CPU I2S driver
	user selectable
Date: Thu, 10 May 2012 10:08:28 +0100
Message-ID: <1336640908-4747-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4132E10B9F2
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:08:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It can only be used with a machine driver so the idiomatic thing for
ASoC is to select this driver from the machine driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/ux500/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 1be1f50..44cf434 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -10,7 +10,5 @@ menuconfig SND_SOC_UX500
 		any of the Ux500 platforms (e.g. U8500).
 
 config SND_SOC_UX500_PLAT_MSP_I2S
-	tristate "Platform - MSP (I2S)"
+	tristate
 	depends on SND_SOC_UX500
-	help
-		Say Y if you want to enable the Ux500 MSP I2S-driver.
-- 
1.7.10
