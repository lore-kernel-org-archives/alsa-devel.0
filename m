From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: Skylake: Don't use local
	pointer for firmware
Date: Mon, 30 May 2016 17:42:56 +0530
Message-ID: <1464610381-19416-3-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC40261A0D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:48 +0200 (CEST)
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

We have firmware pointer is driver context, so use that instead
of local pointer.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 965ce40ce752..dd86232eea05 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -132,20 +132,19 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
-	const struct firmware *fw = NULL;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
 
-	ret = request_firmware(&fw, ctx->fw_name, ctx->dev);
+	ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Request firmware failed %d\n", ret);
 		goto sst_load_base_firmware_failed;
 	}
 
-	ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+	ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
 	/* Retry Enabling core and ROM load. Retry seemed to help */
 	if (ret < 0) {
-		ret = sst_bxt_prepare_fw(ctx, fw->data, fw->size);
+		ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
 			goto sst_load_base_firmware_failed;
@@ -175,7 +174,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	}
 
 sst_load_base_firmware_failed:
-	release_firmware(fw);
+	release_firmware(ctx->fw);
 	return ret;
 }
 
-- 
1.9.1
