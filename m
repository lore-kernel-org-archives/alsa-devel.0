From: Graham Gower <graham.gower@gmail.com>
Subject: [PATCH] ASoC: Fix passing platform_data to ac97 bus
 users and fix a leak.
Date: Wed, 24 Mar 2010 14:59:08 +1030
Message-ID: <4BA99514.8020708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BD35244B8
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 05:29:16 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 14so846014qwa.56
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 21:29:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_new_ac97_codec() allocates for codec->ac97, snd_soc_new_pcms()
then sets the platform_data. However, snd_ac97_mixer() overwrites
codec->ac97 with its own allocated struct snd_ac97.

Signed-off-by: Graham Gower <graham.gower@gmail.com>
---
 sound/soc/codecs/ac97.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index a1bbe16..64ec797 100644
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
@@ -118,11 +120,21 @@ static int ac97_soc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto bus_err;
 
+	/* free the ac97 here so that we don't leak it in snd_ac97_mixer */
+	snd_soc_free_ac97_codec(codec);
+
 	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
 	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
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
-- 
1.6.4
