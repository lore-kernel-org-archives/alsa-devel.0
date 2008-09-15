From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Support runtime selection of CPU in
	pxa2xx-i2s
Date: Mon, 15 Sep 2008 14:25:03 +0100
Message-ID: <1221485106-23881-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080915132418.GA23825@rakim.wolfsonmicro.main>
	<1221485106-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1221485106-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DDB124658
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 15:25:08 +0200 (CEST)
In-Reply-To: <1221485106-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index c796b18..21ca3fe 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -65,11 +65,6 @@ static struct pxa2xx_gpio gpio_bus[] = {
 		.frm = GPIO31_SYNC_I2S_MD,
 	},
 	{ /* I2S SoC Master */
-#ifdef CONFIG_PXA27x
-		.sys = GPIO113_I2S_SYSCLK_MD,
-#else
-		.sys = GPIO32_SYSCLK_I2S_MD,
-#endif
 		.rx = GPIO29_SDATA_IN_I2S_MD,
 		.tx = GPIO30_SDATA_OUT_I2S_MD,
 		.clk = GPIO28_BITCLK_OUT_I2S_MD,
@@ -343,6 +338,11 @@ static struct platform_driver pxa2xx_i2s_driver = {
 
 static int __init pxa2xx_i2s_init(void)
 {
+	if (cpu_is_pxa27x())
+		gpio_bus[1].sys = GPIO113_I2S_SYSCLK_MD;
+	else
+		gpio_bus[1].sys = GPIO32_SYSCLK_I2S_MD;
+
 	clk_i2s = ERR_PTR(-ENOENT);
 	return platform_driver_register(&pxa2xx_i2s_driver);
 }
-- 
1.5.6.5
