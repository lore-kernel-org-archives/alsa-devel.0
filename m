From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Revert recent changes while
	boot errors are investigated" to the asoc tree
Date: Thu, 19 Apr 2018 12:33:42 +0100
Message-ID: <E1f97os-0008Ax-F0@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3672D266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 13:33:43 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Revert recent changes while boot errors are investigated

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

>From 291bfb928863d496e25c785e132a8fbfb32341a8 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 19 Apr 2018 12:14:10 +0100
Subject: [PATCH] ASoC: topology: Revert recent changes while boot errors are
 investigated

Krzysztof Kozlowski reported a NULL dereference in _instantiate_card()
on Odroid XU3 and XU boards which he bisected to 45f8cb57da0d7 (ASoC:
core: Allow topology to override machine driver FE DAI link config).
Revert that commit for now, along with f11a5c27f928 (ASoC: core: Add
name prefix for machines with topology rewrites) due to dependency
issues, in order to keep things booting cleanly in -next.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 12 ------
 sound/soc/soc-core.c | 87 ++------------------------------------------
 sound/soc/soc-pcm.c  | 12 ------
 3 files changed, 3 insertions(+), 108 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3676d0a8f532..ad266d7e9553 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1012,14 +1012,6 @@ struct snd_soc_platform_driver {
 
 	/* platform stream compress ops */
 	const struct snd_compr_ops *compr_ops;
-
-	/* this platform uses topology and ignore machine driver FEs */
-	const char *ignore_machine;
-	const char *topology_name_prefix;
-	int (*be_hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
-				  struct snd_pcm_hw_params *params);
-	bool use_dai_pcm_id;	/* use the DAI link PCM ID as PCM device number */
-	int be_pcm_base;	/* base device ID for all BE PCMs */
 };
 
 struct snd_soc_dai_link_component {
@@ -1126,9 +1118,6 @@ struct snd_soc_dai_link {
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
 
-	/* Do not create a PCM for this DAI link (Backend link) */
-	unsigned int ignore:1;
-
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
@@ -1168,7 +1157,6 @@ struct snd_soc_card {
 	const char *long_name;
 	const char *driver_name;
 	char dmi_longname[80];
-	char topology_shortname[32];
 
 	struct device *dev;
 	struct snd_card *snd_card;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index aa1c33b3cce0..bf7ca32ab31f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1050,9 +1050,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	const char *platform_name;
 	int i;
 
-	if (dai_link->ignore)
-		return 0;
-
 	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
 	if (soc_is_dai_link_bound(card, dai_link)) {
@@ -1675,7 +1672,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int i, ret, num;
+	int i, ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
 			card->name, rtd->num, order);
@@ -1721,23 +1718,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		soc_dpcm_debugfs_add(rtd);
 #endif
 
-	/*
-	 * most drivers will register their PCMs using DAI link ordering but
-	 * topology based drivers can use the DAI link id field to set PCM
-	 * device number and then use rtd + a base offset of the BEs.
-	 */
-	if (rtd->platform->driver->use_dai_pcm_id) {
-		if (rtd->dai_link->no_pcm)
-			num = rtd->platform->driver->be_pcm_base + rtd->num;
-		else
-			num = rtd->dai_link->id;
-	} else {
-		num = rtd->num;
-	}
-
 	if (cpu_dai->driver->compress_new) {
 		/*create compress_device"*/
-		ret = cpu_dai->driver->compress_new(rtd, num);
+		ret = cpu_dai->driver->compress_new(rtd, rtd->num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1747,7 +1730,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 
 		if (!dai_link->params) {
 			/* create the pcm */
-			ret = soc_new_pcm(rtd, num);
+			ret = soc_new_pcm(rtd, rtd->num);
 			if (ret < 0) {
 				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 				       dai_link->stream_name, ret);
@@ -2093,67 +2076,6 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 EXPORT_SYMBOL_GPL(snd_soc_set_dmi_name);
 #endif /* CONFIG_DMI */
 
-static void soc_check_tplg_fes(struct snd_soc_card *card)
-{
-	struct snd_soc_platform *platform;
-	struct snd_soc_dai_link *dai_link;
-	int i;
-
-	list_for_each_entry(platform, &platform_list, list) {
-
-		/* does this platform override FEs ? */
-		if (!platform->driver->ignore_machine)
-			continue;
-
-		/* for this machine ? */
-		if (strcmp(platform->driver->ignore_machine,
-			   card->dev->driver->name))
-			continue;
-
-		/* machine matches, so override the rtd data */
-		for (i = 0; i < card->num_links; i++) {
-
-			dai_link = &card->dai_link[i];
-
-			/* ignore this FE */
-			if (dai_link->dynamic) {
-				dai_link->ignore = true;
-				continue;
-			}
-
-			dev_info(card->dev, "info: override FE DAI link %s\n",
-				 card->dai_link[i].name);
-
-			/* override platform */
-			dai_link->platform_name = platform->component.name;
-			dai_link->cpu_dai_name = platform->component.name;
-
-			/* convert non BE into BE */
-			dai_link->no_pcm = 1;
-			dai_link->dpcm_playback = 1;
-			dai_link->dpcm_capture = 1;
-
-			/* override any BE fixups */
-			dai_link->be_hw_params_fixup =
-				platform->driver->be_hw_params_fixup;
-
-			/* most BE links dont set stream name, so set it to
-			 * dai link name if it's NULL to help bind widgets.
-			 */
-			if (!dai_link->stream_name)
-				dai_link->stream_name = dai_link->name;
-		}
-
-		/* Inform userspace we are using alternate topology */
-		if (platform->driver->topology_name_prefix) {
-			snprintf(card->topology_shortname, 32, "%s-%s",
-				 platform->driver->topology_name_prefix,
-				 card->name);
-			card->name = card->topology_shortname;
-		}
-	}
-}
-
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
@@ -2164,9 +2086,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
-	/* check whether any platform is ignore machine FE and using topology */
-	soc_check_tplg_fes(card);
-
 	/* bind DAIs */
 	for (i = 0; i < card->num_links; i++) {
 		ret = soc_bind_dai_link(card, &card->dai_link[i]);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4ce489165a6d..68d9dc930096 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -909,20 +909,8 @@ int soc_dai_hw_params(struct snd_pcm_substream *substream,
 		      struct snd_pcm_hw_params *params,
 		      struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	int ret;
 
-	/* perform any topology hw_params fixups before DAI  */
-	if (rtd->dai_link->be_hw_params_fixup) {
-		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
-		if (ret < 0) {
-			dev_err(rtd->dev,
-				"ASoC: hw_params topology fixup failed %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	if (dai->driver->ops->hw_params) {
 		ret = dai->driver->ops->hw_params(substream, params, dai);
 		if (ret < 0) {
-- 
2.17.0
