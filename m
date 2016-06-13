From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: Skylake: Update DSP stall bits
Date: Mon, 13 Jun 2016 17:59:03 +0530
Message-ID: <1465820944-14774-7-git-send-email-vinod.koul@intel.com>
References: <1465820944-14774-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 38DBF26587C
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:22:42 +0200 (CEST)
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
Cc: patches.audio@intel.com, Jayachandran B <jayachandran.b@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jayachandran B <jayachandran.b@intel.com>

The stall bits needs to comprehend the number of DSP cores
running, so update the stall and unstall register writes to
comprehend SKL_DSP_CORES_MASK values as well.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 37b1d24a9a9d..33c45aa53532 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -106,9 +106,9 @@ static bool is_skl_dsp_core_enable(struct sst_dsp *ctx)
 static int skl_dsp_reset_core(struct sst_dsp *ctx)
 {
 	/* stall core */
-	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-			 sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
-				SKL_ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+			SKL_ADSPCS_CSTALL_MASK,
+			SKL_ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
 
 	/* set reset state */
 	return skl_dsp_core_set_reset_state(ctx);
@@ -127,9 +127,8 @@ int skl_dsp_start_core(struct sst_dsp *ctx)
 
 	/* run core */
 	dev_dbg(ctx->dev, "run core...\n");
-	sst_dsp_shim_write_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
-			 sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPCS) &
-				~SKL_ADSPCS_CSTALL(SKL_DSP_CORES_MASK));
+	sst_dsp_shim_update_bits_unlocked(ctx, SKL_ADSP_REG_ADSPCS,
+			SKL_ADSPCS_CSTALL_MASK, 0);
 
 	if (!is_skl_dsp_core_enable(ctx)) {
 		skl_dsp_reset_core(ctx);
-- 
1.9.1
