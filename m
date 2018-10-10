From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: max98988: add I2C dependency
Date: Wed, 10 Oct 2018 10:37:13 +0200
Message-ID: <20181010083758.2874864-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

max98988 only builds with I2C support enabled, otherwise we get a build error:

sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(max98088_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]

Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.18.0
