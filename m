From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: s3c24xx-i2s: pass DMA channels as
	platform data" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:45 +0000
Message-ID: <E1Zz7Av-0000Mv-Hc@debutante>
References: <5998295.uG2eFL3eef@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85D13265D12
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:54 +0100 (CET)
In-Reply-To: <5998295.uG2eFL3eef@wuerfel>
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

   ASoC: s3c24xx-i2s: pass DMA channels as platform data

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

>From 359fdfa6fde04b3a752df5251b1dcd8866d436fa Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 18 Nov 2015 15:26:00 +0100
Subject: [PATCH] ASoC: s3c24xx-i2s: pass DMA channels as platform data

This is a minor cleanup to make the s3c2412-i2s and s3c24xx-i2s
drivers independent of the mach/dma.h header file and to allow
removing the dependency on the specific dmaengine driver in the
next patch.

As a side not, only the s3c24xx-i2s driver seems to still be
used, while the definition of the s3c2412-i2s platform device was
removed in commit 6d259a25b56d ("ARM: SAMSUNG: use static
declaration when it is not used in other files") after it had
never been referenced since its introduction in f0fba2ad1b6b
("ASoC: multi-component - ASoC Multi-Component Support").

Apparently it should have been used by mach-jive.c, but that
never happened. My patch at this point leaves the current state
unchanged, we can decide whether to fix or delete the jive
driver and s3c2412-i2s another time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/plat-samsung/devs.c    |  6 ++++++
 sound/soc/samsung/s3c2412-i2s.c | 12 ++++++++++--
 sound/soc/samsung/s3c24xx-i2s.c | 12 ++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e212f9d804bd..823de7b4e53b 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -571,6 +571,11 @@ static struct resource s3c_iis_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
 };
 
+static struct s3c_audio_pdata s3c_iis_platdata = {
+	.dma_playback = (void *)DMACH_I2S_OUT,
+	.dma_capture = (void *)DMACH_I2S_IN,
+};
+
 struct platform_device s3c_device_iis = {
 	.name		= "s3c24xx-iis",
 	.id		= -1,
@@ -579,6 +584,7 @@ struct platform_device s3c_device_iis = {
 	.dev		= {
 		.dma_mask		= &samsung_device_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &s3c_iis_platdata,
 	}
 };
 #endif /* CONFIG_PLAT_S3C24XX */
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 77d27c85a32a..105317f523f2 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -33,14 +33,14 @@
 #include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
+#include <linux/platform_data/asoc-s3c.h>
+
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_out = {
-	.slave		= (void *)(uintptr_t)DMACH_I2S_OUT,
 	.ch_name	= "tx",
 	.dma_size	= 4,
 };
 
 static struct s3c_dma_params s3c2412_i2s_pcm_stereo_in = {
-	.slave		= (void *)(uintptr_t)DMACH_I2S_IN,
 	.ch_name	= "rx",
 	.dma_size	= 4,
 };
@@ -152,6 +152,12 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct resource *res;
+	struct s3c_audio_pdata *pdata = dev_get_platdata(&pdev->dev);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data");
+		return -ENXIO;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	s3c2412_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
@@ -159,7 +165,9 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(s3c2412_i2s.regs);
 
 	s3c2412_i2s_pcm_stereo_out.dma_addr = res->start + S3C2412_IISTXD;
+	s3c2412_i2s_pcm_stereo_out.slave = pdata->dma_playback;
 	s3c2412_i2s_pcm_stereo_in.dma_addr = res->start + S3C2412_IISRXD;
+	s3c2412_i2s_pcm_stereo_in.slave = pdata->dma_capture;
 
 	ret = s3c_i2sv2_register_component(&pdev->dev, -1,
 					   &s3c2412_i2s_component,
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 9da3a77ea2c7..9e6a5bc012e3 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -31,14 +31,14 @@
 #include "dma.h"
 #include "s3c24xx-i2s.h"
 
+#include <linux/platform_data/asoc-s3c.h>
+
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_out = {
-	.slave		= (void *)(uintptr_t)DMACH_I2S_OUT,
 	.ch_name	= "tx",
 	.dma_size	= 2,
 };
 
 static struct s3c_dma_params s3c24xx_i2s_pcm_stereo_in = {
-	.slave		= (void *)(uintptr_t)DMACH_I2S_IN,
 	.ch_name	= "rx",
 	.dma_size	= 2,
 };
@@ -454,6 +454,12 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct resource *res;
+	struct s3c_audio_pdata *pdata = dev_get_platdata(&pdev->dev);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data");
+		return -ENXIO;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -465,7 +471,9 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(s3c24xx_i2s.regs);
 
 	s3c24xx_i2s_pcm_stereo_out.dma_addr = res->start + S3C2410_IISFIFO;
+	s3c24xx_i2s_pcm_stereo_out.slave = pdata->dma_playback;
 	s3c24xx_i2s_pcm_stereo_in.dma_addr = res->start + S3C2410_IISFIFO;
+	s3c24xx_i2s_pcm_stereo_in.slave = pdata->dma_capture;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 			&s3c24xx_i2s_component, &s3c24xx_i2s_dai, 1);
-- 
2.6.2
