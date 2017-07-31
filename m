From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: improve RT5514 dependencies
Date: Mon, 31 Jul 2017 10:30:55 +0200
Message-ID: <20170731083217.4142512-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E0726691A
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 10:32:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>, Hsin-yu Chao <hychao@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-rockchip@lists.infradead.org, Harsha Priya N <harshapriya.n@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Naveen M <naveen.m@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Xing Zheng <zhengxing@rock-chips.com>, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

With SND_SOC_RT5514_SPI=m and SND_SOC_RT5514=y, we get this link error:

sound/soc/codecs/rt5514.o: In function `rt5514_dsp_voice_wake_up_put':
rt5514.c:(.text+0x2068): undefined reference to `rt5514_spi_burst_write'
rt5514.c:(.text+0x20c8): undefined reference to `rt5514_spi_burst_write'

This adds another Kconfig symbol to work around the link error, forcing
the main driver to be a loadable module as well if some other driver
selects the I2C side to be built-in.

Fixes: 2a18483a7fb4 ("ASoC: Intel: Add Kabylake machine driver for RT5514, RT5663 and MAX98927")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This can now lead to a configuration with
SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=y and SND_SOC_RT5514=m. I
don't know if that is a problem or not.

An alternative approach would be to flip the dependency between
rt5514_spi.ko and rt5514.ko and avoid having the rt5514_spi_burst_write
symbol exported.
---
 sound/soc/codecs/Kconfig   | 7 ++++++-
 sound/soc/intel/Kconfig    | 2 +-
 sound/soc/mediatek/Kconfig | 2 +-
 sound/soc/rockchip/Kconfig | 1 -
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 024ddc9938ed..115c6144ca2a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -117,7 +117,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_RT274 if I2C
 	select SND_SOC_RT286 if I2C
 	select SND_SOC_RT298 if I2C
-	select SND_SOC_RT5514 if I2C
+	select SND_SOC_RT5514_I2C if I2C
 	select SND_SOC_RT5616 if I2C
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_RT5640 if I2C
@@ -738,6 +738,11 @@ config SND_SOC_RT298
 
 config SND_SOC_RT5514
 	tristate
+	default m if SND_SOC_RT5514_SPI=m
+	default SND_SOC_RT5514_I2C || SND_SOC_RT5514_SPI
+
+config SND_SOC_RT5514_I2C
+	tristate
 
 config SND_SOC_RT5514_SPI
 	tristate
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b301bfff1c09..f5ef912190ed 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -259,7 +259,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         select SND_SOC_INTEL_SST
         select SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
-        select SND_SOC_RT5514
+        select SND_SOC_RT5514_I2C
         select SND_SOC_MAX98927
         select SND_SOC_HDAC_HDMI
         help
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 5c68797f36c4..6ccf73ae77ca 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -67,7 +67,7 @@ config SND_SOC_MT8173_RT5650_RT5514
 	tristate "ASoC Audio driver for MT8173 with RT5650 RT5514 codecs"
 	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
-	select SND_SOC_RT5514
+	select SND_SOC_RT5514_I2C
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
 	  with the RT5650 and RT5514 codecs.
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index c84487805876..c1139aecdfbe 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -65,7 +65,6 @@ config SND_SOC_RK3399_GRU_SOUND
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP && SPI
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98357A
-	select SND_SOC_RT5514
 	select SND_SOC_DA7219
 	select SND_SOC_RT5514_SPI
 	help
-- 
2.9.0
