From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] soc - ac97 - Clean up checkpatch warnings
Date: Wed, 23 Apr 2008 13:25:21 +0100
Message-ID: <1208953521-23131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <s5hve28dawc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDBE324551
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:25:22 +0200 (CEST)
In-Reply-To: <s5hve28dawc.wl%tiwai@suse.de>
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

Also change some if (x == NULL) to if (!x).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 242130c..2a1ffe3 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -40,7 +40,8 @@ static int ac97_prepare(struct snd_pcm_substream *substream)
 }
 
 #define STD_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_44100 |\
+		SNDRV_PCM_RATE_48000)
 
 struct snd_soc_codec_dai ac97_dai = {
 	.name = "AC97 HiFi",
@@ -86,7 +87,7 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
 
 	socdev->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (socdev->codec == NULL)
+	if (!socdev->codec)
 		return -ENOMEM;
 	codec = socdev->codec;
 	mutex_init(&codec->mutex);
@@ -102,17 +103,17 @@ static int ac97_soc_probe(struct platform_device *pdev)
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if(ret < 0)
+	if (ret < 0)
 		goto err;
 
 	/* add codec as bus device for standard ac97 */
 	ret = snd_ac97_bus(codec->card, 0, &soc_ac97_ops, NULL, &ac97_bus);
-	if(ret < 0)
+	if (ret < 0)
 		goto bus_err;
 
 	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
 	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
-	if(ret < 0)
+	if (ret < 0)
 		goto bus_err;
 
 	ret = snd_soc_register_card(socdev);
@@ -135,7 +136,7 @@ static int ac97_soc_remove(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 
-	if(codec == NULL)
+	if (!codec)
 		return 0;
 
 	snd_soc_free_pcms(socdev);
@@ -145,11 +146,10 @@ static int ac97_soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_ac97= {
+struct snd_soc_codec_device soc_codec_dev_ac97 = {
 	.probe = 	ac97_soc_probe,
 	.remove = 	ac97_soc_remove,
 };
-
 EXPORT_SYMBOL_GPL(soc_codec_dev_ac97);
 
 MODULE_DESCRIPTION("Soc Generic AC97 driver");
-- 
1.5.5.1
