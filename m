From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add D0iX IPCs" to the
	asoc tree
Date: Thu, 03 Nov 2016 11:27:25 -0600
Message-ID: <E1c2LnR-0002gH-Pl@finisterre>
References: <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7E92667E0
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 18:27:35 +0100 (CET)
In-Reply-To: <1474868137-29712-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add D0iX IPCs

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

>From 41b7523f192bdf3804e3e18a61f91244e4a0cb25 Mon Sep 17 00:00:00 2001
From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Date: Thu, 3 Nov 2016 17:07:15 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add D0iX IPCs

The audio DSP supports intermediate power states between D0 and D3
states. These states are D0i0 and D0i3 states.

Collectively we refer these two states as D0iX states.

To set or wake up from these states, driver also needs to send an IPC "Set D0iX
IPC" before doing anything else.

Add support for this new IPC messages.

Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 43 ++++++++++++++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-sst-ipc.h | 10 ++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 797cf4053235..087b8d6e7186 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -172,6 +172,17 @@
 					<< IPC_INITIAL_BLOCK_SHIFT)
 #define IPC_INITIAL_BLOCK_CLEAR		~(IPC_INITIAL_BLOCK_MASK \
 					  << IPC_INITIAL_BLOCK_SHIFT)
+/* Set D0ix IPC extension register */
+#define IPC_D0IX_WAKE_SHIFT		0
+#define IPC_D0IX_WAKE_MASK		0x1
+#define IPC_D0IX_WAKE(x)		(((x) & IPC_D0IX_WAKE_MASK) \
+					<< IPC_D0IX_WAKE_SHIFT)
+
+#define IPC_D0IX_STREAMING_SHIFT	1
+#define IPC_D0IX_STREAMING_MASK		0x1
+#define IPC_D0IX_STREAMING(x)		(((x) & IPC_D0IX_STREAMING_MASK) \
+					<< IPC_D0IX_STREAMING_SHIFT)
+
 
 enum skl_ipc_msg_target {
 	IPC_FW_GEN_MSG = 0,
@@ -258,7 +269,8 @@ enum skl_ipc_module_msg {
 	IPC_MOD_LARGE_CONFIG_SET = 4,
 	IPC_MOD_BIND = 5,
 	IPC_MOD_UNBIND = 6,
-	IPC_MOD_SET_DX = 7
+	IPC_MOD_SET_DX = 7,
+	IPC_MOD_SET_D0IX = 8
 };
 
 static void skl_ipc_tx_data_copy(struct ipc_message *msg, char *tx_data,
@@ -931,3 +943,32 @@ int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_sst_ipc_load_library);
+
+int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc, struct skl_ipc_d0ix_msg *msg)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret;
+
+	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_MOD_SET_D0IX);
+	header.primary |= IPC_MOD_INSTANCE_ID(msg->instance_id);
+	header.primary |= IPC_MOD_ID(msg->module_id);
+
+	header.extension = IPC_D0IX_WAKE(msg->wake);
+	header.extension |= IPC_D0IX_STREAMING(msg->streaming);
+
+	dev_dbg(ipc->dev, "In %s primary=%x ext=%x\n", __func__,
+			header.primary,	header.extension);
+
+	/*
+	 * Use the nopm IPC here as we dont want it checking for D0iX
+	 */
+	ret = sst_ipc_tx_message_nopm(ipc, *ipc_header, NULL, 0, NULL, 0);
+	if (ret < 0)
+		dev_err(ipc->dev, "ipc: set d0ix failed, err %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_set_d0ix);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index 0334ed4af031..1ae265d8ee08 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -111,6 +111,13 @@ struct skl_ipc_large_config_msg {
 	u32 param_data_size;
 };
 
+struct skl_ipc_d0ix_msg {
+	u32 module_id;
+	u32 instance_id;
+	u8 streaming;
+	u8 wake;
+};
+
 #define SKL_IPC_BOOT_MSECS		3000
 
 #define SKL_IPC_D3_MASK	0
@@ -155,6 +162,9 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 			u8 dma_id, u8 table_id);
 
+int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc,
+		struct skl_ipc_d0ix_msg *msg);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
-- 
2.10.1
