From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ASoC: bf5xx-ac97: Convert to
	devm_gpio_request_one()
Date: Wed, 26 Jun 2013 12:02:10 +0100
Message-ID: <1372244530-9701-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Also clean up the error reporting from failed requests while we're at it.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/blackfin/bf5xx-ac97.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index c66bef8..8010f32 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -293,13 +293,14 @@ static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	/* Request PB3 as reset pin */
-	if (gpio_request(CONFIG_SND_BF5XX_RESET_GPIO_NUM, "SND_AD198x RESET")) {
-		pr_err("Failed to request GPIO_%d for reset\n",
-				CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-		ret =  -1;
+	ret = devm_gpio_request_one(&pdev->dev,
+				    CONFIG_SND_BF5XX_RESET_GPIO_NUM,
+				    GPIOF_OUT_INIT_HIGH, "SND_AD198x RESET") {
+		dev_err(&pdev->dev,
+			"Failed to request GPIO_%d for reset: %d\n",
+			CONFIG_SND_BF5XX_RESET_GPIO_NUM, ret);
 		goto gpio_err;
 	}
-	gpio_direction_output(CONFIG_SND_BF5XX_RESET_GPIO_NUM, 1);
 #endif
 
 	sport_handle = sport_init(pdev, 2, sizeof(struct ac97_frame),
@@ -349,10 +350,6 @@ static int asoc_bfin_ac97_probe(struct platform_device *pdev)
 sport_config_err:
 	sport_done(sport_handle);
 sport_err:
-#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-gpio_err:
-#endif
 
 	return ret;
 }
@@ -363,9 +360,6 @@ static int asoc_bfin_ac97_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 	sport_done(sport_handle);
-#ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
-	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
-#endif
 
 	return 0;
 }
-- 
1.8.3.1
