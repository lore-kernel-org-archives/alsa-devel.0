From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: dapm: fix module unload/reload failed
	issue by reset kcontrol's widget list
Date: Tue, 28 Jul 2015 17:03:39 +0800
Message-ID: <1438074219-26408-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C844260438
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 10:58:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We need reset the related kcontrol's widget list during the
freeing of a widget, otherwise, the widget list may be outdated
and reference to it may introduce errors(they usually occurs
during driver modules unloading/reloading).

Here adding a func dapm_update_kcontrols_of_freeing_widget and
call it at dapm_update_kcontrols_of_freeing_widget, to fix those
issues.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/soc-dapm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index aa327c9..1ad8144 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2305,6 +2305,35 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	kfree(path);
 }
 
+/* update all dapm kcontrols that related to a widget which being freed*/
+static void dapm_update_kcontrols_of_freeing_widget(struct snd_soc_dapm_widget * w)
+{
+	struct dapm_kcontrol_data *data = NULL;
+	int i, j, n;
+
+	if (w && w->kcontrols) {
+		for (i = 0; i < w->num_kcontrols; i++) {
+			if (w->kcontrols[i] == NULL)
+				continue;
+			data = snd_kcontrol_chip(w->kcontrols[i]);
+			if (data == NULL)
+				continue;
+			for (j = 0, n = 0; j < data->wlist->num_widgets; j++) {
+				if (data->wlist->widgets[j] == w) {
+					data->wlist->widgets[j] = NULL;
+					n++;
+				}
+			}
+
+			if (n) {
+				data->wlist->num_widgets -= n;
+				data->widget = NULL;
+			}
+		}
+	}
+
+}
+
 /* free all dapm widgets and resources */
 static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
@@ -2326,6 +2355,8 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 		list_for_each_entry_safe(p, next_p, &w->sinks, list_source)
 			dapm_free_path(p);
 
+		dapm_update_kcontrols_of_freeing_widget(w);
+
 		kfree(w->kcontrols);
 		kfree(w->name);
 		kfree(w);
-- 
1.9.1
