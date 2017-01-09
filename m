From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_component{_safe}" to the
	asoc tree
Date: Mon, 09 Jan 2017 20:01:24 +0000
Message-ID: <E1cQg8C-0006rd-Rw@debutante>
References: <874m2074ls.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 662F9266EE9
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:33 +0100 (CET)
In-Reply-To: <874m2074ls.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add for_each_component{_safe}

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

>From d75e460ad330518b56635cfccfba78c90ff0c9df Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Dec 2016 07:37:57 +0000
Subject: [PATCH] ASoC: add for_each_component{_safe}

To be more readable code, this patch adds new for_each_component
macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 10 ++++------
 sound/soc/soc-pcm.c  |  5 ++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1a4311da6126..b37b21a3471f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1193,6 +1193,11 @@ struct snd_soc_card {
 
 	void *drvdata;
 };
+#define	for_each_component(component, card) \
+	list_for_each_entry(component, &(card)->component_dev_list, card_list)
+#define	for_each_component_safe(component, _component, card)	\
+	list_for_each_entry_safe(component, _component, \
+				 &(card)->component_dev_list, card_list)
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 981443e444d1..9f2b9e1a1cee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -703,7 +703,7 @@ int snd_soc_suspend(struct device *dev)
 	snd_soc_dapm_sync(&card->dapm);
 
 	/* suspend all COMPONENTs */
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_component(component, card) {
 		struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 		/* If there are paths active then the COMPONENT will be held with
@@ -794,7 +794,7 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
-	list_for_each_entry(component, &card->component_dev_list, card_list) {
+	for_each_component(component, card) {
 		if (component->suspended) {
 			if (component->resume)
 				component->resume(component);
@@ -1764,7 +1764,7 @@ static int soc_probe_aux_devices(struct snd_soc_card *card)
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry(comp, &card->component_dev_list, card_list) {
+		for_each_component(comp, card) {
 			if (!comp->auxiliary)
 				continue;
 
@@ -1790,9 +1790,7 @@ static void soc_remove_aux_devices(struct snd_soc_card *card)
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 		order++) {
-		list_for_each_entry_safe(comp, _comp,
-			&card->component_dev_list, card_list) {
-
+		for_each_component_safe(comp, _comp, card) {
 			if (!comp->auxiliary)
 				continue;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1739573dcd6a..51927dc93c41 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2631,8 +2631,7 @@ static void soc_pcm_free(struct snd_pcm *pcm)
 	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
 	struct snd_soc_component *component;
 
-	list_for_each_entry(component, &rtd->card->component_dev_list,
-			    card_list) {
+	for_each_component(component, rtd->card) {
 		if (component->pcm_free)
 			component->pcm_free(pcm);
 	}
@@ -2753,7 +2752,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
 
-	list_for_each_entry(component, &rtd->card->component_dev_list, card_list) {
+	for_each_component(component, rtd->card) {
 		if (component->pcm_new) {
 			ret = component->pcm_new(rtd);
 			if (ret < 0) {
-- 
2.11.0
