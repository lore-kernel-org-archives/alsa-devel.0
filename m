From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Make platform probe more like
	codec probe.
Date: Fri, 1 Jul 2011 16:54:08 +0100
Message-ID: <1309535648-4203-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A67324798
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 17:54:22 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation for ASoC dynamic PCM support (AKA ASoC DSP)

Platform will also support DAPM so separate out the probe function
to simplify the code (just like the codec probe).

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |   51 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 32bc503..d49f0ed 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -986,6 +986,39 @@ err_probe:
 	return ret;
 }
 
+static int soc_probe_platform(struct snd_soc_card *card,
+			   struct snd_soc_platform *platform)
+{
+	int ret = 0;
+	const struct snd_soc_platform_driver *driver = platform->driver;
+
+	platform->card = card;
+
+	if (!try_module_get(platform->dev->driver->owner))
+		return -ENODEV;
+
+	if (driver->probe) {
+		ret = driver->probe(platform);
+		if (ret < 0) {
+			dev_err(platform->dev,
+				"asoc: failed to probe platform %s: %d\n",
+				platform->name, ret);
+			goto err_probe;
+		}
+	}
+
+	/* mark platform as probed and add to card platform list */
+	platform->probed = 1;
+	list_add(&platform->card_list, &card->platform_dev_list);
+
+	return 0;
+
+err_probe:
+	module_put(platform->dev->driver->owner);
+
+	return ret;
+}
+
 static void rtd_release(struct device *dev) {}
 
 static int soc_post_component_init(struct snd_soc_card *card,
@@ -1109,21 +1142,9 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	/* probe the platform */
 	if (!platform->probed &&
 			platform->driver->probe_order == order) {
-		if (!try_module_get(platform->dev->driver->owner))
-			return -ENODEV;
-
-		if (platform->driver->probe) {
-			ret = platform->driver->probe(platform);
-			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to probe platform %s\n",
-						platform->name);
-				module_put(platform->dev->driver->owner);
-				return ret;
-			}
-		}
-		/* mark platform as probed and add to card platform list */
-		platform->probed = 1;
-		list_add(&platform->card_list, &card->platform_dev_list);
+		ret = soc_probe_platform(card, platform);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* probe the CODEC DAI */
-- 
1.7.4.1
