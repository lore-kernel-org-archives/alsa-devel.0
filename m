From: jeeja.kp@intel.com
Subject: [PATCH 2/2] ASoC: Intel: Skylake: Removed the unused
	I2S blob structure
Date: Wed, 23 Nov 2016 22:46:27 +0530
Message-ID: <1479921387-31248-2-git-send-email-jeeja.kp@intel.com>
References: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B67AD266735
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 18:06:33 +0100 (CET)
In-Reply-To: <1479921387-31248-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: GuruprasadX Pawse <guruprasadx.pawse@intel.com>

Now that I2S conflig blob structure is no longer in use, remove it.

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-topology.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 3b962d8..08d3928 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -113,23 +113,6 @@ struct skl_cpr_gtw_cfg {
 	u32 config_data[1];
 } __packed;
 
-struct skl_i2s_config_blob {
-	u32 gateway_attrib;
-	u32 tdm_ts_group[8];
-	u32 ssc0;
-	u32 ssc1;
-	u32 sscto;
-	u32 sspsp;
-	u32 sstsa;
-	u32 ssrsa;
-	u32 ssc2;
-	u32 sspsp2;
-	u32 ssc3;
-	u32 ssioc;
-	u32 mdivc;
-	u32 mdivr;
-} __packed;
-
 struct skl_dma_control {
 	u32 node_id;
 	u32 config_length;
-- 
2.5.0
