From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/10] ASoC: dapm: Keep a list of paths per
	kcontrol
Date: Mon, 29 Jul 2013 17:14:00 +0200
Message-ID: <1375110845-8069-6-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CDD262618
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:16 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
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

Currently we store for each path which control (if any at all) is associated
with that control. But we are only ever interested in the reverse relationship,
i.e. we want to know all the paths a certain control is associated with. This is
currently implemented by always iterating over all paths. This patch updates the
code to keep a list for each control which contains all the paths that are
associated with that control. This improves the run time of e.g.
soc_dapm_mixer_update_power() and soc_dapm_mux_update_power() from O(n) (with n
being the number of paths for the card) to O(1).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  2 +-
 sound/soc/soc-dapm.c     | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d7d26cc..693c75b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -490,7 +490,6 @@ struct snd_soc_dapm_path {
 	/* source (input) and sink (output) widgets */
 	struct snd_soc_dapm_widget *source;
 	struct snd_soc_dapm_widget *sink;
-	struct snd_kcontrol *kcontrol;
 
 	/* status */
 	u32 connect:1;	/* source and sink widgets are connected */
@@ -503,6 +502,7 @@ struct snd_soc_dapm_path {
 
 	struct list_head list_source;
 	struct list_head list_sink;
+	struct list_head list_kcontrol;
 	struct list_head list;
 };
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bad6f6d..b779d36 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -176,6 +176,7 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 
 struct dapm_kcontrol_data {
 	unsigned int value;
+	struct list_head paths;
 	struct snd_soc_dapm_widget_list wlist;
 };
 
@@ -194,6 +195,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 	data->wlist.widgets[0] = widget;
 	data->wlist.num_widgets = 1;
+	INIT_LIST_HEAD(&data->paths);
 
 	kcontrol->private_data = data;
 
@@ -234,6 +236,26 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static void dapm_kcontrol_add_path(const struct snd_kcontrol *kcontrol,
+	struct snd_soc_dapm_path *path)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	list_add_tail(&path->list_kcontrol, &data->paths);
+}
+
+static struct list_head *dapm_kcontrol_get_path_list(
+	const struct snd_kcontrol *kcontrol)
+{
+	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
+
+	return &data->paths;
+}
+
+#define dapm_kcontrol_for_each_path(path, kcontrol) \
+	list_for_each_entry(path, dapm_kcontrol_get_path_list(kcontrol), \
+		list_kcontrol)
+
 static unsigned int dapm_kcontrol_get_value(const struct snd_kcontrol *kcontrol)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
@@ -671,7 +693,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	}
 
 	w->kcontrols[kci] = kcontrol;
-	path->kcontrol = kcontrol;
+	dapm_kcontrol_add_path(kcontrol, path);
 
 	return 0;
 }
@@ -691,7 +713,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				continue;
 
 			if (w->kcontrols[i]) {
-				path->kcontrol = w->kcontrols[i];
+				dapm_kcontrol_add_path(w->kcontrols[i], path);
 				continue;
 			}
 
@@ -730,7 +752,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 		return ret;
 
 	list_for_each_entry(path, &w->sources, list_sink)
-		path->kcontrol = w->kcontrols[0];
+		dapm_kcontrol_add_path(w->kcontrols[0], path);
 
 	return 0;
 }
@@ -1990,10 +2012,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 	int found = 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &card->paths, list) {
-		if (path->kcontrol != kcontrol)
-			continue;
-
+	dapm_kcontrol_for_each_path(path, kcontrol) {
 		if (!path->name || !e->texts[mux])
 			continue;
 
@@ -2043,11 +2062,7 @@ static int soc_dapm_mixer_update_power(struct snd_soc_card *card,
 	int found = 0;
 
 	/* find dapm widget path assoc with kcontrol */
-	list_for_each_entry(path, &card->paths, list) {
-		if (path->kcontrol != kcontrol)
-			continue;
-
-		/* found, now check type */
+	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
 		path->connect = connect;
 		dapm_mark_dirty(path->source, "mixer connection");
@@ -2152,6 +2167,7 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 {
 	list_del(&path->list_sink);
 	list_del(&path->list_source);
+	list_del(&path->list_kcontrol);
 	list_del(&path->list);
 	kfree(path);
 }
-- 
1.8.0
