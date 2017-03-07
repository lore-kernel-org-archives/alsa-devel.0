From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: optimize ROM init retries"
	to the asoc tree
Date: Tue, 07 Mar 2017 13:57:15 +0100
Message-ID: <E1clEfz-0004ce-Mx@finisterre>
References: <1483330807-9518-7-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E09B0266AC4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:57:27 +0100 (CET)
In-Reply-To: <1483330807-9518-7-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bxtn: optimize ROM init retries

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

>From 7d3f91dc1e4db18b644695c9442c62679a5dff6e Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 17 Feb 2017 22:48:57 +0530
Subject: [PATCH] ASoC: Intel: bxtn: optimize ROM init retries

During S3->S0 transition, sometime ROM init fails because of
authentication engine loads later than the OS. In this case driver
waits for a longer period and then retries the FW download causing
huge delay in resume time of audio device.

To avoid this, ROM INIT wait time is set to a optimal value and
increased the retries for firmware download.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 7762d5a18fce..d3be1be5a372 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -25,7 +25,8 @@
 #include "skl-sst-ipc.h"
 
 #define BXT_BASEFW_TIMEOUT	3000
-#define BXT_INIT_TIMEOUT	500
+#define BXT_INIT_TIMEOUT	300
+#define BXT_ROM_INIT_TIMEOUT	70
 #define BXT_IPC_PURGE_FW	0x01004000
 
 #define BXT_ROM_INIT		0x5
@@ -45,6 +46,8 @@
 /* Delay before scheduling D0i3 entry */
 #define BXT_D0I3_DELAY 5000
 
+#define BXT_FW_ROM_INIT_RETRY 3
+
 static unsigned int bxt_get_errorcode(struct sst_dsp *ctx)
 {
 	 return sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE);
@@ -185,7 +188,7 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 
 	/* Step 7: Wait for ROM init */
 	ret = sst_dsp_register_poll(ctx, BXT_ADSP_FW_STATUS, SKL_FW_STS_MASK,
-			SKL_FW_INIT, BXT_INIT_TIMEOUT, "ROM Load");
+			SKL_FW_INIT, BXT_ROM_INIT_TIMEOUT, "ROM Load");
 	if (ret < 0) {
 		dev_err(ctx->dev, "Timeout for ROM init, ret:%d\n", ret);
 		goto base_fw_load_failed;
@@ -218,7 +221,7 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 {
 	struct firmware stripped_fw;
 	struct skl_sst *skl = ctx->thread_context;
-	int ret;
+	int ret, i;
 
 	if (ctx->fw == NULL) {
 		ret = request_firmware(&ctx->fw, ctx->fw_name, ctx->dev);
@@ -239,18 +242,20 @@ static int bxt_load_base_firmware(struct sst_dsp *ctx)
 	stripped_fw.size = ctx->fw->size;
 	skl_dsp_strip_extended_manifest(&stripped_fw);
 
-	ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
-	/* Retry Enabling core and ROM load. Retry seemed to help */
-	if (ret < 0) {
+
+	for (i = 0; i < BXT_FW_ROM_INIT_RETRY; i++) {
 		ret = sst_bxt_prepare_fw(ctx, stripped_fw.data, stripped_fw.size);
-		if (ret < 0) {
-			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+		if (ret == 0)
+			break;
+	}
+
+	if (ret < 0) {
+		dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
 			sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
 			sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
 
-			dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
-			goto sst_load_base_firmware_failed;
-		}
+		dev_err(ctx->dev, "Core En/ROM load fail:%d\n", ret);
+		goto sst_load_base_firmware_failed;
 	}
 
 	ret = sst_transfer_fw_host_dma(ctx);
-- 
2.11.0
