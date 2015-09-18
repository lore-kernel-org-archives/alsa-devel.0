From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rockchip: Fix missing CLKDEV_LOOKUP
	dependency
Date: Fri, 18 Sep 2015 15:25:32 +0800
Message-ID: <1442561132.11434.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2730B260417
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 09:25:38 +0200 (CEST)
Received: by pacfv12 with SMTP id fv12so44151629pac.2
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 00:25:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make SND_SOC_ROCKCHIP_MAX98090 and SND_SOC_ROCKCHIP_RT5645 depend on
CLKDEV_LOOKUP to fix below build warning:

warning: (SND_SOC_ROCKCHIP_MAX98090 && SND_SOC_ROCKCHIP_RT5645) selects
SND_SOC_ROCKCHIP_I2S which has unmet direct dependencies (SOUND && !M68K &&
!UML && SND && SND_SOC && CLKDEV_LOOKUP && SND_SOC_ROCKCHIP)

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index 58bae8e..5709057 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -17,7 +17,7 @@ config SND_SOC_ROCKCHIP_I2S
 
 config SND_SOC_ROCKCHIP_MAX98090
 	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
@@ -27,7 +27,7 @@ config SND_SOC_ROCKCHIP_MAX98090
 
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_RT5645
 	help
-- 
2.1.4
