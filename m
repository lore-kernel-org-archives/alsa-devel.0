From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 1/3] ASoC: rt5677: add REGMAP_I2C and REGMAP_IRQ dependency
Date: Wed, 10 Dec 2014 20:15:25 -0800
Message-ID: <1418271327-14710-1-git-send-email-benzh@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Anatol Pomozov <anatol@google.com>, Dylan Reid <dgreid@chromium.org>, Albert Chen <albertchen@realtek.com>, linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

The codec driver uses regmap to do i2c read/write.
The codec driver started to use REGMAP_IRQ since:

5e3363ad1b7b2e1f197a3f56b01e21cb155ad454
ASoC: rt5677: add GPIO IRQ support

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6f21a76..60f9425 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -503,6 +503,8 @@ config SND_SOC_RT5670
 
 config SND_SOC_RT5677
 	tristate
+	select REGMAP_I2C
+	select REGMAP_IRQ
 
 config SND_SOC_RT5677_SPI
 	tristate
-- 
2.2.0.rc0.207.ga3a616c
