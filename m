From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 3/4] ASoC: pxa2xx-i2s: remove GPIO pin setup
Date: Tue,  3 Feb 2009 17:19:42 +0100
Message-ID: <1233677983-23710-4-git-send-email-philipp.zabel@gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f27.google.com (mail-fx0-f27.google.com
	[209.85.220.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FF7C10384F
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:26:30 +0100 (CET)
Received: by fxm8 with SMTP id 8so1175270fxm.8
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:26:30 -0800 (PST)
In-Reply-To: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

This should be done during board init via pxa2xx_mfp_config instead.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |   36 ------------------------------------
 1 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 517991f..83b59d7 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -25,20 +25,11 @@
 
 #include <mach/hardware.h>
 #include <mach/pxa-regs.h>
-#include <mach/pxa2xx-gpio.h>
 #include <mach/audio.h>
 
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-i2s.h"
 
-struct pxa2xx_gpio {
-	u32 sys;
-	u32	rx;
-	u32 tx;
-	u32 clk;
-	u32 frm;
-};
-
 /*
  * I2S Controller Register and Bit Definitions
  */
@@ -106,21 +97,6 @@ static struct pxa2xx_pcm_dma_params pxa2xx_i2s_pcm_stereo_in = {
 				  DCMD_BURST32 | DCMD_WIDTH4,
 };
 
-static struct pxa2xx_gpio gpio_bus[] = {
-	{ /* I2S SoC Slave */
-		.rx = GPIO29_SDATA_IN_I2S_MD,
-		.tx = GPIO30_SDATA_OUT_I2S_MD,
-		.clk = GPIO28_BITCLK_IN_I2S_MD,
-		.frm = GPIO31_SYNC_I2S_MD,
-	},
-	{ /* I2S SoC Master */
-		.rx = GPIO29_SDATA_IN_I2S_MD,
-		.tx = GPIO30_SDATA_OUT_I2S_MD,
-		.clk = GPIO28_BITCLK_OUT_I2S_MD,
-		.frm = GPIO31_SYNC_I2S_MD,
-	},
-};
-
 static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -181,9 +157,6 @@ static int pxa2xx_i2s_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	if (clk_id != PXA2XX_I2S_SYSCLK)
 		return -ENODEV;
 
-	if (pxa_i2s.master && dir == SND_SOC_CLOCK_OUT)
-		pxa_gpio_mode(gpio_bus[pxa_i2s.master].sys);
-
 	return 0;
 }
 
@@ -194,10 +167,6 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
-	pxa_gpio_mode(gpio_bus[pxa_i2s.master].rx);
-	pxa_gpio_mode(gpio_bus[pxa_i2s.master].tx);
-	pxa_gpio_mode(gpio_bus[pxa_i2s.master].frm);
-	pxa_gpio_mode(gpio_bus[pxa_i2s.master].clk);
 	BUG_ON(IS_ERR(clk_i2s));
 	clk_enable(clk_i2s);
 	pxa_i2s_wait();
@@ -398,11 +367,6 @@ static struct platform_driver pxa2xx_i2s_driver = {
 
 static int __init pxa2xx_i2s_init(void)
 {
-	if (cpu_is_pxa27x())
-		gpio_bus[1].sys = GPIO113_I2S_SYSCLK_MD;
-	else
-		gpio_bus[1].sys = GPIO32_SYSCLK_I2S_MD;
-
 	clk_i2s = ERR_PTR(-ENOENT);
 	return platform_driver_register(&pxa2xx_i2s_driver);
 }
-- 
1.5.6.5
