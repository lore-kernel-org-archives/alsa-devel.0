From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: pass filter function as
	pointer" to the asoc tree
Date: Sat, 21 Nov 2015 14:01:34 +0000
Message-ID: <E1a08jO-0001CJ-OQ@finisterre>
References: <22941104.ypKpSkv4En@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC3B726085B
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:03:28 +0100 (CET)
In-Reply-To: <22941104.ypKpSkv4En@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: pass filter function as pointer

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

>From 9bdca822cbd6b66124f2298504b6c4526599dc8f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2015 22:31:11 +0100
Subject: [PATCH] ASoC: samsung: pass filter function as pointer

As we are now passing the filter data as pointers to the drivers,
we can take the final step and also pass the filter function the
same way. I'm keeping this change separate, as there it's less
obvious that this is a net win.

Upsides of this are:

- The ASoC drivers are completely independent from the DMA engine
  implementation, which simplifies the Kconfig logic and in theory
  allows the same sound drivers to be built in a kernel that supports
  different kinds of dmaengine drivers.

- Consistency with other subsystems and drivers

On the other hand, we have a few downsides:

- The s3c24xx-dma driver now needs to be built-in for the ac97 platform
  device to be instantiated on s3c2440.

- samsung_dmaengine_pcm_config cannot be marked 'const' any more
  because the filter function pointer needs to be set at runtime.
  This is safe as long we don't have multiple different DMA engines
  in thet same system at runtime, but is nonetheless ugly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-s3c64xx/dev-audio.c      |  6 ++++++
 arch/arm/plat-samsung/devs.c           |  6 ++++++
 drivers/dma/Kconfig                    |  2 +-
 include/linux/platform_data/asoc-s3c.h |  4 ++++
 sound/soc/samsung/Kconfig              |  2 --
 sound/soc/samsung/ac97.c               |  3 ++-
 sound/soc/samsung/dma.h                |  4 +++-
 sound/soc/samsung/dmaengine.c          | 16 +++++-----------
 sound/soc/samsung/i2s.c                | 11 ++++++++---
 sound/soc/samsung/pcm.c                |  5 ++++-
 sound/soc/samsung/s3c2412-i2s.c        |  4 ++--
 sound/soc/samsung/s3c24xx-i2s.c        |  4 ++--
 sound/soc/samsung/spdif.c              |  9 +++++++--
 13 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 9a42736..b577833 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -58,6 +58,7 @@ static struct resource s3c64xx_iis0_resource[] = {
 
 static struct s3c_audio_pdata i2s0_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_I2S0_OUT,
 	.dma_capture = DMACH_I2S0_IN,
 };
@@ -79,6 +80,7 @@ static struct resource s3c64xx_iis1_resource[] = {
 
 static struct s3c_audio_pdata i2s1_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_I2S1_OUT,
 	.dma_capture = DMACH_I2S1_IN,
 };
@@ -100,6 +102,7 @@ static struct resource s3c64xx_iisv4_resource[] = {
 
 static struct s3c_audio_pdata i2sv4_pdata = {
 	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_HSI_I2SV40_TX,
 	.dma_capture = DMACH_HSI_I2SV40_RX,
 	.type = {
@@ -150,6 +153,7 @@ static struct resource s3c64xx_pcm0_resource[] = {
 
 static struct s3c_audio_pdata s3c_pcm0_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_capture = DMACH_PCM0_RX,
 	.dma_playback = DMACH_PCM0_TX,
 };
@@ -171,6 +175,7 @@ static struct resource s3c64xx_pcm1_resource[] = {
 
 static struct s3c_audio_pdata s3c_pcm1_pdata = {
 	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+	.dma_filter = pl08x_filter_id,
 	.dma_playback = DMACH_PCM1_TX,
 	.dma_capture = DMACH_PCM1_RX,
 };
@@ -205,6 +210,7 @@ static struct resource s3c64xx_ac97_resource[] = {
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
 	.dma_playback = DMACH_AC97_PCMOUT,
+	.dma_filter = pl08x_filter_id,
 	.dma_capture = DMACH_AC97_PCMIN,
 	.dma_capture_mic = DMACH_AC97_MICIN,
 };
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 823de7b..7263e95 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -78,6 +78,9 @@ static struct resource s3c_ac97_resource[] = {
 };
 
 static struct s3c_audio_pdata s3c_ac97_pdata = {
+#ifdef CONFIG_S3C24XX_DMAC
+	.dma_filter = s3c24xx_dma_filter,
+#endif
 	.dma_playback = (void *)DMACH_PCM_OUT,
 	.dma_capture = (void *)DMACH_PCM_IN,
 	.dma_capture_mic = (void *)DMACH_MIC_IN,
@@ -572,6 +575,9 @@ static struct resource s3c_iis_resource[] = {
 };
 
 static struct s3c_audio_pdata s3c_iis_platdata = {
+#ifdef CONFIG_S3C24XX_DMAC
+	.dma_filter = s3c24xx_dma_filter,
+#endif
 	.dma_playback = (void *)DMACH_I2S_OUT,
 	.dma_capture = (void *)DMACH_I2S_IN,
 };
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index e6cd1a3..17655d9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -432,7 +432,7 @@ config STE_DMA40
 	  Support for ST-Ericsson DMA40 controller
 
 config S3C24XX_DMAC
-	tristate "Samsung S3C24XX DMA support"
+	bool "Samsung S3C24XX DMA support"
 	depends on ARCH_S3C24XX
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
diff --git a/include/linux/platform_data/asoc-s3c.h b/include/linux/platform_data/asoc-s3c.h
index 33f88b4..15bf56e 100644
--- a/include/linux/platform_data/asoc-s3c.h
+++ b/include/linux/platform_data/asoc-s3c.h
@@ -13,6 +13,9 @@
  */
 #define S3C64XX_AC97_GPD  0
 #define S3C64XX_AC97_GPE  1
+
+#include <linux/dmaengine.h>
+
 extern void s3c64xx_ac97_setup_gpio(int);
 
 struct samsung_i2s {
@@ -39,6 +42,7 @@ struct samsung_i2s {
  */
 struct s3c_audio_pdata {
 	int (*cfg_gpio)(struct platform_device *);
+	dma_filter_fn dma_filter;
 	void *dma_playback;
 	void *dma_capture;
 	void *dma_play_sec;
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 3744c9e..78baa26 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,8 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
 	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
-	depends on S3C64XX_PL080 || !ARCH_S3C64XX
-	depends on S3C24XX_DMAC || !ARCH_S3C24XX
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 9c52193..4a7a503 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -388,7 +388,8 @@ static int s3c_ac97_probe(struct platform_device *pdev)
 	if (ret)
 		goto err5;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 ac97_pdata->dma_filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err5;
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 085ef30..a7616cc 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -13,6 +13,7 @@
 #define _S3C_AUDIO_H
 
 #include <sound/dmaengine_pcm.h>
+#include <linux/dmaengine.h>
 
 struct s3c_dma_params {
 	void *slave;				/* Channel ID */
@@ -25,6 +26,7 @@ struct s3c_dma_params {
 void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
 				struct s3c_dma_params *playback,
 				struct s3c_dma_params *capture);
-int samsung_asoc_dma_platform_register(struct device *dev);
+int samsung_asoc_dma_platform_register(struct device *dev,
+				       dma_filter_fn fn);
 
 #endif
diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 727008d..0631259 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -28,17 +28,8 @@
 
 #include "dma.h"
 
-#ifdef CONFIG_ARCH_S3C64XX
-#define filter_fn pl08x_filter_id
-#elif defined(CONFIG_ARCH_S3C24XX)
-#define filter_fn s3c24xx_dma_filter
-#else
-#define filter_fn NULL
-#endif
-
-static const struct snd_dmaengine_pcm_config samsung_dmaengine_pcm_config = {
+static struct snd_dmaengine_pcm_config samsung_dmaengine_pcm_config = {
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.compat_filter_fn = filter_fn,
 };
 
 void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
@@ -67,8 +58,11 @@ void samsung_asoc_init_dma_data(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_init_dma_data);
 
-int samsung_asoc_dma_platform_register(struct device *dev)
+int samsung_asoc_dma_platform_register(struct device *dev,
+				       dma_filter_fn filter)
 {
+	samsung_dmaengine_pcm_config.compat_filter_fn = filter;
+
 	return devm_snd_dmaengine_pcm_register(dev,
 			&samsung_dmaengine_pcm_config,
 			SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME |
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0945b5d..84d9e77 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -89,6 +89,7 @@ struct i2s_dai {
 	struct s3c_dma_params dma_playback;
 	struct s3c_dma_params dma_capture;
 	struct s3c_dma_params idma_playback;
+	dma_filter_fn filter;
 	u32	quirks;
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
@@ -1244,7 +1245,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		if (ret != 0)
 			return ret;
 
-		return samsung_asoc_dma_platform_register(&pdev->dev);
+		return samsung_asoc_dma_platform_register(&pdev->dev,
+							  sec_dai->filter);
 	}
 
 	pri_dai = i2s_alloc_dai(pdev, false);
@@ -1264,6 +1266,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 		pri_dai->dma_playback.slave = i2s_pdata->dma_playback;
 		pri_dai->dma_capture.slave = i2s_pdata->dma_capture;
+		pri_dai->filter = i2s_pdata->dma_filter;
 
 		if (&i2s_pdata->type)
 			i2s_cfg = &i2s_pdata->type.i2s;
@@ -1325,8 +1328,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.ch_name = "tx-sec";
 
-		if (!np)
+		if (!np) {
 			sec_dai->dma_playback.slave = i2s_pdata->dma_play_sec;
+			sec_dai->filter = i2s_pdata->dma_filter;
+		}
 
 		sec_dai->dma_playback.dma_size = 4;
 		sec_dai->addr = pri_dai->addr;
@@ -1348,7 +1353,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter);
 	if (ret != 0)
 		return ret;
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index c77f324..498f563 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -488,6 +488,7 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	struct s3c_pcm_info *pcm;
 	struct resource *mem_res;
 	struct s3c_audio_pdata *pcm_pdata;
+	dma_filter_fn filter;
 	int ret;
 
 	/* Check for valid device index */
@@ -556,9 +557,11 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	s3c_pcm_stereo_out[pdev->id].dma_addr = mem_res->start
 							+ S3C_PCM_TXFIFO;
 
+	filter = NULL;
 	if (pcm_pdata) {
 		s3c_pcm_stereo_in[pdev->id].slave = pcm_pdata->dma_capture;
 		s3c_pcm_stereo_out[pdev->id].slave = pcm_pdata->dma_playback;
+		filter = pcm_pdata->dma_filter;
 	}
 
 	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
@@ -573,7 +576,7 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 		goto err5;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err5;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 105317f..204029d 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -25,7 +25,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 #include <plat/gpio-cfg.h>
 
@@ -177,7 +176,8 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 pdata->dma_filter);
 	if (ret)
 		pr_err("failed to register the DMA: %d\n", ret);
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 9e6a5bc..b3a475d 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -23,7 +23,6 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/dma.h>
 #include <mach/gpio-samsung.h>
 #include <plat/gpio-cfg.h>
 #include "regs-iis.h"
@@ -482,7 +481,8 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev,
+						 pdata->dma_filter);
 	if (ret)
 		pr_err("failed to register the dma: %d\n", ret);
 
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 9dd7ee6..4687f52 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -361,6 +361,7 @@ static int spdif_probe(struct platform_device *pdev)
 	struct s3c_audio_pdata *spdif_pdata;
 	struct resource *mem_res;
 	struct samsung_spdif_info *spdif;
+	dma_filter_fn filter;
 	int ret;
 
 	spdif_pdata = pdev->dev.platform_data;
@@ -426,11 +427,15 @@ static int spdif_probe(struct platform_device *pdev)
 
 	spdif_stereo_out.dma_size = 2;
 	spdif_stereo_out.dma_addr = mem_res->start + DATA_OUTBUF;
-	spdif_stereo_out.slave = spdif_pdata ? spdif_pdata->dma_playback : NULL;
+	filter = NULL;
+	if (spdif_pdata) {
+		spdif_stereo_out.slave = spdif_pdata->dma_playback;
+		filter = spdif_pdata->dma_filter;
+	}
 
 	spdif->dma_playback = &spdif_stereo_out;
 
-	ret = samsung_asoc_dma_platform_register(&pdev->dev);
+	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
 		goto err4;
-- 
2.6.1
