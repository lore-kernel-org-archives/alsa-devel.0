From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Remove table based DAPM/control
	setup support from snd_soc_platform_driver
Date: Wed, 20 Aug 2014 13:08:49 +0200
Message-ID: <1408532929-26978-5-git-send-email-lars@metafoo.de>
References: <1408532929-26978-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id C8F7A2656E9
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 13:08:58 +0200 (CEST)
In-Reply-To: <1408532929-26978-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

There are no users left and new users should rather use the component_driver
struct embedded in the snd_soc_platform_driver struct to do this. E.g.:

static const struct snd_soc_platform_driver foobar_driver = {
	.component_driver = {
		.dapm_widgets = ...,
		.num_dapm_widgets = ...,
		...,
	},
	...
};

instead of

static const struct snd_soc_platform_driver foobar_driver = {
	.dapm_widgets = ...,
	.num_dapm_widgets = ...,
	...
};

This also allows us to remove the steal_sibling_dai_widgets hack.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  9 --------
 sound/soc/soc-core.c | 58 ++++++----------------------------------------------
 2 files changed, 6 insertions(+), 61 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e6440d8..3f07a1e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -764,7 +764,6 @@ struct snd_soc_component {
 	unsigned int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	unsigned int num_dapm_routes;
-	bool steal_sibling_dai_widgets;
 	struct snd_soc_codec *codec;
 
 	int (*probe)(struct snd_soc_component *);
@@ -869,14 +868,6 @@ struct snd_soc_platform_driver {
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
-	/* Default control and setup, added after probe() is run */
-	const struct snd_kcontrol_new *controls;
-	int num_controls;
-	const struct snd_soc_dapm_widget *dapm_widgets;
-	int num_dapm_widgets;
-	const struct snd_soc_dapm_route *dapm_routes;
-	int num_dapm_routes;
-
 	/*
 	 * For platform caused delay reporting.
 	 * Optional.
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e982cb0..c3a63a1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1089,7 +1089,6 @@ static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	struct snd_soc_component *dai_component, *component2;
 	struct snd_soc_dai *dai;
 	int ret;
 
@@ -1116,44 +1115,12 @@ static int soc_probe_component(struct snd_soc_card *card,
 		}
 	}
 
-	/*
-	 * This is rather ugly, but certain platforms expect that the DAPM
-	 * widgets for the DAIs for components with the same parent device are
-	 * created in the platforms DAPM context. Until that is fixed we need to
-	 * keep this.
-	 */
-	if (component->steal_sibling_dai_widgets) {
-		dai_component = NULL;
-		list_for_each_entry(component2, &component_list, list) {
-			if (component == component2)
-				continue;
-
-			if (component2->dev == component->dev &&
-			    !list_empty(&component2->dai_list)) {
-				dai_component = component2;
-				break;
-			}
-		}
-	} else {
-		dai_component = component;
-		list_for_each_entry(component2, &component_list, list) {
-			if (component2->dev == component->dev &&
-			    component2->steal_sibling_dai_widgets) {
-				dai_component = NULL;
-				break;
-			}
-		}
-	}
-
-	if (dai_component) {
-		list_for_each_entry(dai, &dai_component->dai_list, list) {
-			snd_soc_dapm_new_dai_widgets(dapm, dai);
-			if (ret != 0) {
-				dev_err(component->dev,
-					"Failed to create DAI widgets %d\n",
-					ret);
-				goto err_probe;
-			}
+	list_for_each_entry(dai, &component->dai_list, list) {
+		ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
+		if (ret != 0) {
+			dev_err(component->dev,
+				"Failed to create DAI widgets %d\n", ret);
+			goto err_probe;
 		}
 	}
 
@@ -4165,19 +4132,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
-	if (platform_drv->controls) {
-		platform->component.controls = platform_drv->controls;
-		platform->component.num_controls = platform_drv->num_controls;
-	}
-	if (platform_drv->dapm_widgets) {
-		platform->component.dapm_widgets = platform_drv->dapm_widgets;
-		platform->component.num_dapm_widgets = platform_drv->num_dapm_widgets;
-		platform->component.steal_sibling_dai_widgets = true;
-	}
-	if (platform_drv->dapm_routes) {
-		platform->component.dapm_routes = platform_drv->dapm_routes;
-		platform->component.num_dapm_routes = platform_drv->num_dapm_routes;
-	}
 
 	if (platform_drv->probe)
 		platform->component.probe = snd_soc_platform_drv_probe;
-- 
1.8.0
