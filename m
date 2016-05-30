From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Skylake: Strip manifest for
	Broxton platform
Date: Mon, 30 May 2016 17:42:58 +0530
Message-ID: <1464610381-19416-5-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DC88326073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:53 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Ramesh Babu <ramesh.babu@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Broxton firmrware comes with extended manifest so invoke
skl_dsp_strip_extended_manifest() to check and strip

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index dd86232eea05..0dd921349663 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -132,6 +132,7 @@ static int sst_transfer_fw_host_dma(struct sst_dsp *ctx)
 
 static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
+	struct firmware stripped_fw;
 	struct skl_sst *skl = ctx->thread_context;
 	int ret;
 
@@ -141,10 +142,19 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 		goto sst_load_base_firmware_failed;
 	}
 
-	ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
+	/* check for extended manifest */
+	if (ctx->fw == NULL)
+		goto sst_load_base_firmware_failed;
+
+
+	stripped_fw.data = ctx->fw->data;
+	stripped_fw.size = ctx->fw->size;
+	skl_dsp_strip_extended_manifest(&stripped_fw);
+
+	ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 	/* Retry Enabling core and ROM load. Retry seemed to help */
 	if (ret < 0) {
-		ret = sst_bxt_prepare_fw(ctx, ctx->fw->data, ctx->fw->size);
+		ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
 		if (ret < 0) {
 			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
 			goto sst_load_base_firmware_failed;
-- 
1.9.1
