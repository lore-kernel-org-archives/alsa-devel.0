From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: Use DSP poll API to poll
	FW status" to the asoc tree
Date: Fri, 06 Jan 2017 18:16:32 +0000
Message-ID: <E1cPZ44-00038h-VV@debutante>
References: <1483330807-9518-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE0B22677FE
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:38 +0100 (CET)
In-Reply-To: <1483330807-9518-3-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: bxtn: Use DSP poll API to poll FW status

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

>From 1448099dd3d55546057cdda0493a6493c007b9fd Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 2 Jan 2017 09:50:03 +0530
Subject: [PATCH] ASoC: Intel: bxtn: Use DSP poll API to poll FW status

Use the optimized dsp_register_poll API to poll the DSP firmware
status register rather than open coding it.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index e4a382870132..15a063a403cc 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -151,23 +151,13 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	}
 
 	/* Step 4: Wait for DONE Bit */
-	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
-		reg = sst_dsp_shim_read(ctx, SKL_ADSP_REG_HIPCIE);
-
-		if (reg & SKL_ADSP_REG_HIPCIE_DONE) {
-			sst_dsp_shim_update_bits_forced(ctx,
-					SKL_ADSP_REG_HIPCIE,
+	ret = sst_dsp_register_poll(ctx, SKL_ADSP_REG_HIPCIE,
 					SKL_ADSP_REG_HIPCIE_DONE,
-					SKL_ADSP_REG_HIPCIE_DONE);
-			break;
-		}
-		mdelay(1);
-	}
-	if (!i) {
-		dev_info(ctx->dev, "Waiting for HIPCIE done, reg: 0x%x\n", reg);
-		sst_dsp_shim_update_bits(ctx, SKL_ADSP_REG_HIPCIE,
-				SKL_ADSP_REG_HIPCIE_DONE,
-				SKL_ADSP_REG_HIPCIE_DONE);
+					SKL_ADSP_REG_HIPCIE_DONE,
+					BXT_INIT_TIMEOUT, "HIPCIE Done");
+	if (ret < 0) {
+		dev_err(ctx->dev, "Timout for Purge Request%d\n", ret);
+		goto base_fw_load_failed;
 	}
 
 	/* Step 5: power down core1 */
@@ -182,19 +172,10 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
 	skl_ipc_op_int_enable(ctx);
 
 	/* Step 7: Wait for ROM init */
-	for (i = BXT_INIT_TIMEOUT; i > 0; --i) {
-		if (SKL_FW_INIT ==
-				(sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS) &
-				SKL_FW_STS_MASK)) {
-
-			dev_info(ctx->dev, "ROM loaded, continue FW loading\n");
-			break;
-		}
-		mdelay(1);
-	}
-	if (!i) {
-		dev_err(ctx->dev, "Timeout for ROM init, HIPCIE: 0x%x\n", reg);
-		ret = -EIO;
+	ret = sst_dsp_register_poll(ctx, BXT_ADSP_FW_STATUS, SKL_FW_STS_MASK,
+			SKL_FW_INIT, BXT_INIT_TIMEOUT, "ROM Load");
+	if (ret < 0) {
+		dev_err(ctx->dev, "Timeout for ROM init, ret:%d\n", ret);
 		goto base_fw_load_failed;
 	}
 
-- 
2.11.0
