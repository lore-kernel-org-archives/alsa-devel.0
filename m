From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/10] ASoC: Pass the DAI being configured into
	CPU DAI probe and remove
Date: Wed, 11 Jun 2008 13:47:10 +0100
Message-ID: <1213188435-1986-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76DC624825
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:17 +0200 (CEST)
In-Reply-To: <1213188435-1986-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This allows per-DAI initialisation to be done by the CPU DAI drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h              |    6 ++++--
 sound/soc/davinci/davinci-i2s.c  |    6 ++++--
 sound/soc/pxa/pxa2xx-ac97.c      |    3 ++-
 sound/soc/s3c24xx/s3c2412-i2s.c  |    3 ++-
 sound/soc/s3c24xx/s3c2443-ac97.c |    6 ++++--
 sound/soc/s3c24xx/s3c24xx-i2s.c  |    3 ++-
 sound/soc/soc-core.c             |    6 +++---
 7 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9fa2093..56d2224 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -358,8 +358,10 @@ struct snd_soc_cpu_dai {
 	unsigned char type;
 
 	/* DAI callbacks */
-	int (*probe)(struct platform_device *pdev);
-	void (*remove)(struct platform_device *pdev);
+	int (*probe)(struct platform_device *pdev,
+		     struct snd_soc_cpu_dai *dai);
+	void (*remove)(struct platform_device *pdev,
+		       struct snd_soc_cpu_dai *dai);
 	int (*suspend)(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai);
 	int (*resume)(struct platform_device *pdev,
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index c421774..c3b545c 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -295,7 +295,8 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
-static int davinci_i2s_probe(struct platform_device *pdev)
+static int davinci_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_cpu_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_machine *machine = socdev->machine;
@@ -356,7 +357,8 @@ err_release_region:
 	return ret;
 }
 
-static void davinci_i2s_remove(struct platform_device *pdev)
+static void davinci_i2s_remove(struct platform_device *pdev,
+			       struct snd_soc_cpu_dai *dai)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_machine *machine = socdev->machine;
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 97ec2d9..cb94795 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -310,7 +310,8 @@ static int pxa2xx_ac97_resume(struct platform_device *pdev,
 #define pxa2xx_ac97_resume	NULL
 #endif
 
-static int pxa2xx_ac97_probe(struct platform_device *pdev)
+static int pxa2xx_ac97_probe(struct platform_device *pdev,
+			     struct snd_soc_cpu_dai *dai)
 {
 	int ret;
 
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index c4a46dd..c463a82 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -601,7 +601,8 @@ struct clk *s3c2412_get_iisclk(void)
 EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
 
 
-static int s3c2412_i2s_probe(struct platform_device *pdev)
+static int s3c2412_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_cpu_dai *dai)
 {
 	DBG("Entered %s\n", __func__);
 
diff --git a/sound/soc/s3c24xx/s3c2443-ac97.c b/sound/soc/s3c24xx/s3c2443-ac97.c
index 0eed140..533565b 100644
--- a/sound/soc/s3c24xx/s3c2443-ac97.c
+++ b/sound/soc/s3c24xx/s3c2443-ac97.c
@@ -209,7 +209,8 @@ static struct s3c24xx_pcm_dma_params s3c2443_ac97_mic_mono_in = {
 	.dma_size	= 4,
 };
 
-static int s3c2443_ac97_probe(struct platform_device *pdev)
+static int s3c2443_ac97_probe(struct platform_device *pdev,
+			      struct snd_soc_cpu_dai *dai)
 {
 	int ret;
 	u32 ac_glbctrl;
@@ -260,7 +261,8 @@ static int s3c2443_ac97_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void s3c2443_ac97_remove(struct platform_device *pdev)
+static void s3c2443_ac97_remove(struct platform_device *pdev,
+				struct snd_soc_cpu_dai *dai)
 {
 	free_irq(IRQ_S3C244x_AC97, NULL);
 	clk_disable(s3c24xx_ac97.ac97_clk);
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 4c52f79..42e96b5 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -377,7 +377,8 @@ u32 s3c24xx_i2s_get_clockrate(void)
 }
 EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
 
-static int s3c24xx_i2s_probe(struct platform_device *pdev)
+static int s3c24xx_i2s_probe(struct platform_device *pdev,
+			     struct snd_soc_cpu_dai *dai)
 {
 	DBG("Entered %s\n", __func__);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f594ab8..c96a618 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -768,7 +768,7 @@ static int soc_probe(struct platform_device *pdev)
 	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->probe) {
-			ret = cpu_dai->probe(pdev);
+			ret = cpu_dai->probe(pdev, cpu_dai);
 			if (ret < 0)
 				goto cpu_dai_err;
 		}
@@ -798,7 +798,7 @@ cpu_dai_err:
 	for (i--; i >= 0; i--) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
-			cpu_dai->remove(pdev);
+			cpu_dai->remove(pdev, cpu_dai);
 	}
 
 	if (machine->remove)
@@ -827,7 +827,7 @@ static int soc_remove(struct platform_device *pdev)
 	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->remove)
-			cpu_dai->remove(pdev);
+			cpu_dai->remove(pdev, cpu_dai);
 	}
 
 	if (machine->remove)
-- 
1.5.5.3
