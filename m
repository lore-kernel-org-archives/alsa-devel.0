From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: Update DSP core state in
	D0" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:38 +0000
Message-ID: <E1coDQY-0002Jw-SG@debutante>
References: <1488910446-26415-5-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C0222670CF
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:47 +0100 (CET)
In-Reply-To: <1488910446-26415-5-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: bxtn: Update DSP core state in D0

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

>From 1fb344a33a2f99378128281df97770e2c5182c2d Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:26 +0530
Subject: [PATCH] ASoC: Intel: bxtn: Update DSP core state in D0

In system suspend, firmware needs to be re-downloaded as IMR is cleared.
When firmware is downloaded in D0, core state is not set to running
state causing instability with subsequent D0-D3 cycles.

So set the core state correctly during D0 and check the DSP core state
if not in reset to set the DSP to D3.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c     | 1 +
 sound/soc/intel/skylake/skl-sst-dsp.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index b34c96508605..2a2bb944cd40 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -446,6 +446,7 @@ static int bxt_set_dsp_D0(struct sst_dsp *ctx, unsigned int core_id)
 				return ret;
 			}
 		}
+		skl->cores.state[core_id] = SKL_DSP_RUNNING;
 		return ret;
 	}
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index c3deefab65d6..08332723c700 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -355,12 +355,13 @@ int skl_dsp_get_core(struct sst_dsp *ctx, unsigned int core_id)
 		ret = ctx->fw_ops.set_state_D0(ctx, core_id);
 		if (ret < 0) {
 			dev_err(ctx->dev, "unable to get core%d\n", core_id);
-			return ret;
+			goto out;
 		}
 	}
 
 	skl->cores.usage_count[core_id]++;
 
+out:
 	dev_dbg(ctx->dev, "core id %d state %d usage_count %d\n",
 			core_id, skl->cores.state[core_id],
 			skl->cores.usage_count[core_id]);
@@ -379,7 +380,8 @@ int skl_dsp_put_core(struct sst_dsp *ctx, unsigned int core_id)
 		return -EINVAL;
 	}
 
-	if (--skl->cores.usage_count[core_id] == 0) {
+	if ((--skl->cores.usage_count[core_id] == 0) &&
+		(skl->cores.state[core_id] != SKL_DSP_RESET)) {
 		ret = ctx->fw_ops.set_state_D3(ctx, core_id);
 		if (ret < 0) {
 			dev_err(ctx->dev, "unable to put core %d: %d\n",
-- 
2.11.0
