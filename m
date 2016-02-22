From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2] ASoC: Intel: Skylake: remove bogus
	comparison of an array with NULL
Date: Mon, 22 Feb 2016 09:37:27 +0530
Message-ID: <1456114047-14941-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 629EC26057F
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 05:03:44 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Alan Cox <alan@linux.intel.com>

dfw_ac->params is an array not a pointer. It will never be NULL. The check
on ac->max appears sufficient.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22a9e6fe1c05..99f50a034e1d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1657,8 +1657,7 @@ static int skl_init_algo_data(struct device *dev, struct soc_bytes_ext *be,
 		if (!ac->params)
 			return -ENOMEM;
 
-		if (dfw_ac->params)
-			memcpy(ac->params, dfw_ac->params, ac->max);
+		memcpy(ac->params, dfw_ac->params, ac->max);
 	}
 
 	be->dobj.private  = ac;
-- 
1.9.1
