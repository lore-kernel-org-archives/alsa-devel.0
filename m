From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8985: add i2c dependency" to the asoc tree
Date: Mon, 13 Jun 2016 17:54:58 +0100
Message-ID: <E1bCV8c-0004gT-Tj@finisterre>
References: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8985: add i2c dependency

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

>From 05252513fbb9874a292a78aa577e5d42bb4d5ad0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jun 2016 17:39:42 +0200
Subject: [PATCH] ASoC: wm8985: add i2c dependency

The wm8985 driver is now user-selectable, but building it with
I2C disabled results in a link failure:

sound/built-in.o: In function `wm8985_i2c_probe':
:(.text+0x44914): undefined reference to `__devm_regmap_init_i2c'
sound/built-in.o: In function `wm8985_exit':
:(.exit.text+0x3d8): undefined reference to `i2c_del_driver'
sound/built-in.o: In function `wm8985_modinit':
:(.init.text+0x1454): undefined reference to `i2c_register_driver'

This adds a Kconfig dependency the way that the other codec
drivers have it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 811e66de2241 ("ASoC: wm8985: add support for WM8758")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5c635f7ec0aa..f8f6dc6c6a98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -945,6 +945,7 @@ config SND_SOC_WM8983
 
 config SND_SOC_WM8985
 	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
+	depends on I2C
 
 config SND_SOC_WM8988
 	tristate
-- 
2.8.1
