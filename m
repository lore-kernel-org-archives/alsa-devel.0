From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Skylake: Update FW purge for
	Broxton
Date: Mon, 13 Jun 2016 17:59:02 +0530
Message-ID: <1465820944-14774-6-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F3400265471
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:39 +0200 (CEST)
In-Reply-To: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

Broxton needs to send Purge firmware IPC to DSP before downloading the
firmware. The DMA id needs to be updated for that.

While at it also update Broxton boot sequence to send purge request after
power up and before yanking off reset.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c     | 16 +++++++++++++---
 sound/soc/intel/skylake/skl-sst-dsp.c |  4 ++--
 sound/soc/intel/skylake/skl-sst-dsp.h |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index e50bac74f4a8..622da5d3e3b3 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -58,13 +58,19 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	ctx->dsp_ops.stream_tag = stream_tag;
 	memcpy(ctx->dmab.area, fwdata, fwsize);
 
+	ret = skl_dsp_core_power_up(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "Boot dsp core failed ret: %d\n", ret);
+		goto base_fw_load_failed;
+	}
+
 	/* Purge FW request */
 	sst_dsp_shim_write(ctx, SKL_ADSP_REG_HIPCI, SKL_ADSP_REG_HIPCI_BUSY |
-					 BXT_IPC_PURGE_FW | (stream_tag - 1));
+				(BXT_IPC_PURGE_FW | ((stream_tag - 1) << 9)));
 
-	ret = skl_dsp_enable_core(ctx);
+	ret = skl_dsp_start_core(ctx);
 	if (ret < 0) {
-		dev_err(ctx->dev, "Boot dsp core failed ret: %d\n", ret);
+		dev_err(ctx->dev, "Start dsp core failed ret: %d\n", ret);
 		ret = -EIO;
 		goto base_fw_load_failed;
 	}
@@ -161,6 +167,10 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	if (ret < 0) {
 		ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 		if (ret < 0) {
+			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
+			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
+
 			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
 			goto sst_load_base_firmware_failed;
 		}
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 13c19855ee1a..37b1d24a9a9d 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -114,7 +114,7 @@ static int skl_dsp_reset_core(struct sst_dsp *ctx)
 	return skl_dsp_core_set_reset_state(ctx);
 }
 
-static int skl_dsp_start_core(struct sst_dsp *ctx)
+int skl_dsp_start_core(struct sst_dsp *ctx)
 {
 	int ret;
 
@@ -140,7 +140,7 @@ static int skl_dsp_start_core(struct sst_dsp *ctx)
 	return ret;
 }
 
-static int skl_dsp_core_power_up(struct sst_dsp *ctx)
+int skl_dsp_core_power_up(struct sst_dsp *ctx)
 {
 	int ret;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 7efaf642c10a..22fbe1075cb5 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -182,5 +182,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, unsigned int offset);
 void skl_freeup_uuid_list(struct skl_sst *ctx);
 
 int skl_dsp_strip_extended_manifest(struct firmware *fw);
+int skl_dsp_start_core(struct sst_dsp *ctx);
+int skl_dsp_core_power_up(struct sst_dsp *ctx);
 
 #endif /*__SKL_SST_DSP_H__*/
-- 
1.9.1
