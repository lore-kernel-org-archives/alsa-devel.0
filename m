From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/11] ASoC: Actively manage MCLK for
	AT91SAM9G20-EK
Date: Wed, 18 Feb 2009 12:02:29 +0000
Message-ID: <1234958553-16049-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AE71910388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:18:15 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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

We have software control of the MCLK for the WM8731 so save a bit of
power by actively managing it within the machine driver, enabling it
only while the codec is active.

Once ASoC supports multiple boards and doesn't require the soc-audio
device the initial clock setup should be pushed down into the arch/arm
code but for now this reduces merge issues.

Tested-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |   68 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index b7efdc8..ab32514 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -53,6 +53,9 @@
 #include "atmel-pcm.h"
 #include "atmel_ssc_dai.h"
 
+#define MCLK_RATE 12000000
+
+static struct clk *mclk;
 
 static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
 {
@@ -60,11 +63,12 @@ static int at91sam9g20ek_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	int ret;
 
-	/* codec system clock is supplied by PCK0, set to 12MHz */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
-		12000000, SND_SOC_CLOCK_IN);
-	if (ret < 0)
+		MCLK_RATE, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		clk_disable(mclk);
 		return ret;
+	}
 
 	return 0;
 }
@@ -190,6 +194,31 @@ static struct snd_soc_ops at91sam9g20ek_ops = {
 	.shutdown = at91sam9g20ek_shutdown,
 };
 
+static int at91sam9g20ek_set_bias_level(struct snd_soc_card *card,
+					enum snd_soc_bias_level level)
+{
+	static int mclk_on;
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+		if (!mclk_on)
+			ret = clk_enable(mclk);
+		if (ret == 0)
+			mclk_on = 1;
+		break;
+
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_STANDBY:
+		if (mclk_on)
+			clk_disable(mclk);
+		mclk_on = 0;
+		break;
+	}
+
+	return ret;
+}
 
 static const struct snd_soc_dapm_widget at91sam9g20ek_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
@@ -248,6 +277,7 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
 	.platform = &atmel_soc_platform,
 	.dai_link = &at91sam9g20ek_dai,
 	.num_links = 1,
+	.set_bias_level = at91sam9g20ek_set_bias_level,
 };
 
 static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
@@ -267,12 +297,38 @@ static int __init at91sam9g20ek_init(void)
 {
 	struct atmel_ssc_info *ssc_p = at91sam9g20ek_dai.cpu_dai->private_data;
 	struct ssc_device *ssc = NULL;
+	struct clk *pllb;
 	int ret;
 
 	if (!machine_is_at91sam9g20ek())
 		return -ENODEV;
 
 	/*
+	 * Codec MCLK is supplied by PCK0 - set it up.
+	 */
+	mclk = clk_get(NULL, "pck0");
+	if (IS_ERR(mclk)) {
+		printk(KERN_ERR "ASoC: Failed to get MCLK\n");
+		ret = PTR_ERR(mclk);
+		goto err;
+	}
+
+	pllb = clk_get(NULL, "pllb");
+	if (IS_ERR(mclk)) {
+		printk(KERN_ERR "ASoC: Failed to get PLLB\n");
+		ret = PTR_ERR(mclk);
+		goto err_mclk;
+	}
+	ret = clk_set_parent(mclk, pllb);
+	clk_put(pllb);
+	if (ret != 0) {
+		printk(KERN_ERR "ASoC: Failed to set MCLK parent\n");
+		goto err_mclk;
+	}
+
+	clk_set_rate(mclk, MCLK_RATE);
+
+	/*
 	 * Request SSC device
 	 */
 	ssc = ssc_request(0);
@@ -303,6 +359,10 @@ static int __init at91sam9g20ek_init(void)
 	return ret;
 
 err_ssc:
+err_mclk:
+	clk_put(mclk);
+	mclk = NULL;
+err:
 	return ret;
 }
 
@@ -320,6 +380,8 @@ static void __exit at91sam9g20ek_exit(void)
 
 	platform_device_unregister(at91sam9g20ek_snd_device);
 	at91sam9g20ek_snd_device = NULL;
+	clk_put(mclk);
+	mclk = NULL;
 }
 
 module_init(at91sam9g20ek_init);
-- 
1.5.6.3
