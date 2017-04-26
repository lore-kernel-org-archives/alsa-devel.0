From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Modify load_lib_ipc
	arguments for a nowait version" to the asoc tree
Date: Wed, 26 Apr 2017 15:48:53 +0100
Message-ID: <E1d3OFR-0000Ou-7U@finisterre>
References: <1492786693-24167-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D6C6267407
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 16:49:08 +0200 (CEST)
In-Reply-To: <1492786693-24167-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Modify load_lib_ipc arguments for a nowait version

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

>From 100e7f396ddf9abd76d5ec93f689be00187512f9 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 25 Apr 2017 12:18:23 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Modify load_lib_ipc arguments for a
 nowait version

Kabylake uses code loader dma and wait on notification instead of ipc
reply for load library ipc status. So modify the argument of
skl_sst_ipc_load_library to check on flag to wait for ipc reply.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c | 8 ++++++--
 sound/soc/intel/skylake/skl-sst-ipc.h | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index d26545ee3e58..fde4bc0f35b0 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -81,7 +81,7 @@ bxt_load_library(struct sst_dsp *ctx, struct skl_lib_info *linfo, int lib_count)
 		memcpy(dmab.area, stripped_fw.data, stripped_fw.size);
 
 		ctx->dsp_ops.trigger(ctx->dev, true, stream_tag);
-		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i);
+		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i, true);
 		if (ret < 0)
 			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
 					linfo[i].name, ret);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index e90fe2c0bf2c..7147eddc6d3c 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -971,7 +971,7 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 EXPORT_SYMBOL_GPL(skl_ipc_get_large_config);
 
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
-				u8 dma_id, u8 table_id)
+				u8 dma_id, u8 table_id, bool wait)
 {
 	struct skl_ipc_header header = {0};
 	u64 *ipc_header = (u64 *)(&header);
@@ -983,7 +983,11 @@ int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 	header.primary |= IPC_MOD_INSTANCE_ID(table_id);
 	header.primary |= IPC_MOD_ID(dma_id);
 
-	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, NULL, 0, NULL, 0);
+	if (wait)
+		ret = sst_ipc_tx_message_wait(ipc, *ipc_header,
+					NULL, 0, NULL, 0);
+	else
+		ret = sst_ipc_tx_message_nowait(ipc, *ipc_header, NULL, 0);
 
 	if (ret < 0)
 		dev_err(ipc->dev, "ipc: load lib failed\n");
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 4abf98c0e00e..e057da2713c6 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -197,7 +197,7 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param);
 
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
-			u8 dma_id, u8 table_id);
+			u8 dma_id, u8 table_id, bool wait);
 
 int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc,
 		struct skl_ipc_d0ix_msg *msg);
-- 
2.11.0
