From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Cleanup
	skl_module_cfg declaration
Date: Thu,  4 Jul 2019 22:01:06 +0200
Message-ID: <20190704200106.11289-8-cezary.rojewski@intel.com>
References: <20190704200106.11289-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51C60F801A4
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 22:03:13 +0200 (CEST)
In-Reply-To: <20190704200106.11289-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

With removal of MCPS, CPS and CPC ambiguity, ibs and obs params for
struct skl_module_cfg have been left unused. Update struct declaration
by removing these two.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-topology.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 99a0277191ca..e967800dbb62 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -383,8 +383,6 @@ struct skl_module_cfg {
 	u8 out_queue_mask;
 	u8 in_queue;
 	u8 out_queue;
-	u32 ibs;
-	u32 obs;
 	u8 is_loadable;
 	u8 core_id;
 	u8 dev_type;
-- 
2.17.1
