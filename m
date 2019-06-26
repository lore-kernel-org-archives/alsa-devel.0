From: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Recover BXT FW on DSP
	boot timeout error
Date: Wed, 26 Jun 2019 11:38:51 +0200
Message-ID: <20190626093851.18474-1-pawel.harlozinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18C2AF8071F
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 11:39:18 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Szymon Mielczarek <szymonx.mielczarek@intel.com>, tiwai@suse.de, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

When DSP boots with timeout error, reinitialize, transfer
and boot firmware to recover audio.

Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 440bca7afbf1..a2844bdca1b8 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -455,13 +455,18 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 	/* If core 1 was turned on for booting core 0, turn it off */
 		skl_dsp_core_power_down(ctx, SKL_DSP_CORE_MASK(1));
 		if (ret == 0) {
-			dev_err(ctx->dev, "%s: DSP boot timeout\n", __func__);
-			dev_err(ctx->dev, "Error code=0x%x: FW status=0x%x\n",
+			dev_warn(ctx->dev,
+				"DSP boot timeout: Error code=0x%x: FW status=0x%x\n",
 				sst_dsp_shim_read(ctx, BXT_ADSP_ERROR_CODE),
 				sst_dsp_shim_read(ctx, BXT_ADSP_FW_STATUS));
-			dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
-			ret = -EIO;
-			goto err;
+
+			ret = bxt_sst_init_fw(skl->dev, skl);
+			dev_warn(ctx->dev, "Reload fw status: %d\n", ret);
+			if (ret < 0) {
+				dev_err(ctx->dev, "Failed to set core0 to D0 state\n");
+				ret = -EIO;
+				goto err;
+			}
 		}
 	}
 
-- 
2.17.1
