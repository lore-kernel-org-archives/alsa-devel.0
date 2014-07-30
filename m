From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add debug to set DX state
Date: Wed, 30 Jul 2014 20:11:26 +0800
Message-ID: <1406722286-8173-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3653D2608D3
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 14:10:28 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add some debugging info to help with Dx state debug.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 436c2fa..9825d19 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1646,7 +1646,7 @@ int sst_hsw_dx_set_state(struct sst_hsw *hsw,
 	enum sst_hsw_dx_state state, struct sst_hsw_ipc_dx_reply *dx)
 {
 	u32 header, state_;
-	int ret;
+	int ret, item;
 
 	header = IPC_GLB_TYPE(IPC_GLB_ENTER_DX_STATE);
 	state_ = state;
@@ -1660,6 +1660,13 @@ int sst_hsw_dx_set_state(struct sst_hsw *hsw,
 		return ret;
 	}
 
+	for (item = 0; item < dx->entries_no; item++) {
+		dev_dbg(hsw->dev,
+			"Item[%d] offset[%x] - size[%x] - source[%x]\n",
+			item, dx->mem_info[item].offset,
+			dx->mem_info[item].size,
+			dx->mem_info[item].source);
+	}
 	dev_dbg(hsw->dev, "ipc: got %d entry numbers for state %d\n",
 		dx->entries_no, state);
 
-- 
1.8.3.2
