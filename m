From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Convert WM8994 to devm_kzalloc()
Date: Thu,  1 Dec 2011 14:16:46 +0000
Message-ID: <1322749006-371-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 794D5103C04
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:09 +0100 (CET)
In-Reply-To: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Still have a manual free in there for some realloc()ed memory as there's
no devm version of that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index aea5100..a4b41ff 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2904,8 +2904,8 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		};
 
 		/* We need an array of texts for the enum API */
-		wm8994->drc_texts = kmalloc(sizeof(char *)
-					    * pdata->num_drc_cfgs, GFP_KERNEL);
+		wm8994->drc_texts = devm_kzalloc(wm8994->codec->dev,
+			    sizeof(char *) * pdata->num_drc_cfgs, GFP_KERNEL);
 		if (!wm8994->drc_texts) {
 			dev_err(wm8994->codec->dev,
 				"Failed to allocate %d DRC config texts\n",
@@ -3369,7 +3369,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = control->regmap;
 
-	wm8994 = kzalloc(sizeof(struct wm8994_priv), GFP_KERNEL);
+	wm8994 = devm_kzalloc(codec->dev, sizeof(struct wm8994_priv),
+			      GFP_KERNEL);
 	if (wm8994 == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm8994);
@@ -3763,8 +3764,6 @@ err_irq:
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, codec);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
 	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
-err:
-	kfree(wm8994);
 	return ret;
 }
 
@@ -3816,8 +3815,6 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 	if (wm8994->enh_eq)
 		release_firmware(wm8994->enh_eq);
 	kfree(wm8994->retune_mobile_texts);
-	kfree(wm8994->drc_texts);
-	kfree(wm8994);
 
 	return 0;
 }
-- 
1.7.7.3
