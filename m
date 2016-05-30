From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Skylake: Find uuids for
	Broxton
Date: Mon, 30 May 2016 17:43:01 +0530
Message-ID: <1464610381-19416-8-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8104026073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:07:01 +0200 (CEST)
In-Reply-To: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Broxton uses different offset in manifest for parsing module
table. So invoke common parsing utility from broxton using
broxton offset.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 0dd921349663..46235b93e4f8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -130,6 +130,8 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 	return ret;
 }
 
+#define BXT_ADSP_FW_BIN_HDR_OFFSET 0x2000
+
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
@@ -146,6 +148,9 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	if (ctx->fw == NULL)
 		goto sst_load_base_firmware_failed;
 
+	ret = snd_skl_parse_uuids(ctx, BXT_ADSP_FW_BIN_HDR_OFFSET);
+	if (ret < 0)
+		goto sst_load_base_firmware_failed;
 
 	stripped_fw.data = ctx->fw->data;
 	stripped_fw.size = ctx->fw->size;
@@ -283,6 +288,7 @@ int bxt_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	skl->dev = dev;
 	skl_dev.thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
 
 	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
 	if (!skl->dsp) {
@@ -323,6 +329,7 @@ EXPORT_SYMBOL_GPL(bxt_sst_dsp_init);
 
 void bxt_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->cl_dev.ops.cl_cleanup_controller(ctx->dsp);
 
-- 
1.9.1
