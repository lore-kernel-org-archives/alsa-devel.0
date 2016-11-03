From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support for LPMode"
	to the asoc tree
Date: Thu, 03 Nov 2016 11:26:46 -0600
Message-ID: <E1c2Lmo-0002dQ-8Q@finisterre>
References: <1474868137-29712-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E250F2667EA
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 18:27:05 +0100 (CET)
In-Reply-To: <1474868137-29712-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jayachandran B <jayachandran.b@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support for LPMode

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

>From 8a0cb2360ddb941e0a2fbe33d400d2985e4f2fff Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 3 Nov 2016 17:07:18 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support for LPMode

For D0i3, we need to tell DSP to run the pipelines in LP mode. This
information is kept in topology and passed to driver as an attribute
for pipe.

So add a new tuple for lpmode and program the pipe based on value set.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/snd_sst_tokens.h    | 5 ++++-
 sound/soc/intel/skylake/skl-messages.c | 3 ++-
 sound/soc/intel/skylake/skl-sst-ipc.c  | 9 ++++++++-
 sound/soc/intel/skylake/skl-sst-ipc.h  | 2 +-
 sound/soc/intel/skylake/skl-topology.c | 5 +++++
 sound/soc/intel/skylake/skl-topology.h | 1 +
 6 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
index 1ee2e943d66a..f4b8b34de519 100644
--- a/include/uapi/sound/snd_sst_tokens.h
+++ b/include/uapi/sound/snd_sst_tokens.h
@@ -157,6 +157,8 @@
  *
  * %SKL_TKN_STR_LIB_NAME:       Specifies the library name
  *
+ * %SKL_TKN_U32_PMODE:		Specifies the power mode for pipe
+ *
  * module_id and loadable flags dont have tokens as these values will be
  * read from the DSP FW manifest
  */
@@ -208,7 +210,8 @@ enum SKL_TKNS {
 	SKL_TKN_U32_PROC_DOMAIN,
 	SKL_TKN_U32_LIB_COUNT,
 	SKL_TKN_STR_LIB_NAME,
-	SKL_TKN_MAX = SKL_TKN_STR_LIB_NAME,
+	SKL_TKN_U32_PMODE,
+	SKL_TKN_MAX = SKL_TKN_U32_PMODE,
 };
 
 #endif
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 805b7f2173f3..87fc647fa04c 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -1042,7 +1042,8 @@ int skl_create_pipeline(struct skl_sst *ctx, struct skl_pipe *pipe)
 	dev_dbg(ctx->dev, "%s: pipe_id = %d\n", __func__, pipe->ppl_id);
 
 	ret = skl_ipc_create_pipeline(&ctx->ipc, pipe->memory_pages,
-				pipe->pipe_priority, pipe->ppl_id);
+				pipe->pipe_priority, pipe->ppl_id,
+				pipe->lp_mode);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to create pipeline\n");
 		return ret;
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 087b8d6e7186..734408a34a24 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -81,6 +81,11 @@
 #define IPC_INSTANCE_ID(x)		(((x) & IPC_INSTANCE_ID_MASK) \
 					<< IPC_INSTANCE_ID_SHIFT)
 
+#define IPC_PPL_LP_MODE_SHIFT           0
+#define IPC_PPL_LP_MODE_MASK            0x1
+#define IPC_PPL_LP_MODE(x)              (((x) & IPC_PPL_LP_MODE_MASK) \
+					<< IPC_PPL_LP_MODE_SHIFT)
+
 /* Set pipeline state message */
 #define IPC_PPL_STATE_SHIFT		0
 #define IPC_PPL_STATE_MASK		0x1F
@@ -559,7 +564,7 @@ void skl_ipc_free(struct sst_generic_ipc *ipc)
 }
 
 int skl_ipc_create_pipeline(struct sst_generic_ipc *ipc,
-		u16 ppl_mem_size, u8 ppl_type, u8 instance_id)
+		u16 ppl_mem_size, u8 ppl_type, u8 instance_id, u8 lp_mode)
 {
 	struct skl_ipc_header header = {0};
 	u64 *ipc_header = (u64 *)(&header);
@@ -572,6 +577,8 @@ int skl_ipc_create_pipeline(struct sst_generic_ipc *ipc,
 	header.primary |= IPC_PPL_TYPE(ppl_type);
 	header.primary |= IPC_PPL_MEM_SIZE(ppl_mem_size);
 
+	header.extension = IPC_PPL_LP_MODE(lp_mode);
+
 	dev_dbg(ipc->dev, "In %s header=%d\n", __func__, header.primary);
 	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, NULL, 0, NULL, 0);
 	if (ret < 0) {
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index a45c42046b64..83bf1689f62e 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -148,7 +148,7 @@ struct skl_ipc_d0ix_msg {
 irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context);
 
 int skl_ipc_create_pipeline(struct sst_generic_ipc *sst_ipc,
-		u16 ppl_mem_size, u8 ppl_type, u8 instance_id);
+		u16 ppl_mem_size, u8 ppl_type, u8 instance_id, u8 lp_mode);
 
 int skl_ipc_delete_pipeline(struct sst_generic_ipc *sst_ipc, u8 instance_id);
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b5b1934d8550..9a7a008f6689 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1519,6 +1519,10 @@ static int skl_tplg_fill_pipe_tkn(struct device *dev,
 		pipe->memory_pages = tkn_val;
 		break;
 
+	case SKL_TKN_U32_PMODE:
+		pipe->lp_mode = tkn_val;
+		break;
+
 	default:
 		dev_err(dev, "Token not handled %d\n", tkn);
 		return -EINVAL;
@@ -1841,6 +1845,7 @@ static int skl_tplg_get_token(struct device *dev,
 	case SKL_TKN_U32_PIPE_CONN_TYPE:
 	case SKL_TKN_U32_PIPE_PRIORITY:
 	case SKL_TKN_U32_PIPE_MEM_PGS:
+	case SKL_TKN_U32_PMODE:
 		if (is_pipe_exists) {
 			ret = skl_tplg_fill_pipe_tkn(dev, mconfig->pipe,
 					tkn_elem->token, tkn_elem->value);
diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index a519360f42a6..11fd0a4b6603 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -279,6 +279,7 @@ struct skl_pipe {
 	u8 pipe_priority;
 	u16 conn_type;
 	u32 memory_pages;
+	u8 lp_mode;
 	struct skl_pipe_params *p_params;
 	enum skl_pipe_state state;
 	struct list_head w_list;
-- 
2.10.1
