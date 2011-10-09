From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Cache connected input and output
	recursions
Date: Sun,  9 Oct 2011 11:53:14 +0100
Message-ID: <1318157594-18998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89133245FE
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:53:16 +0200 (CEST)
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

The number of connected input and output endpoints for a given widgets
can't change during a DAPM run so there is no need to redo the recursion
through branches of the tree we've already visited. Doing this on one of
my test systems gives an improvement of:

         Power    Path   Neighbour
Before:  63       607    731
After:   63       141    181

which scales up well as more widgets are involved in paths.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +
 sound/soc/soc-dapm.c     |   60 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5b2202f..17a4c17 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -498,6 +498,8 @@ struct snd_soc_dapm_widget {
 	/* used during DAPM updates */
 	struct list_head power_list;
 	struct list_head dirty;
+	int inputs;
+	int outputs;
 };
 
 struct snd_soc_dapm_update {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 24e5d45..f42e8b9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -666,6 +666,9 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	struct snd_soc_dapm_path *path;
 	int con = 0;
 
+	if (widget->outputs >= 0)
+		return widget->outputs;
+
 	DAPM_UPDATE_STAT(widget, path_checks);
 
 	if (widget->id == snd_soc_dapm_supply)
@@ -674,21 +677,29 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
-		if (widget->active)
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->active) {
+			widget->outputs = snd_soc_dapm_suspend_check(widget);
+			return widget->outputs;
+		}
 	default:
 		break;
 	}
 
 	if (widget->connected) {
 		/* connected pin ? */
-		if (widget->id == snd_soc_dapm_output && !widget->ext)
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->id == snd_soc_dapm_output && !widget->ext) {
+			widget->outputs = snd_soc_dapm_suspend_check(widget);
+			return widget->outputs;
+		}
 
 		/* connected jack or spk ? */
-		if (widget->id == snd_soc_dapm_hp || widget->id == snd_soc_dapm_spk ||
-		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sources)))
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->id == snd_soc_dapm_hp ||
+		    widget->id == snd_soc_dapm_spk ||
+		    (widget->id == snd_soc_dapm_line &&
+		     !list_empty(&widget->sources))) {
+			widget->outputs = snd_soc_dapm_suspend_check(widget);
+			return widget->outputs;
+		}
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
@@ -706,6 +717,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 		}
 	}
 
+	widget->outputs = con;
+
 	return con;
 }
 
@@ -718,6 +731,9 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	struct snd_soc_dapm_path *path;
 	int con = 0;
 
+	if (widget->inputs >= 0)
+		return widget->inputs;
+
 	DAPM_UPDATE_STAT(widget, path_checks);
 
 	if (widget->id == snd_soc_dapm_supply)
@@ -727,25 +743,35 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
-		if (widget->active)
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->active) {
+			widget->inputs = snd_soc_dapm_suspend_check(widget);
+			return widget->inputs;
+		}
 	default:
 		break;
 	}
 
 	if (widget->connected) {
 		/* connected pin ? */
-		if (widget->id == snd_soc_dapm_input && !widget->ext)
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->id == snd_soc_dapm_input && !widget->ext) {
+			widget->inputs = snd_soc_dapm_suspend_check(widget);
+			return widget->inputs;
+		}
 
 		/* connected VMID/Bias for lower pops */
-		if (widget->id == snd_soc_dapm_vmid)
-			return snd_soc_dapm_suspend_check(widget);
+		if (widget->id == snd_soc_dapm_vmid) {
+			widget->inputs = snd_soc_dapm_suspend_check(widget);
+			return widget->inputs;
+		}
 
 		/* connected jack ? */
 		if (widget->id == snd_soc_dapm_mic ||
-		    (widget->id == snd_soc_dapm_line && !list_empty(&widget->sinks)))
-			return snd_soc_dapm_suspend_check(widget);
+		    (widget->id == snd_soc_dapm_line &&
+		     !list_empty(&widget->sinks))) {
+			widget->inputs = snd_soc_dapm_suspend_check(widget);
+			return widget->inputs;
+		}
+
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
@@ -763,6 +789,8 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 		}
 	}
 
+	widget->inputs = con;
+
 	return con;
 }
 
@@ -1336,6 +1364,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 
 	list_for_each_entry(w, &card->widgets, list) {
 		w->power_checked = false;
+		w->inputs = -1;
+		w->outputs = -1;
 	}
 
 	/* Check which widgets we need to power and store them in
-- 
1.7.6.3
