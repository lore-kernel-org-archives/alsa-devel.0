From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: dapm: Simplify fully route card
	handling
Date: Sun, 21 Dec 2014 11:05:44 +0100
Message-ID: <1419156344-25472-2-git-send-email-lars@metafoo.de>
References: <1419156344-25472-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-115.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E8126059D
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 11:05:49 +0100 (CET)
In-Reply-To: <1419156344-25472-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

For legacy reasons the ASoC framework assumes that a CODEC INPUT or OUTPUT
widget that is not explicitly connected to a external source or sink is
potentially connected to a source or a sink and hence the framework treats
the widget itself as source (for INPUT) or sink (for OUTPUT). For this
reason a INPUT or OUTPUT widget that is really not connected needs to be
explicitly marked as so.

Setting the card's fully_routed flag will cause the ASoC core, once that all
widgets and routes have been registered, to go through the list of all
widgets and mark all INPUT and OUTPUT that are not externally connected as
non-connected. This essentially negates the default behaviour of treating
INPUT or OUTPUT widgets without external routes as sources or sinks.

This patch takes a different approach while getting the same result. Instead
of first marking INPUT and OUTPUT widgets as sinks/sources and then later
marking them as non-connected, just never mark them as a sink or a source if
the fully_routed flag is set on a card.

This requires a lot less code and also results in a slightly faster card
initialization since there is no need to iterate over all widgets and check
whether the INPUT and OUTPUT widgets are connected or not.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   1 -
 sound/soc/soc-core.c     |   3 --
 sound/soc/soc-dapm.c     | 104 ++++++++---------------------------------------
 3 files changed, 16 insertions(+), 92 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 89823cf..ecffecc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -431,7 +431,6 @@ int snd_soc_dapm_force_enable_pin_unlocked(struct snd_soc_dapm_context *dapm,
 					   const char *pin);
 int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 				const char *pin);
-void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card);
 unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol);
 
 /* Mostly internal - should not normally be used */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2c62620..c024962 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1626,9 +1626,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
-	if (card->fully_routed)
-		snd_soc_dapm_auto_nc_pins(card);
-
 	snd_soc_dapm_new_widgets(card);
 
 	ret = snd_card_register(card->snd_card);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b8eba93..ea49684 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2279,6 +2279,9 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 
 	switch (w->id) {
 	case snd_soc_dapm_input:
+		/* On a fully routed card a input is never a source */
+		if (w->dapm->card->fully_routed)
+			break;
 		w->is_source = 1;
 		list_for_each_entry(p, &w->sources, list_sink) {
 			if (p->source->id == snd_soc_dapm_micbias ||
@@ -2291,6 +2294,9 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 		}
 		break;
 	case snd_soc_dapm_output:
+		/* On a fully routed card a output is never a sink */
+		if (w->dapm->card->fully_routed)
+			break;
 		w->is_sink = 1;
 		list_for_each_entry(p, &w->sinks, list_source) {
 			if (p->sink->id == snd_soc_dapm_spk ||
@@ -3085,16 +3091,24 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	switch (w->id) {
 	case snd_soc_dapm_mic:
-	case snd_soc_dapm_input:
 		w->is_source = 1;
 		w->power_check = dapm_generic_check_power;
 		break;
+	case snd_soc_dapm_input:
+		if (!dapm->card->fully_routed)
+			w->is_source = 1;
+		w->power_check = dapm_generic_check_power;
+		break;
 	case snd_soc_dapm_spk:
 	case snd_soc_dapm_hp:
-	case snd_soc_dapm_output:
 		w->is_sink = 1;
 		w->power_check = dapm_generic_check_power;
 		break;
+	case snd_soc_dapm_output:
+		if (!dapm->card->fully_routed)
+			w->is_sink = 1;
+		w->power_check = dapm_generic_check_power;
+		break;
 	case snd_soc_dapm_vmid:
 	case snd_soc_dapm_siggen:
 		w->is_source = 1;
@@ -3809,92 +3823,6 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
 /**
- * dapm_is_external_path() - Checks if a path is a external path
- * @card: The card the path belongs to
- * @path: The path to check
- *
- * Returns true if the path is either between two different DAPM contexts or
- * between two external pins of the same DAPM context. Otherwise returns
- * false.
- */
-static bool dapm_is_external_path(struct snd_soc_card *card,
-	struct snd_soc_dapm_path *path)
-{
-	dev_dbg(card->dev,
-		"... Path %s(id:%d dapm:%p) - %s(id:%d dapm:%p)\n",
-		path->source->name, path->source->id, path->source->dapm,
-		path->sink->name, path->sink->id, path->sink->dapm);
-
-	/* Connection between two different DAPM contexts */
-	if (path->source->dapm != path->sink->dapm)
-		return true;
-
-	/* Loopback connection from external pin to external pin */
-	if (path->sink->id == snd_soc_dapm_input) {
-		switch (path->source->id) {
-		case snd_soc_dapm_output:
-		case snd_soc_dapm_micbias:
-			return true;
-		default:
-			break;
-		}
-	}
-
-	return false;
-}
-
-static bool snd_soc_dapm_widget_in_card_paths(struct snd_soc_card *card,
-					      struct snd_soc_dapm_widget *w)
-{
-	struct snd_soc_dapm_path *p;
-
-	list_for_each_entry(p, &w->sources, list_sink) {
-		if (dapm_is_external_path(card, p))
-			return true;
-	}
-
-	list_for_each_entry(p, &w->sinks, list_source) {
-		if (dapm_is_external_path(card, p))
-			return true;
-	}
-
-	return false;
-}
-
-/**
- * snd_soc_dapm_auto_nc_pins - call snd_soc_dapm_nc_pin for unused pins
- * @card: The card whose pins should be processed
- *
- * Automatically call snd_soc_dapm_nc_pin() for any external pins in the card
- * which are unused. Pins are used if they are connected externally to a
- * component, whether that be to some other device, or a loop-back connection to
- * the component itself.
- */
-void snd_soc_dapm_auto_nc_pins(struct snd_soc_card *card)
-{
-	struct snd_soc_dapm_widget *w;
-
-	dev_dbg(card->dev, "ASoC: Auto NC: DAPMs: card:%p\n", &card->dapm);
-
-	list_for_each_entry(w, &card->widgets, list) {
-		switch (w->id) {
-		case snd_soc_dapm_input:
-		case snd_soc_dapm_output:
-			dev_dbg(card->dev, "ASoC: Auto NC: Checking widget %s\n",
-				w->name);
-			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
-				dev_dbg(card->dev,
-					"... Not in map; disabling\n");
-				snd_soc_dapm_nc_pin(w->dapm, w->name);
-			}
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-/**
  * snd_soc_dapm_free - free dapm resources
  * @dapm: DAPM context
  *
-- 
1.8.0
