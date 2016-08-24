From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/9] ASoC: Intel: Skylake: check manifest size
Date: Wed, 24 Aug 2016 18:03:13 +0530
Message-ID: <1472042001-9582-2-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B2D426759C
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:31 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

For some platforms manifest data may not be defined, thus the private
data would not be defined as well.

So check the size of private data and proceed only if it is valid.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 108ebb9ab329..6bceab8f0bac 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2401,6 +2401,10 @@ static int skl_manifest_load(struct snd_soc_component *cmpnt,
 	struct skl *skl = ebus_to_skl(ebus);
 	int ret = 0;
 
+	/* proceed only if we have private data defined */
+	if (manifest->priv.size == 0)
+		return 0;
+
 	minfo = &skl->skl_sst->manifest;
 
 	skl_tplg_get_manifest_data(manifest, bus->dev, minfo);
-- 
1.9.1
