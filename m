From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] ad1938:let soc-core dapm handle PLL power
Date: Fri, 25 Dec 2009 14:10:08 +0800
Message-ID: <1261721408-16248-4-git-send-email-21cnbao@gmail.com>
References: <1261721408-16248-1-git-send-email-21cnbao@gmail.com>
	<1261721408-16248-2-git-send-email-21cnbao@gmail.com>
	<1261721408-16248-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id C6E95103803
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 07:10:22 +0100 (CET)
In-Reply-To: <1261721408-16248-3-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

PM architecture of ad1938 is simple, we don't need a bundle of functions like
ad1938_pll_powerctrl, ad1938_set_bias_level for only PLL. A dapm supply will
handle on/off of PLL.
Since soc-core can poweron/off PLL on-demand, we don't need to poweron/off PLL
in suspend/resume entries too.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad1938.c |   62 ++------------------------------------------
 1 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index 735c356..47d9ac0 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -97,6 +97,7 @@ static const struct snd_kcontrol_new ad1938_snd_controls[] = {
 static const struct snd_soc_dapm_widget ad1938_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", "Playback", AD1938_DAC_CTRL0, 0, 1),
 	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("PLL_PWR", AD1938_PLL_CLK_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("ADC_PWR", AD1938_ADC_CTRL0, 0, 1, NULL, 0),
 	SND_SOC_DAPM_OUTPUT("DAC1OUT"),
 	SND_SOC_DAPM_OUTPUT("DAC2OUT"),
@@ -107,6 +108,8 @@ static const struct snd_soc_dapm_widget ad1938_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route audio_paths[] = {
+	{ "DAC", NULL, "PLL_PWR" },
+	{ "ADC", NULL, "PLL_PWR" },
 	{ "DAC", NULL, "ADC_PWR" },
 	{ "ADC", NULL, "ADC_PWR" },
 	{ "DAC1OUT", "DAC1 Switch", "DAC" },
@@ -134,16 +137,6 @@ static int ad1938_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
-static inline int ad1938_pll_powerctrl(struct snd_soc_codec *codec, int cmd)
-{
-	int reg = codec->read(codec, AD1938_PLL_CLK_CTRL0);
-	reg = (cmd > 0) ? reg & (~AD1938_PLL_POWERDOWN) : reg |
-		AD1938_PLL_POWERDOWN;
-	codec->write(codec, AD1938_PLL_CLK_CTRL0, reg);
-
-	return 0;
-}
-
 static int ad1938_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int width)
 {
@@ -306,24 +299,6 @@ static int ad1938_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int ad1938_set_bias_level(struct snd_soc_codec *codec,
-		enum snd_soc_bias_level level)
-{
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		ad1938_pll_powerctrl(codec, 1);
-		break;
-	case SND_SOC_BIAS_PREPARE:
-		break;
-	case SND_SOC_BIAS_STANDBY:
-	case SND_SOC_BIAS_OFF:
-		ad1938_pll_powerctrl(codec, 0);
-		break;
-	}
-	codec->bias_level = level;
-	return 0;
-}
-
 /*
  * interface to read/write ad1938 register
  */
@@ -514,7 +489,6 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 	codec->num_dai = 1;
 	codec->write = ad1938_write_reg;
 	codec->read = ad1938_read_reg_cache;
-	codec->set_bias_level = ad1938_set_bias_level;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
@@ -559,7 +533,6 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 
 static void ad1938_unregister(struct ad1938_priv *ad1938)
 {
-	ad1938_set_bias_level(&ad1938->codec, SND_SOC_BIAS_OFF);
 	snd_soc_unregister_dai(&ad1938_dai);
 	snd_soc_unregister_codec(&ad1938->codec);
 	kfree(ad1938);
@@ -593,7 +566,6 @@ static int ad1938_probe(struct platform_device *pdev)
 				  ARRAY_SIZE(ad1938_dapm_widgets));
 	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
 
-	ad1938_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 pcm_err:
 	return ret;
@@ -610,37 +582,9 @@ static int ad1938_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ad1938_suspend(struct platform_device *pdev,
-		pm_message_t state)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	ad1938_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int ad1938_resume(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
-		ad1938_set_bias_level(codec, SND_SOC_BIAS_ON);
-
-	return 0;
-}
-#else
-#define ad1938_suspend NULL
-#define ad1938_resume NULL
-#endif
-
 struct snd_soc_codec_device soc_codec_dev_ad1938 = {
 	.probe = 	ad1938_probe,
 	.remove = 	ad1938_remove,
-	.suspend =      ad1938_suspend,
-	.resume =       ad1938_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ad1938);
 
-- 
1.5.6.3
