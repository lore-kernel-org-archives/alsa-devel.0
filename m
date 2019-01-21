From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add soc_cleanup_component()"
	to the asoc tree
Date: Mon, 21 Jan 2019 19:20:22 +0000 (GMT)
Message-ID: <20190121192022.846481127D00@debutante.sirena.org.uk>
References: <87bm4aamhm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 411C126680F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 20:20:23 +0100 (CET)
In-Reply-To: <87bm4aamhm.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add soc_cleanup_component()

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

>From 22d1423187e5b4d9d5a9851f24466fc0f585a36f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Jan 2019 09:32:55 +0900
Subject: [PATCH] ASoC: soc-core: add soc_cleanup_component()

We need to cleanup component when soc_probe_component() was
failed, or when soc_remove_component() was called.
But they are cleanuping component on each way.
(And soc_probe_component() doesn't call snd_soc_dapm_free(),
but it should).
Same code in many places makes code un-understandable.

This patch adds new soc_cleanup_component() and call it from
snd_probe_component() and snd_remove_component().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7fc10a41e0e9..8a58fa86675a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -937,21 +937,24 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	return -EPROBE_DEFER;
 }
 
+static void soc_cleanup_component(struct snd_soc_component *component)
+{
+	list_del(&component->card_list);
+	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
+	soc_cleanup_component_debugfs(component);
+	component->card = NULL;
+	module_put(component->dev->driver->owner);
+}
+
 static void soc_remove_component(struct snd_soc_component *component)
 {
 	if (!component->card)
 		return;
 
-	list_del(&component->card_list);
-
 	if (component->driver->remove)
 		component->driver->remove(component);
 
-	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
-
-	soc_cleanup_component_debugfs(component);
-	component->card = NULL;
-	module_put(component->dev->driver->owner);
+	soc_cleanup_component(component);
 }
 
 static void soc_remove_dai(struct snd_soc_dai *dai, int order)
@@ -1360,6 +1363,8 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 	component->card = card;
 	dapm->card = card;
+	INIT_LIST_HEAD(&component->card_list);
+	INIT_LIST_HEAD(&dapm->list);
 	soc_set_name_prefix(card, component);
 
 	soc_init_component_debugfs(component);
@@ -1422,12 +1427,9 @@ static int soc_probe_component(struct snd_soc_card *card,
 	/* see for_each_card_components */
 	list_add(&component->card_list, &card->component_dev_list);
 
-	return 0;
-
 err_probe:
-	soc_cleanup_component_debugfs(component);
-	component->card = NULL;
-	module_put(component->dev->driver->owner);
+	if (ret < 0)
+		soc_cleanup_component(component);
 
 	return ret;
 }
-- 
2.20.1
