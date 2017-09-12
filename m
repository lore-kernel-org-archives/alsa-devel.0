From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] alsa-lib: topology: fix usage of
	SND_TPLG_INDEX_ALL when checking routes
Date: Tue, 12 Sep 2017 21:47:42 +0100
Message-ID: <1505249262-14531-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F36D266B1C
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 22:47:57 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Make sure SND_TPLG_INDEX_ALL is used correctly when checking routes so
that connecting routes of different indexes does not emit any warnings.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/dapm.c | 4 ++--
 src/topology/elem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 66892a6..0ddbf96 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -279,7 +279,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->sink,
-			SND_TPLG_TYPE_DAPM_WIDGET, elem->index)) {
+			SND_TPLG_TYPE_DAPM_WIDGET, SND_TPLG_INDEX_ALL)) {
 			SNDERR("warning: undefined sink widget/stream '%s'\n",
 				route->sink);
 		}
@@ -302,7 +302,7 @@ int tplg_build_routes(snd_tplg_t *tplg)
 
 		}
 		if (!tplg_elem_lookup(&tplg->widget_list, route->source,
-			SND_TPLG_TYPE_DAPM_WIDGET, elem->index)) {
+			SND_TPLG_TYPE_DAPM_WIDGET, SND_TPLG_INDEX_ALL)) {
 			SNDERR("warning: Undefined source widget/stream '%s'\n",
 				route->source);
 		}
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 89a4ac9..9a7c7b7 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -123,7 +123,7 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 			return elem;
 		/* SND_TPLG_INDEX_ALL is the default value "0" and applicable
 		   for all use cases */
-		if ((elem->index != SND_TPLG_INDEX_ALL)
+		if ((index != SND_TPLG_INDEX_ALL)
 			&& (elem->index > index))
 			break;
 	}
-- 
1.9.1
