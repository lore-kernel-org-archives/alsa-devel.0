From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/2] ASoC: core: Add extra dapm properties for
	Device Tree
Date: Sat, 14 Feb 2015 17:22:49 -0800
Message-ID: <15b0ecaefffcd48bb5f56fe76326d705c3467438.1423963314.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A9434260488
 for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2015 02:23:15 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id hz1so26999010pad.9
 for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2015 17:23:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The current helper functions, snd_soc_of_parse_audio_simple_widgets()
and snd_soc_of_parse_audio_routing(), set dapm_widgets and dapm_routes
without caring if they are already set by using build-in widgets and
routes in the card driver. So there could be one of them, build-in one
or Device Tree one, overrided by the other depending on which one was
assigned later.

This patch adds an extra pair of dapm_widgets and dapm_routes for DT
use only so as to prevent unexpected overriding.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ac8b333..7443062 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1068,11 +1068,16 @@ struct snd_soc_card {
 
 	/*
 	 * Card-specific routes and widgets.
+	 * Note: of_dapm_xxx for Device Tree; Otherwise for driver build-in.
 	 */
 	const struct snd_soc_dapm_widget *dapm_widgets;
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
+	const struct snd_soc_dapm_widget *of_dapm_widgets;
+	int num_of_dapm_widgets;
+	const struct snd_soc_dapm_route *of_dapm_routes;
+	int num_of_dapm_routes;
 	bool fully_routed;
 
 	struct work_struct deferred_resume_work;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c024962..2695a12 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1486,6 +1486,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
 					  card->num_dapm_widgets);
 
+	if (card->of_dapm_widgets)
+		snd_soc_dapm_new_controls(&card->dapm, card->of_dapm_widgets,
+					  card->num_of_dapm_widgets);
+
 	/* initialise the sound card only once */
 	if (card->probe) {
 		ret = card->probe(card);
@@ -1541,6 +1545,10 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
 					card->num_dapm_routes);
 
+	if (card->of_dapm_routes)
+		snd_soc_dapm_add_routes(&card->dapm, card->of_dapm_routes,
+					card->num_of_dapm_routes);
+
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
 		dai_link = &card->dai_link[i];
@@ -3187,8 +3195,8 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 		widgets[i].name = wname;
 	}
 
-	card->dapm_widgets = widgets;
-	card->num_dapm_widgets = num_widgets;
+	card->of_dapm_widgets = widgets;
+	card->num_of_dapm_widgets = num_widgets;
 
 	return 0;
 }
@@ -3272,8 +3280,8 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 		}
 	}
 
-	card->num_dapm_routes = num_routes;
-	card->dapm_routes = routes;
+	card->num_of_dapm_routes = num_routes;
+	card->of_dapm_routes = routes;
 
 	return 0;
 }
-- 
1.9.1
