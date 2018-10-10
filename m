From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98988: add I2C dependency" to the asoc tree
Date: Wed, 10 Oct 2018 15:40:20 +0100 (BST)
Message-ID: <20181010144021.010401122395@debutante.sirena.org.uk>
References: <20181010083758.2874864-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010083758.2874864-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98988: add I2C dependency

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 9641faa2db7e856f50a6d1169e1b9f01e7fcb2b0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Oct 2018 10:37:13 +0200
Subject: [PATCH] ASoC: max98988: add I2C dependency

max98988 only builds with I2C support enabled, otherwise we get a build error:

sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(max98088_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]

Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3c6bd6019b92..774d38310875 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -641,6 +641,7 @@ config SND_SOC_LM49453
 
 config SND_SOC_MAX98088
 	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
+	depends on I2C
 
 config SND_SOC_MAX98090
        tristate
-- 
2.19.0.rc2
