From: Randy Li <ayaka@soulik.info>
Subject: [PATCH] ASoC: es8328: explict I2C and SPI menu entry
Date: Sun, 14 Aug 2016 16:33:49 +0800
Message-ID: <1471163629-11193-1-git-send-email-ayaka@soulik.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, john@metanate.com, Randy Li <ayaka@soulik.info>
List-Id: alsa-devel@alsa-project.org

The es8328 support both I2C and SPI as control interface, and it is
possible that the interface is determined by dts in simple sound
card situation. We would better allow them be built at the same time.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 sound/soc/codecs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f3fb98f..bcf9b1d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -489,14 +489,14 @@ config SND_SOC_HDMI_CODEC
 	select HDMI
 
 config SND_SOC_ES8328
-	tristate "Everest Semi ES8328 CODEC"
+	tristate
 
 config SND_SOC_ES8328_I2C
-	tristate
+	tristate "Everest Semi ES8328 CODEC  (I2C)"
 	select SND_SOC_ES8328
 
 config SND_SOC_ES8328_SPI
-	tristate
+	tristate "Everest Semi ES8328 CODEC  (SPI)"
 	select SND_SOC_ES8328
 
 config SND_SOC_GTM601
-- 
2.7.4
