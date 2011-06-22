From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: core - Fix dai usage in pcm_new()
	platform handlers
Date: Wed, 22 Jun 2011 20:05:29 +0200
Message-ID: <1308765929-14482-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8532480C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:05:39 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 552d1ef ("ASoC: core - Optimise and refactor pcm_new() to pass
only rtd") refactored the ASoC internal core to only pass a pointer
to a runtime as argument to individual pcm_new() functions. However, the
new code that was added to the handlers to get access to the dai now
uses rtd->cpu_dai, while before this patch, rtd->codec_dai was used.

This patch fixes all the pcm_new() handlers that were affected. Tested
on a PXA platform.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 sound/soc/atmel/atmel-pcm.c         |    2 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c |    2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |    2 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |    2 +-
 sound/soc/davinci/davinci-pcm.c     |    2 +-
 sound/soc/fsl/fsl_dma.c             |    2 +-
 sound/soc/fsl/mpc5200_dma.c         |    2 +-
 sound/soc/imx/imx-pcm-fiq.c         |    2 +-
 sound/soc/imx/imx-ssi.c             |    2 +-
 sound/soc/jz4740/jz4740-pcm.c       |    2 +-
 sound/soc/kirkwood/kirkwood-dma.c   |    2 +-
 sound/soc/mid-x86/sst_platform.c    |    2 +-
 sound/soc/nuc900/nuc900-pcm.c       |    2 +-
 sound/soc/omap/omap-pcm.c           |    2 +-
 sound/soc/pxa/pxa2xx-pcm.c          |    2 +-
 sound/soc/s6000/s6000-pcm.c         |    2 +-
 sound/soc/samsung/dma.c             |    2 +-
 sound/soc/tegra/tegra_pcm.c         |    2 +-
 sound/soc/txx9/txx9aclc.c           |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index f81d4c3..d1140c1 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -367,7 +367,7 @@ static u64 atmel_pcm_dmamask = 0xffffffff;
 static int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 9e59f68..fdaed48 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -421,7 +421,7 @@ static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
 int bf5xx_pcm_ac97_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 96d0d90..9bdf1ea 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -251,7 +251,7 @@ static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
 int bf5xx_pcm_i2s_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index c95cc03..2d7e176 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -286,7 +286,7 @@ static u64 bf5xx_pcm_dmamask = DMA_BIT_MASK(32);
 static int bf5xx_pcm_tdm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index a49e667..35b60f9 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -836,7 +836,7 @@ static u64 davinci_pcm_dmamask = 0xffffffff;
 static int davinci_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 732208c..932da5f 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -297,7 +297,7 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
 static int fsl_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	static u64 fsl_dma_dmamask = DMA_BIT_MASK(36);
 	int ret;
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 19ad0c1..729b0f8 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -302,7 +302,7 @@ static u64 psc_dma_dmamask = 0xffffffff;
 static int psc_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct psc_dma *psc_dma = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	size_t size = psc_dma_hardware.buffer_bytes_max;
diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 309c59e..dc8296a 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -241,7 +241,7 @@ static int ssi_irq = 0;
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 158a91c..5b0972b 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -391,7 +391,7 @@ static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/jz4740/jz4740-pcm.c b/sound/soc/jz4740/jz4740-pcm.c
index a7c9578..5a34dee 100644
--- a/sound/soc/jz4740/jz4740-pcm.c
+++ b/sound/soc/jz4740/jz4740-pcm.c
@@ -302,7 +302,7 @@ static u64 jz4740_pcm_dmamask = DMA_BIT_MASK(32);
 int jz4740_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cd33de1..75255e4 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -315,7 +315,7 @@ static int kirkwood_dma_preallocate_dma_buffer(struct snd_pcm *pcm,
 static int kirkwood_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index 3e78260..92de19c 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -404,7 +404,7 @@ static void sst_pcm_free(struct snd_pcm *pcm)
 
 int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int retval = 0;
 
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index d589ef1..1964801 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -318,7 +318,7 @@ static u64 nuc900_pcm_dmamask = DMA_BIT_MASK(32);
 static int nuc900_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 
 	if (!card->dev->dma_mask)
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index b2f5751..0787a54 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -369,7 +369,7 @@ static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
 static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index d73d6f6..5438a67 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -88,7 +88,7 @@ static u64 pxa2xx_pcm_dmamask = DMA_BIT_MASK(32);
 static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index 80c85fd..925192d 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -446,7 +446,7 @@ static u64 s6000_pcm_dmamask = DMA_BIT_MASK(32);
 static int s6000_pcm_new(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_card *card = runtime->card->snd_card;
-	struct snd_soc_dai *dai = runtime->cpu_dai;
+	struct snd_soc_dai *dai = runtime->codec_dai;
 	struct snd_pcm *pcm = runtime->pcm;
 	struct s6000_pcm_dma_params *params;
 	int res;
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 9465588..a2475b2 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -428,7 +428,7 @@ static u64 dma_mask = DMA_BIT_MASK(32);
 static int dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index ff86e5e..efd00a3 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -325,7 +325,7 @@ static u64 tegra_dma_mask = DMA_BIT_MASK(32);
 static int tegra_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 34aa972..5be6191 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -290,7 +290,7 @@ static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai = rtd->codec_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct platform_device *pdev = to_platform_device(dai->platform->dev);
 	struct txx9aclc_soc_device *dev;
-- 
1.7.5.4
