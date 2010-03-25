From: Graham Gower <graham.gower@gmail.com>
Subject: Re: [PATCH] ASoC: Fix passing platform_data to ac97
 bus users and fix a leak.
Date: Thu, 25 Mar 2010 10:52:12 +1030
Message-ID: <4BAAACB4.6030303@gmail.com>
References: <4BA99514.8020708@gmail.com> <20100324130611.GA26910@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 164B624469
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 01:22:24 +0100 (CET)
Received: by wwb34 with SMTP id 34so645800wwb.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 17:22:22 -0700 (PDT)
In-Reply-To: <20100324130611.GA26910@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark, Liam,

As requested, this patch removes the initial allocation of codec->ac97.


Signed-off-by: Graham Gower <graham.gower@gmail.com>
---
 sound/soc/codecs/ac97.c |   15 +++++++++------
 sound/soc/soc-core.c    |    2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index a1bbe16..bcfa532 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -80,9 +80,11 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 static int ac97_soc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_card *card = socdev->card;
 	struct snd_soc_codec *codec;
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
+	int i;
 	int ret = 0;
 
 	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
@@ -102,12 +104,6 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
-	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
-	if (ret < 0) {
-		printk(KERN_ERR "ASoC: failed to init gen ac97 glue\n");
-		goto err;
-	}
-
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0)
@@ -123,6 +119,13 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto bus_err;
 
+	for (i = 0; i < card->num_links; i++) {
+		if (card->dai_link[i].codec_dai->ac97_control) {
+			snd_ac97_dev_add_pdata(codec->ac97,
+				card->dai_link[i].cpu_dai->ac97_pdata);
+		}
+	}
+
 	return 0;
 
 bus_err:
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c8b0556..5704923 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1548,7 +1548,7 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 			mutex_unlock(&codec->mutex);
 			return ret;
 		}
-		if (card->dai_link[i].codec_dai->ac97_control) {
+		if (card->dai_link[i].codec_dai->ac97_control && codec->ac97) {
 			snd_ac97_dev_add_pdata(codec->ac97,
 				card->dai_link[i].cpu_dai->ac97_pdata);
 		}
-- 
1.6.4
