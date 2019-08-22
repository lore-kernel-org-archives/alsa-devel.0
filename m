From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix Kconfig warning without GPIOLIB" to the asoc tree
Date: Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Message-ID: <20190822183257.9C0E4D02CEB@fitzroy.sirena.org.uk>
References: <20190822143007.73644-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822143007.73644-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, maruthi.bayyavarapu@amd.com, perex@perex.cz, tglx@linutronix.de, tiwai@suse.com, Vijendar.Mukunda@amd.com, yuehaibing@huawei.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix Kconfig warning without GPIOLIB

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 0ce6a624473e7e5752a84416f85f73d082308edd Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:30:07 +0800
Subject: [PATCH] ASoC: AMD: Fix Kconfig warning without GPIOLIB

While do rand build without GPIOLIB, we get Kconfig warning:\

WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
  Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && GPIOLIB [=n]
  Selected by [m]:
  - SND_SOC_AMD_CZ_DA7219MX98357_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_AMD_ACP [=m] && I2C [=y]

Add GPIOLIB dependency to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190822143007.73644-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 9ca9214cb7fb..5f40517717c4 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -10,7 +10,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
 	select SND_SOC_MAX98357A
 	select SND_SOC_ADAU7002
 	select REGULATOR
-	depends on SND_SOC_AMD_ACP && I2C
+	depends on SND_SOC_AMD_ACP && I2C && GPIOLIB
 	help
 	 This option enables machine driver for DA7219 and MAX9835.
 
-- 
2.20.1
