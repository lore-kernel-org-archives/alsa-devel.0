From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 01/12] ASoC: Intel: Skylake: Check list empty
	while getting module info
Date: Tue, 26 Jul 2016 18:06:39 +0530
Message-ID: <1469536610-27606-2-git-send-email-vinod.koul@intel.com>
References: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A9654266991
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2016 14:29:44 +0200 (CEST)
In-Reply-To: <1469536610-27606-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

Module list can be NULL so check if the list is empty before
accessing the list.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 25fcb796bd86..ddcb52a51854 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -123,6 +123,11 @@ int snd_skl_get_module_info(struct skl_sst *ctx, u8 *uuid,
 
 	uuid_mod = (uuid_le *)uuid;
 
+	if (list_empty(&ctx->uuid_list)) {
+		dev_err(ctx->dev, "Module list is empty\n");
+		return -EINVAL;
+	}
+
 	list_for_each_entry(module, &ctx->uuid_list, list) {
 		if (uuid_le_cmp(*uuid_mod, module->uuid) == 0) {
 			dfw_config->module_id = module->id;
-- 
1.9.1
