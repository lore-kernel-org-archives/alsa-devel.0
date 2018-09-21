From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_component() macro" to the
	asoc tree
Date: Fri, 21 Sep 2018 18:14:09 +0100 (BST)
Message-ID: <20180921171409.54C0D440078@finisterre.ee.mobilebroadband>
References: <87d0t72zyg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CC72678A5
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 19:14:11 +0200 (CEST)
In-Reply-To: <87d0t72zyg.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_component() macro

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

>From 368dee9459472b44f760a35cd07a6f3b90b3e549 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Sep 2018 05:23:01 +0000
Subject: [PATCH] ASoC: add for_each_component() macro

To be more readable code, this patch adds
new for_each_component() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d8625ac2b201..b9b33c8cac2e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -54,6 +54,9 @@ static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(component_list);
 static LIST_HEAD(unbind_card_list);
 
+#define for_each_component(component)			\
+	list_for_each_entry(component, &component_list, list)
+
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
@@ -176,7 +179,7 @@ static int dai_list_show(struct seq_file *m, void *v)
 
 	mutex_lock(&client_mutex);
 
-	list_for_each_entry(component, &component_list, list)
+	for_each_component(component)
 		list_for_each_entry(dai, &component->dai_list, list)
 			seq_printf(m, "%s\n", dai->name);
 
@@ -192,7 +195,7 @@ static int component_list_show(struct seq_file *m, void *v)
 
 	mutex_lock(&client_mutex);
 
-	list_for_each_entry(component, &component_list, list)
+	for_each_component(component)
 		seq_printf(m, "%s\n", component->name);
 
 	mutex_unlock(&client_mutex);
@@ -725,7 +728,7 @@ static struct snd_soc_component *soc_find_component(
 
 	lockdep_assert_held(&client_mutex);
 
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 		if (of_node) {
 			if (component->dev->of_node == of_node)
 				return component;
@@ -775,7 +778,7 @@ struct snd_soc_dai *snd_soc_find_dai(
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 		if (!snd_soc_is_matching_component(dlc, component))
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list) {
@@ -902,7 +905,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->codec_dai = codec_dais[0];
 
 	/* find one from the set of registered platforms */
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 		if (!snd_soc_is_matching_component(dai_link->platform,
 						   component))
 			continue;
@@ -1874,7 +1877,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 	struct snd_soc_dai_link *dai_link;
 	int i;
 
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 
 		/* does this component override FEs ? */
 		if (!component->driver->ignore_machine)
@@ -3091,6 +3094,7 @@ static void snd_soc_component_add(struct snd_soc_component *component)
 			snd_soc_component_setup_regmap(component);
 	}
 
+	/* see for_each_component */
 	list_add(&component->list, &component_list);
 	INIT_LIST_HEAD(&component->dobj_list);
 
@@ -3226,7 +3230,7 @@ static int __snd_soc_unregister_component(struct device *dev)
 	int found = 0;
 
 	mutex_lock(&client_mutex);
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 		if (dev != component->dev)
 			continue;
 
@@ -3258,7 +3262,7 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 
 	ret = NULL;
 	mutex_lock(&client_mutex);
-	list_for_each_entry(component, &component_list, list) {
+	for_each_component(component) {
 		if (dev != component->dev)
 			continue;
 
@@ -3658,7 +3662,7 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	 */
 	ret = -ENOTSUPP;
 	mutex_lock(&client_mutex);
-	list_for_each_entry(pos, &component_list, list) {
+	for_each_component(pos) {
 		struct device_node *component_of_node = pos->dev->of_node;
 
 		if (!component_of_node && pos->dev->parent)
@@ -3688,7 +3692,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 	int ret = -EPROBE_DEFER;
 
 	mutex_lock(&client_mutex);
-	list_for_each_entry(pos, &component_list, list) {
+	for_each_component(pos) {
 		component_of_node = pos->dev->of_node;
 		if (!component_of_node && pos->dev->parent)
 			component_of_node = pos->dev->parent->of_node;
-- 
2.19.0
