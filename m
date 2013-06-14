From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: dapm: Add a helper function to free
	a DAPM path
Date: Fri, 14 Jun 2013 13:16:53 +0200
Message-ID: <1371208614-18697-4-git-send-email-lars@metafoo.de>
References: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-121.synserver.de (smtp-out-121.synserver.de
 [212.40.185.121])
 by alsa0.perex.cz (Postfix) with ESMTP id DE907264F3A
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:16:56 +0200 (CEST)
In-Reply-To: <1371208614-18697-1-git-send-email-lars@metafoo.de>
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

We have the same code for freeing a DAPM path in three different locations.
Introduce a new helper function to take care of this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6d4a72e..a771473 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2109,6 +2109,15 @@ static void snd_soc_dapm_sys_remove(struct device *dev)
 	device_remove_file(dev, &dev_attr_dapm_widget);
 }
 
+static void dapm_free_path(struct snd_soc_dapm_path *path)
+{
+	list_del(&path->list_sink);
+	list_del(&path->list_source);
+	list_del(&path->list);
+	kfree(path->long_name);
+	kfree(path);
+}
+
 /* free all dapm widgets and resources */
 static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
@@ -2124,20 +2133,12 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 		 * While removing the path, remove reference to it from both
 		 * source and sink widgets so that path is removed only once.
 		 */
-		list_for_each_entry_safe(p, next_p, &w->sources, list_sink) {
-			list_del(&p->list_sink);
-			list_del(&p->list_source);
-			list_del(&p->list);
-			kfree(p->long_name);
-			kfree(p);
-		}
-		list_for_each_entry_safe(p, next_p, &w->sinks, list_source) {
-			list_del(&p->list_sink);
-			list_del(&p->list_source);
-			list_del(&p->list);
-			kfree(p->long_name);
-			kfree(p);
-		}
+		list_for_each_entry_safe(p, next_p, &w->sources, list_sink)
+			dapm_free_path(p);
+
+		list_for_each_entry_safe(p, next_p, &w->sinks, list_source)
+			dapm_free_path(p);
+
 		kfree(w->kcontrols);
 		kfree(w->name);
 		kfree(w);
@@ -2413,10 +2414,7 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 		dapm_mark_dirty(path->source, "Route removed");
 		dapm_mark_dirty(path->sink, "Route removed");
 
-		list_del(&path->list);
-		list_del(&path->list_sink);
-		list_del(&path->list_source);
-		kfree(path);
+		dapm_free_path(path);
 	} else {
 		dev_warn(dapm->dev, "ASoC: Route %s->%s does not exist\n",
 			 source, sink);
-- 
1.8.0
