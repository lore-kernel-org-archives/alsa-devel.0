From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Fix SND_SOC_TPLG_INDEX_ALL for
	freeing soc topology.
Date: Wed, 14 Mar 2018 20:47:22 +0000
Message-ID: <20180314204722.14144-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B3A626718B
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 21:47:31 +0100 (CET)
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
Cc: Yan Wang <yan.wang@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Yan Wang <yan.wang@linux.intel.com>

In snd_soc_tplg_component_remove(), it should compare index and
not dobj->index with SND_SOC_TPLG_INDEX_ALL for removing all
topology objects.

Signed-off-by: Yan Wang <yan.wang@linux.intel.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index f941d37e825b..e752bd7265d5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2597,7 +2597,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 
 			/* match index */
 			if (dobj->index != index &&
-				dobj->index != SND_SOC_TPLG_INDEX_ALL)
+				index != SND_SOC_TPLG_INDEX_ALL)
 				continue;
 
 			switch (dobj->type) {
-- 
2.14.1
