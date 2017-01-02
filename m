From: jeeja.kp@intel.com
Subject: [PATCH 2/6] ASoC: Intel: bxtn: Use DSP poll API to
	poll FW status
Date: Mon,  2 Jan 2017 09:50:03 +0530
Message-ID: <1483330807-9518-3-git-send-email-jeeja.kp@intel.com>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EFCF266653
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 05:09:27 +0100 (CET)
In-Reply-To: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Use the optimized dsp_register_poll API to poll the DSP firmware
status register rather than open coding it.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 1f9f33d..d959643 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -153,23 +153,13 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
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
@@ -184,19 +174,10 @@ static int sst_bxt_prepare_fw(struct sst_dsp *ctx,
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
2.5.0
