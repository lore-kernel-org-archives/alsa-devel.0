From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add for_each_xxx macro for
	aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:52 +0100 (BST)
Message-ID: <20190812130952.62DDF2740CED@ypsilon.sirena.org.uk>
References: <87ftmc6w8s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5229FF80214
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:59 +0200 (CEST)
In-Reply-To: <87ftmc6w8s.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Danny Milosavljevic <dannym@scratchpost.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@li>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add for_each_xxx macro for aux_dev

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c2b71c71037bea7765aa6ff37824520d19108769 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:54:44 +0900
Subject: [PATCH] ASoC: soc-core: add for_each_xxx macro for aux_dev

To be more readable code, this patch adds
new for_each_xxx() macro for aux_dev.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ftmc6w8s.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h        | 10 ++++++++++
 sound/soc/meson/axg-card.c |  7 ++++---
 sound/soc/soc-core.c       | 15 ++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2fc56e5963f3..b1fe5ebea257 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1087,6 +1087,10 @@ struct snd_soc_card {
 	for ((i) = 0;							\
 	     ((i) < (card)->num_links) && ((link) = &(card)->dai_link[i]); \
 	     (i)++)
+#define for_each_card_pre_auxs(card, i, aux)				\
+	for ((i) = 0;							\
+	     ((i) < (card)->num_aux_devs) && ((aux) = &(card)->aux_dev[i]); \
+	     (i)++)
 
 #define for_each_card_links(card, link)				\
 	list_for_each_entry(link, &(card)->dai_link_list, list)
@@ -1098,6 +1102,12 @@ struct snd_soc_card {
 #define for_each_card_rtds_safe(card, rtd, _rtd)	\
 	list_for_each_entry_safe(rtd, _rtd, &(card)->rtd_list, list)
 
+#define for_each_card_auxs(card, component)			\
+	list_for_each_entry(component, &card->aux_comp_list, card_aux_list)
+#define for_each_card_auxs_safe(card, component, _comp)	\
+	list_for_each_entry_safe(component, _comp,	\
+				 &card->aux_comp_list, card_aux_list)
+
 #define for_each_card_components(card, component)			\
 	list_for_each_entry(component, &(card)->component_dev_list, card_list)
 
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 6283e5025548..1f698adde506 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -111,6 +111,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 	struct snd_soc_card *card = &priv->card;
 	struct snd_soc_dai_link *link;
 	struct snd_soc_dai_link_component *codec;
+	struct snd_soc_aux_dev *aux;
 	int i, j;
 
 	if (card->dai_link) {
@@ -123,8 +124,8 @@ static void axg_card_clean_references(struct axg_card *priv)
 	}
 
 	if (card->aux_dev) {
-		for (i = 0; i < card->num_aux_devs; i++)
-			of_node_put(card->aux_dev[i].dlc.of_node);
+		for_each_card_pre_auxs(card, i, aux)
+			of_node_put(aux->dlc.of_node);
 	}
 
 	kfree(card->dai_link);
@@ -157,7 +158,7 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->aux_dev = aux;
 	card->num_aux_devs = num;
 
-	for (i = 0; i < card->num_aux_devs; i++, aux++) {
+	for_each_card_pre_auxs(card, i, aux) {
 		aux->dlc.of_node =
 			of_parse_phandle(node, "audio-aux-devs", i);
 		if (!aux->dlc.of_node)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4af382d52675..e9f44505cc3e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1533,9 +1533,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	return ret;
 }
 
-static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
+static int soc_bind_aux_dev(struct snd_soc_card *card,
+			    struct snd_soc_aux_dev *aux_dev)
 {
-	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_component *component;
 
 	/* codecs, usually analog devices */
@@ -1544,6 +1544,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 
 	component->init = aux_dev->init;
+	/* see for_each_card_auxs */
 	list_add(&component->card_aux_list, &card->aux_comp_list);
 
 	return 0;
@@ -1556,7 +1557,7 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 	int ret;
 
 	for_each_comp_order(order) {
-		list_for_each_entry(comp, &card->aux_comp_list, card_aux_list) {
+		for_each_card_auxs(card, comp) {
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
 				if (ret < 0) {
@@ -1578,8 +1579,7 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 	int order;
 
 	for_each_comp_order(order) {
-		list_for_each_entry_safe(comp, _comp,
-			&card->aux_comp_list, card_aux_list) {
+		for_each_card_auxs_safe(card, comp, _comp) {
 
 			if (comp->driver->remove_order == order) {
 				soc_remove_component(comp);
@@ -1913,6 +1913,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link *dai_link;
+	struct snd_soc_aux_dev *aux;
 	int ret, i, order;
 
 	mutex_lock(&client_mutex);
@@ -1943,8 +1944,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* bind aux_devs too */
-	for (i = 0; i < card->num_aux_devs; i++) {
-		ret = soc_bind_aux_dev(card, i);
+	for_each_card_pre_auxs(card, i, aux) {
+		ret = soc_bind_aux_dev(card, aux);
 		if (ret != 0)
 			goto probe_end;
 	}
-- 
2.20.1
