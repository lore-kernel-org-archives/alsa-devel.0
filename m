From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/13] ASoC: Add component level probe/remove
	support
Date: Tue, 19 Aug 2014 15:51:21 +0200
Message-ID: <1408456290-13945-5-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 772D2265677
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:43 +0200 (CEST)
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

Now that we have a unified probe and remove path make sure to call them for all
components. soc_{probe,remove}_component are responsible for setting up the DAPM
context for the component, initialize the component prefix, manage the debugfs
entries as well as do the registration of table based controls and DAPM
elements. They also call the component drivers probe and remove callbacks. This
patch makes these things available for generic snd_soc_component drivers rather
than only having them for snd_soc_codec and snd_soc_platform drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 11 +++++++++++
 sound/soc/soc-core.c | 42 ++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0e7e761..cb5c9ca 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -690,6 +690,17 @@ struct snd_soc_compr_ops {
 struct snd_soc_component_driver {
 	const char *name;
 
+	/* Default control and setup, added after probe() is run */
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	unsigned int num_dapm_widgets;
+	const struct snd_soc_dapm_route *dapm_routes;
+	unsigned int num_dapm_routes;
+
+	int (*probe)(struct snd_soc_component *);
+	void (*remove)(struct snd_soc_component *);
+
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1e0d212..76598cc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1058,7 +1058,7 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	int i;
 
 	/* remove the platform */
@@ -1068,18 +1068,17 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 
 	/* remove the CODEC-side CODEC */
 	for (i = 0; i < rtd->num_codecs; i++) {
-		codec = rtd->codec_dais[i]->codec;
-		if (codec && codec->component.probed &&
-		    codec->component.driver->remove_order == order)
-			soc_remove_component(&codec->component);
+		component = rtd->codec_dais[i]->component;
+		if (component->probed &&
+		    component->driver->remove_order == order)
+			soc_remove_component(component);
 	}
 
 	/* remove any CPU-side CODEC */
 	if (cpu_dai) {
-		codec = cpu_dai->codec;
-		if (codec && codec->component.probed &&
-		    codec->component.driver->remove_order == order)
-			soc_remove_component(&codec->component);
+		if (cpu_dai->component->probed &&
+		    cpu_dai->component->driver->remove_order == order)
+			soc_remove_component(cpu_dai->component);
 	}
 }
 
@@ -1289,19 +1288,17 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	int i, ret;
 
 	/* probe the CPU-side component, if it is a CODEC */
-	if (rtd->cpu_dai->codec) {
-		component = &rtd->cpu_dai->codec->component;
-		if (!component->probed &&
-		    component->driver->probe_order == order) {
-			ret = soc_probe_component(card, component);
-			if (ret < 0)
-				return ret;
-		}
+	component = rtd->cpu_dai->component;
+	if (!component->probed &&
+	    component->driver->probe_order == order) {
+		ret = soc_probe_component(card, component);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* probe the CODEC-side components */
 	for (i = 0; i < rtd->num_codecs; i++) {
-		component = &rtd->codec_dais[i]->codec->component;
+		component = rtd->codec_dais[i]->component;
 		if (!component->probed &&
 		    component->driver->probe_order == order) {
 			ret = soc_probe_component(card, component);
@@ -4042,6 +4039,8 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 
 	component->dev = dev;
 	component->driver = driver;
+	component->probe = component->driver->probe;
+	component->remove = component->driver->remove;
 
 	if (!component->dapm_ptr)
 		component->dapm_ptr = &component->dapm;
@@ -4055,6 +4054,13 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	if (driver->stream_event)
 		dapm->stream_event = snd_soc_component_stream_event;
 
+	component->controls = driver->controls;
+	component->num_controls = driver->num_controls;
+	component->dapm_widgets = driver->dapm_widgets;
+	component->num_dapm_widgets = driver->num_dapm_widgets;
+	component->dapm_routes = driver->dapm_routes;
+	component->num_dapm_routes = driver->num_dapm_routes;
+
 	INIT_LIST_HEAD(&component->dai_list);
 	mutex_init(&component->io_mutex);
 
-- 
1.8.0
