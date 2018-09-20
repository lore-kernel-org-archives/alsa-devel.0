From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_card_links() macro" to the
	asoc tree
Date: Thu, 20 Sep 2018 18:35:53 +0100 (BST)
Message-ID: <20180920173553.725EE440078@finisterre.ee.mobilebroadband>
References: <87va73ppl8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A1D026789F
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:56 +0200 (CEST)
In-Reply-To: <87va73ppl8.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_card_links() macro

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

>From 98061fdbfccc02aa0fd6637c67a0524aab385b8d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:29:16 +0000
Subject: [PATCH] ASoC: add for_each_card_links() macro

To be more readable code, this patch adds
new for_each_card_links() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 6 ++++++
 sound/soc/soc-core.c | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f94b989e7a1a..1fffbaa819d9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1125,6 +1125,12 @@ struct snd_soc_card {
 	     ((i) < (card)->num_links) && ((link) = &(card)->dai_link[i]); \
 	     (i)++)
 
+#define for_each_card_links(card, link)				\
+	list_for_each_entry(dai_link, &(card)->dai_link_list, list)
+#define for_each_card_links_safe(card, link, _link)			\
+	list_for_each_entry_safe(link, _link, &(card)->dai_link_list, list)
+
+
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
 	struct device *dev;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 532d8c59ed1e..495173635642 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -816,7 +816,7 @@ struct snd_soc_dai_link *snd_soc_find_dai_link(struct snd_soc_card *card,
 
 	lockdep_assert_held(&client_mutex);
 
-	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+	for_each_card_links_safe(card, link, _link) {
 		if (link->id != id)
 			continue;
 
@@ -1004,7 +1004,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 			soc_remove_link_components(card, rtd, order);
 	}
 
-	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+	for_each_card_links_safe(card, link, _link) {
 		if (link->dobj.type == SND_SOC_DOBJ_DAI_LINK)
 			dev_warn(card->dev, "Topology forgot to remove link %s?\n",
 				link->name);
@@ -1219,7 +1219,7 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	if (dai_link->dobj.type && card->remove_dai_link)
 		card->remove_dai_link(card, dai_link);
 
-	list_for_each_entry_safe(link, _link, &card->dai_link_list, list) {
+	for_each_card_links_safe(card, link, _link) {
 		if (link == dai_link) {
 			list_del(&link->list);
 			return;
@@ -2033,7 +2033,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* Find new DAI links added during probing components and bind them.
 	 * Components with topology may bring new DAIs and DAI links.
 	 */
-	list_for_each_entry(dai_link, &card->dai_link_list, list) {
+	for_each_card_links(card, dai_link) {
 		if (soc_is_dai_link_bound(card, dai_link))
 			continue;
 
-- 
2.19.0
