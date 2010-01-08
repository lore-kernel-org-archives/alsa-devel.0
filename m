From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Convert new i.MX SSI driver to use
	static DAI array
Date: Fri,  8 Jan 2010 16:19:57 +0000
Message-ID: <1262967598-4096-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C225C103857
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 17:20:02 +0100 (CET)
In-Reply-To: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

While dynamically allocated DAIs are the way forward the core doesn't
yet support anything except matching with a pointer to the actual DAI
so convert to doing that so that machine drivers don't have to jump
through hoops to register themselves.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/imx-ssi.c |   40 ++++++++++++++++++++--------------------
 sound/soc/imx/imx-ssi.h |    3 +--
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index c57a11f..ccb7ec9 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -60,7 +60,7 @@
 static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	u32 sccr;
 
 	sccr = readl(ssi->base + SSI_STCCR);
@@ -87,7 +87,7 @@ static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
  */
 static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	u32 strcr = 0, scr;
 
 	scr = readl(ssi->base + SSI_SCR) & ~(SSI_SCR_SYN | SSI_SCR_NET);
@@ -160,7 +160,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 static int imx_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	u32 scr;
 
 	scr = readl(ssi->base + SSI_SCR);
@@ -188,7 +188,7 @@ static int imx_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 static int imx_ssi_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 				  int div_id, int div)
 {
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	u32 stccr, srccr;
 
 	stccr = readl(ssi->base + SSI_STCCR);
@@ -237,7 +237,7 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *cpu_dai)
 {
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	u32 reg, sccr;
 
 	/* Tx/Rx config */
@@ -274,7 +274,7 @@ static int imx_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct imx_ssi *ssi = container_of(cpu_dai, struct imx_ssi, dai);
+	struct imx_ssi *ssi = cpu_dai->private_data;
 	unsigned int sier_bits, sier;
 	unsigned int scr;
 
@@ -570,7 +570,7 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 };
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
-struct snd_soc_dai *imx_ssi_pcm_dai[2];
+struct snd_soc_dai imx_ssi_pcm_dai[2];
 EXPORT_SYMBOL_GPL(imx_ssi_pcm_dai);
 
 static int imx_ssi_probe(struct platform_device *pdev)
@@ -581,6 +581,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	struct snd_soc_platform *platform;
 	int ret = 0;
 	unsigned int val;
+	struct snd_soc_dai *dai = &imx_ssi_pcm_dai[pdev->id];
+
+	if (dai->id >= ARRAY_SIZE(imx_ssi_pcm_dai))
+		return -EINVAL;
 
 	ssi = kzalloc(sizeof(*ssi), GFP_KERNEL);
 	if (!ssi)
@@ -592,8 +596,6 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		ssi->flags = pdata->flags;
 	}
 
-	imx_ssi_pcm_dai[pdev->id] = &ssi->dai;
-
 	ssi->irq = platform_get_irq(pdev, 0);
 
 	ssi->clk = clk_get(&pdev->dev, NULL);
@@ -631,13 +633,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		}
 		ac97_ssi = ssi;
 		setup_channel_to_ac97(ssi);
-		memcpy(&ssi->dai, &imx_ac97_dai, sizeof(imx_ac97_dai));
+		memcpy(dai, &imx_ac97_dai, sizeof(imx_ac97_dai));
 	} else
-		memcpy(&ssi->dai, &imx_ssi_dai, sizeof(imx_ssi_dai));
-
-	ssi->dai.id = pdev->id;
-	ssi->dai.dev = &pdev->dev;
-	ssi->dai.name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
+		memcpy(dai, &imx_ssi_dai, sizeof(imx_ssi_dai));
 
 	writel(0x0, ssi->base + SSI_SIER);
 
@@ -652,9 +650,10 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	if (res)
 		ssi->dma_params_rx.dma = res->start;
 
-	ssi->dai.id = pdev->id;
-	ssi->dai.dev = &pdev->dev;
-	ssi->dai.name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
+	dai->id = pdev->id;
+	dai->dev = &pdev->dev;
+	dai->name = kasprintf(GFP_KERNEL, "imx-ssi.%d", pdev->id);
+	dai->private_data = ssi;
 
 	if ((cpu_is_mx27() || cpu_is_mx21()) &&
 			!(ssi->flags & IMX_SSI_USE_AC97)) {
@@ -671,7 +670,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
 		SSI_SFCSR_RFWM0(ssi->dma_params_rx.burstsize);
 	writel(val, ssi->base + SSI_SFCSR);
 
-	ret = snd_soc_register_dai(&ssi->dai);
+	ret = snd_soc_register_dai(dai);
 	if (ret) {
 		dev_err(&pdev->dev, "register DAI failed\n");
 		goto failed_register;
@@ -699,8 +698,9 @@ static int __devexit imx_ssi_remove(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+	struct snd_soc_dai *dai = &imx_ssi_pcm_dai[pdev->id];
 
-	snd_soc_unregister_dai(&ssi->dai);
+	snd_soc_unregister_dai(dai);
 
 	if (ssi->flags & IMX_SSI_USE_AC97)
 		ac97_ssi = NULL;
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index cb2c81f..55f26eb 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -183,7 +183,7 @@
 #define IMX_SSI_RX_DIV_PSR	4
 #define IMX_SSI_RX_DIV_PM	5
 
-extern struct snd_soc_dai *imx_ssi_pcm_dai[2];
+extern struct snd_soc_dai imx_ssi_pcm_dai[2];
 extern struct snd_soc_platform imx_soc_platform;
 
 #define DRV_NAME "imx-ssi"
@@ -195,7 +195,6 @@ struct imx_pcm_dma_params {
 };
 
 struct imx_ssi {
-	struct snd_soc_dai dai;
 	struct platform_device *ac97_dev;
 
 	struct snd_soc_device imx_ac97;
-- 
1.6.6
