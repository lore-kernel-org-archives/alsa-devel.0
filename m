From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: rename "cmpnt" to
	"component"" to the asoc tree
Date: Mon, 07 Aug 2017 16:53:05 +0100
Message-ID: <E1dekL3-0005St-V5@debutante>
References: <87tw1qppo4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 796612672BB
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:53:13 +0200 (CEST)
In-Reply-To: <87tw1qppo4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: rename "cmpnt" to "component"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cf9e829eaf0195e722bc3a3929002a3fbe74dafa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Aug 2017 02:06:23 +0000
Subject: [PATCH] ASoC: soc-core: rename "cmpnt" to "component"

To unify notation, to readable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  4 ++--
 sound/soc/soc-core.c | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9c94b97c17f8..de57a8ad057b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -469,10 +469,10 @@ int snd_soc_register_codec(struct device *dev,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_codec(struct device *dev);
 int snd_soc_register_component(struct device *dev,
-			 const struct snd_soc_component_driver *cmpnt_drv,
+			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 int devm_snd_soc_register_component(struct device *dev,
-			 const struct snd_soc_component_driver *cmpnt_drv,
+			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
 int snd_soc_cache_init(struct snd_soc_codec *codec);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a01944..b21488972198 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3282,40 +3282,40 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 }
 
 int snd_soc_register_component(struct device *dev,
-			       const struct snd_soc_component_driver *cmpnt_drv,
+			       const struct snd_soc_component_driver *component_driver,
 			       struct snd_soc_dai_driver *dai_drv,
 			       int num_dai)
 {
-	struct snd_soc_component *cmpnt;
+	struct snd_soc_component *component;
 	int ret;
 
-	cmpnt = kzalloc(sizeof(*cmpnt), GFP_KERNEL);
-	if (!cmpnt) {
+	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	if (!component) {
 		dev_err(dev, "ASoC: Failed to allocate memory\n");
 		return -ENOMEM;
 	}
 
-	ret = snd_soc_component_initialize(cmpnt, cmpnt_drv, dev);
+	ret = snd_soc_component_initialize(component, component_driver, dev);
 	if (ret)
 		goto err_free;
 
-	cmpnt->ignore_pmdown_time = true;
-	cmpnt->registered_as_component = true;
+	component->ignore_pmdown_time = true;
+	component->registered_as_component = true;
 
-	ret = snd_soc_register_dais(cmpnt, dai_drv, num_dai, true);
+	ret = snd_soc_register_dais(component, dai_drv, num_dai, true);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to register DAIs: %d\n", ret);
 		goto err_cleanup;
 	}
 
-	snd_soc_component_add(cmpnt);
+	snd_soc_component_add(component);
 
 	return 0;
 
 err_cleanup:
-	snd_soc_component_cleanup(cmpnt);
+	snd_soc_component_cleanup(component);
 err_free:
-	kfree(cmpnt);
+	kfree(component);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_component);
@@ -3327,22 +3327,22 @@ EXPORT_SYMBOL_GPL(snd_soc_register_component);
  */
 void snd_soc_unregister_component(struct device *dev)
 {
-	struct snd_soc_component *cmpnt;
+	struct snd_soc_component *component;
 
 	mutex_lock(&client_mutex);
-	list_for_each_entry(cmpnt, &component_list, list) {
-		if (dev == cmpnt->dev && cmpnt->registered_as_component)
+	list_for_each_entry(component, &component_list, list) {
+		if (dev == component->dev && component->registered_as_component)
 			goto found;
 	}
 	mutex_unlock(&client_mutex);
 	return;
 
 found:
-	snd_soc_tplg_component_remove(cmpnt, SND_SOC_TPLG_INDEX_ALL);
-	snd_soc_component_del_unlocked(cmpnt);
+	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+	snd_soc_component_del_unlocked(component);
 	mutex_unlock(&client_mutex);
-	snd_soc_component_cleanup(cmpnt);
-	kfree(cmpnt);
+	snd_soc_component_cleanup(component);
+	kfree(component);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
-- 
2.13.3
