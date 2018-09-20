From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add for_each_card_rtds() macro" to the
	asoc tree
Date: Thu, 20 Sep 2018 18:35:46 +0100 (BST)
Message-ID: <20180920173546.BC2F7440078@finisterre.ee.mobilebroadband>
References: <87tvmnppko.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 097372678AC
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 19:35:48 +0200 (CEST)
In-Reply-To: <87tvmnppko.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: add for_each_card_rtds() macro

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

>From bcb1fd1fcd6507ba5a1f8610550135dc367aedb7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 18 Sep 2018 01:29:35 +0000
Subject: [PATCH] ASoC: add for_each_card_rtds() macro

To be more readable code, this patch adds
new for_each_card_rtds() macro, and replace existing code to it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h                          |  4 ++
 sound/soc/codecs/hdac_hdmi.c                 |  2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  4 +-
 sound/soc/soc-core.c                         | 48 ++++++++++----------
 sound/soc/soc-dapm.c                         |  2 +-
 sound/soc/soc-pcm.c                          | 12 ++---
 6 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1fffbaa819d9..164418dbf40e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1130,6 +1130,10 @@ struct snd_soc_card {
 #define for_each_card_links_safe(card, link, _link)			\
 	list_for_each_entry_safe(link, _link, &(card)->dai_link_list, list)
 
+#define for_each_card_rtds(card, rtd)			\
+	list_for_each_entry(rtd, &(card)->rtd_list, list)
+#define for_each_card_rtds_safe(card, rtd, _rtd)	\
+	list_for_each_entry_safe(rtd, _rtd, &(card)->rtd_list, list)
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 41d90dc6ebf7..4e9854889a95 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1604,7 +1604,7 @@ static struct snd_pcm *hdac_hdmi_get_pcm_from_id(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		if (rtd->pcm && (rtd->pcm->device == device))
 			return rtd->pcm;
 	}
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 6c36da560877..afc559866095 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -765,7 +765,7 @@ static int sst_soc_prepare(struct device *dev)
 	snd_soc_poweroff(drv->soc_card->dev);
 
 	/* set the SSPs to idle */
-	list_for_each_entry(rtd, &drv->soc_card->rtd_list, list) {
+	for_each_card_rtds(drv->soc_card, rtd) {
 		struct snd_soc_dai *dai = rtd->cpu_dai;
 
 		if (dai->active) {
@@ -786,7 +786,7 @@ static void sst_soc_complete(struct device *dev)
 		return;
 
 	/* restart SSPs */
-	list_for_each_entry(rtd, &drv->soc_card->rtd_list, list) {
+	for_each_card_rtds(drv->soc_card, rtd) {
 		struct snd_soc_dai *dai = rtd->cpu_dai;
 
 		if (dai->active) {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 495173635642..7efcf3475d6f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -342,7 +342,7 @@ struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		if (rtd->dai_link->no_pcm &&
 			!strcmp(rtd->dai_link->name, dai_link))
 			return rtd->pcm->streams[stream].substream;
@@ -399,7 +399,7 @@ static void soc_remove_pcm_runtimes(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd, *_rtd;
 
-	list_for_each_entry_safe(rtd, _rtd, &card->rtd_list, list) {
+	for_each_card_rtds_safe(card, rtd, _rtd) {
 		list_del(&rtd->list);
 		soc_free_pcm_runtime(rtd);
 	}
@@ -412,7 +412,7 @@ struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		if (!strcmp(rtd->dai_link->name, dai_link))
 			return rtd;
 	}
@@ -452,7 +452,7 @@ int snd_soc_suspend(struct device *dev)
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D3hot);
 
 	/* mute any active DACs */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -467,7 +467,7 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	/* suspend all pcms */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		if (rtd->dai_link->ignore_suspend)
 			continue;
 
@@ -477,7 +477,7 @@ int snd_soc_suspend(struct device *dev)
 	if (card->suspend_pre)
 		card->suspend_pre(card);
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -488,10 +488,10 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	/* close any waiting streams */
-	list_for_each_entry(rtd, &card->rtd_list, list)
+	for_each_card_rtds(card, rtd)
 		flush_delayed_work(&rtd->delayed_work);
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 
 		if (rtd->dai_link->ignore_suspend)
 			continue;
@@ -548,7 +548,7 @@ int snd_soc_suspend(struct device *dev)
 		}
 	}
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -592,7 +592,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		card->resume_pre(card);
 
 	/* resume control bus DAIs */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -610,7 +610,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		}
 	}
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 
 		if (rtd->dai_link->ignore_suspend)
 			continue;
@@ -625,7 +625,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	/* unmute any active DACs */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -639,7 +639,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		}
 	}
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 		if (rtd->dai_link->ignore_suspend)
@@ -674,7 +674,7 @@ int snd_soc_resume(struct device *dev)
 		return 0;
 
 	/* activate pins from sleep state */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *codec_dai;
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		int j;
@@ -694,7 +694,7 @@ int snd_soc_resume(struct device *dev)
 	 * have that problem and may take a substantial amount of time to resume
 	 * due to I/O costs and anti-pop so handle them out of line.
 	 */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		bus_control |= cpu_dai->driver->bus_control;
 	}
@@ -839,7 +839,7 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 {
 	struct snd_soc_pcm_runtime *rtd;
 
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		if (rtd->dai_link == dai_link)
 			return true;
 	}
@@ -994,13 +994,13 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		list_for_each_entry(rtd, &card->rtd_list, list)
+		for_each_card_rtds(card, rtd)
 			soc_remove_link_dais(card, rtd, order);
 	}
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		list_for_each_entry(rtd, &card->rtd_list, list)
+		for_each_card_rtds(card, rtd)
 			soc_remove_link_components(card, rtd, order);
 	}
 
@@ -2014,7 +2014,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* probe all components used by DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		list_for_each_entry(rtd, &card->rtd_list, list) {
+		for_each_card_rtds(card, rtd) {
 			ret = soc_probe_link_components(card, rtd, order);
 			if (ret < 0) {
 				dev_err(card->dev,
@@ -2048,7 +2048,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* probe all DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		list_for_each_entry(rtd, &card->rtd_list, list) {
+		for_each_card_rtds(card, rtd) {
 			ret = soc_probe_link_dais(card, rtd, order);
 			if (ret < 0) {
 				dev_err(card->dev,
@@ -2169,7 +2169,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *rtd;
 
 	/* make sure any delayed work runs */
-	list_for_each_entry(rtd, &card->rtd_list, list)
+	for_each_card_rtds(card, rtd)
 		flush_delayed_work(&rtd->delayed_work);
 
 	/* free the ALSA card at first; this syncs with pending operations */
@@ -2211,13 +2211,13 @@ int snd_soc_poweroff(struct device *dev)
 
 	/* Flush out pmdown_time work - we actually do want to run it
 	 * now, we're shutting down so no imminent restart. */
-	list_for_each_entry(rtd, &card->rtd_list, list)
+	for_each_card_rtds(card, rtd)
 		flush_delayed_work(&rtd->delayed_work);
 
 	snd_soc_dapm_shutdown(card);
 
 	/* deactivate pins to sleep state */
-	list_for_each_entry(rtd, &card->rtd_list, list) {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		struct snd_soc_dai *codec_dai;
 		int i;
@@ -2686,7 +2686,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 		return ret;
 
 	/* deactivate pins to sleep state */
-	list_for_each_entry(rtd, &card->rtd_list, list)  {
+	for_each_card_rtds(card, rtd)  {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		struct snd_soc_dai *codec_dai;
 		int j;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ee6b9758ec15..8c5b065c8880 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4183,7 +4183,7 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	struct snd_soc_pcm_runtime *rtd;
 
 	/* for each BE DAI link... */
-	list_for_each_entry(rtd, &card->rtd_list, list)  {
+	for_each_card_rtds(card, rtd)  {
 		/*
 		 * dynamic FE links have no fixed DAI mapping.
 		 * CODEC<->CODEC links have no direct connection.
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1eff1dbb0d00..09d0f668c78e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1307,7 +1307,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 	dev_dbg(card->dev, "ASoC: find BE for widget %s\n", widget->name);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		list_for_each_entry(be, &card->rtd_list, list) {
+		for_each_card_rtds(card, be) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
@@ -1326,7 +1326,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	} else {
 
-		list_for_each_entry(be, &card->rtd_list, list) {
+		for_each_card_rtds(card, be) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
@@ -1382,7 +1382,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 	int i;
 
 	if (dir == SND_SOC_DAPM_DIR_OUT) {
-		list_for_each_entry(rtd, &card->rtd_list, list) {
+		for_each_card_rtds(card, rtd) {
 			if (!rtd->dai_link->no_pcm)
 				continue;
 
@@ -1395,7 +1395,7 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 			}
 		}
 	} else { /* SND_SOC_DAPM_DIR_IN */
-		list_for_each_entry(rtd, &card->rtd_list, list) {
+		for_each_card_rtds(card, rtd) {
 			if (!rtd->dai_link->no_pcm)
 				continue;
 
@@ -2761,14 +2761,14 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 	/* shutdown all old paths first */
-	list_for_each_entry(fe, &card->rtd_list, list) {
+	for_each_card_rtds(card, fe) {
 		ret = soc_dpcm_fe_runtime_update(fe, 0);
 		if (ret)
 			goto out;
 	}
 
 	/* bring new paths up */
-	list_for_each_entry(fe, &card->rtd_list, list) {
+	for_each_card_rtds(card, fe) {
 		ret = soc_dpcm_fe_runtime_update(fe, 1);
 		if (ret)
 			goto out;
-- 
2.19.0
