From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: remove support for card rebind
	using component framework" to the asoc tree
Date: Thu,  2 Aug 2018 17:20:48 +0100 (BST)
Message-ID: <20180802162049.00EB01121BE5@debutante.sirena.org.uk>
References: <20180802150338.24538-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0EE2677D8
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2018 18:20:51 +0200 (CEST)
In-Reply-To: <20180802150338.24538-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: stefan.wahren@i2se.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, guillaume.tucker@collabora.com, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: remove support for card rebind using component framework

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 611cbc8799b672f41b6ba7afed758ad9efb959a7 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 2 Aug 2018 16:03:38 +0100
Subject: [PATCH] ASoC: core: remove support for card rebind using component
 framework

DRM based audio components get registered inside the component framework
bind callback. However component framework has a big mutex lock taken for
every call to component_add, component_del and bind, unbind callbacks.

This can lead to deadlock situation if we are trying to add new/remove
component within a bind/unbind callbacks. Which is what was happening
with bcm2837 rpi 3.

Revert this change till we sort out the mutex issue.

Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  7 -----
 sound/soc/soc-core.c | 62 --------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ace474e8649e..41cec42fb456 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/component.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
@@ -1091,12 +1090,6 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
-	/* component framework related */
-	bool components_added;
-	/* set in machine driver to enable/disable auto re-binding */
-	bool auto_bind;
-	struct component_match *match;
-
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b27923303d..82eb3868be67 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,28 +279,11 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
-static int snd_soc_card_comp_compare(struct device *dev, void *data)
-{
-	struct snd_soc_component *component;
-
-	lockdep_assert_held(&client_mutex);
-	list_for_each_entry(component, &component_list, list) {
-		if (dev == component->dev) {
-			if (!strcmp(component->name, data))
-				return 1;
-			break;
-		}
-	}
-
-	return 0;
-}
-
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_rtdcom_list *new_rtdcom;
-	char *cname;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -317,13 +300,6 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
-	if (rtd->card->auto_bind && !rtd->card->components_added) {
-		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
-				       "%s", component->name);
-		component_match_add(rtd->card->dev, &rtd->card->match,
-				    snd_soc_card_comp_compare, cname);
-	}
-
 	return 0;
 }
 
@@ -859,25 +835,6 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 	return false;
 }
 
-static int snd_soc_card_comp_bind(struct device *dev)
-{
-	struct snd_soc_card *card = dev_get_drvdata(dev);
-
-	if (card->instantiated)
-		return 0;
-
-	return snd_soc_register_card(card);
-}
-
-static void snd_soc_card_comp_unbind(struct device *dev)
-{
-}
-
-static const struct component_master_ops snd_soc_card_comp_ops = {
-	.bind = snd_soc_card_comp_bind,
-	.unbind = snd_soc_card_comp_unbind,
-};
-
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -2169,12 +2126,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
-	if (card->auto_bind && !card->components_added) {
-		component_master_add_with_match(card->dev,
-						&snd_soc_card_comp_ops,
-						card->match);
-		card->components_added = true;
-	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2820,9 +2771,6 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 	}
 
-	if (!card->auto_bind && card->components_added)
-		component_master_del(card->dev, &snd_soc_card_comp_ops);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
@@ -3235,17 +3183,8 @@ int snd_soc_add_component(struct device *dev,
 
 	snd_soc_component_add(component);
 
-	ret = component_add(dev, NULL);
-	if (ret < 0) {
-		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
-		goto err_comp;
-	}
-
 	return 0;
 
-err_comp:
-	soc_remove_component(component);
-	snd_soc_unregister_dais(component);
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
@@ -3293,7 +3232,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
-		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.18.0
