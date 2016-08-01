From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add library loading
	IPCs" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:07 +0100
Message-ID: <E1bUGgF-0006Lg-N2@debutante>
References: <1469536610-27606-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B236D26609F
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 19:07:16 +0200 (CEST)
In-Reply-To: <1469536610-27606-10-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Kranthi G <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add library loading IPCs

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

>From b1f89b197b3f7360239fc2120755252cead4e572 Mon Sep 17 00:00:00 2001
From: Ramesh Babu <ramesh.babu@intel.com>
Date: Tue, 26 Jul 2016 18:06:47 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add library loading IPCs

DSP fw can have additional firmwares as libs. These libs can be
loaded using message IPC_GLB_LOAD_LIBRARY.

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Kranthi G <gudishax.kranthikumar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 23 +++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 96f2f6889b18..1544564c0ad1 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -190,6 +190,7 @@ enum skl_ipc_glb_type {
 	IPC_GLB_GET_PPL_CONTEXT_SIZE = 21,
 	IPC_GLB_SAVE_PPL = 22,
 	IPC_GLB_RESTORE_PPL = 23,
+	IPC_GLB_LOAD_LIBRARY = 24,
 	IPC_GLB_NOTIFY = 26,
 	IPC_GLB_MAX_IPC_MSG_NUMBER = 31 /* Maximum message number */
 };
@@ -902,3 +903,25 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_ipc_get_large_config);
+
+int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
+				u8 dma_id, u8 table_id)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret = 0;
+
+	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_GLB_LOAD_LIBRARY);
+	header.primary |= IPC_MOD_INSTANCE_ID(table_id);
+	header.primary |= IPC_MOD_ID(dma_id);
+
+	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, NULL, 0, NULL, 0);
+
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: load lib failed\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_sst_ipc_load_library);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 31e5bc356aa2..fc46779f80c3 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -151,6 +151,9 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param);
 
+int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
+			u8 dma_id, u8 table_id);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
-- 
2.8.1
