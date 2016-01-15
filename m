From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: add i2c dependency" to the
	asoc tree
Date: Fri, 15 Jan 2016 18:18:52 +0000
Message-ID: <E1aK8xY-0005PQ-Kp@debutante>
References: <5346380.rqT2CVl4PH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 055C7260523
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 19:19:05 +0100 (CET)
In-Reply-To: <5346380.rqT2CVl4PH@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: add i2c dependency

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

>From ec3995da27e782cc407ce48101c98c19c9ce738d Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Jan 2016 23:14:54 +0100
Subject: [PATCH] ASoC: mediatek: add i2c dependency

The newly added mediatek drivers for mt8173 select codes that depend
on I2C, which cuases a build failure if I2C is disabled:

warning: (SND_SOC_ADAU1761_I2C && SND_SOC_ADAU1781_I2C && SND_SOC_ADAU1977_I2C && SND_SOC_RT5677 && EXTCON_MAX14577 && EXTCON_MAX77693 && EXTCON_MAX77843 && BMC150_ACCEL_I2C && BMG160_I2C) selects REGMAP_I2C which has unmet direct dependencies (I2C)
codecs/rt5645.c:3854:1: warning: data definition has no type or storage class
codecs/rt5645.c:3854:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
codecs/rt5677.c:5270:1: warning: data definition has no type or storage class
77_i2c_driver);

codecs/rt5677.c:5270:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]

This adds an explicit dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 15c04e2eae34..976967675387 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -9,7 +9,7 @@ config SND_SOC_MEDIATEK
 
 config SND_SOC_MT8173_MAX98090
 	tristate "ASoC Audio driver for MT8173 with MAX98090 codec"
-	depends on SND_SOC_MEDIATEK
+	depends on SND_SOC_MEDIATEK && I2C
 	select SND_SOC_MAX98090
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
@@ -19,7 +19,7 @@ config SND_SOC_MT8173_MAX98090
 
 config SND_SOC_MT8173_RT5650_RT5676
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5676 codecs"
-	depends on SND_SOC_MEDIATEK
+	depends on SND_SOC_MEDIATEK && I2C
 	select SND_SOC_RT5645
 	select SND_SOC_RT5677
 	help
-- 
2.7.0.rc3
