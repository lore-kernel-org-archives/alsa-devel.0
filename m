From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] SoC: Fix MAX98357A codec driver dependencies
Date: Wed, 11 Feb 2015 13:13:18 -0800
Message-ID: <1423689198-24034-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Guenter Roeck <linux@roeck-us.net>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The max98357a driver depends on GPIOLIB. This may cause the following
build failure.

sound/soc/codecs/max98357a.c: In function 'max98357a_daiops_trigger':
sound/soc/codecs/max98357a.c:30:3: error: implicit declaration of function 'gpiod_set_value'
sound/soc/codecs/max98357a.c: In function 'max98357a_codec_probe':
sound/soc/codecs/max98357a.c:55:2: error: implicit declaration of function 'devm_gpiod_get'
sound/soc/codecs/max98357a.c:61:2: error: implicit declaration of function 'gpiod_direction_output'

Seen with mips:allmodconfig as well as various randconfig builds.

Fixes: af5adf129369 ("ASoC: max98357a: Add MAX98357A codec driver")
Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 064e6c1..ea9f0e3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -69,7 +69,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
-	select SND_SOC_MAX98357A
+	select SND_SOC_MAX98357A if GPIOLIB
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
-- 
2.1.0
