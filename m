From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add data based control initialisation
	for CODECs and cards
Date: Thu,  7 Apr 2011 19:24:00 +0900
Message-ID: <1302171840-22041-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E65A524333
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 01:12:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow CODEC and card drivers to point to an array of controls from their
driver structure rather than explicitly calling snd_soc_add_controls().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    7 ++++++-
 sound/soc/soc-core.c |   11 +++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2720a9f..435cb83 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -577,7 +577,9 @@ struct snd_soc_codec_driver {
 			pm_message_t state);
 	int (*resume)(struct snd_soc_codec *);
 
-	/* Default DAPM setup, added after probe() is run */
+	/* Default control and setup, added after probe() is run */
+	const struct snd_kcontrol_new *controls;
+	int num_controls;
 	const struct snd_soc_dapm_widget *dapm_widgets;
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
@@ -747,6 +749,9 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd_aux;
 	int num_aux_rtd;
 
+	const struct snd_kcontrol_new *controls;
+	int num_controls;
+
 	/*
 	 * Card-specific routes and widgets.
 	 */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0cf6997..d95ff2a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1491,6 +1491,9 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		}
 	}
 
+	if (driver->controls)
+		snd_soc_add_controls(codec, driver->controls,
+				     driver->num_controls);
 	if (driver->dapm_widgets)
 		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
 					  driver->num_dapm_widgets);
@@ -1888,6 +1891,14 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	/* We should have a non-codec control add function but we don't */
+	if (card->controls)
+		snd_soc_add_controls(list_first_entry(&card->codec_dev_list,
+						      struct snd_soc_codec,
+						      card_list),
+				     card->controls,
+				     card->num_controls);
+
 	if (card->dapm_widgets)
 		snd_soc_dapm_new_controls(&card->dapm, card->dapm_widgets,
 					  card->num_dapm_widgets);
-- 
1.7.4.1
