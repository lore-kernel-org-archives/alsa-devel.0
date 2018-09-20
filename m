From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_comp_order() macro" to the
	asoc tree
Date: Thu, 20 Sep 2018 18:35:30 +0100 (BST)
Message-ID: <20180920173530.86236440078@finisterre.ee.mobilebroadband>
References: <87o9cvppiu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A572678BE
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:32 +0200 (CEST)
In-Reply-To: <87o9cvppiu.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_comp_order() macro

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

>From 1a1035a9854fd893d487a84edccc1d5804e1d716 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:30:41 +0000
Subject: [PATCH] ASoC: add for_each_comp_order() macro

To be more readable code, this patch adds
new for_each_comp_order() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 18 ++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 34efab6baff6..93aa894a57ef 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -372,6 +372,11 @@
 #define SND_SOC_COMP_ORDER_LATE		1
 #define SND_SOC_COMP_ORDER_LAST		2
 
+#define for_each_comp_order(order)		\
+	for (order  = SND_SOC_COMP_ORDER_FIRST;	\
+	     order <= SND_SOC_COMP_ORDER_LAST;	\
+	     order++)
+
 /*
  * Bias levels
  *
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 673a694ede3e..d8625ac2b201 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -992,14 +992,12 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link *link, *_link;
 
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-			order++) {
+	for_each_comp_order(order) {
 		for_each_card_rtds(card, rtd)
 			soc_remove_link_dais(card, rtd, order);
 	}
 
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-			order++) {
+	for_each_comp_order(order) {
 		for_each_card_rtds(card, rtd)
 			soc_remove_link_components(card, rtd, order);
 	}
@@ -1617,8 +1615,7 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 	int order;
 	int ret;
 
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-		order++) {
+	for_each_comp_order(order) {
 		list_for_each_entry(comp, &card->aux_comp_list, card_aux_list) {
 			if (comp->driver->probe_order == order) {
 				ret = soc_probe_component(card,	comp);
@@ -1640,8 +1637,7 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 	struct snd_soc_component *comp, *_comp;
 	int order;
 
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-		order++) {
+	for_each_comp_order(order) {
 		list_for_each_entry_safe(comp, _comp,
 			&card->aux_comp_list, card_aux_list) {
 
@@ -2013,8 +2009,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* probe all components used by DAI links on this card */
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-			order++) {
+	for_each_comp_order(order) {
 		for_each_card_rtds(card, rtd) {
 			ret = soc_probe_link_components(card, rtd, order);
 			if (ret < 0) {
@@ -2047,8 +2042,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* probe all DAI links on this card */
-	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
-			order++) {
+	for_each_comp_order(order) {
 		for_each_card_rtds(card, rtd) {
 			ret = soc_probe_link_dais(card, rtd, order);
 			if (ret < 0) {
-- 
2.19.0
