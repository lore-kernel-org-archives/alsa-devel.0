From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Release FW ctx in
	cleanup" to the asoc tree
Date: Fri, 06 Jan 2017 18:16:29 +0000
Message-ID: <E1cPZ41-00037p-WD@debutante>
References: <1483330807-9518-5-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 739FF267801
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:36 +0100 (CET)
In-Reply-To: <1483330807-9518-5-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: Skylake: Release FW ctx in cleanup

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

>From bc65a326c579e93a5c2120a65ede72f11369ee5a Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 2 Jan 2017 09:50:05 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Release FW ctx in cleanup

Saved firmware ctx was not never released, so release Firmware
ctx in cleanup routine.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8fc3178bc79c..b30bd384c8d3 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -515,6 +515,9 @@ EXPORT_SYMBOL_GPL(skl_sst_init_fw);
 
 void skl_sst_dsp_cleanup(struct device *dev, struct skl_sst *ctx)
 {
+
+	if (ctx->dsp->fw)
+		release_firmware(ctx->dsp->fw);
 	skl_clear_module_table(ctx->dsp);
 	skl_freeup_uuid_list(ctx);
 	skl_ipc_free(&ctx->ipc);
-- 
2.11.0
