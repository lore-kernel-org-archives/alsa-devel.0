From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH] ASoC: fix a use after free case
Date: Fri, 21 Sep 2018 16:59:35 +0200
Message-ID: <20180921145934.GD28693@kadasd710.ka.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 650D12676A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 16:59:37 +0200 (CEST)
Content-Disposition: inline
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Unloading ASoC modules as used by the SOF driver leads to an object
being used after it's been freed. Fix this be clearing a reference to
it and making sure to check for its presence. This fixes issue #144.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/soc-core.c     | 6 +++---
 sound/soc/soc-topology.c | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9cfe10d8040c..dce9d53ff283 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -942,9 +942,9 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (dai && dai->probed &&
-			dai->driver->remove_order == order) {
-		if (dai->driver->remove) {
+	if (dai && dai->probed) {
+		if (dai->driver && dai->driver->remove_order == order &&
+		    dai->driver->remove) {
 			err = dai->driver->remove(dai);
 			if (err < 0)
 				dev_err(dai->dev,
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 66e77e020745..6d438ec8c0ec 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -502,6 +502,7 @@ static void remove_dai(struct snd_soc_component *comp,
 {
 	struct snd_soc_dai_driver *dai_drv =
 		container_of(dobj, struct snd_soc_dai_driver, dobj);
+	struct snd_soc_dai *dai;
 
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
@@ -509,6 +510,10 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	list_for_each_entry(dai, &comp->dai_list, list)
+		if (dai->driver == dai_drv)
+			dai->driver = NULL;
+
 	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
-- 
2.17.1
