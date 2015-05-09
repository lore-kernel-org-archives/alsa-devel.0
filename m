From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Sun, 10 May 2015 00:12:04 +0200
Message-ID: <554E8634.2010008@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make generic ASoC AC'97 CODEC selectable in config.

This way this driver can be used for platforms which don't need
specialized AC'97 CODEC drivers but which are not directly
selectable in config themselves (for example DT based ones).

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
 	select SND_SOC_AB8500_CODEC if ABX500_CORE
-	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
+	select SND_SOC_AC97_CODEC
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD193X_SPI if SPI_MASTER
 	select SND_SOC_AD193X_I2C if I2C
@@ -212,8 +212,9 @@ config SND_SOC_AB8500_CODEC
 	tristate
 
 config SND_SOC_AC97_CODEC
-	tristate
+	tristate "Build generic ASoC AC97 CODEC driver"
 	select SND_AC97_CODEC
+	select SND_SOC_AC97_BUS
 
 config SND_SOC_AD1836
 	tristate
