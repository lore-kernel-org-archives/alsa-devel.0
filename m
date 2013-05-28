From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 02/10] ASoC: blackfin: bf5xx-i2s: Use
	dev_{err, dbg} instead of pr_{error, debug}
Date: Tue, 28 May 2013 19:22:10 +0200
Message-ID: <1369761738-29503-2-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Using dev_{err,dbg} instead of pr_{error,debug} makes it easier to recognize
which device created the message.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/bf5xx-i2s.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index dd0c2a4..78411f2 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -74,7 +74,8 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		ret = -EINVAL;
 		break;
 	default:
-		printk(KERN_ERR "%s: Unknown DAI format type\n", __func__);
+		dev_err(cpu_dai->dev, "%s: Unknown DAI format type\n",
+			__func__);
 		ret = -EINVAL;
 		break;
 	}
@@ -88,7 +89,8 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		ret = -EINVAL;
 		break;
 	default:
-		printk(KERN_ERR "%s: Unknown DAI master type\n", __func__);
+		dev_err(cpu_dai->dev, "%s: Unknown DAI master type\n",
+			__func__);
 		ret = -EINVAL;
 		break;
 	}
@@ -141,14 +143,14 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		ret = sport_config_rx(sport_handle, bf5xx_i2s->rcr1,
 				      bf5xx_i2s->rcr2, 0, 0);
 		if (ret) {
-			pr_err("SPORT is busy!\n");
+			dev_err(dai->dev, "SPORT is busy!\n");
 			return -EBUSY;
 		}
 
 		ret = sport_config_tx(sport_handle, bf5xx_i2s->tcr1,
 				      bf5xx_i2s->tcr2, 0, 0);
 		if (ret) {
-			pr_err("SPORT is busy!\n");
+			dev_err(dai->dev, "SPORT is busy!\n");
 			return -EBUSY;
 		}
 	}
@@ -162,7 +164,7 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
 	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
 
-	pr_debug("%s enter\n", __func__);
+	dev_dbg(dai->dev, "%s enter\n", __func__);
 	/* No active stream, SPORT is allowed to be configured again. */
 	if (!dai->active)
 		bf5xx_i2s->configured = 0;
@@ -173,7 +175,7 @@ static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 {
 	struct sport_device *sport_handle = snd_soc_dai_get_drvdata(dai);
 
-	pr_debug("%s : sport %d\n", __func__, dai->id);
+	dev_dbg(dai->dev, "%s : sport %d\n", __func__, dai->id);
 
 	if (dai->capture_active)
 		sport_rx_stop(sport_handle);
@@ -188,19 +190,19 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 	struct bf5xx_i2s_port *bf5xx_i2s = sport_handle->private_data;
 	int ret;
 
-	pr_debug("%s : sport %d\n", __func__, dai->id);
+	dev_dbg(dai->dev, "%s : sport %d\n", __func__, dai->id);
 
 	ret = sport_config_rx(sport_handle, bf5xx_i2s->rcr1,
 				      bf5xx_i2s->rcr2, 0, 0);
 	if (ret) {
-		pr_err("SPORT is busy!\n");
+		dev_err(dai->dev, "SPORT is busy!\n");
 		return -EBUSY;
 	}
 
 	ret = sport_config_tx(sport_handle, bf5xx_i2s->tcr1,
 				      bf5xx_i2s->tcr2, 0, 0);
 	if (ret) {
-		pr_err("SPORT is busy!\n");
+		dev_err(dai->dev, "SPORT is busy!\n");
 		return -EBUSY;
 	}
 
@@ -264,7 +266,7 @@ static int bf5xx_i2s_probe(struct platform_device *pdev)
 	ret = snd_soc_register_component(&pdev->dev, &bf5xx_i2s_component,
 					 &bf5xx_i2s_dai, 1);
 	if (ret) {
-		pr_err("Failed to register DAI: %d\n", ret);
+		dev_err(&pdev->dev, "Failed to register DAI: %d\n", ret);
 		sport_done(sport_handle);
 		return ret;
 	}
@@ -276,7 +278,7 @@ static int bf5xx_i2s_remove(struct platform_device *pdev)
 {
 	struct sport_device *sport_handle = platform_get_drvdata(pdev);
 
-	pr_debug("%s enter\n", __func__);
+	dev_dbg(&pdev->dev, "%s enter\n", __func__);
 
 	snd_soc_unregister_component(&pdev->dev);
 	sport_done(sport_handle);
-- 
1.8.0
