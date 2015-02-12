From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/13] ASoC: Intel: update MMX ID to 3
Date: Thu, 12 Feb 2015 09:59:55 +0530
Message-ID: <1423715405-4562-4-git-send-email-vinod.koul@intel.com>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 54B1F26512D
 for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2015 05:32:56 +0100 (CET)
In-Reply-To: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The updated firmware expects the MMX ID to be used as 3, so update the
driver as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-atom-controls.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
index dfebfdd5eb2a..daecc58f28af 100644
--- a/sound/soc/intel/sst-atom-controls.h
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -150,7 +150,7 @@ enum sst_cmd_type {
 
 enum sst_task {
 	SST_TASK_SBA = 1,
-	SST_TASK_MMX,
+	SST_TASK_MMX = 3,
 };
 
 enum sst_type {
-- 
1.7.9.5
