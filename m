From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/6] ASoC: Intel: Skylake: Modify arguments to
	reuse module transfer function
Date: Fri, 21 Apr 2017 20:28:10 +0530
Message-ID: <1492786693-24167-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B22BE26718E
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:21 +0200 (CEST)
In-Reply-To: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: G Kranthi <gudishax.kranthikumar@intel.com>

Kabylake also uses code loader dma for module load and library load.
skl_transfer_module can be reused. Modify the arguments to include
library index to be passed to lib load ipc and module/lib check to use
correct ipc for lib/module load.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 4fdd503a837c..4d4fef0f92ea 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -325,7 +325,7 @@ static struct skl_module_table *skl_module_get_from_id(
 }
 
 static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
-				u32 size, u16 mod_id)
+			u32 size, u16 mod_id, u8 table_id, bool is_module)
 {
 	int ret, bytes_left, curr_pos;
 	struct skl_sst *skl = ctx->thread_context;
@@ -335,10 +335,12 @@ static int skl_transfer_module(struct sst_dsp *ctx, const void *data,
 	if (bytes_left < 0)
 		return bytes_left;
 
-	ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES, &mod_id);
-	if (ret < 0) {
-		dev_err(ctx->dev, "Failed to Load module: %d\n", ret);
-		goto out;
+	if (is_module) {/* load module */
+		ret = skl_ipc_load_modules(&skl->ipc, SKL_NUM_MODULES, &mod_id);
+		if (ret < 0) {
+			dev_err(ctx->dev, "Failed to Load module: %d\n", ret);
+			goto out;
+		}
 	}
 
 	/*
@@ -393,7 +395,8 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
 
 	if (!module_entry->usage_cnt) {
 		ret = skl_transfer_module(ctx, module_entry->mod_info->fw->data,
-				module_entry->mod_info->fw->size, mod_id);
+				module_entry->mod_info->fw->size,
+				mod_id, 0, true);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Failed to Load module\n");
 			return ret;
-- 
1.9.1
