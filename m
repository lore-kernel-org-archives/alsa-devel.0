From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Return negative
	error code
Date: Thu, 27 Apr 2017 12:21:22 +0530
Message-ID: <1493275882-27708-3-git-send-email-vinod.koul@intel.com>
References: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 74C782671A0
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 08:49:49 +0200 (CEST)
In-Reply-To: <1493275882-27708-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Guneshwor Singh <guneshwor.o.singh@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

skl_tplg_add_pipe() returned EEXIST instead of negative EEXIST, so fix that
and handle the return value as well.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0e459d3eb17a..29f68713a231 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1711,7 +1711,7 @@ static int skl_tplg_add_pipe(struct device *dev,
 	list_for_each_entry(ppl, &skl->ppl_list, node) {
 		if (ppl->pipe->ppl_id == tkn_elem->value) {
 			mconfig->pipe = ppl->pipe;
-			return EEXIST;
+			return -EEXIST;
 		}
 	}
 
@@ -2003,11 +2003,13 @@ static int skl_tplg_get_token(struct device *dev,
 		ret = skl_tplg_add_pipe(dev,
 				mconfig, skl, tkn_elem);
 
-		if (ret < 0)
+		if (ret < 0) {
+			if (ret == -EEXIST) {
+				is_pipe_exists = 1;
+				break;
+			}
 			return is_pipe_exists;
-
-		if (ret == EEXIST)
-			is_pipe_exists = 1;
+		}
 
 		break;
 
-- 
1.9.1
