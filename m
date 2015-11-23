From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Skylake: Fix to update bit
	depth for module params
Date: Mon, 23 Nov 2015 22:26:25 +0530
Message-ID: <1448297789-6524-4-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A43482654C6
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:52:53 +0100 (CET)
In-Reply-To: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Module hw param fixup will change the valid bit depth based
on the fixup flag. If valid bit depth changes, need to set
the bit depth according to valid bit depth. This patch
fixes this issue of updating bit depth correctly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0937ea2129c1..698c4aa03933 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -147,8 +147,24 @@ static void skl_tplg_update_params(struct skl_module_fmt *fmt,
 		fmt->s_freq = params->s_freq;
 	if (fixup & SKL_CH_FIXUP_MASK)
 		fmt->channels = params->ch;
-	if (fixup & SKL_FMT_FIXUP_MASK)
-		fmt->valid_bit_depth = params->s_fmt;
+	if (fixup & SKL_FMT_FIXUP_MASK) {
+		fmt->valid_bit_depth = skl_get_bit_depth(params->s_fmt);
+
+		/*
+		 * 16 bit is 16 bit container whereas 24 bit is in 32 bit
+		 * container so update bit depth accordingly
+		 */
+		switch (fmt->valid_bit_depth) {
+		case SKL_DEPTH_16BIT:
+			fmt->bit_depth = fmt->valid_bit_depth;
+			break;
+
+		default:
+			fmt->bit_depth = SKL_DEPTH_32BIT;
+			break;
+		}
+	}
+
 }
 
 /*
-- 
1.9.1
