From: jeeja.kp@intel.com
Subject: [PATCH 02/10] ASoC: Intel: Skylake: Set the pipe state
	to paused when paused
Date: Fri,  3 Jun 2016 18:29:35 +0530
Message-ID: <1464958783-19344-3-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E10EA26523B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 15:03:12 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

When pipe is stopped/Paused, set the pipe state to paused instead
of created.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index c682403..07d2a73 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1125,7 +1125,7 @@ int skl_stop_pipe(struct skl_sst *ctx, struct skl_pipe *pipe)
 		return ret;
 	}
 
-	pipe->state = SKL_PIPE_CREATED;
+	pipe->state = SKL_PIPE_PAUSED;
 
 	return 0;
 }
-- 
2.5.0
