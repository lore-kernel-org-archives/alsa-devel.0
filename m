From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 01/25] ASoC: blackfin: remove __dev*
	attributes
Date: Fri,  7 Dec 2012 09:26:13 -0500
Message-ID: <1354890397-28568-2-git-send-email-wfp5p@virginia.edu>
References: <1354890397-28568-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1354890397-28568-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c     | 6 +++---
 sound/soc/blackfin/bf5xx-ac97.c         | 6 +++---
 sound/soc/blackfin/bf5xx-ad1836.c       | 6 +++---
 sound/soc/blackfin/bf5xx-i2s-pcm.c      | 6 +++---
 sound/soc/blackfin/bf5xx-i2s.c          | 6 +++---
 sound/soc/blackfin/bf5xx-tdm-pcm.c      | 6 +++---
 sound/soc/blackfin/bf5xx-tdm.c          | 6 +++---
 sound/soc/blackfin/bf6xx-i2s.c          | 6 +++---
 sound/soc/blackfin/bfin-eval-adau1373.c | 4 ++--
 sound/soc/blackfin/bfin-eval-adau1701.c | 4 ++--
 sound/soc/blackfin/bfin-eval-adav80x.c  | 4 ++--
 11 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index d7dc9bd..7e2f360 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -453,12 +453,12 @@ static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
+static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
 }
 
-static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
+static int bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -471,7 +471,7 @@ static struct platform_driver bf5xx_pcm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = __devexit_p(bf5xx_soc_platform_remove),
+	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bf5xx_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index f4e9dc4..8e41bcb 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -282,7 +282,7 @@ static struct snd_soc_dai_driver bfin_ac97_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 };
 
-static int __devinit asoc_bfin_ac97_probe(struct platform_device *pdev)
+static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
@@ -352,7 +352,7 @@ gpio_err:
 	return ret;
 }
 
-static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
+static int asoc_bfin_ac97_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
@@ -372,7 +372,7 @@ static struct platform_driver asoc_bfin_ac97_driver = {
 	},
 
 	.probe = asoc_bfin_ac97_probe,
-	.remove = __devexit_p(asoc_bfin_ac97_remove),
+	.remove = asoc_bfin_ac97_remove,
 };
 
 module_platform_driver(asoc_bfin_ac97_driver);
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 16b9c9e..d23f4b0 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -75,7 +75,7 @@ static struct snd_soc_card bf5xx_ad1836 = {
 	.num_links = 1,
 };
 
-static __devinit int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
+static int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &bf5xx_ad1836;
 	const char **link_name;
@@ -98,7 +98,7 @@ static __devinit int bf5xx_ad1836_driver_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit bf5xx_ad1836_driver_remove(struct platform_device *pdev)
+static int bf5xx_ad1836_driver_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -113,7 +113,7 @@ static struct platform_driver bf5xx_ad1836_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bf5xx_ad1836_driver_probe,
-	.remove = __devexit_p(bf5xx_ad1836_driver_remove),
+	.remove = bf5xx_ad1836_driver_remove,
 };
 module_platform_driver(bf5xx_ad1836_driver);
 
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 63205d7..262c1de 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -292,12 +292,12 @@ static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bfin_i2s_soc_platform_probe(struct platform_device *pdev)
+static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
 }
 
-static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
+static int bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -310,7 +310,7 @@ static struct platform_driver bfin_i2s_pcm_driver = {
 	},
 
 	.probe = bfin_i2s_soc_platform_probe,
-	.remove = __devexit_p(bfin_i2s_soc_platform_remove),
+	.remove = bfin_i2s_soc_platform_remove,
 };
 
 module_platform_driver(bfin_i2s_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 4dccf03..168d88b 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -245,7 +245,7 @@ static struct snd_soc_dai_driver bf5xx_i2s_dai = {
 	.ops = &bf5xx_i2s_dai_ops,
 };
 
-static int __devinit bf5xx_i2s_probe(struct platform_device *pdev)
+static int bf5xx_i2s_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
@@ -267,7 +267,7 @@ static int __devinit bf5xx_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bf5xx_i2s_remove(struct platform_device *pdev)
+static int bf5xx_i2s_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
@@ -281,7 +281,7 @@ static int __devexit bf5xx_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_driver = {
 	.probe  = bf5xx_i2s_probe,
-	.remove = __devexit_p(bf5xx_i2s_remove),
+	.remove = bf5xx_i2s_remove,
 	.driver = {
 		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 254490c..0e6b888 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -317,12 +317,12 @@ static struct snd_soc_platform_driver bf5xx_tdm_soc_platform = {
 	.pcm_free       = bf5xx_pcm_free_dma_buffers,
 };
 
-static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
+static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_platform(&pdev->dev, &bf5xx_tdm_soc_platform);
 }
 
-static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
+static int bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
@@ -335,7 +335,7 @@ static struct platform_driver bfin_tdm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = __devexit_p(bf5xx_soc_platform_remove),
+	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bfin_tdm_driver);
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 594f882..c1e516e 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -249,7 +249,7 @@ static struct snd_soc_dai_driver bf5xx_tdm_dai = {
 	.ops = &bf5xx_tdm_dai_ops,
 };
 
-static int __devinit bfin_tdm_probe(struct platform_device *pdev)
+static int bfin_tdm_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle;
 	int ret;
@@ -295,7 +295,7 @@ sport_config_err:
 	return ret;
 }
 
-static int __devexit bfin_tdm_remove(struct platform_device *pdev)
+static int bfin_tdm_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
@@ -307,7 +307,7 @@ static int __devexit bfin_tdm_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_tdm_driver = {
 	.probe  = bfin_tdm_probe,
-	.remove = __devexit_p(bfin_tdm_remove),
+	.remove = bfin_tdm_remove,
 	.driver = {
 		.name   = "bfin-tdm",
 		.owner  = THIS_MODULE,
diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index c3c2466..8f33797 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -186,7 +186,7 @@ static struct snd_soc_dai_driver bfin_i2s_dai = {
 	.ops = &bfin_i2s_dai_ops,
 };
 
-static int __devinit bfin_i2s_probe(struct platform_device *pdev)
+static int bfin_i2s_probe(struct platform_device *pdev)
 {
 	struct sport_device *sport;
 	struct device *dev = &pdev->dev;
@@ -208,7 +208,7 @@ static int __devinit bfin_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit bfin_i2s_remove(struct platform_device *pdev)
+static int bfin_i2s_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport = platform_get_drvdata(pdev);
 
@@ -220,7 +220,7 @@ static int __devexit bfin_i2s_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_driver = {
 	.probe  = bfin_i2s_probe,
-	.remove = __devexit_p(bfin_i2s_remove),
+	.remove = bfin_i2s_remove,
 	.driver = {
 		.name = "bfin-i2s",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index f3adbdb..4ef9683 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -157,7 +157,7 @@ static int bfin_eval_adau1373_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adau1373);
 }
 
-static int __devexit bfin_eval_adau1373_remove(struct platform_device *pdev)
+static int bfin_eval_adau1373_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -173,7 +173,7 @@ static struct platform_driver bfin_eval_adau1373_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1373_probe,
-	.remove = __devexit_p(bfin_eval_adau1373_remove),
+	.remove = bfin_eval_adau1373_remove,
 };
 
 module_platform_driver(bfin_eval_adau1373_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index b0531fc..3b55081 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -97,7 +97,7 @@ static int bfin_eval_adau1701_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adau1701);
 }
 
-static int __devexit bfin_eval_adau1701_remove(struct platform_device *pdev)
+static int bfin_eval_adau1701_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -113,7 +113,7 @@ static struct platform_driver bfin_eval_adau1701_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adau1701_probe,
-	.remove = __devexit_p(bfin_eval_adau1701_remove),
+	.remove = bfin_eval_adau1701_remove,
 };
 
 module_platform_driver(bfin_eval_adau1701_driver);
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 84b0998..3b1b61a 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -122,7 +122,7 @@ static int bfin_eval_adav80x_probe(struct platform_device *pdev)
 	return snd_soc_register_card(&bfin_eval_adav80x);
 }
 
-static int __devexit bfin_eval_adav80x_remove(struct platform_device *pdev)
+static int bfin_eval_adav80x_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -145,7 +145,7 @@ static struct platform_driver bfin_eval_adav80x_driver = {
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = bfin_eval_adav80x_probe,
-	.remove = __devexit_p(bfin_eval_adav80x_remove),
+	.remove = bfin_eval_adav80x_remove,
 	.id_table = bfin_eval_adav80x_ids,
 };
 
-- 
1.8.0.1
