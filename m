From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: Instantiate all DAPM widgets at once
Date: Thu, 28 Apr 2011 18:46:13 +0200
Message-ID: <1304009173-5786-7-git-send-email-lars@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-163.synserver.de
	[212.40.185.163])
	by alsa0.perex.cz (Postfix) with SMTP id 0FB011039BE
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 18:46:31 +0200 (CEST)
In-Reply-To: <1304009173-5786-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently after each codec or auxdev has been probed its DAPM widgets are
instantiated.

Since widgets are kept in a per card list and routes can interconnect between
widgets from different DAPM contexts on the same card it is possible that
snd_soc_dapm_new_widgets is run on an incomplete DAPM configuration which might
cause unnecessary register writes and/or cause audible problems.

This patch addresses the issue by instantiating all widgets from all DAPM contexts
after all components of the card have been initialized.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   16 +++++++++++++++-
 sound/soc/soc-core.c     |    5 ++---
 sound/soc/soc-dapm.c     |   29 ++++++++++++++---------------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9679c18..5666c3e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -344,7 +344,7 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	int num);
 
 /* dapm path setup */
-int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
+int snd_soc_dapm_card_new_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
@@ -515,4 +515,18 @@ struct snd_soc_dapm_context {
 #endif
 };
 
+/*
+ * snd_soc_dapm_new_widgets - add new dapm widgets
+ * @dapm: DAPM context
+ *
+ * Checks the DAPM context's card for any new dapm widgets and creates them if
+ * found.
+ *
+ * Returns 0 for success.
+ */
+static inline int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
+{
+	return snd_soc_dapm_card_new_widgets(dapm->card);
+}
+
 #endif
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c30fa9d..ea38e0a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1567,9 +1567,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	}
 	codec->name_prefix = temp;
 
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-
 	/* register the rtd device */
 	rtd->codec = codec;
 	rtd->dev.parent = card->dev;
@@ -1935,6 +1932,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 			goto probe_aux_dev_err;
 		}
 	}
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_card_new_widgets(card);
 
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e3c5d36..46e396c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -323,9 +323,9 @@ static int dapm_connect_mixer(struct snd_soc_dapm_context *dapm,
 }
 
 /* create new dapm mixer control */
-static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_widget *w)
+static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 {
+	struct snd_soc_dapm_context *dapm = w->dapm;
 	int i, ret = 0;
 	size_t name_len, prefix_len;
 	struct snd_soc_dapm_path *path;
@@ -404,9 +404,9 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 }
 
 /* create new dapm mux control */
-static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_widget *w)
+static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 {
+	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
 	struct snd_card *card = dapm->card->snd_card;
@@ -451,8 +451,7 @@ err:
 }
 
 /* create new dapm volume control */
-static int dapm_new_pga(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_widget *w)
+static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 {
 	if (w->num_kcontrols)
 		dev_err(w->dapm->dev,
@@ -1679,19 +1678,19 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
 /**
- * snd_soc_dapm_new_widgets - add new dapm widgets
- * @dapm: DAPM context
+ * snd_soc_dapm_card_new_widgets - add new dapm widgets
+ * @card: Card to check for new widgets
  *
- * Checks the codec for any new dapm widgets and creates them if found.
+ * Checks the card for any new dapm widgets and creates them if found.
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
+int snd_soc_dapm_card_new_widgets(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
 	unsigned int val;
 
-	list_for_each_entry(w, &dapm->card->widgets, list)
+	list_for_each_entry(w, &card->widgets, list)
 	{
 		if (w->new)
 			continue;
@@ -1701,13 +1700,13 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mixer(dapm, w);
+			dapm_new_mixer(w);
 			break;
 		case snd_soc_dapm_mux:
 		case snd_soc_dapm_virt_mux:
 		case snd_soc_dapm_value_mux:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_mux(dapm, w);
+			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_adc:
 		case snd_soc_dapm_aif_out:
@@ -1720,7 +1719,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		case snd_soc_dapm_pga:
 		case snd_soc_dapm_out_drv:
 			w->power_check = dapm_generic_check_power;
-			dapm_new_pga(dapm, w);
+			dapm_new_pga(w);
 			break;
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
@@ -1755,7 +1754,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm)
 		dapm_debugfs_add_widget(w);
 	}
 
-	dapm_power_widgets(dapm->card, SND_SOC_DAPM_STREAM_NOP, NULL);
+	dapm_power_widgets(card, SND_SOC_DAPM_STREAM_NOP, NULL);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
-- 
1.7.2.5
