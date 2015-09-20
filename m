From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Fix missing CLKDEV_LOOKUP
	dependency" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:04 -0700
Message-ID: <E1ZdSFc-00041i-HG@finisterre>
References: <1442561132.11434.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 15AE526065C
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:38 +0200 (CEST)
In-Reply-To: <1442561132.11434.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: Fix missing CLKDEV_LOOKUP dependency

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9d70594760a94523c550d2cc0f47b3c0af63c8e9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 18 Sep 2015 15:25:32 +0800
Subject: [PATCH] ASoC: rockchip: Fix missing CLKDEV_LOOKUP dependency

Make SND_SOC_ROCKCHIP_MAX98090 and SND_SOC_ROCKCHIP_RT5645 depend on
CLKDEV_LOOKUP to fix below build warning:

warning: (SND_SOC_ROCKCHIP_MAX98090 && SND_SOC_ROCKCHIP_RT5645) selects
SND_SOC_ROCKCHIP_I2S which has unmet direct dependencies (SOUND && !M68K &&
!UML && SND && SND_SOC && CLKDEV_LOOKUP && SND_SOC_ROCKCHIP)

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.5.0
