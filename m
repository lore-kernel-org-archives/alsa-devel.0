From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/4] ASoC: soc-core: Increment codec and
	platform driver refcounts before probing
Date: Wed, 26 Jan 2011 13:58:14 +0200
Message-ID: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 900FF2454F
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:57:03 +0100 (CET)
Received: by fxm5 with SMTP id 5so871208fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 03:57:03 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
moved codec and platform driver refcount increments from soc_bind_dai_link
to more appropriate places.

Adjust a little them so that refcounts are incremented before executing the
driver probe functions.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Harsha Priya <priya.harsha@intel.com>
---
I don't know any regression with this so probably 2.6.39 material.
---
 sound/soc/soc-core.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 14861f9..4da185f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1408,26 +1408,31 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	codec->dapm.card = card;
 	soc_set_name_prefix(card, codec);
 
+	if (!try_module_get(codec->dev->driver->owner))
+		return -ENODEV;
+
 	if (codec->driver->probe) {
 		ret = codec->driver->probe(codec);
 		if (ret < 0) {
 			dev_err(codec->dev,
 				"asoc: failed to probe CODEC %s: %d\n",
 				codec->name, ret);
-			return ret;
+			goto err_probe;
 		}
 	}
 
 	soc_init_codec_debugfs(codec);
 
 	/* mark codec as probed and add to card codec list */
-	if (!try_module_get(codec->dev->driver->owner))
-		return -ENODEV;
-
 	codec->probed = 1;
 	list_add(&codec->card_list, &card->codec_dev_list);
 	list_add(&codec->dapm.list, &card->dapm_list);
 
+	return 0;
+
+err_probe:
+	module_put(codec->dev->driver->owner);
+
 	return ret;
 }
 
@@ -1545,19 +1550,19 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the platform */
 	if (!platform->probed) {
+		if (!try_module_get(platform->dev->driver->owner))
+			return -ENODEV;
+
 		if (platform->driver->probe) {
 			ret = platform->driver->probe(platform);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to probe platform %s\n",
 						platform->name);
+				module_put(platform->dev->driver->owner);
 				return ret;
 			}
 		}
 		/* mark platform as probed and add to card platform list */
-
-		if (!try_module_get(platform->dev->driver->owner))
-			return -ENODEV;
-
 		platform->probed = 1;
 		list_add(&platform->card_list, &card->platform_dev_list);
 	}
-- 
1.7.2.3
