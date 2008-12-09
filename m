From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 12/18] ASoC: Register platform DAIs
Date: Tue,  9 Dec 2008 14:01:36 +0000
Message-ID: <1228831302-17605-12-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35ACC2446D
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 15:01:46 +0100 (CET)
In-Reply-To: <1228831302-17605-11-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Register all platform DAIs with the core.  In line with current behaviour
this is done at module probe time rather than when the devices are probed
(since currently that only happens as the entire ASoC card is registered
except for those drivers that currently implement some kind of hotplug).
Since the core currently ignores DAI registration this has no practical
effect.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/atmel_ssc_dai.c  |   11 +++++++++++
 sound/soc/au1x/psc-ac97.c        |    3 ++-
 sound/soc/au1x/psc-i2s.c         |    3 ++-
 sound/soc/blackfin/bf5xx-ac97.c  |   12 ++++++++++++
 sound/soc/blackfin/bf5xx-i2s.c   |   12 ++++++++++++
 sound/soc/davinci/davinci-i2s.c  |   12 ++++++++++++
 sound/soc/fsl/fsl_ssi.c          |   10 ++++++++++
 sound/soc/omap/omap-mcbsp.c      |   13 +++++++++++++
 sound/soc/pxa/pxa-ssp.c          |   12 ++++++++++++
 sound/soc/pxa/pxa2xx-ac97.c      |   12 ++++++++++++
 sound/soc/pxa/pxa2xx-i2s.c       |   13 ++++++++++++-
 sound/soc/s3c24xx/s3c2412-i2s.c  |   13 +++++++++++++
 sound/soc/s3c24xx/s3c2443-ac97.c |   13 +++++++++++++
 sound/soc/s3c24xx/s3c24xx-i2s.c  |   12 ++++++++++++
 sound/soc/sh/hac.c               |   12 ++++++++++++
 sound/soc/sh/ssi.c               |   12 ++++++++++++
 16 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index d9b874c..c9f02ed 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -772,6 +772,17 @@ struct snd_soc_dai atmel_ssc_dai[NUM_SSC_DEVICES] = {
 };
 EXPORT_SYMBOL_GPL(atmel_ssc_dai);
 
+static int __devinit atmel_ssc_modinit(void)
+{
+	return snd_soc_register_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
+}
+module_init(snd_soc_init);
+
+static void __exit snd_soc_exit(void)
+{
+	snd_soc_unregister_dais(atmel_ssc_dai, ARRAY_SIZE(atmel_ssc_dai));
+}
+
 /* Module information */
 MODULE_AUTHOR("Sedji Gaouaou, sedji.gaouaou@atmel.com, www.atmel.com");
 MODULE_DESCRIPTION("ATMEL SSC ASoC Interface");
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a1e824d..f0e30ae 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -371,11 +371,12 @@ EXPORT_SYMBOL_GPL(au1xpsc_ac97_dai);
 static int __init au1xpsc_ac97_init(void)
 {
 	au1xpsc_ac97_workdata = NULL;
-	return 0;
+	return snd_soc_register_dai(&au1xpsc_ac97_dai);
 }
 
 static void __exit au1xpsc_ac97_exit(void)
 {
+	snd_soc_unregister_dai(&au1xpsc_ac97_dai);
 }
 
 module_init(au1xpsc_ac97_init);
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 16f9746..f916de4 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -396,11 +396,12 @@ EXPORT_SYMBOL(au1xpsc_i2s_dai);
 static int __init au1xpsc_i2s_init(void)
 {
 	au1xpsc_i2s_workdata = NULL;
-	return 0;
+	return snd_soc_register_dai(&au1xpsc_i2s_dai);
 }
 
 static void __exit au1xpsc_i2s_exit(void)
 {
+	snd_soc_unregister_dai(&au1xpsc_i2s_dai);
 }
 
 module_init(au1xpsc_i2s_init);
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index c602ce1..ad3efee 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -431,6 +431,18 @@ struct snd_soc_dai bfin_ac97_dai = {
 };
 EXPORT_SYMBOL_GPL(bfin_ac97_dai);
 
+static int __devinit bfin_ac97_init(void)
+{
+	return snd_soc_register_dai(&bfin_ac97_dai);
+}
+module_init(bfin_ac97_init);
+
+static void __exit bfin_ac97_exit(void)
+{
+	snd_soc_unregister_dai(&bfin_ac97_dai);
+}
+module_exit(bfin_ac97_exit);
+
 MODULE_AUTHOR("Roy Huang");
 MODULE_DESCRIPTION("AC97 driver for ADI Blackfin");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 9f8ce87..0d58d2b 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -313,6 +313,18 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(bf5xx_i2s_dai);
 
+static int __devinit bfin_i2s_init(void)
+{
+	return snd_soc_register_dai(&bfin_i2s_dai);
+}
+module_init(bfin_i2s_init);
+
+static void __exit bfin_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&bfin_i2s_dai);
+}
+module_exit(bfin_i2s_exit);
+
 /* Module information */
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("I2S driver for ADI Blackfin");
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 8b99efb..d89fc2f 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -481,6 +481,18 @@ struct snd_soc_dai davinci_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(davinci_i2s_dai);
 
+static int __devinit davinci_i2s_init(void)
+{
+	return snd_soc_register_dai(&davinci_i2s_dai);
+}
+module_init(davinci_i2s_init);
+
+static void __exit davinci_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&davinci_i2s_dai);
+}
+module_exit(davinci_i2s_exit);
+
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI I2S (McBSP) SoC Interface");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 52c290b..c6d6eb7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -673,6 +673,14 @@ struct snd_soc_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
 	fsl_ssi_dai->private_data = ssi_private;
 	fsl_ssi_dai->name = ssi_private->name;
 	fsl_ssi_dai->id = ssi_info->id;
+	fsl_ssi_dai->dev = ssi_info->dev;
+
+	ret = snd_soc_register_dai(fsl_ssi_dai);
+	if (ret != 0) {
+		dev_err(ssi_info->dev, "failed to register DAI: %d\n", ret);
+		kfree(fsl_ssi_dai);
+		return NULL;
+	}
 
 	return fsl_ssi_dai;
 }
@@ -690,6 +698,8 @@ void fsl_ssi_destroy_dai(struct snd_soc_dai *fsl_ssi_dai)
 
 	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
 
+	snd_soc_unregister_dai(&ssi_private->cpu_dai);
+
 	kfree(ssi_private);
 }
 EXPORT_SYMBOL_GPL(fsl_ssi_destroy_dai);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e8f1314..41cab20 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -499,6 +499,19 @@ struct snd_soc_dai omap_mcbsp_dai[] = {
 
 EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
 
+static int __devinit omap_mcbsp_init(void)
+{
+	return snd_soc_register_dais(omap_mcbsp_dai,
+				     ARRAY_SIZE(omap_mcbsp_dai));
+}
+module_init(omap_mcbsp_init);
+
+static void __exit omap_mcbsp_exit(void)
+{
+	snd_soc_unregister_dais(omap_mcbsp_dai, ARRAY_SIZE(omap_mcbsp_dai));
+}
+module_exit(omap_mcbsp_exit);
+
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
 MODULE_DESCRIPTION("OMAP I2S SoC Interface");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 73fa10d..3587f2f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -913,6 +913,18 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 };
 EXPORT_SYMBOL_GPL(pxa_ssp_dai);
 
+static int __devinit pxa_ssp_init(void)
+{
+	return snd_soc_register_dais(pxa_ssp_dai, ARRAY_SIZE(pxa_ssp_dai));
+}
+module_init(pxa_ssp_init);
+
+static void __exit pxa_ssp_exit(void)
+{
+	snd_soc_unregister_dais(pxa_ssp_dai, ARRAY_SIZE(pxa_ssp_dai));
+}
+module_exit(pxa_ssp_exit);
+
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("PXA SSP/PCM SoC Interface");
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 8eed80d..f6249d5 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -228,6 +228,18 @@ struct snd_soc_dai pxa_ac97_dai[] = {
 EXPORT_SYMBOL_GPL(pxa_ac97_dai);
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
+static int __devinit pxa_ac97_init(void)
+{
+	return snd_soc_register_dais(pxa_ac97_dai, ARRAY_SIZE(pxa_ac97_dai));
+}
+module_init(pxa_ac97_init);
+
+static void __exit pxa_ac97_exit(void)
+{
+	snd_soc_unregister_dais(pxa_ac97_dai, ARRAY_SIZE(pxa_ac97_dai));
+}
+module_exit(pxa_ac97_exit);
+
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 314973a..517991f 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -364,12 +364,23 @@ EXPORT_SYMBOL_GPL(pxa_i2s_dai);
 
 static int pxa2xx_i2s_probe(struct platform_device *dev)
 {
+	int ret;
+
 	clk_i2s = clk_get(&dev->dev, "I2SCLK");
-	return IS_ERR(clk_i2s) ? PTR_ERR(clk_i2s) : 0;
+	if (IS_ERR(clk_i2s))
+		return PTR_ERR(clk_i2s);
+
+	pxa_i2s_dai.dev = &dev->dev;
+	ret = snd_soc_register_dai(&pxa_i2s_dai);
+	if (ret != 0)
+		clk_put(clk_i2s);
+
+	return ret;
 }
 
 static int __devexit pxa2xx_i2s_remove(struct platform_device *dev)
 {
+	snd_soc_unregister_dai(&pxa_i2s_dai);
 	clk_put(clk_i2s);
 	clk_i2s = ERR_PTR(-ENOENT);
 	return 0;
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 75f87c3..2cf0507 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -736,6 +736,19 @@ struct snd_soc_dai s3c2412_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(s3c2412_i2s_dai);
 
+static int __devinit s3c2412_i2s_init(void)
+{
+	return snd_soc_register_dai(&s3c2412_i2s_dai);
+}
+module_init(s3c2412_i2s_init);
+
+static void __exit s3c2412_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&s3c2412_i2s_dai);
+}
+module_exit(s3c2412_i2s_exit);
+
+
 /* Module information */
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C2412 I2S SoC Interface");
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index f0bc9b7..7360c6d 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -396,6 +396,19 @@ struct snd_soc_dai s3c2443_ac97_dai[] = {
 EXPORT_SYMBOL_GPL(s3c2443_ac97_dai);
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
+static int __devinit s3c2443_ac97_init(void)
+{
+	return snd_soc_register_dai(&s3c2443_ac97_dai);
+}
+module_init(s3c2443_ac97_init);
+
+static void __exit s3c2443_ac97_exit(void)
+{
+	snd_soc_unregister_dai(&s3c2443_ac97_dai);
+}
+module_exit(s3c2443_ac97_exit);
+
+
 MODULE_AUTHOR("Graeme Gregory");
 MODULE_DESCRIPTION("AC97 driver for the Samsung s3c2443 chip");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 45fe8f7..897b1ac 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -482,6 +482,18 @@ struct snd_soc_dai s3c24xx_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_dai);
 
+static int __devinit s3c24xx_i2s_init(void)
+{
+	return snd_soc_register_dai(&s3c24xx_i2s_dai);
+}
+module_init(s3c24xx_i2s_init);
+
+static void __exit s3c24xx_i2s_exit(void)
+{
+	snd_soc_unregister_dai(&s3c24xx_i2s_dai);
+}
+module_exit(s3c24xx_i2s_exit);
+
 /* Module information */
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("s3c24xx I2S SoC Interface");
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index c435913..9169bad 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -314,6 +314,18 @@ struct snd_soc_dai sh4_hac_dai[] = {
 };
 EXPORT_SYMBOL_GPL(sh4_hac_dai);
 
+static int __devinit sh4_hac_init(void)
+{
+	return snd_soc_register_dais(sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
+}
+module_init(sh4_hac_init);
+
+static void __exit sh4_hac_exit(void)
+{
+	snd_soc_unregister_dais(sh4_hac_dai, ARRAY_SIZE(sh4_hac_dai));
+}
+module_exit(sh4_hac_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip HAC (AC97) audio driver");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index fed544a..9093588 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -392,6 +392,18 @@ struct snd_soc_dai sh4_ssi_dai[] = {
 };
 EXPORT_SYMBOL_GPL(sh4_ssi_dai);
 
+static int __devinit sh4_ssi_init(void)
+{
+	return snd_soc_register_dais(sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
+}
+module_init(sh4_ssi_init);
+
+static void __exit sh4_ssi_exit(void)
+{
+	snd_soc_unregister_dais(sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
+}
+module_exit(sh4_ssi_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip SSI (I2S) audio driver");
 MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.5.6.5
