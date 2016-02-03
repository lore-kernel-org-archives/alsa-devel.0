From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 05/11] ASoC: Intel: Skylake: Fix return of
	skl_get_queue_index
Date: Wed,  3 Feb 2016 17:59:48 +0530
Message-ID: <1454502594-21700-6-git-send-email-vinod.koul@intel.com>
References: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CBE8A260701
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 13:26:37 +0100 (CET)
In-Reply-To: <1454502594-21700-1-git-send-email-vinod.koul@intel.com>
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

In unbind modules, the skl_get_queue_index() can return error
if the pin is dynamic and module is not bound yet. So instead
of returning error this check should return success as modules
is not yet bound. This will let the module be bound when connected
pipes are enabled and will bind this as well.

So change the return value to 0

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index de6dac496a0d..bb5f1d7d0cad 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -688,14 +688,14 @@ int skl_unbind_modules(struct skl_sst *ctx,
 	/* get src queue index */
 	src_index = skl_get_queue_index(src_mcfg->m_out_pin, dst_id, out_max);
 	if (src_index < 0)
-		return -EINVAL;
+		return 0;
 
 	msg.src_queue = src_index;
 
 	/* get dst queue index */
 	dst_index  = skl_get_queue_index(dst_mcfg->m_in_pin, src_id, in_max);
 	if (dst_index < 0)
-		return -EINVAL;
+		return 0;
 
 	msg.dst_queue = dst_index;
 
-- 
1.9.1
