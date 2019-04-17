From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to module" to the asoc tree
Date: Wed, 17 Apr 2019 17:42:13 +0100 (BST)
Message-ID: <20190417164213.C3B0C1128FC8@debutante.sirena.org.uk>
References: <20190417152932.36436-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417152932.36436-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, kaichieh.chuang@mediatek.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, matthias.bgg@gmail.com, perex@perex.cz, shunli.wang@mediatek.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to module

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 04e7a02937527fd7edb1e493f04613f2340085dc Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 17 Apr 2019 23:29:32 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: Fix build err while CONFIG_I2C set to
 module

During randconfig builds, I occasionally run into an invalid configuration

WARNING: unmet direct dependencies detected for SND_SOC_TS3A227E
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=m]
  Selected by [y]:
  - SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8183 [=y]

sound/soc/codecs/ts3a227e.o: In function `ts3a227e_i2c_probe':
ts3a227e.c:(.text+0x684): undefined reference to `__devm_regmap_init_i2c'
sound/soc/codecs/ts3a227e.o: In function `ts3a227e_driver_init':
ts3a227e.c:(.init.text+0x18): undefined reference to `i2c_register_driver'
sound/soc/codecs/ts3a227e.o: In function `ts3a227e_driver_exit':
ts3a227e.c:(.exit.text+0x14): undefined reference to `i2c_del_driver'

This patch add I2C dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 874404bcccfd..f70b7109f2b6 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -118,6 +118,7 @@ config SND_SOC_MT8183
 
 config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with MT6358 TS3A227E MAX98357A codec"
+	depends on I2C
 	depends on SND_SOC_MT8183
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
-- 
2.20.1
