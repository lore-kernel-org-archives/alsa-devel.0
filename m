From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC fix up SND_SOC_WM8985 dependency" to the asoc tree
Date: Fri, 17 Jun 2016 12:43:30 +0100
Message-ID: <E1bDsBO-00027u-0D@debutante>
References: <20160617101230.2052826-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617101230.2052826-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC fix up SND_SOC_WM8985 dependency

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

>From b82d67f4cf320b7ebe97799ffb0aa85e0172ab40 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Jun 2016 12:12:00 +0200
Subject: [PATCH] ASoC fix up SND_SOC_WM8985 dependency

I just added an I2C dependency to the wm8985 driver to work around
a build failure, but it turns out that was premature: we actually
need to depend on SND_SOC_I2C_AND_SPI, as the driver can work with either
of the two, and we only need to prevent a configuration that has
I2C=m and SND_SOC_WM8985=y.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 05252513fbb9 ("ASoC: wm8985: add i2c dependency")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f8f6dc6c6a98..cf6d401fc823 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -945,7 +945,7 @@ config SND_SOC_WM8983
 
 config SND_SOC_WM8985
 	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
-	depends on I2C
+	depends on SND_SOC_I2C_AND_SPI
 
 config SND_SOC_WM8988
 	tristate
-- 
2.8.1
