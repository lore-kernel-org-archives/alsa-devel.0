From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/3] ASoC: topology: fix oops/use-after-free
	case with dai driver
Date: Fri,  1 Feb 2019 11:05:13 -0600
Message-ID: <20190201170513.13905-4-pierre-louis.bossart@linux.intel.com>
References: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 0643D267470
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
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>

rmmod/modprobe tests expose a kernel oops when accessing the dai
driver pointer. This comes from the topology design which operates in
multiple passes. Each object removal happens at a specific iteration,
and the code checks for the iteration (order) number after the memory
containing the order was freed.

Fix this be clearing a reference to the dai driver and check its
validity to avoid dereferences.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-core.c     | 2 +-
 sound/soc/soc-topology.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d6b5edba8d2d..9dad2b1498c1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -965,7 +965,7 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 {
 	int err;
 
-	if (!dai || !dai->probed ||
+	if (!dai || !dai->probed || !dai->driver ||
 	    dai->driver->remove_order != order)
 		return;
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 23d421370e6c..bb7e5422a419 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -523,6 +523,7 @@ static void remove_dai(struct snd_soc_component *comp,
 {
 	struct snd_soc_dai_driver *dai_drv =
 		container_of(dobj, struct snd_soc_dai_driver, dobj);
+	struct snd_soc_dai *dai;
 
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
@@ -530,6 +531,10 @@ static void remove_dai(struct snd_soc_component *comp,
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
