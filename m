From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] ASoC: RX1950: Fix hw_params function
Date: Sat, 13 Nov 2010 14:53:41 +0200
Message-ID: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 98FEB2443E
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 13:54:35 +0100 (CET)
Received: by ewy2 with SMTP id 2so340211ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 04:54:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Unfortunatelly, I misunderstood datasheet, and on s3c244x-iis
when MPLLin source for master clock is selected, prescaler has
no effect. Remove dividor calculation for 44100 rate; remove 88200
rate at all, rx1950 can't do it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/s3c24xx/rx1950_uda1380.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index ffd5cf2..468cc11 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -50,7 +50,6 @@ static unsigned int rates[] = {
 	16000,
 	44100,
 	48000,
-	88200,
 };
 
 static struct snd_pcm_hw_constraint_list hw_rates = {
@@ -130,7 +129,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 };
 
 static struct platform_device *s3c24xx_snd_device;
-static struct clk *xtal;
 
 static int rx1950_startup(struct snd_pcm_substream *substream)
 {
@@ -179,10 +177,8 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 	case 44100:
 	case 88200:
 		clk_source = S3C24XX_CLKSRC_MPLL;
-		fs_mode = S3C2410_IISMOD_256FS;
-		div = clk_get_rate(xtal) / (256 * rate);
-		if (clk_get_rate(xtal) % (256 * rate) > (128 * rate))
-			div++;
+		fs_mode = S3C2410_IISMOD_384FS;
+		div = 1;
 		break;
 	default:
 		printk(KERN_ERR "%s: rate %d is not supported\n",
@@ -210,7 +206,7 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 
 	/* set MCLK division for sample rate */
 	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
-		S3C2410_IISMOD_384FS);
+		fs_mode);
 	if (ret < 0)
 		return ret;
 
@@ -295,17 +291,8 @@ static int __init rx1950_init(void)
 		goto err_plat_add;
 	}
 
-	xtal = clk_get(&s3c24xx_snd_device->dev, "xtal");
-
-	if (IS_ERR(xtal)) {
-		ret = PTR_ERR(xtal);
-		platform_device_unregister(s3c24xx_snd_device);
-		goto err_clk;
-	}
-
 	return 0;
 
-err_clk:
 err_plat_add:
 err_plat_alloc:
 err_gpio_conf:
@@ -320,7 +307,6 @@ static void __exit rx1950_exit(void)
 	platform_device_unregister(s3c24xx_snd_device);
 	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
 		hp_jack_gpios);
-	clk_put(xtal);
 	gpio_free(S3C2410_GPA(1));
 }
 
-- 
1.7.3.2
