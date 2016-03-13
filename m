From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Unstatify
	skl_dsp_enable_core" to the asoc tree
Date: Sun, 13 Mar 2016 15:15:03 +0700
Message-ID: <E1af1B1-0004IC-4D@finisterre>
References: <1457671376-18667-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7C9260534
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:11 +0100 (CET)
In-Reply-To: <1457671376-18667-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Unstatify skl_dsp_enable_core

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

>From 130e69a4773fb65af284d3fd1f3de762324d06e6 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Fri, 11 Mar 2016 10:12:51 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Unstatify skl_dsp_enable_core

The function skl_dsp_enable_core will be called by other parts of
driver so this can no longer be a static function.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 +-
 sound/soc/intel/skylake/skl-sst-dsp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 646d10a0d176..a5267e8a96e0 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -181,7 +181,7 @@ static int skl_dsp_core_power_down(struct sst_dsp *ctx)
 			"Power down");
 }
 
-static int skl_dsp_enable_core(struct sst_dsp *ctx)
+int skl_dsp_enable_core(struct sst_dsp *ctx)
 {
 	int ret;
 
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index 676e78be0169..b6e310d49dd6 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -148,6 +148,7 @@ int skl_cldma_prepare(struct sst_dsp *ctx);
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
+int skl_dsp_enable_core(struct sst_dsp *ctx);
 int skl_dsp_disable_core(struct sst_dsp *ctx);
 bool is_skl_dsp_running(struct sst_dsp *ctx);
 irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id);
-- 
2.7.0
