From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update DSP stall bits"
	to the asoc tree
Date: Tue, 14 Jun 2016 16:08:59 +0100
Message-ID: <E1bCpxb-0001RL-56@finisterre>
References: <1465820944-14774-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 888F0261691
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 17:09:12 +0200 (CEST)
In-Reply-To: <1465820944-14774-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update DSP stall bits

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

>From 2f74053bead3f47ddee219f521562db941ce0ae1 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Mon, 13 Jun 2016 17:59:03 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update DSP stall bits

The stall bits needs to comprehend the number of DSP cores
running, so update the stall and unstall register writes to
comprehend SKL_DSP_CORES_MASK values as well.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
