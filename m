From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 3/3] ASoC: core - Add convenience register for
	platform kcontrol and DAPM
Date: Mon, 4 Jul 2011 22:10:53 +0100
Message-ID: <1309813853-7142-4-git-send-email-lrg@ti.com>
References: <1309813853-7142-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id DFC071038B6
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:11:02 +0200 (CEST)
In-Reply-To: <1309813853-7142-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Allow platform probe to register platform kcontrols and DAPM just like
the CODEC probe().

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    8 ++++++++
 sound/soc/soc-core.c |   11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6ce8dc3..aa19f5a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -651,6 +651,14 @@ struct snd_soc_platform_driver {
 	int (*pcm_new)(struct snd_soc_pcm_runtime *);
 	void (*pcm_free)(struct snd_pcm *);
 
+	/* Default control and setup, added after probe() is run */
+	const struct snd_kcontrol_new *controls;
+	int num_controls;
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	int num_dapm_widgets;
+	const struct snd_soc_dapm_route *dapm_routes;
+	int num_dapm_routes;
+
 	/*
 	 * For platform caused delay reporting.
 	 * Optional.
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 36e71e9..70f4779 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -998,6 +998,10 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	if (!try_module_get(platform->dev->driver->owner))
 		return -ENODEV;
 
+	if (driver->dapm_widgets)
+		snd_soc_dapm_new_controls(&platform->dapm,
+			driver->dapm_widgets, driver->num_dapm_widgets);
+
 	if (driver->probe) {
 		ret = driver->probe(platform);
 		if (ret < 0) {
@@ -1008,6 +1012,13 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		}
 	}
 
+	if (driver->controls)
+		snd_soc_add_platform_controls(platform, driver->controls,
+				     driver->num_controls);
+	if (driver->dapm_routes)
+		snd_soc_dapm_add_routes(&platform->dapm, driver->dapm_routes,
+					driver->num_dapm_routes);
+
 	/* mark platform as probed and add to card platform list */
 	platform->probed = 1;
 	list_add(&platform->card_list, &card->platform_dev_list);
-- 
1.7.4.1
