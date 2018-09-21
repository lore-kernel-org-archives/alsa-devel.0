From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_component_dais() macro" to
	the asoc tree
Date: Fri, 21 Sep 2018 18:14:01 +0100 (BST)
Message-ID: <20180921171401.B2A0B440078@finisterre.ee.mobilebroadband>
References: <87bm8r2zy0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C6F32676A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 19:14:04 +0200 (CEST)
In-Reply-To: <87bm8r2zy0.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_component_dais() macro

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

>From 15a0c64572463eddf59e80aa643d3a87809a7d9b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Sep 2018 05:23:17 +0000
Subject: [PATCH] ASoC: add for_each_component_dais() macro

To be more readable code, this patch adds
new for_each_component_dais() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 93aa894a57ef..f1dab1f4b194 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -864,6 +864,11 @@ struct snd_soc_component {
 #endif
 };
 
+#define for_each_component_dais(component, dai)\
+	list_for_each_entry(dai, &(component)->dai_list, list)
+#define for_each_component_dais_safe(component, dai, _dai)\
+	list_for_each_entry_safe(dai, _dai, &(component)->dai_list, list)
+
 struct snd_soc_rtdcom_list {
 	struct snd_soc_component *component;
 	struct list_head list; /* rtd::component_list */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b9b33c8cac2e..62e8e36062df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -180,7 +180,7 @@ static int dai_list_show(struct seq_file *m, void *v)
 	mutex_lock(&client_mutex);
 
 	for_each_component(component)
-		list_for_each_entry(dai, &component->dai_list, list)
+		for_each_component_dais(component, dai)
 			seq_printf(m, "%s\n", dai->name);
 
 	mutex_unlock(&client_mutex);
@@ -781,7 +781,7 @@ struct snd_soc_dai *snd_soc_find_dai(
 	for_each_component(component) {
 		if (!snd_soc_is_matching_component(dlc, component))
 			continue;
-		list_for_each_entry(dai, &component->dai_list, list) {
+		for_each_component_dais(component, dai) {
 			if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
 			    && (!dai->driver->name
 				|| strcmp(dai->driver->name, dlc->dai_name)))
@@ -1312,7 +1312,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 		}
 	}
 
-	list_for_each_entry(dai, &component->dai_list, list) {
+	for_each_component_dais(component, dai) {
 		ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
 		if (ret != 0) {
 			dev_err(component->dev,
@@ -2842,7 +2842,7 @@ static void snd_soc_unregister_dais(struct snd_soc_component *component)
 {
 	struct snd_soc_dai *dai, *_dai;
 
-	list_for_each_entry_safe(dai, _dai, &component->dai_list, list) {
+	for_each_component_dais_safe(component, dai, _dai) {
 		dev_dbg(component->dev, "ASoC: Unregistered DAI '%s'\n",
 			dai->name);
 		list_del(&dai->list);
@@ -2894,6 +2894,7 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
 	if (!dai->driver->ops)
 		dai->driver->ops = &null_dai_ops;
 
+	/* see for_each_component_dais */
 	list_add_tail(&dai->list, &component->dai_list);
 	component->num_dai++;
 
@@ -3728,7 +3729,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 			ret = 0;
 
 			/* find target DAI */
-			list_for_each_entry(dai, &pos->dai_list, list) {
+			for_each_component_dais(pos, dai) {
 				if (id == 0)
 					break;
 				id--;
-- 
2.19.0
