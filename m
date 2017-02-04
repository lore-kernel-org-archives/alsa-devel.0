From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Allow to select ES8328_I2C and ES8328_SPI directly" to the asoc tree
Date: Sat, 04 Feb 2017 13:18:17 +0100
Message-ID: <E1cZzIH-0005S9-K1@finisterre>
References: <20170203143800.23859-3-romain.perier@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170203143800.23859-3-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Allow to select ES8328_I2C and ES8328_SPI directly

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aa00f2c8aff7b85f882b6fd1706fc4241046aba7 Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Date: Fri, 3 Feb 2017 15:37:58 +0100
Subject: [PATCH] ASoC: Allow to select ES8328_I2C and ES8328_SPI directly

Currently, we have to select these symbols explictly via Kconfig, from
another entry. If we plan to use generic audio drivers like
simple-audio-card, the user need to be able to enable these symbols
directly via the menuconfig.

This commit also fixes unmet dependencies to SND_SOC_IMX_ES8328 caused
by these changes.

Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/Kconfig | 8 ++++----
 sound/soc/fsl/Kconfig    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a8cb1c..cfa423338963 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -528,12 +528,12 @@ config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
 config SND_SOC_ES8328_I2C
-	tristate
-	select SND_SOC_ES8328
+	depends on SND_SOC_ES8328
+	tristate "I2C support for Everest Semi ES8328 CODEC"
 
 config SND_SOC_ES8328_SPI
-	tristate
-	select SND_SOC_ES8328
+	depends on SND_SOC_ES8328
+	tristate "SPI support for Everest Semi ES8328 CODEC"
 
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 37f9b6201918..0b914a1ca8d2 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -244,7 +244,7 @@ config SND_SOC_IMX_WM8962
 
 config SND_SOC_IMX_ES8328
 	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
-	depends on OF && (I2C || SPI)
+	depends on OF && (I2C || SPI) && SND_SOC_ES8328
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_IMX_PCM_DMA
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
