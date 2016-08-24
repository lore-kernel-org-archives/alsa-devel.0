From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH -next] sound: rockchip: fix build when SPI_MASTER is not
 enabled
Date: Wed, 24 Aug 2016 10:57:20 -0700
Message-ID: <22fcb876-1a27-0ff4-3f18-5079281c247e@infradead.org>
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
To: moderated for non-subscribers <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Fix multiple build errors in sound/soc/rockchip/ drivers by
adding "depends on SPI_MASTER".

Fixes these build errors:
sound/built-in.o: In function `rt5514_spi_burst_read':
(.text+0x6c26c): undefined reference to `spi_sync'
sound/built-in.o: In function `rt5514_spi_burst_write':
(.text+0x6c96e): undefined reference to `spi_sync'
sound/built-in.o: In function `rockchip_sound_probe':
rk3399_gru_sound.c:(.text+0x9f579): undefined reference to `spi_bus_type'
sound/built-in.o: In function `rt5514_spi_driver_init':
rt5514-spi.c:(.init.text+0x983): undefined reference to `__spi_register_driver'

Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc:	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc:	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc:	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
---
 sound/soc/rockchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20160824.orig/sound/soc/rockchip/Kconfig
+++ linux-next-20160824/sound/soc/rockchip/Kconfig
@@ -45,6 +45,7 @@ config SND_SOC_ROCKCHIP_RT5645
 config SND_SOC_RK3399_GRU_SOUND
 	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	depends on SPI_MASTER
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98357A
 	select SND_SOC_RT5514
