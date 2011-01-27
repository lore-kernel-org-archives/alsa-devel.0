From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: soc-core: Increment codec and
	platform driver refcounts before probing
Date: Thu, 27 Jan 2011 16:24:22 +0200
Message-ID: <1296138262-28113-3-git-send-email-jhnikula@gmail.com>
References: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 663F7103B14
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 15:23:41 +0100 (CET)
Received: by bwz10 with SMTP id 10so2463305bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 06:23:40 -0800 (PST)
In-Reply-To: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
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
index e9f81c5..9dfbb8f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1412,26 +1412,31 @@ static int soc_probe_codec(struct snd_soc_card *card,
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
 
@@ -1549,19 +1554,19 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
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
