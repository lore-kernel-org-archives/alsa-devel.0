From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: da7219: Fix build error without CONFIG_I2C
Date: Sat, 1 Jun 2019 16:51:44 +0800
Message-ID: <20190601085144.13832-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, shunli.wang@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

Fix gcc build error while CONFIG_I2C is not set

sound/soc/codecs/da7219.c:2640:1: warning: data definition has no type or storage class
 module_i2c_driver(da7219_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/da7219.c:2640:1: error: type defaults to int in declaration of module_i2c_driver [-Werror=implicit-int]
sound/soc/codecs/da7219.c:2640:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/da7219.c:2629:26: warning: da7219_i2c_driver defined but not used [-Wunused-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 933ab51..111e44b 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -133,7 +133,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 
 config SND_SOC_MT8183_DA7219_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with DA7219 MAX98357A codec"
-	depends on SND_SOC_MT8183
+	depends on SND_SOC_MT8183 && I2C
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
 	select SND_SOC_DA7219
-- 
2.7.4
