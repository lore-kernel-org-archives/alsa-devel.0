From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: pcm3008: Convert to
	devm_gpio_request_one()
Date: Wed, 10 Jul 2013 16:55:00 +0100
Message-ID: <1373471700-24119-4-git-send-email-broonie@kernel.org>
References: <1373471700-24119-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F2512656F1
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 17:58:06 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 4fa4ded..b883f99 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -49,14 +49,6 @@ static struct snd_soc_dai_driver pcm3008_dai = {
 	},
 };
 
-static void pcm3008_gpio_free(struct pcm3008_setup_data *setup)
-{
-	gpio_free(setup->dem0_pin);
-	gpio_free(setup->dem1_pin);
-	gpio_free(setup->pdad_pin);
-	gpio_free(setup->pdda_pin);
-}
-
 #ifdef CONFIG_PM
 static int pcm3008_soc_suspend(struct snd_soc_codec *codec)
 {
@@ -103,49 +95,37 @@ static int pcm3008_codec_probe(struct platform_device *pdev)
 	 */
 
 	/* Configure DEM0 GPIO (turning OFF DAC De-emphasis). */
-	ret = gpio_request(setup->dem0_pin, "codec_dem0");
-	if (ret == 0)
-		ret = gpio_direction_output(setup->dem0_pin, 1);
+	ret = devm_gpio_request_one(&pdev->dev, setup->dem0_pin,
+				    GPIOF_OUT_INIT_HIGH, "codec_dem0");
 	if (ret != 0)
-		goto gpio_err;
+		return ret;
 
 	/* Configure DEM1 GPIO (turning OFF DAC De-emphasis). */
-	ret = gpio_request(setup->dem1_pin, "codec_dem1");
-	if (ret == 0)
-		ret = gpio_direction_output(setup->dem1_pin, 0);
+	ret = devm_gpio_request_one(&pdev->dev, setup->dem1_pin,
+				    GPIOF_OUT_INIT_LOW, "codec_dem1");
 	if (ret != 0)
-		goto gpio_err;
+		return ret;
 
 	/* Configure PDAD GPIO. */
-	ret = gpio_request(setup->pdad_pin, "codec_pdad");
-	if (ret == 0)
-		ret = gpio_direction_output(setup->pdad_pin, 1);
+	ret = devm_gpio_request_one(&pdev->dev, setup->pdad_pin,
+				    GPIOF_OUT_INIT_HIGH, "codec_pdad");
 	if (ret != 0)
-		goto gpio_err;
+		return ret;
 
 	/* Configure PDDA GPIO. */
-	ret = gpio_request(setup->pdda_pin, "codec_pdda");
-	if (ret == 0)
-		ret = gpio_direction_output(setup->pdda_pin, 1);
+	ret = devm_gpio_request_one(&pdev->dev, setup->pdda_pin,
+				    GPIOF_OUT_INIT_HIGH, "codec_pdda");
 	if (ret != 0)
-		goto gpio_err;
+		return ret;
 
 	return snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
-
-gpio_err:
-	pcm3008_gpio_free(setup);
-	return ret;
 }
 
 static int pcm3008_codec_remove(struct platform_device *pdev)
 {
-	struct pcm3008_setup_data *setup = pdev->dev.platform_data;
-
 	snd_soc_unregister_codec(&pdev->dev);
 
-	pcm3008_gpio_free(setup);
-
 	return 0;
 }
 
-- 
1.8.3.2
