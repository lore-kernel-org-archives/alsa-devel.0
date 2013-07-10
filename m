From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/4] ASoC: pcm3008: Move gpio allocation to
	probe
Date: Wed, 10 Jul 2013 16:54:58 +0100
Message-ID: <1373471700-24119-2-git-send-email-broonie@kernel.org>
References: <1373471700-24119-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EAF16265876
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 15:20:06 +0200 (CEST)
In-Reply-To: <1373471700-24119-1-git-send-email-broonie@kernel.org>
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

This is better from a device model point of view since we don't try to
do things like instantiate the card until the required resources appear.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 87 ++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 32e5a59..8ab1c03 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -57,10 +57,40 @@ static void pcm3008_gpio_free(struct pcm3008_setup_data *setup)
 	gpio_free(setup->pdda_pin);
 }
 
-static int pcm3008_soc_probe(struct snd_soc_codec *codec)
+#ifdef CONFIG_PM
+static int pcm3008_soc_suspend(struct snd_soc_codec *codec)
+{
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+
+	gpio_set_value(setup->pdad_pin, 0);
+	gpio_set_value(setup->pdda_pin, 0);
+
+	return 0;
+}
+
+static int pcm3008_soc_resume(struct snd_soc_codec *codec)
 {
 	struct pcm3008_setup_data *setup = codec->dev->platform_data;
-	int ret = 0;
+
+	gpio_set_value(setup->pdad_pin, 1);
+	gpio_set_value(setup->pdda_pin, 1);
+
+	return 0;
+}
+#else
+#define pcm3008_soc_suspend NULL
+#define pcm3008_soc_resume NULL
+#endif
+
+static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
+	.suspend =	pcm3008_soc_suspend,
+	.resume =	pcm3008_soc_resume,
+};
+
+static int pcm3008_codec_probe(struct platform_device *pdev)
+{
+	struct pcm3008_setup_data *setup = pdev->dev.platform_data;
+	int ret;
 
 	/* DEM1  DEM0  DE-EMPHASIS_MODE
 	 * Low   Low   De-emphasis 44.1 kHz ON
@@ -97,63 +127,22 @@ static int pcm3008_soc_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		goto gpio_err;
 
-	return ret;
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
 
 gpio_err:
 	pcm3008_gpio_free(setup);
-
 	return ret;
 }
 
-static int pcm3008_soc_remove(struct snd_soc_codec *codec)
-{
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
-
-	pcm3008_gpio_free(setup);
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int pcm3008_soc_suspend(struct snd_soc_codec *codec)
-{
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
-
-	gpio_set_value(setup->pdad_pin, 0);
-	gpio_set_value(setup->pdda_pin, 0);
-
-	return 0;
-}
-
-static int pcm3008_soc_resume(struct snd_soc_codec *codec)
+static int pcm3008_codec_remove(struct platform_device *pdev)
 {
-	struct pcm3008_setup_data *setup = codec->dev->platform_data;
+	struct pcm3008_setup_data *setup = pdev->dev.platform_data;
 
-	gpio_set_value(setup->pdad_pin, 1);
-	gpio_set_value(setup->pdda_pin, 1);
-
-	return 0;
-}
-#else
-#define pcm3008_soc_suspend NULL
-#define pcm3008_soc_resume NULL
-#endif
-
-static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
-	.probe = 	pcm3008_soc_probe,
-	.remove = 	pcm3008_soc_remove,
-	.suspend =	pcm3008_soc_suspend,
-	.resume =	pcm3008_soc_resume,
-};
+	snd_soc_unregister_codec(&pdev->dev);
 
-static int pcm3008_codec_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
-}
+	pcm3008_gpio_free(setup);
 
-static int pcm3008_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
-- 
1.8.3.2
