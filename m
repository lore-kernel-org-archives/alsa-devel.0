From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: pcm3008: Manage DAC and ADC power
	with DAPM
Date: Thu, 15 Aug 2013 12:04:56 +0100
Message-ID: <1376564696-5614-2-git-send-email-broonie@kernel.org>
References: <1376564696-5614-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 376D82655AA
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 13:05:04 +0200 (CEST)
In-Reply-To: <1376564696-5614-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Rather than leaving the DAC and ADC active whenever the system is running
manage their power with DAPM.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 72 +++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 19f5028..b6618c4 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -28,20 +28,53 @@
 
 #include "pcm3008.h"
 
+static int pcm3008_dac_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+
+	gpio_set_value_cansleep(setup->pdda_pin,
+				SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
+static int pcm3008_adc_ev(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+
+	gpio_set_value_cansleep(setup->pdad_pin,
+				SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget pcm3008_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("VINL"),
 SND_SOC_DAPM_INPUT("VINR"),
 
+SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, pcm3008_dac_ev,
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_ADC_E("ADC", NULL, SND_SOC_NOPM, 0, 0, pcm3008_adc_ev,
+		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
 SND_SOC_DAPM_OUTPUT("VOUTL"),
 SND_SOC_DAPM_OUTPUT("VOUTR"),
 };
 
 static const struct snd_soc_dapm_route pcm3008_dapm_routes[] = {
-	{ "PCM3008 Capture", NULL, "VINL" },
-	{ "PCM3008 Capture", NULL, "VINR" },
+	{ "PCM3008 Capture", NULL, "ADC" },
+	{ "ADC", NULL, "VINL" },
+	{ "ADC", NULL, "VINR" },
 
-	{ "VOUTL", NULL, "PCM3008 Playback" },
-	{ "VOUTR", NULL, "PCM3008 Playback" },
+	{ "DAC", NULL, "PCM3008 Playback" },
+	{ "VOUTL", NULL, "DAC" },
+	{ "VOUTR", NULL, "DAC" },
 };
 
 #define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
@@ -65,34 +98,7 @@ static struct snd_soc_dai_driver pcm3008_dai = {
 	},
 };
 
-#ifdef CONFIG_PM
-static int pcm3008_soc_suspend(struct snd_soc_codec *codec)
-{
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
-
-	gpio_set_value_cansleep(setup->pdad_pin, 0);
-	gpio_set_value_cansleep(setup->pdda_pin, 0);
-
-	return 0;
-}
-
-static int pcm3008_soc_resume(struct snd_soc_codec *codec)
-{
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
-
-	gpio_set_value_cansleep(setup->pdad_pin, 1);
-	gpio_set_value_cansleep(setup->pdda_pin, 1);
-
-	return 0;
-}
-#else
-#define pcm3008_soc_suspend NULL
-#define pcm3008_soc_resume NULL
-#endif
-
 static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
-	.suspend =	pcm3008_soc_suspend,
-	.resume =	pcm3008_soc_resume,
 	.dapm_widgets = pcm3008_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(pcm3008_dapm_widgets),
 	.dapm_routes = pcm3008_dapm_routes,
@@ -128,13 +134,13 @@ static int pcm3008_codec_probe(struct platform_device *pdev)
 
 	/* Configure PDAD GPIO. */
 	ret = devm_gpio_request_one(&pdev->dev, setup->pdad_pin,
-				    GPIOF_OUT_INIT_HIGH, "codec_pdad");
+				    GPIOF_OUT_INIT_LOW, "codec_pdad");
 	if (ret != 0)
 		return ret;
 
 	/* Configure PDDA GPIO. */
 	ret = devm_gpio_request_one(&pdev->dev, setup->pdda_pin,
-				    GPIOF_OUT_INIT_HIGH, "codec_pdda");
+				    GPIOF_OUT_INIT_LOW, "codec_pdda");
 	if (ret != 0)
 		return ret;
 
-- 
1.8.4.rc2
