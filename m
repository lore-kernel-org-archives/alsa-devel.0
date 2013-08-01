From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: dapm: Fix kcontrol path list
	corruption
Date: Thu,  1 Aug 2013 14:08:07 +0200
Message-ID: <1375358887-9160-2-git-send-email-lars@metafoo.de>
References: <1375358887-9160-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id B7C65260369
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 14:07:07 +0200 (CEST)
In-Reply-To: <1375358887-9160-1-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

When calling krealloc for the kcontrol data the items in the path list that
point back to the head of the list will now point to freed memory, which causes
the list to become corrupted. To fix this, instead of resizing the whole data
struct, only resize the widget list.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This is a slightly different version from what I posted before. It should still
work but it would be good if somebody could test it.
---
 sound/soc/soc-dapm.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b4fae87..5f64c16 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -177,7 +177,7 @@ static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 struct dapm_kcontrol_data {
 	unsigned int value;
 	struct list_head paths;
-	struct snd_soc_dapm_widget_list wlist;
+	struct snd_soc_dapm_widget_list *wlist;
 };
 
 static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
@@ -185,7 +185,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 {
 	struct dapm_kcontrol_data *data;
 
-	data = kzalloc(sizeof(*data) + sizeof(widget), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		dev_err(widget->dapm->dev,
 				"ASoC: can't allocate kcontrol data for %s\n",
@@ -193,8 +193,6 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 		return -ENOMEM;
 	}
 
-	data->wlist.widgets[0] = widget;
-	data->wlist.num_widgets = 1;
 	INIT_LIST_HEAD(&data->paths);
 
 	kcontrol->private_data = data;
@@ -205,6 +203,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+	kfree(data->wlist);
 	kfree(data);
 }
 
@@ -213,25 +212,30 @@ static struct snd_soc_dapm_widget_list *dapm_kcontrol_get_wlist(
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
 
-	return &data->wlist;
+	return data->wlist;
 }
 
 static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
-	struct dapm_kcontrol_data *new_data;
-	unsigned int n = data->wlist.num_widgets + 1;
+	struct snd_soc_dapm_widget_list *new_wlist;
+	unsigned int n;
+
+	if (data->wlist)
+		n = data->wlist->num_widgets + 1;
+	else
+		n = 1;
 
-	new_data = krealloc(data, sizeof(*data) + sizeof(widget) * n,
-		GFP_KERNEL);
-	if (!new_data)
+	new_wlist = krealloc(data->wlist,
+			sizeof(*new_wlist) + sizeof(widget) * n, GFP_KERNEL);
+	if (!new_wlist)
 		return -ENOMEM;
 
-	new_data->wlist.widgets[n - 1] = widget;
-	new_data->wlist.num_widgets = n;
+	new_wlist->widgets[n - 1] = widget;
+	new_wlist->num_widgets = n;
 
-	kcontrol->private_data = new_data;
+	data->wlist = new_wlist;
 
 	return 0;
 }
@@ -689,12 +693,12 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 				w->name, name, ret);
 			return ret;
 		}
-	} else {
-		ret = dapm_kcontrol_add_widget(kcontrol, w);
-		if (ret)
-			return ret;
 	}
 
+	ret = dapm_kcontrol_add_widget(kcontrol, w);
+	if (ret)
+		return ret;
+
 	w->kcontrols[kci] = kcontrol;
 	dapm_kcontrol_add_path(kcontrol, path);
 
-- 
1.8.0
