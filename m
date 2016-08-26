From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] ASoC: rockchip: use SPI dependency for rt5514
Date: Fri, 26 Aug 2016 17:50:55 +0200
Message-ID: <20160826155120.1162512-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The rk3399 scans the spi_bus_type to find the rt5514 driver, but does not
actually have a Kconfig dependency on SPI, so we can end up with a link
failure:

sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_driver_init':
rt5514-spi.c:(.init.text+0x14): undefined reference to `__spi_register_driver'
sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_burst_read':
rt5514-spi.c:(.text.rt5514_spi_burst_read+0x18c): undefined reference to `spi_sync'
sound/soc/codecs/snd-soc-rt5514-spi.o: In function `rt5514_spi_burst_write':
rt5514-spi.c:(.text.rt5514_spi_burst_write+0x1b4): undefined reference to `spi_sync'
sound/soc/rockchip/snd-soc-rk3399-gru-sound.o: In function `rockchip_sound_probe':
rk3399_gru_sound.c:(.text.rockchip_sound_probe+0x128): undefined reference to `spi_bus_type'

This adds the missing dependency.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: c6eac8a36a84 ("ASoC: rockchip: Add machine driver for RK3399 GRU Boards")
---
 sound/soc/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index d82d763d4854..c783f9a22595 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -44,7 +44,7 @@ config SND_SOC_ROCKCHIP_RT5645
 
 config SND_SOC_RK3399_GRU_SOUND
 	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
-	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP && SPI
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5514
-- 
2.9.0
