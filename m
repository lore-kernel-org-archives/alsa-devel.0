From: Zhiwei Jiang <qq282012236@gmail.com>
Subject: [PATCH] ASoC: dapm: Skip suspending widgets with ignore flag
Date: Mon, 21 Jan 2019 22:48:18 +0800
Message-ID: <20190121144818.23042-1-qq282012236@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: qq282012236@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

For endpoint wigdets which have set the suspend ignore flag, asoc
shouldn't mark them as dirty when ASoC suspend function is called.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..68c49090f561 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -278,7 +278,7 @@ void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 	mutex_lock(&card->dapm_mutex);
 
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->is_ep) {
+		if (w->is_ep && !w->ignore_suspend) {
 			dapm_mark_dirty(w, "Rechecking endpoints");
 			if (w->is_ep & SND_SOC_DAPM_EP_SINK)
 				dapm_widget_invalidate_output_paths(w);
-- 
2.19.0
