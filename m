From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Fix lockdep warning in ASoC machine probe
Date: Mon, 21 Jan 2008 13:04:42 +0000
Message-ID: <1200920682-24256-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B38424481
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 14:04:46 +0100 (CET)
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Don't take the codec mutex during machine probe until we have registered
with ALSA, fixing a lockdep warning reported by Dmitry Baryshkov.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/soc-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2eb9b20..78d1662 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1098,7 +1098,6 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	struct snd_soc_machine *machine = socdev->machine;
 	int ret = 0, i, ac97 = 0, err = 0;
 
-	mutex_lock(&codec->mutex);
 	for(i = 0; i < machine->num_links; i++) {
 		if (socdev->machine->dai_link[i].init) {
 			err = socdev->machine->dai_link[i].init(codec);
@@ -1124,12 +1123,14 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 		goto out;
 	}
 
+	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	if (ac97) {
 		ret = soc_ac97_dev_register(codec);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: AC97 device register failed\n");
 			snd_card_free(codec->card);
+			mutex_unlock(&codec->mutex);
 			goto out;
 		}
 	}
@@ -1142,8 +1143,10 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	err = device_create_file(socdev->dev, &dev_attr_codec_reg);
 	if (err < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs entries\n");
-out:
+
 	mutex_unlock(&codec->mutex);
+
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);
-- 
1.5.3.8
