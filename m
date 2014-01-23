From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ASoC: Samsung: Fix Kconfig dependency
Date: Thu, 23 Jan 2014 16:22:06 +0530
Message-ID: <1390474326-5544-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A95BC264E9F
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 11:56:36 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id fa1so1723279pad.0
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 02:56:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Select S3C24XX_DMA instead of S3C2410_DMA to avoid following dependency issues
and build errors:

warning: (CPU_S3C2410 && CPU_S3C2442 && SND_SOC_SAMSUNG && SND_S3C24XX_I2S && SND_S3C2412_SOC_I2S && SND_SOC_SAMSUNG_SMDK2443_WM9710 && SND_SOC_SAMSUNG_LN2440SBC_ALC650) selects S3C2410_DMA which has unmet direct dependencies (ARCH_S3C24XX && S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442))
warning: (CPU_S3C2410 && CPU_S3C2442 && SND_SOC_SAMSUNG && SND_S3C24XX_I2S && SND_S3C2412_SOC_I2S && SND_SOC_SAMSUNG_SMDK2443_WM9710 && SND_SOC_SAMSUNG_LN2440SBC_ALC650) selects S3C2410_DMA which has unmet direct dependencies (ARCH_S3C24XX && S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442))

arch/arm/mach-s3c24xx/built-in.o: In function `s3c2410_dma_add':
arch/arm/mach-s3c24xx/dma-s3c2410.c:134: undefined reference to `s3c2410_dma_init'
arch/arm/mach-s3c24xx/dma-s3c2410.c:135: undefined reference to `s3c24xx_dma_order_set'
arch/arm/mach-s3c24xx/dma-s3c2410.c:136: undefined reference to `s3c24xx_dma_init_map'
arch/arm/plat-samsung/include/plat/dma-ops.h:60: undefined reference to `s3c_dma_get_ops'
sound/soc/samsung/s3c24xx-i2s.c:293: undefined reference to `s3c2410_dma_ctrl'
arch/arm/plat-samsung/include/plat/dma-ops.h:60: undefined reference to `s3c_dma_get_ops'
arch/arm/plat-samsung/include/plat/dma-ops.h:60: undefined reference to `s3c_dma_get_ops'
sound/built-in.o: In function `s3c2412_i2s_trigger':
sound/soc/samsung/s3c-i2s-v2.c:432: undefined reference to `s3c2410_dma_ctrl'

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 27930fc432dc..e8fbf4e5732f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -19,7 +19,7 @@ config SND_S3C_DMA_LEGACY
 
 config SND_S3C24XX_I2S
 	tristate
-	select S3C2410_DMA
+	select S3C24XX_DMA
 
 config SND_S3C_I2SV2_SOC
 	tristate
-- 
1.7.9.5
