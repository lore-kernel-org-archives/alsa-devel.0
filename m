From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8994: Move runtime PM init to platform
	device init
Date: Mon,  1 Jul 2013 20:47:10 +0100
Message-ID: <1372708030-8162-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B296261721
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 21:47:16 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As well as being better style this allows the device to idle when there is
no audio card instantaited which is probably what we want.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8994.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1d4b1ec..02c320f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4014,9 +4014,6 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994->micdet_irq = control->pdata.micdet_irq;
 
-	pm_runtime_enable(codec->dev);
-	pm_runtime_idle(codec->dev);
-
 	/* By default use idle_bias_off, will override for WM8994 */
 	codec->dapm.idle_bias_off = 1;
 
@@ -4389,8 +4386,6 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	pm_runtime_disable(codec->dev);
-
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
 				&wm8994->fll_locked[i]);
@@ -4449,6 +4444,9 @@ static int wm8994_probe(struct platform_device *pdev)
 
 	wm8994->wm8994 = dev_get_drvdata(pdev->dev.parent);
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_idle(&pdev->dev);
+
 	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8994,
 			wm8994_dai, ARRAY_SIZE(wm8994_dai));
 }
@@ -4456,6 +4454,8 @@ static int wm8994_probe(struct platform_device *pdev)
 static int wm8994_remove(struct platform_device *pdev)
 {
 	snd_soc_unregister_codec(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
-- 
1.8.3.1
