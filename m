From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: [PATCH 2/3] ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs
Date: Tue, 20 Mar 2018 13:03:31 -0300
Message-ID: <20180320160332.13212-3-ezequiel@vanguardiasur.com.ar>
References: <20180320160332.13212-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180320160332.13212-1-ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Ezequiel Garcia <ezequiel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Ezequiel Garcia <ezequiel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

The driver does not select all the codec drivers that needs.
Fix it by selecting the analog and HDMI codecs.

Cc: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Signed-off-by: Ezequiel Garcia <ezequiel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 sound/soc/rockchip/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b0825370d262..957046ac6c8c 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -56,6 +56,9 @@ config SND_SOC_RK3288_HDMI_ANALOG
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_HDMI_CODEC
+	select SND_SOC_ES8328_I2C
+	select SND_SOC_ES8328_SPI if SPI_MASTER
+	select DRM_DW_HDMI_I2S_AUDIO if DRM_DW_HDMI
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  RK3288 boards using an analog output and the built-in HDMI audio.
-- 
2.16.2
