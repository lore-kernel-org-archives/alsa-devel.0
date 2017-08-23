From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix uninitialized return
Date: Wed, 23 Aug 2017 19:37:12 +0530
Message-ID: <1503497232-21345-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3324C2677A2
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 16:24:20 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On failure to get dsp_ops, dsp_init returns error without assigning ret. ret
is assigned in code path which will never be executed. Fix it.

Fixes: f77d443c4c29 ("ASoC: Intel: Skylake: Fix to free resources for dsp_init failure"
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index f0f11f597b21..697d07bc1b5a 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -278,8 +278,8 @@ int skl_init_dsp(struct skl *skl)
 
 	ops = skl_get_dsp_ops(skl->pci->device);
 	if (!ops) {
-		goto unmap_mmio;
 		ret = -EIO;
+		goto unmap_mmio;
 	}
 
 	loader_ops = ops->loader_ops();
-- 
1.9.1
