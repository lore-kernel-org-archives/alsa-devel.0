From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Remove platform device from DAI
	suspend and resume operations
Date: Thu,  4 Dec 2008 11:26:45 +0000
Message-ID: <1228390006-30338-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081204112542.GA30250@rakim.wolfsonmicro.main>
	<1228390006-30338-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228390006-30338-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9A2524153
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 12:26:47 +0100 (CET)
In-Reply-To: <1228390006-30338-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

None of the DAIs use it except s3c2412-i2s which only uses it for
dev_() printouts.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h         |    6 ++----
 sound/soc/atmel/atmel_ssc_dai.c |    6 ++----
 sound/soc/au1x/psc-ac97.c       |    6 ++----
 sound/soc/au1x/psc-i2s.c        |    6 ++----
 sound/soc/blackfin/bf5xx-ac97.c |    6 ++----
 sound/soc/blackfin/bf5xx-i2s.c  |    6 ++----
 sound/soc/pxa/pxa-ssp.c         |    6 ++----
 sound/soc/pxa/pxa2xx-ac97.c     |    6 ++----
 sound/soc/pxa/pxa2xx-i2s.c      |    6 ++----
 sound/soc/s3c24xx/s3c2412-i2s.c |   16 +++++++---------
 sound/soc/s3c24xx/s3c24xx-i2s.c |    6 ++----
 sound/soc/soc-core.c            |    8 ++++----
 12 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a01a24b..e2d5f76 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -191,10 +191,8 @@ struct snd_soc_dai {
 		     struct snd_soc_dai *dai);
 	void (*remove)(struct platform_device *pdev,
 		       struct snd_soc_dai *dai);
-	int (*suspend)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
-	int (*resume)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
+	int (*suspend)(struct snd_soc_dai *dai);
+	int (*resume)(struct snd_soc_dai *dai);
 
 	/* ops */
 	struct snd_soc_dai_ops ops;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 0bb18df..d9b874c 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -628,8 +628,7 @@ static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 
 
 #ifdef CONFIG_PM
-static int atmel_ssc_suspend(struct platform_device *pdev,
-			    struct snd_soc_dai *cpu_dai)
+static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 {
 	struct atmel_ssc_info *ssc_p;
 
@@ -657,8 +656,7 @@ static int atmel_ssc_suspend(struct platform_device *pdev,
 
 
 
-static int atmel_ssc_resume(struct platform_device *pdev,
-			   struct snd_soc_dai *cpu_dai)
+static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 {
 	struct atmel_ssc_info *ssc_p;
 	u32 cr;
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index a0bcfea..a1e824d 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -314,8 +314,7 @@ static void au1xpsc_ac97_remove(struct platform_device *pdev,
 	au1xpsc_ac97_workdata = NULL;
 }
 
-static int au1xpsc_ac97_suspend(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
+static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
 {
 	/* save interesting registers and disable PSC */
 	au1xpsc_ac97_workdata->pm[0] =
@@ -329,8 +328,7 @@ static int au1xpsc_ac97_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int au1xpsc_ac97_resume(struct platform_device *pdev,
-			       struct snd_soc_dai *dai)
+static int au1xpsc_ac97_resume(struct snd_soc_dai *dai)
 {
 	/* restore PSC clock config */
 	au_writel(au1xpsc_ac97_workdata->pm[0] | PSC_SEL_PS_AC97MODE,
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index f4217e7..16f9746 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -339,8 +339,7 @@ static void au1xpsc_i2s_remove(struct platform_device *pdev,
 	au1xpsc_i2s_workdata = NULL;
 }
 
-static int au1xpsc_i2s_suspend(struct platform_device *pdev,
-			       struct snd_soc_dai *cpu_dai)
+static int au1xpsc_i2s_suspend(struct snd_soc_dai *cpu_dai)
 {
 	/* save interesting register and disable PSC */
 	au1xpsc_i2s_workdata->pm[0] =
@@ -354,8 +353,7 @@ static int au1xpsc_i2s_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int au1xpsc_i2s_resume(struct platform_device *pdev,
-			      struct snd_soc_dai *cpu_dai)
+static int au1xpsc_i2s_resume(struct snd_soc_dai *cpu_dai)
 {
 	/* select I2S mode and PSC clock */
 	au_writel(PSC_CTRL_DISABLE, PSC_CTRL(au1xpsc_i2s_workdata));
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 709bdf0..c602ce1 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -269,8 +269,7 @@ struct snd_ac97_bus_ops soc_ac97_ops = {
 EXPORT_SYMBOL_GPL(soc_ac97_ops);
 
 #ifdef CONFIG_PM
-static int bf5xx_ac97_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
 {
 	struct sport_device *sport =
 		(struct sport_device *)dai->private_data;
@@ -285,8 +284,7 @@ static int bf5xx_ac97_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int bf5xx_ac97_resume(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 {
 	int ret;
 	struct sport_device *sport =
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 6e5036b..9f8ce87 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -222,16 +222,14 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void bf5xx_i2s_remove(struct platform_device *pdev,
-			   struct snd_soc_dai *dai)
+static void bf5xx_i2s_remove(struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	peripheral_free_list(&sport_req[sport_num][0]);
 }
 
 #ifdef CONFIG_PM
-static int bf5xx_i2s_suspend(struct platform_device *dev,
-			     struct snd_soc_dai *dai)
+static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 {
 	struct sport_device *sport =
 		(struct sport_device *)dai->private_data;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 402fc5b..73fa10d 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -244,8 +244,7 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 
 #ifdef CONFIG_PM
 
-static int pxa_ssp_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *cpu_dai)
+static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 
@@ -257,8 +256,7 @@ static int pxa_ssp_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int pxa_ssp_resume(struct platform_device *pdev,
-	struct snd_soc_dai *cpu_dai)
+static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index bffbe28..8eed80d 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -87,14 +87,12 @@ static struct pxa2xx_pcm_dma_params pxa2xx_ac97_pcm_mic_mono_in = {
 };
 
 #ifdef CONFIG_PM
-static int pxa2xx_ac97_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int pxa2xx_ac97_suspend(struct snd_soc_dai *dai)
 {
 	return pxa2xx_ac97_hw_suspend();
 }
 
-static int pxa2xx_ac97_resume(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int pxa2xx_ac97_resume(struct snd_soc_dai *dai)
 {
 	return pxa2xx_ac97_hw_resume();
 }
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index f9a9e2e..314973a 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -293,8 +293,7 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
 }
 
 #ifdef CONFIG_PM
-static int pxa2xx_i2s_suspend(struct platform_device *dev,
-	struct snd_soc_dai *dai)
+static int pxa2xx_i2s_suspend(struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
@@ -311,8 +310,7 @@ static int pxa2xx_i2s_suspend(struct platform_device *dev,
 	return 0;
 }
 
-static int pxa2xx_i2s_resume(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int pxa2xx_i2s_resume(struct snd_soc_dai *dai)
 {
 	if (!dai->active)
 		return 0;
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 1c74104..75f87c3 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -649,8 +649,7 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 }
 
 #ifdef CONFIG_PM
-static int s3c2412_i2s_suspend(struct platform_device *dev,
-			      struct snd_soc_dai *dai)
+static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
 {
 	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
 	u32 iismod;
@@ -665,25 +664,24 @@ static int s3c2412_i2s_suspend(struct platform_device *dev,
 		iismod = readl(i2s->regs + S3C2412_IISMOD);
 
 		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
-			dev_warn(&dev->dev, "%s: RXDMA active?\n", __func__);
+			pr_warning("%s: RXDMA active?\n", __func__);
 
 		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
-			dev_warn(&dev->dev, "%s: TXDMA active?\n", __func__);
+			pr_warning("%s: TXDMA active?\n", __func__);
 
 		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
-			dev_warn(&dev->dev, "%s: IIS active\n", __func__);
+			pr_warning("%s: IIS active\n", __func__);
 	}
 
 	return 0;
 }
 
-static int s3c2412_i2s_resume(struct platform_device *pdev,
-			      struct snd_soc_dai *dai)
+static int s3c2412_i2s_resume(struct snd_soc_dai *dai)
 {
 	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
 
-	dev_info(&pdev->dev, "dai_active %d, IISMOD %08x, IISCON %08x\n",
-		 dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
+	pr_info("dai_active %d, IISMOD %08x, IISCON %08x\n",
+		dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
 
 	if (dai->active) {
 		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 8d9135f..45fe8f7 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -419,8 +419,7 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev,
 }
 
 #ifdef CONFIG_PM
-static int s3c24xx_i2s_suspend(struct platform_device *pdev,
-		struct snd_soc_dai *cpu_dai)
+static int s3c24xx_i2s_suspend(struct snd_soc_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
 
@@ -434,8 +433,7 @@ static int s3c24xx_i2s_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int s3c24xx_i2s_resume(struct platform_device *pdev,
-		struct snd_soc_dai *cpu_dai)
+static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
 	clk_enable(s3c24xx_i2s.iis_clk);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f83852f..2f2a8d9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -650,7 +650,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && !cpu_dai->ac97_control)
-			cpu_dai->suspend(pdev, cpu_dai);
+			cpu_dai->suspend(cpu_dai);
 		if (platform->suspend)
 			platform->suspend(cpu_dai);
 	}
@@ -676,7 +676,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->ac97_control)
-			cpu_dai->suspend(pdev, cpu_dai);
+			cpu_dai->suspend(cpu_dai);
 	}
 
 	if (card->suspend_post)
@@ -712,7 +712,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->ac97_control)
-			cpu_dai->resume(pdev, cpu_dai);
+			cpu_dai->resume(cpu_dai);
 	}
 
 	if (codec_dev->resume)
@@ -739,7 +739,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && !cpu_dai->ac97_control)
-			cpu_dai->resume(pdev, cpu_dai);
+			cpu_dai->resume(cpu_dai);
 		if (platform->resume)
 			platform->resume(cpu_dai);
 	}
-- 
1.5.6.5
