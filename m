From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2] ASoC: topology: Fix bugs of freeing soc
	topology.
Date: Mon, 26 Mar 2018 16:48:00 +0100
Message-ID: <20180326154800.10975-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 40EA4266E07
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 17:48:18 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Yan Wang <yan.wang@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Yan Wang <yan.wang@linux.intel.com>

In snd_soc_tplg_component_remove(), it should compare index and
not dobj->index with SND_SOC_TPLG_INDEX_ALL for removing all
topology objects.

Signed-off-by: Yan Wang <yan.wang@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---

Notes:
    Sign-off added since V1.

 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b363f2409f72..e5ee7a5a2b02 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2563,7 +2563,7 @@ int snd_soc_tplg_component_remove(struct snd_soc_component *comp, u32 index)
 
 			/* match index */
 			if (dobj->index != index &&
-				dobj->index != SND_SOC_TPLG_INDEX_ALL)
+				index != SND_SOC_TPLG_INDEX_ALL)
 				continue;
 
 			switch (dobj->type) {
-- 
2.14.1
