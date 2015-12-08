From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: add LARGE_CONFIG_GET
	IPC support" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:24 +0000
Message-ID: <E1a6NfY-000434-Ug@debutante>
References: <1448703121-5831-13-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7160C2606BB
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:32 +0100 (CET)
In-Reply-To: <1448703121-5831-13-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mousami Jana <mousami.janax@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: add LARGE_CONFIG_GET IPC support

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

>From cce1c7f383e829651e0729d4b0b2cb78ea5cb2d6 Mon Sep 17 00:00:00 2001
From: Mousami Jana <mousami.janax@intel.com>
Date: Thu, 3 Dec 2015 23:29:55 +0530
Subject: [PATCH] ASoC: Intel: Skylake: add LARGE_CONFIG_GET IPC support

For messages which have larger payload than mailbox data, we need
to split the payload using set of messages containing mailbox
size as payload.

For sending such payload we already support LARGE_CONFIG_SET
IPCs and now to query such payload add LARGE_CONFIG_GET IPC

Signed-off-by: Mousami Jana <mousami.janax@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 53 +++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-sst-ipc.h |  3 ++
 2 files changed, 56 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 33860d2311c4..62e665a3b8f7 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -349,6 +349,8 @@ static void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 	switch (reply) {
 	case IPC_GLB_REPLY_SUCCESS:
 		dev_info(ipc->dev, "ipc FW reply %x: success\n", header.primary);
+		/* copy the rx data from the mailbox */
+		sst_dsp_inbox_read(ipc->dsp, msg->rx_data, msg->rx_size);
 		break;
 
 	case IPC_GLB_REPLY_OUT_OF_MEMORY:
@@ -834,3 +836,54 @@ int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(skl_ipc_set_large_config);
+
+int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
+		struct skl_ipc_large_config_msg *msg, u32 *param)
+{
+	struct skl_ipc_header header = {0};
+	u64 *ipc_header = (u64 *)(&header);
+	int ret = 0;
+	size_t sz_remaining, rx_size, data_offset;
+
+	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
+	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
+	header.primary |= IPC_GLB_TYPE(IPC_MOD_LARGE_CONFIG_GET);
+	header.primary |= IPC_MOD_INSTANCE_ID(msg->instance_id);
+	header.primary |= IPC_MOD_ID(msg->module_id);
+
+	header.extension = IPC_DATA_OFFSET_SZ(msg->param_data_size);
+	header.extension |= IPC_LARGE_PARAM_ID(msg->large_param_id);
+	header.extension |= IPC_FINAL_BLOCK(1);
+	header.extension |= IPC_INITIAL_BLOCK(1);
+
+	sz_remaining = msg->param_data_size;
+	data_offset = 0;
+
+	while (sz_remaining != 0) {
+		rx_size = sz_remaining > SKL_ADSP_W1_SZ
+				? SKL_ADSP_W1_SZ : sz_remaining;
+		if (rx_size == sz_remaining)
+			header.extension |= IPC_FINAL_BLOCK(1);
+
+		ret = sst_ipc_tx_message_wait(ipc, *ipc_header, NULL, 0,
+					      ((char *)param) + data_offset,
+					      msg->param_data_size);
+		if (ret < 0) {
+			dev_err(ipc->dev,
+				"ipc: get large config fail, err: %d\n", ret);
+			return ret;
+		}
+		sz_remaining -= rx_size;
+		data_offset = msg->param_data_size - sz_remaining;
+
+		/* clear the fields */
+		header.extension &= IPC_INITIAL_BLOCK_CLEAR;
+		header.extension &= IPC_DATA_OFFSET_SZ_CLEAR;
+		/* fill the fields */
+		header.extension |= IPC_INITIAL_BLOCK(1);
+		header.extension |= IPC_DATA_OFFSET_SZ(data_offset);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(skl_ipc_get_large_config);
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.h b/sound/soc/intel/skylake/skl-sst-ipc.h
index e17012778560..1bbcdb471cf2 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.h
+++ b/sound/soc/intel/skylake/skl-sst-ipc.h
@@ -120,6 +120,9 @@ int skl_ipc_set_dx(struct sst_generic_ipc *ipc,
 int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param);
 
+int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
+		struct skl_ipc_large_config_msg *msg, u32 *param);
+
 void skl_ipc_int_enable(struct sst_dsp *dsp);
 void skl_ipc_op_int_enable(struct sst_dsp *ctx);
 void skl_ipc_op_int_disable(struct sst_dsp *ctx);
-- 
2.6.2
