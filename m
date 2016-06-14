From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update FW purge for
	Broxton" to the asoc tree
Date: Tue, 14 Jun 2016 16:09:02 +0100
Message-ID: <E1bCpxe-0001TG-HU@finisterre>
References: <1465820944-14774-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B1C261615
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:12 +0200 (CEST)
In-Reply-To: <1465820944-14774-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update FW purge for Broxton

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

>From 2023576dd74c9afdb25692f7e9ac9a837e8cf3bd Mon Sep 17 00:00:00 2001
From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Date: Mon, 13 Jun 2016 17:59:02 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update FW purge for Broxton

Broxton needs to send Purge firmware IPC to DSP before downloading the
firmware. The DMA id needs to be updated for that.

While at it also update Broxton boot sequence to send purge request after
power up and before yanking off reset.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
