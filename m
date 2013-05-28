From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 10/10] blackfin: Remove references to
	the bf5x_tdm driver
Date: Tue, 28 May 2013 19:22:18 +0200
Message-ID: <1369761738-29503-10-git-send-email-lars@metafoo.de>
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

The bf5x_tdm driver has been removed. Remove all references to it from board
code.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c | 12 -----------
 arch/blackfin/mach-bf527/boards/ezkit.c      | 30 +--------------------------
 arch/blackfin/mach-bf533/boards/ezkit.c      | 12 -----------
 arch/blackfin/mach-bf533/boards/stamp.c      | 31 ----------------------------
 arch/blackfin/mach-bf537/boards/stamp.c      | 28 -------------------------
 arch/blackfin/mach-bf548/boards/ezkit.c      | 28 +------------------------
 arch/blackfin/mach-bf561/boards/ezkit.c      | 12 -----------
 7 files changed, 2 insertions(+), 151 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index d58f50e..1e7be62 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -283,14 +283,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	/* TODO: add platform data here */
-};
-#endif
-
 static struct spi_board_info bfin_spi_board_info[] __initdata = {
 #if defined(CONFIG_MTD_M25P80) \
 	|| defined(CONFIG_MTD_M25P80_MODULE)
@@ -800,10 +792,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 #if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE)
 	&bfin_i2s,
 #endif
-
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm,
-#endif
 };
 
 static int __init ad7160eval_init(void)
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 8224895..d0a0c5e 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -493,8 +493,7 @@ static const struct ad7879_platform_data bfin_ad7879_ts_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE) || \
-	defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
+#if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE)
 
 static const u16 bfin_snd_pin[][7] = {
 	{P_SPORT0_DTPRI, P_SPORT0_TSCLK, P_SPORT0_RFS,
@@ -549,13 +548,6 @@ static struct platform_device bfin_i2s_pcm = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm_pcm = {
-	.name = "bfin-tdm-pcm-audio",
-	.id = -1,
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97_pcm = {
 	.name = "bfin-ac97-pcm-audio",
@@ -575,18 +567,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	.num_resources = ARRAY_SIZE(bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM]),
-	.resource = bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM],
-	.dev = {
-		.platform_data = &bfin_snd_data[CONFIG_SND_BF5XX_SPORT_NUM],
-	},
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) \
 	        || defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 static const char * const ad1836_link[] = {
@@ -1269,10 +1249,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s_pcm,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm_pcm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97_pcm,
 #endif
@@ -1281,10 +1257,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AD1836) || \
 	defined(CONFIG_SND_BF5XX_SOC_AD1836_MODULE)
 	&bfin_ad1836_machine,
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index 07811c2..90fb0d1 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -450,14 +450,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	/* TODO: add platform data here */
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97 = {
 	.name = "bfin-ac97",
@@ -516,10 +508,6 @@ static struct platform_device *ezkit_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97,
 #endif
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index a644a8b..1ea1dda 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -542,7 +542,6 @@ static struct platform_device bfin_dpmc = {
 };
 
 #if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE) || \
-	defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE) \
 	|| defined(CONFIG_SND_BF5XX_AC97) || \
 	defined(CONFIG_SND_BF5XX_AC97_MODULE)
 
@@ -603,13 +602,6 @@ static struct platform_device bfin_i2s_pcm = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm_pcm = {
-	.name = "bfin-tdm-pcm-audio",
-	.id = -1,
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97_pcm = {
 	.name = "bfin-ac97-pcm-audio",
@@ -675,20 +667,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_TDM) || \
-	defined(CONFIG_SND_BF5XX_SOC_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	.num_resources =
-		ARRAY_SIZE(bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM]),
-	.resource = bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM],
-	.dev = {
-		.platform_data = &bfin_snd_data[CONFIG_SND_BF5XX_SPORT_NUM],
-	},
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AC97) || \
 	defined(CONFIG_SND_BF5XX_SOC_AC97_MODULE)
 static struct platform_device bfin_ac97 = {
@@ -761,10 +739,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s_pcm,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm_pcm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97_pcm,
 #endif
@@ -792,11 +766,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_TDM) || \
-	defined(CONFIG_SND_BF5XX_SOC_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AC97) || \
 	defined(CONFIG_SND_BF5XX_SOC_AC97_MODULE)
 	&bfin_ac97,
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index d978ca9..44fd1d4 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2570,7 +2570,6 @@ static struct platform_device bfin_dpmc = {
 };
 
 #if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE) || \
-	defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE) || \
 	defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 
 #define SPORT_REQ(x) \
@@ -2628,13 +2627,6 @@ static struct platform_device bfin_i2s_pcm = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm_pcm = {
-	.name = "bfin-tdm-pcm-audio",
-	.id = -1,
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97_pcm = {
 	.name = "bfin-ac97-pcm-audio",
@@ -2699,18 +2691,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_TDM) || defined(CONFIG_SND_BF5XX_SOC_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	.num_resources = ARRAY_SIZE(bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM]),
-	.resource = bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM],
-	.dev = {
-		.platform_data = &bfin_snd_data[CONFIG_SND_BF5XX_SPORT_NUM],
-	},
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AC97) || defined(CONFIG_SND_BF5XX_SOC_AC97_MODULE)
 static struct platform_device bfin_ac97 = {
 	.name = "bfin-ac97",
@@ -2935,10 +2915,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s_pcm,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm_pcm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97_pcm,
 #endif
@@ -2961,10 +2937,6 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_TDM) || defined(CONFIG_SND_BF5XX_SOC_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AC97) || defined(CONFIG_SND_BF5XX_SOC_AC97_MODULE)
 	&bfin_ac97,
 #endif
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index c4d07f0..372eb54 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -1393,7 +1393,6 @@ static struct platform_device bfin_dpmc = {
 };
 
 #if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE) || \
-	defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE) || \
 	defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 
 #define SPORT_REQ(x) \
@@ -1461,13 +1460,6 @@ static struct platform_device bfin_i2s_pcm = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm_pcm = {
-	.name = "bfin-tdm-pcm-audio",
-	.id = -1,
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97_pcm = {
 	.name = "bfin-ac97-pcm-audio",
@@ -1501,18 +1493,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_TDM) || defined(CONFIG_SND_BF5XX_SOC_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	.num_resources = ARRAY_SIZE(bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM]),
-	.resource = bfin_snd_resources[CONFIG_SND_BF5XX_SPORT_NUM],
-	.dev = {
-		.platform_data = &bfin_snd_data[CONFIG_SND_BF5XX_SPORT_NUM],
-	},
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AC97) || defined(CONFIG_SND_BF5XX_SOC_AC97_MODULE)
 static struct platform_device bfin_ac97 = {
 	.name = "bfin-ac97",
@@ -1646,9 +1626,7 @@ static struct platform_device *ezkit_devices[] __initdata = {
 #if defined(CONFIG_SND_BF5XX_I2S) || defined(CONFIG_SND_BF5XX_I2S_MODULE)
 	&bfin_i2s_pcm,
 #endif
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm_pcm,
-#endif
+
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97_pcm,
 #endif
@@ -1661,10 +1639,6 @@ static struct platform_device *ezkit_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97,
 #endif
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index 9512c36..92938e7 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -523,14 +523,6 @@ static struct platform_device bfin_i2s = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-static struct platform_device bfin_tdm = {
-	.name = "bfin-tdm",
-	.id = CONFIG_SND_BF5XX_SPORT_NUM,
-	/* TODO: add platform data here */
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 static struct platform_device bfin_ac97 = {
 	.name = "bfin-ac97",
@@ -611,10 +603,6 @@ static struct platform_device *ezkit_devices[] __initdata = {
 	&bfin_i2s,
 #endif
 
-#if defined(CONFIG_SND_BF5XX_TDM) || defined(CONFIG_SND_BF5XX_TDM_MODULE)
-	&bfin_tdm,
-#endif
-
 #if defined(CONFIG_SND_BF5XX_AC97) || defined(CONFIG_SND_BF5XX_AC97_MODULE)
 	&bfin_ac97,
 #endif
-- 
1.8.0
