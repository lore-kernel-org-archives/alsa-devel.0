From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/3] ASoC: dapm: fix use-after-free issue with
	dailink sname
Date: Fri,  1 Feb 2019 11:05:12 -0600
Message-ID: <20190201170513.13905-3-pierre-louis.bossart@linux.intel.com>
References: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B44F267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 18:05:23 +0100 (CET)
In-Reply-To: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Commit 7620fe9161ce ("ASoC: topology: fix memory leak in
soc_tplg_dapm_widget_create") fixed a memory leak issue, but
additional tests and KASAN reports show a use-after-free in soc-dapm.

The widgets are created with a kmemdup operating on a template. The
"name" string is also duplicated, but the "sname" string is not. As a
result, when the template is freed after widget creation, its sname
string is still used.

Fix by explicitly duplicating the "sname" string, and freeing it when
required.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-dapm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f0d3d2d1a6bc..993b73fcd7b9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -321,7 +321,22 @@ EXPORT_SYMBOL_GPL(dapm_mark_endpoints_dirty);
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	const struct snd_soc_dapm_widget *_widget)
 {
-	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
+	struct snd_soc_dapm_widget *w;
+
+	w = kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
+	if (!w)
+		return NULL;
+
+	/*
+	 * w->name is duplicated in caller, but w->sname isn't.
+	 * Duplicate it here if defined
+	 */
+	if (_widget->sname) {
+		w->sname = kstrdup_const(_widget->sname, GFP_KERNEL);
+		if (!w->sname)
+			return NULL;
+	}
+	return w;
 }
 
 struct dapm_kcontrol_data {
@@ -2438,6 +2453,7 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 
 	kfree(w->kcontrols);
 	kfree_const(w->name);
+	kfree_const(w->sname);
 	kfree(w);
 }
 
@@ -3495,6 +3511,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	else
 		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
+		kfree_const(w->sname);
 		kfree(w);
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.17.1
