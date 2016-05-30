From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Skylake: Find uuids for
	Skylake
Date: Mon, 30 May 2016 17:43:00 +0530
Message-ID: <1464610381-19416-7-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 66428265341
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:59 +0200 (CEST)
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

SKylake uses different offset in manifest for parsing module
table. So invoke common parsing utility from skylake using
skylake offset.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index be2c42b815b7..6021fa6ed80d 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -68,6 +68,8 @@ static int skl_transfer_firmware(struct sst_dsp *ctx,
 	return ret;
 }
 
+#define SKL_ADSP_FW_BIN_HDR_OFFSET 0x284
+
 static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
@@ -85,6 +87,16 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 			skl_dsp_disable_core(ctx);
 			return -EIO;
 		}
+
+	}
+
+	ret = snd_skl_parse_uuids(ctx, SKL_ADSP_FW_BIN_HDR_OFFSET);
+	if (ret < 0) {
+		dev_err(ctx->dev,
+				"UUID parsing err: %d\n", ret);
+		release_firmware(ctx->fw);
+		skl_dsp_disable_core(ctx);
+		return ret;
 	}
 
 	/* check for extended manifest */
@@ -416,6 +428,7 @@ int skl_sst_dsp_init(struct device *dev, void __iomem *mmio_base, int irq,
 
 	skl->dev = dev;
 	skl_dev.thread_context = skl;
+	INIT_LIST_HEAD(&skl->uuid_list);
 
 	skl->dsp = skl_dsp_ctx_init(dev, &skl_dev, irq);
 	if (!skl->dsp) {
@@ -459,6 +472,7 @@ EXPORT_SYMBOL_GPL(skl_sst_dsp_init);
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
 	skl_clear_module_table(ctx->dsp);
+	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
 	ctx->dsp->ops->free(ctx->dsp);
 	if (ctx->boot_complete) {
-- 
1.9.1
