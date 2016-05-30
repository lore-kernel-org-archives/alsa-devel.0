From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Skylake: Strip manifest for
	Skylake platform
Date: Mon, 30 May 2016 17:42:57 +0530
Message-ID: <1464610381-19416-4-git-send-email-vinod.koul@intel.com>
References: <1464610381-19416-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BB5CD261AAF
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:06:50 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Future firmware updates may comes with extended manifest so invoke
skl_dsp_strip_extended_manifest() to check and strip

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 13ec8d53b526..be2c42b815b7 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -72,6 +72,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 {
 	int ret = 0, i;
 	struct skl_sst *skl = ctx->thread_context;
+	struct firmware stripped_fw;
 	u32 reg;
 
 	skl->boot_complete = false;
@@ -86,6 +87,12 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		}
 	}
 
+	/* check for extended manifest */
+	stripped_fw.data = ctx->fw->data;
+	stripped_fw.size = ctx->fw->size;
+
+	skl_dsp_strip_extended_manifest(&stripped_fw);
+
 	ret = skl_dsp_boot(ctx);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Boot dsp core failed ret: %d", ret);
@@ -119,7 +126,7 @@ static int skl_load_base_firmware(struct sst_dsp *ctx)
 		goto transfer_firmware_failed;
 	}
 
-	ret = skl_transfer_firmware(ctx, ctx->fw->data, ctx->fw->size);
+	ret = skl_transfer_firmware(ctx, stripped_fw.data, stripped_fw.size);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Transfer firmware failed%d\n", ret);
 		goto transfer_firmware_failed;
-- 
1.9.1
