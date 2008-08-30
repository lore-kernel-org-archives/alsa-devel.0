From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] ASoC: fix pxa2xx-i2s clk_get call
Date: Sun, 31 Aug 2008 00:45:02 +0400
Message-ID: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DCBD247E2
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Aug 2008 22:47:19 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so817031fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2008 13:47:18 -0700 (PDT)
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

pxa2xx-isa: probe actual device and use it for clk_get call
thus fixing error during startup hook

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 8548818..c796b18 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -81,7 +82,6 @@ static int pxa2xx_i2s_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 
-	clk_i2s = clk_get(NULL, "I2SCLK");
 	if (IS_ERR(clk_i2s))
 		return PTR_ERR(clk_i2s);
 
@@ -152,6 +152,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].tx);
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].frm);
 	pxa_gpio_mode(gpio_bus[pxa_i2s.master].clk);
+	BUG_ON(IS_ERR(clk_i2s));
 	clk_enable(clk_i2s);
 	pxa_i2s_wait();
 
@@ -317,6 +318,43 @@ struct snd_soc_dai pxa_i2s_dai = {
 
 EXPORT_SYMBOL_GPL(pxa_i2s_dai);
 
+static int pxa2xx_i2s_probe(struct platform_device *dev)
+{
+	clk_i2s = clk_get(&dev->dev, "I2SCLK");
+	return IS_ERR(clk_i2s) ? PTR_ERR(clk_i2s) : 0;
+}
+
+static int __devexit pxa2xx_i2s_remove(struct platform_device *dev)
+{
+	clk_put(clk_i2s);
+	clk_i2s = ERR_PTR(-ENOENT);
+	return 0;
+}
+
+static struct platform_driver pxa2xx_i2s_driver = {
+	.probe = pxa2xx_i2s_probe,
+	.remove = __devexit_p(pxa2xx_i2s_remove),
+
+	.driver = {
+		.name = "pxa2xx-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init pxa2xx_i2s_init(void)
+{
+	clk_i2s = ERR_PTR(-ENOENT);
+	return platform_driver_register(&pxa2xx_i2s_driver);
+}
+
+static void __exit pxa2xx_i2s_exit(void)
+{
+	platform_driver_unregister(&pxa2xx_i2s_driver);
+}
+
+module_init(pxa2xx_i2s_init);
+module_exit(pxa2xx_i2s_exit);
+
 /* Module information */
 MODULE_AUTHOR("Liam Girdwood, liam.girdwood@wolfsonmicro.com, www.wolfsonmicro.com");
 MODULE_DESCRIPTION("pxa2xx I2S SoC Interface");
-- 
1.5.6.3
