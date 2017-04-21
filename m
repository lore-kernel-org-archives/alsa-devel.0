From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Skylake: Modify load_lib_ipc
	arguments for a nowait version
Date: Fri, 21 Apr 2017 20:28:12 +0530
Message-ID: <1492786693-24167-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1492786693-24167-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D453267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:11:24 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Kabylake uses code loader dma and wait on notification instead of ipc
reply for load library ipc status. So modify the argument of
skl_sst_ipc_load_library to check on flag to wait for ipc reply.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c | 8 ++++++--
 sound/soc/intel/skylake/skl-sst-ipc.h | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 2df7d104bfca..a7d1a3ffedcb 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -81,7 +81,7 @@ static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 		memcpy(dmab.area, stripped_fw.data, stripped_fw.size);
 
 		ctx->dsp_ops.trigger(ctx->dev, true, stream_tag);
-		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i);
+		ret = skl_sst_ipc_load_library(&skl->ipc, dma_id, i, true);
 		if (ret < 0)
 			dev_err(ctx->dev, "IPC Load Lib for %s fail: %d\n",
 					linfo[i].name, ret);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index d51b483b4d79..c0226dd59445 100644
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
1.9.1
