From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Reduce the number of neigbours we mark
	dirty when updating power
Date: Mon,  3 Oct 2011 22:44:41 +0100
Message-ID: <1317678281-30696-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3EFFC103944
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 23:44:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If two widgets are not currently connected then there is no need to
propagate a power state change between them as we mark the affected
widgets when we change a connection. Similarly if a neighbour widget is
already in the state being set for the current widget then there is no
need to recheck.

On one system I tested this gave:

           Power    Path   Neighbour
Before:    114      1066   1327
After:     106      970    1186

which is an improvement, although relatively small.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 06d8cfa..e0d9971 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1215,6 +1215,21 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	}
 }
 
+static void dapm_widget_set_peer_power(struct snd_soc_dapm_widget *peer,
+				       bool power, bool connect)
+{
+	/* If a connection is being made or broken then that update
+	 * will have marked the peer dirty, otherwise the widgets are
+	 * not connected and this update has no impact. */
+	if (!connect)
+		return;
+
+	/* If the peer is already in the state we're moving to then we
+	 * won't have an impact on it. */
+	if (power != peer->power)
+		dapm_mark_dirty(peer);
+}
+
 static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 				  struct list_head *up_list,
 				  struct list_head *down_list)
@@ -1227,19 +1242,18 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	trace_snd_soc_dapm_widget_power(w, power);
 
 	/* If we changed our power state perhaps our neigbours changed
-	 * also.  We're not yet smart enough to update relevant
-	 * neighbours when we change the state of a widget, this acts
-	 * as a proxy for that.  It will notify more neighbours than
-	 * is ideal.
+	 * also.
 	 */
 	list_for_each_entry(path, &w->sources, list_sink) {
 		if (path->source) {
-			dapm_mark_dirty(path->source);
+			dapm_widget_set_peer_power(path->source, power,
+						   path->connect);
 		}
 	}
 	list_for_each_entry(path, &w->sinks, list_source) {
 		if (path->sink) {
-			dapm_mark_dirty(path->sink);
+			dapm_widget_set_peer_power(path->sink, power,
+						   path->connect);
 		}
 	}
 
-- 
1.7.6.3
