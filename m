From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/13] ASoC: Move component->probed check into
	soc_{remove, probe}_component()
Date: Tue, 19 Aug 2014 15:51:24 +0200
Message-ID: <1408456290-13945-8-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E52265695
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:46 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Having the check in a centralized place makes the code a bit cleaner and
shorter.

Note: There is a slight semantic change in this patch. soc_probe_aux_dev() will
no longer return -EBUSY if the AUX dev has already been probed before. This is
fine though since it will simply do nothing in that case and return success.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b84bf05..19b3d2c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1004,6 +1004,9 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 
 static void soc_remove_component(struct snd_soc_component *component)
 {
+	if (!component->probed)
+		return;
+
 	/* This is a HACK and will be removed soon */
 	if (component->codec)
 		list_del(&component->codec->card_list);
@@ -1079,22 +1082,19 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	int i;
 
 	/* remove the platform */
-	if (platform && platform->component.probed &&
-	    platform->component.driver->remove_order == order)
+	if (platform && platform->component.driver->remove_order == order)
 		soc_remove_component(&platform->component);
 
 	/* remove the CODEC-side CODEC */
 	for (i = 0; i < rtd->num_codecs; i++) {
 		component = rtd->codec_dais[i]->component;
-		if (component->probed &&
-		    component->driver->remove_order == order)
+		if (component->driver->remove_order == order)
 			soc_remove_component(component);
 	}
 
 	/* remove any CPU-side CODEC */
 	if (cpu_dai) {
-		if (cpu_dai->component->probed &&
-		    cpu_dai->component->driver->remove_order == order)
+		if (cpu_dai->component->driver->remove_order == order)
 			soc_remove_component(cpu_dai->component);
 	}
 }
@@ -1145,6 +1145,9 @@ static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_dai *dai;
 	int ret;
 
+	if (component->probed)
+		return 0;
+
 	component->card = card;
 	dapm->card = card;
 	soc_set_name_prefix(card, component);
@@ -1306,8 +1309,7 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 
 	/* probe the CPU-side component, if it is a CODEC */
 	component = rtd->cpu_dai->component;
-	if (!component->probed &&
-	    component->driver->probe_order == order) {
+	if (component->driver->probe_order == order) {
 		ret = soc_probe_component(card, component);
 		if (ret < 0)
 			return ret;
@@ -1316,8 +1318,7 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	/* probe the CODEC-side components */
 	for (i = 0; i < rtd->num_codecs; i++) {
 		component = rtd->codec_dais[i]->component;
-		if (!component->probed &&
-		    component->driver->probe_order == order) {
+		if (component->driver->probe_order == order) {
 			ret = soc_probe_component(card, component);
 			if (ret < 0)
 				return ret;
@@ -1325,8 +1326,7 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	}
 
 	/* probe the platform */
-	if (!platform->component.probed &&
-	    platform->component.driver->probe_order == order) {
+	if (platform->component.driver->probe_order == order) {
 		ret = soc_probe_component(card, &platform->component);
 		if (ret < 0)
 			return ret;
@@ -1621,11 +1621,6 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	int ret;
 
-	if (rtd->component->probed) {
-		dev_err(rtd->dev, "ASoC: codec already probed\n");
-		return -EBUSY;
-	}
-
 	ret = soc_probe_component(card, rtd->component);
 	if (ret < 0)
 		return ret;
-- 
1.8.0
