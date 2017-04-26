From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Modify arguments to
	reuse module transfer function" to the asoc tree
Date: Wed, 26 Apr 2017 15:49:14 +0100
Message-ID: <E1d3OFm-0000S3-G7@finisterre>
References: <1493102904-12624-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B54A2670DB
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:31 +0200 (CEST)
In-Reply-To: <1493102904-12624-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: G Kranthi <gudishax.kranthikumar@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Modify arguments to reuse module transfer function

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4e0277d226b578be99cf8899fd1442bf11873d12 Mon Sep 17 00:00:00 2001
From: G Kranthi <gudishax.kranthikumar@intel.com>
Date: Tue, 25 Apr 2017 12:18:21 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Modify arguments to reuse module
 transfer function

Kabylake also uses code loader dma for module load and library load.
skl_transfer_module can be reused. Modify the arguments to include
library index to be passed to lib load ipc and module/lib check to use
correct ipc for lib/module load.

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 4fdd503a837c..b4c3b5c63115 100644
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
+	if (is_module) { /* load module */
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
2.11.0
