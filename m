From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/12] ASoC: dapm: Add a flag to mark paths
	connected to supply widgets
Date: Mon, 20 Oct 2014 19:36:41 +0200
Message-ID: <1413826604-3212-10-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 12D092658CB
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:54 +0200 (CEST)
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

Supply widgets do not count towards the input and output widgets of their
neighbors and for supply widgets themselves we do not care for the number
of input or output paths. This means that a path that connects to a supply
widget effectively behaves the same as a path that as the weak property set.
This patch adds a new path flag that gets set to true when the path is
connected to at least one supply widget. If a path with the flag set is
encountered in is_connected_{input,output}_ep() is is skipped in the same
way that weak paths are skipped. This slightly brings down the number of
path checks.

Since both the weak and the supply flag are implemented as bitfields which
are stored in the same word there is no runtime overhead due to checking
both rather than just one and also the size of the path struct is not
increased by this patch. Another advantage is that we do not have to handle
supply widgets in is_connected_{input,output}_ep() anymore since it will
never be called for supply widgets. The only exception is from
dapm_widget_power_read_file() where a check is added to special case supply
widgets.

Testing with the ADAU1761, which has a handful of supply widgets, shows the
following changes in the DAPM stats for a playback stream start.

         Power  Path  Neighbour
Before:  34     78    117
After:   34     48    117

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  1 +
 sound/soc/soc-dapm.c     | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 8cf3aad..e7ebeb7 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -510,6 +510,7 @@ struct snd_soc_dapm_path {
 	u32 connect:1;	/* source and sink widgets are connected */
 	u32 walking:1;  /* path is in the process of being walked */
 	u32 weak:1;	/* path ignored for power management */
+	u32 is_supply:1;	/* At least one of the connected widgets is a supply */
 
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 578c119..a7d5acf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -821,9 +821,6 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	if (widget->is_supply)
-		return 0;
-
 	if (widget->is_sink && widget->connected) {
 		widget->outputs = snd_soc_dapm_suspend_check(widget);
 		return widget->outputs;
@@ -832,7 +829,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 	list_for_each_entry(path, &widget->sinks, list_source) {
 		DAPM_UPDATE_STAT(widget, neighbour_checks);
 
-		if (path->weak)
+		if (path->weak || path->is_supply)
 			continue;
 
 		if (path->walking)
@@ -882,9 +879,6 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	if (widget->is_supply)
-		return 0;
-
 	if (widget->is_source && widget->connected) {
 		widget->inputs = snd_soc_dapm_suspend_check(widget);
 		return widget->inputs;
@@ -893,7 +887,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 	list_for_each_entry(path, &widget->sources, list_sink) {
 		DAPM_UPDATE_STAT(widget, neighbour_checks);
 
-		if (path->weak)
+		if (path->weak || path->is_supply)
 			continue;
 
 		if (path->walking)
@@ -1691,8 +1685,14 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	in = is_connected_input_ep(w, NULL);
-	out = is_connected_output_ep(w, NULL);
+	/* Supply widgets are not handled by is_connected_{input,output}_ep() */
+	if (w->is_supply) {
+		in = 0;
+		out = 0;
+	} else {
+		in = is_connected_input_ep(w, NULL);
+		out = is_connected_output_ep(w, NULL);
+	}
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
 		       w->name, w->power ? "On" : "Off",
@@ -2217,6 +2217,9 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	INIT_LIST_HEAD(&path->list_source);
 	INIT_LIST_HEAD(&path->list_sink);
 
+	if (wsource->is_supply || wsink->is_supply)
+		path->is_supply = 1;
+
 	/* connect static paths */
 	if (control == NULL) {
 		path->connect = 1;
-- 
1.8.0
