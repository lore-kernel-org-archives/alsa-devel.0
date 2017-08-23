From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix DSP core ref count
	for init failure" to the asoc tree
Date: Wed, 23 Aug 2017 12:24:32 +0100
Message-ID: <E1dkTlw-00077V-TF@debutante>
References: <1503400553-15377-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 49B882664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 13:24:42 +0200 (CEST)
In-Reply-To: <1503400553-15377-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix DSP core ref count for init failure

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

>From 7b992c24de78a206b3abd07192686d2d5db5012c Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 22 Aug 2017 16:45:53 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix DSP core ref count for init failure

During dsp init failure, the ref count is not incremented and dsp is
powered down. But as the skl driver calls put_core for the init failure it
decrements the dsp core ref count and ref count becomes unbalanced.

This results in dsp core powered up in further runtime suspend/resume
cycles and never powered down.

So increment the ref count before dsp core powerup and for any failure,
decrement in put_core will be balanced.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index c2ba5ff1632c..19ee1d4f3bdf 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -351,6 +351,8 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		return -EINVAL;
 	}
 
+	skl->cores.usage_count[core_id]++;
+
 	if (skl->cores.state[core_id] == SKL_DSP_RESET) {
 		ret = ctx->fw_ops.set_state_D0(ctx, core_id);
 		if (ret < 0) {
@@ -359,8 +361,6 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		}
 	}
 
-	skl->cores.usage_count[core_id]++;
-
 out:
 	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
 			core_id, skl->cores.state[core_id],
-- 
2.14.1
