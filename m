From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/12] ASoC: dapm: Remove always true path
	source/sink checks
Date: Mon, 20 Oct 2014 19:36:34 +0200
Message-ID: <1413826604-3212-3-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6B72658B4
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

A path has always a valid source and a valid sink otherwise we wouldn't add
it in the first place. Hence all tests that check if sink/source is non NULL
always evaluate to true and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b8b44c9..12f9f5f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -909,7 +909,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 		trace_snd_soc_dapm_output_path(widget, path);
 
-		if (path->sink && path->connect) {
+		if (path->connect) {
 			path->walked = 1;
 			path->walking = 1;
 
@@ -1017,7 +1017,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 		trace_snd_soc_dapm_input_path(widget, path);
 
-		if (path->source && path->connect) {
+		if (path->connect) {
 			path->walked = 1;
 			path->walking = 1;
 
@@ -1219,9 +1219,6 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 		    !path->connected(path->source, path->sink))
 			continue;
 
-		if (!path->sink)
-			continue;
-
 		if (dapm_widget_power_check(path->sink))
 			return 1;
 	}
@@ -1636,12 +1633,9 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	/* If we changed our power state perhaps our neigbours changed
 	 * also.
 	 */
-	list_for_each_entry(path, &w->sources, list_sink) {
-		if (path->source) {
-			dapm_widget_set_peer_power(path->source, power,
-						   path->connect);
-		}
-	}
+	list_for_each_entry(path, &w->sources, list_sink)
+		dapm_widget_set_peer_power(path->source, power, path->connect);
+
 	switch (w->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
@@ -1650,12 +1644,9 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 		/* Supplies can't affect their outputs, only their inputs */
 		break;
 	default:
-		list_for_each_entry(path, &w->sinks, list_source) {
-			if (path->sink) {
-				dapm_widget_set_peer_power(path->sink, power,
-							   path->connect);
-			}
-		}
+		list_for_each_entry(path, &w->sinks, list_source)
+			dapm_widget_set_peer_power(path->sink, power,
+						   path->connect);
 		break;
 	}
 
-- 
1.8.0
