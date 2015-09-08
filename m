From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: make dapm cache search depth configurable
Date: Tue,  8 Sep 2015 11:11:37 +0100
Message-ID: <1441707097-11200-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C46FE260666
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 12:11:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Nikesh.Oswal@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

cache search depth will have a default value of 2 and can
be modified by the respective component probe function

Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-core.c     |    2 ++
 sound/soc/soc-dapm.c     |    5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5abba03..15717b4 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -629,6 +629,7 @@ struct snd_soc_dapm_context {
 
 	struct snd_soc_dapm_wcache path_sink_cache;
 	struct snd_soc_dapm_wcache path_source_cache;
+	unsigned int cache_search_depth;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6173d15..1802883 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1595,6 +1595,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	card->dapm.bias_level = SND_SOC_BIAS_OFF;
 	card->dapm.dev = card->dev;
 	card->dapm.card = card;
+	card->dapm.cache_search_depth = 2;
 	list_add(&card->dapm.list, &card->dapm_list);
 
 #ifdef CONFIG_DEBUG_FS
@@ -2665,6 +2666,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->remove = component->driver->remove;
 
 	dapm = &component->dapm;
+	dapm->cache_search_depth = 2;
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f4bf21a..36ab9cb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -580,11 +580,12 @@ dapm_wcache_lookup(struct snd_soc_dapm_wcache *wcache, const char *name)
 {
 	struct snd_soc_dapm_widget *w = wcache->widget;
 	struct list_head *wlist;
-	const int depth = 2;
+	int depth;
 	int i = 0;
 
-	if (w) {
+	if (w && w->dapm->cache_search_depth) {
 		wlist = &w->dapm->card->widgets;
+		depth = w->dapm->cache_search_depth;
 
 		list_for_each_entry_from(w, wlist, list) {
 			if (!strcmp(name, w->name))
-- 
1.7.9.5
