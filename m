From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: replace codec_dev_list to
	component_dev_list on Card" to the asoc tree
Date: Thu, 01 Dec 2016 21:46:10 +0000
Message-ID: <E1cCZBC-0007ei-Ih@debutante>
References: <87wpgm39ad.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14506265823
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 22:46:18 +0100 (CET)
In-Reply-To: <87wpgm39ad.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: core: replace codec_dev_list to component_dev_list on Card

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

>From d9fc40639dc1b87915426d2ef489a591b0fd650b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 Nov 2016 06:22:36 +0000
Subject: [PATCH] ASoC: core: replace codec_dev_list to component_dev_list on
 Card

Current Card has Codec list (= codec_dev_list), but Codec will be
removed in the future. Because of this reason, this patch adds
new Component list in Card, and replace Codec list.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h                     |  6 +++---
 sound/soc/intel/boards/broadwell.c      | 16 ++++++++++------
 sound/soc/intel/boards/cht_bsw_rt5672.c | 16 ++++++++++------
 sound/soc/soc-core.c                    | 28 ++++++++++++++++------------
 4 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1ed9371ece0d..b5544e2287b8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -810,6 +810,7 @@ struct snd_soc_component {
 
 	struct list_head list;
 	struct list_head list_aux; /* for auxiliary component of the card */
+	struct list_head card_list;
 
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dai;
@@ -868,7 +869,6 @@ struct snd_soc_codec {
 	const struct snd_soc_codec_driver *driver;
 
 	struct list_head list;
-	struct list_head card_list;
 
 	/* runtime */
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
@@ -1170,7 +1170,7 @@ struct snd_soc_card {
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
-	struct list_head codec_dev_list;
+	struct list_head component_dev_list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1540,11 +1540,11 @@ static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platfo
 
 static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 {
-	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
 	INIT_LIST_HEAD(&card->aux_comp_list);
+	INIT_LIST_HEAD(&card->component_dev_list);
 }
 
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 7486a0022fde..80f3a2d95737 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -220,10 +220,12 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 };
 
 static int broadwell_suspend(struct snd_soc_card *card){
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, "i2c-INT343A:00")) {
+			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
 			rt286_mic_detect(codec, NULL);
 			break;
@@ -233,10 +235,12 @@ static int broadwell_suspend(struct snd_soc_card *card){
 }
 
 static int broadwell_resume(struct snd_soc_card *card){
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, "i2c-INT343A:00")) {
+			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-INT343A:00")) {
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
 			rt286_mic_detect(codec, &broadwell_headset);
 			break;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index df9d254baa18..dfae9cfa0ac6 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -292,10 +292,12 @@ static struct snd_soc_dai_link cht_dailink[] = {
 
 static int cht_suspend_pre(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
 			rt5670_jack_suspend(codec);
 			break;
@@ -306,10 +308,12 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 
 static int cht_resume_post(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
 			rt5670_jack_resume(codec);
 			break;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0bbcd903261..d204bb772f00 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -626,7 +626,7 @@ static void codec2codec_close_delayed_work(struct work_struct *work)
 int snd_soc_suspend(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct snd_soc_pcm_runtime *rtd;
 	int i;
 
@@ -703,8 +703,12 @@ int snd_soc_suspend(struct device *dev)
 	snd_soc_dapm_sync(&card->dapm);
 
 	/* suspend all CODECs */
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+		struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+		if (!codec)
+			continue;
 
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
@@ -768,7 +772,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	int i;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
@@ -794,7 +798,12 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
-	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+		if (!codec)
+			continue;
+
 		if (codec->suspended) {
 			if (codec->driver->resume)
 				codec->driver->resume(codec);
@@ -1072,9 +1081,7 @@ static void soc_remove_component(struct snd_soc_component *component)
 	if (!component->card)
 		return;
 
-	/* This is a HACK and will be removed soon */
-	if (component->codec)
-		list_del(&component->codec->card_list);
+	list_del(&component->card_list);
 
 	if (component->remove)
 		component->remove(component);
@@ -1443,10 +1450,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 					component->num_dapm_routes);
 
 	list_add(&dapm->list, &card->dapm_list);
-
-	/* This is a HACK and will be removed soon */
-	if (component->codec)
-		list_add(&component->codec->card_list, &card->codec_dev_list);
+	list_add(&component->card_list, &card->component_dev_list);
 
 	return 0;
 
-- 
2.10.2
