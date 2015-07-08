From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Use card field to indicate whether a
	component is bound" to the asoc tree
Date: Wed, 08 Jul 2015 20:05:21 +0100
Message-ID: <E1ZCuen-0005DZ-Mn@debutante>
References: <1436381264-6924-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 92164265A86
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:05:29 +0200 (CEST)
In-Reply-To: <1436381264-6924-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Use card field to indicate whether a component is bound

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

>From abd31b32dde4683df6fd0439caa314aafd751698 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 8 Jul 2015 20:47:44 +0200
Subject: [PATCH] ASoC: Use card field to indicate whether a component is bound

Use the card field of a component to indicate whether it is bound or not.
This makes a certain sense given that the field contains the card the
component is bound to and a component can only be bound to one card at a
time. And it also requires to unset the card field when the component is
unbound from the card.

This makes the probded flag redundant and it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93df8bf9d54a..59635a12c3be 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -758,7 +758,6 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
-	unsigned int probed:1;
 
 	struct list_head list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96bb71aea529..42575b03411e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -978,7 +978,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 
 static void soc_remove_component(struct snd_soc_component *component)
 {
-	if (!component->probed)
+	if (!component->card)
 		return;
 
 	/* This is a HACK and will be removed soon */
@@ -991,7 +991,7 @@ static void soc_remove_component(struct snd_soc_component *component)
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 
 	soc_cleanup_component_debugfs(component);
-	component->probed = 0;
+	component->card = NULL;
 	module_put(component->dev->driver->owner);
 }
 
@@ -1105,7 +1105,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
 
-	if (component->probed) {
+	if (component->card) {
 		if (component->card != card) {
 			dev_err(component->dev,
 				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
@@ -1115,13 +1115,13 @@ static int soc_probe_component(struct snd_soc_card *card,
 		return 0;
 	}
 
+	if (!try_module_get(component->dev->driver->owner))
+		return -ENODEV;
+
 	component->card = card;
 	dapm->card = card;
 	soc_set_name_prefix(card, component);
 
-	if (!try_module_get(component->dev->driver->owner))
-		return -ENODEV;
-
 	soc_init_component_debugfs(component);
 
 	if (component->dapm_widgets) {
@@ -1165,7 +1165,6 @@ static int soc_probe_component(struct snd_soc_card *card,
 		snd_soc_dapm_add_routes(dapm, component->dapm_routes,
 					component->num_dapm_routes);
 
-	component->probed = 1;
 	list_add(&dapm->list, &card->dapm_list);
 
 	/* This is a HACK and will be removed soon */
@@ -1176,6 +1175,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 err_probe:
 	soc_cleanup_component_debugfs(component);
+	component->card = NULL;
 	module_put(component->dev->driver->owner);
 
 	return ret;
@@ -1459,7 +1459,7 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 		rtd->dev_registered = 0;
 	}
 
-	if (component && component->probed)
+	if (component)
 		soc_remove_component(component);
 }
 
-- 
2.1.4
