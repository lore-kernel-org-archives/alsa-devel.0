From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/12] ASoC: dapm: Reduce number of checked
	paths in dapm_widget_in_card_paths()
Date: Mon, 20 Oct 2014 19:36:33 +0200
Message-ID: <1413826604-3212-2-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A79B2658B3
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:47 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
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

Each widget has a list of all the paths that it is connected to. There is no
need to iterate over all paths when we are only interested in the paths of a
specific widget.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 65 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c61cb9c..b8b44c9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3788,35 +3788,54 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
+/**
+ * dapm_is_external_path() - Checks if a path is a external path
+ * @card: The card the path belongs to
+ * @path: The path to check
+ *
+ * Returns true if the path is either between two different DAPM contexts or
+ * between two external pins of the same DAPM context. Otherwise returns
+ * false.
+ */
+static bool dapm_is_external_path(struct snd_soc_card *card,
+	struct snd_soc_dapm_path *path)
+{
+	dev_dbg(card->dev,
+		"... Path %s(id:%d dapm:%p) - %s(id:%d dapm:%p)\n",
+		path->source->name, path->source->id, path->source->dapm,
+		path->sink->name, path->sink->id, path->sink->dapm);
+
+	/* Connection between two different DAPM contexts */
+	if (path->source->dapm != path->sink->dapm)
+		return true;
+
+	/* Loopback connection from external pin to external pin */
+	if (path->sink->id == snd_soc_dapm_input) {
+		switch (path->source->id) {
+		case snd_soc_dapm_output:
+		case snd_soc_dapm_micbias:
+			return true;
+		default:
+			break;
+		}
+	}
+
+	return false;
+}
+
 static bool snd_soc_dapm_widget_in_card_paths(struct snd_soc_card *card,
 					      struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &card->paths, list) {
-		if ((p->source == w) || (p->sink == w)) {
-			dev_dbg(card->dev,
-			    "... Path %s(id:%d dapm:%p) - %s(id:%d dapm:%p)\n",
-			    p->source->name, p->source->id, p->source->dapm,
-			    p->sink->name, p->sink->id, p->sink->dapm);
+	list_for_each_entry(p, &w->sources, list_sink) {
+		if (dapm_is_external_path(card, p))
+			return true;
+	}
 
-			/* Connected to something other than the codec */
-			if (p->source->dapm != p->sink->dapm)
-				return true;
-			/*
-			 * Loopback connection from codec external pin to
-			 * codec external pin
-			 */
-			if (p->sink->id == snd_soc_dapm_input) {
-				switch (p->source->id) {
-				case snd_soc_dapm_output:
-				case snd_soc_dapm_micbias:
-					return true;
-				default:
-					break;
-				}
-			}
-		}
+	list_for_each_entry(p, &w->sinks, list_source) {
+		if (dapm_is_external_path(card, p))
+			return true;
 	}
 
 	return false;
-- 
1.8.0
