From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_rtdcom_add() and convert to
	consistent operation" to the asoc tree
Date: Thu, 10 Aug 2017 16:41:44 +0100
Message-ID: <E1dfpai-0001cC-Nf@finisterre>
References: <87lgniqvwx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADC432665D5
 for <alsa-devel@alsa-project.org>; Thu, 10 Aug 2017 17:42:00 +0200 (CEST)
In-Reply-To: <87lgniqvwx.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Brian Norris <briannorris@chromium.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use snd_soc_rtdcom_add() and convert to consistent operation

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

>From 90be711e23f7c7ee7b3d6a6e5aa7ee9bab321f2e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 Aug 2017 06:18:10 +0000
Subject: [PATCH] ASoC: use snd_soc_rtdcom_add() and convert to consistent
 operation

Basically, current ALSA SoC framework is based on CPU/Codec/Platform,
but its operation doesn't have consistent.
Thus, source code was unreadable, and difficult to understand.
This patch connects each component (= CPU/Codec/Platform) to rtd by
using snd_soc_rtdcom_add(), and convert uneven operations to consistent
operation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 +-
 sound/soc/soc-core.c | 61 +++++++++++++++++++++++-----------------------------
 sound/soc/soc-pcm.c  | 38 ++++++++++++++++----------------
 3 files changed, 47 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 87dbe39797ca..82e078151787 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1237,7 +1237,7 @@ struct snd_soc_pcm_runtime {
 	struct snd_pcm *pcm;
 	struct snd_compr *compr;
 	struct snd_soc_codec *codec;
-	struct snd_soc_platform *platform;
+	struct snd_soc_platform *platform; /* will be removed */
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c2462e0f0f0d..bbbe003fc0af 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1100,6 +1100,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
+	struct snd_soc_component *component;
 	struct snd_soc_dai **codec_dais;
 	struct snd_soc_platform *platform;
 	struct device_node *platform_of_node;
@@ -1127,6 +1128,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 			dai_link->cpu_dai_name);
 		goto _err_defer;
 	}
+	snd_soc_rtdcom_add(rtd, rtd->cpu_dai->component);
 
 	rtd->num_codecs = dai_link->num_codecs;
 
@@ -1139,6 +1141,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 				codecs[i].dai_name);
 			goto _err_defer;
 		}
+		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
 	}
 
 	/* Single codec links expect codec and codec_dai in runtime data */
@@ -1151,6 +1154,23 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 		platform_name = "snd-soc-dummy";
 
 	/* find one from the set of registered platforms */
+	list_for_each_entry(component, &component_list, list) {
+		platform_of_node = component->dev->of_node;
+		if (!platform_of_node && component->dev->parent->of_node)
+			platform_of_node = component->dev->parent->of_node;
+
+		if (dai_link->platform_of_node) {
+			if (platform_of_node != dai_link->platform_of_node)
+				continue;
+		} else {
+			if (strcmp(component->name, platform_name))
+				continue;
+		}
+
+		snd_soc_rtdcom_add(rtd, component);
+	}
+
+	/* find one from the set of registered platforms */
 	list_for_each_entry(platform, &platform_list, list) {
 		platform_of_node = platform->dev->of_node;
 		if (!platform_of_node && platform->dev->parent->of_node)
@@ -1235,27 +1255,15 @@ static void soc_remove_link_dais(struct snd_soc_card *card,
 static void soc_remove_link_components(struct snd_soc_card *card,
 	struct snd_soc_pcm_runtime *rtd, int order)
 {
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
-	int i;
+	struct snd_soc_rtdcom_list *rtdcom;
 
-	/* remove the platform */
-	if (platform && platform->component.driver->remove_order == order)
-		soc_remove_component(&platform->component);
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
 
-	/* remove the CODEC-side CODEC */
-	for (i = 0; i < rtd->num_codecs; i++) {
-		component = rtd->codec_dais[i]->component;
 		if (component->driver->remove_order == order)
 			soc_remove_component(component);
 	}
-
-	/* remove any CPU-side CODEC */
-	if (cpu_dai) {
-		if (cpu_dai->component->driver->remove_order == order)
-			soc_remove_component(cpu_dai->component);
-	}
 }
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
@@ -1607,21 +1615,13 @@ static int soc_probe_link_components(struct snd_soc_card *card,
 			struct snd_soc_pcm_runtime *rtd,
 				     int order)
 {
-	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
-	int i, ret;
+	struct snd_soc_rtdcom_list *rtdcom;
+	int ret;
 
-	/* probe the CPU-side component, if it is a CODEC */
-	component = rtd->cpu_dai->component;
-	if (component->driver->probe_order == order) {
-		ret = soc_probe_component(card, component);
-		if (ret < 0)
-			return ret;
-	}
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
 
-	/* probe the CODEC-side components */
-	for (i = 0; i < rtd->num_codecs; i++) {
-		component = rtd->codec_dais[i]->component;
 		if (component->driver->probe_order == order) {
 			ret = soc_probe_component(card, component);
 			if (ret < 0)
@@ -1629,13 +1629,6 @@ static int soc_probe_link_components(struct snd_soc_card *card,
 		}
 	}
 
-	/* probe the platform */
-	if (platform->component.driver->probe_order == order) {
-		ret = soc_probe_component(card, &platform->component);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dcc5ece08668..aa4c02de9c61 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -450,6 +450,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	const char *codec_dai_name = "multicodec";
@@ -458,10 +460,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	pinctrl_pm_select_default_state(cpu_dai->dev);
 	for (i = 0; i < rtd->num_codecs; i++)
 		pinctrl_pm_select_default_state(rtd->codec_dais[i]->dev);
-	pm_runtime_get_sync(cpu_dai->dev);
-	for (i = 0; i < rtd->num_codecs; i++)
-		pm_runtime_get_sync(rtd->codec_dais[i]->dev);
-	pm_runtime_get_sync(platform->dev);
+
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		pm_runtime_get_sync(component->dev);
+	}
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -599,15 +603,13 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 
-	pm_runtime_mark_last_busy(platform->dev);
-	pm_runtime_put_autosuspend(platform->dev);
-	for (i = 0; i < rtd->num_codecs; i++) {
-		pm_runtime_mark_last_busy(rtd->codec_dais[i]->dev);
-		pm_runtime_put_autosuspend(rtd->codec_dais[i]->dev);
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
+
+		pm_runtime_mark_last_busy(component->dev);
+		pm_runtime_put_autosuspend(component->dev);
 	}
 
-	pm_runtime_mark_last_busy(cpu_dai->dev);
-	pm_runtime_put_autosuspend(cpu_dai->dev);
 	for (i = 0; i < rtd->num_codecs; i++) {
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
@@ -655,6 +657,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_component *component;
+	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i;
@@ -711,17 +715,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	mutex_unlock(&rtd->pcm_mutex);
 
-	pm_runtime_mark_last_busy(platform->dev);
-	pm_runtime_put_autosuspend(platform->dev);
+	for_each_rtdcom(rtd, rtdcom) {
+		component = rtdcom->component;
 
-	for (i = 0; i < rtd->num_codecs; i++) {
-		pm_runtime_mark_last_busy(rtd->codec_dais[i]->dev);
-		pm_runtime_put_autosuspend(rtd->codec_dais[i]->dev);
+		pm_runtime_mark_last_busy(component->dev);
+		pm_runtime_put_autosuspend(component->dev);
 	}
 
-	pm_runtime_mark_last_busy(cpu_dai->dev);
-	pm_runtime_put_autosuspend(cpu_dai->dev);
-
 	for (i = 0; i < rtd->num_codecs; i++) {
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
-- 
2.13.2
