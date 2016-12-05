From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: save FW version" to the
	asoc tree
Date: Mon, 05 Dec 2016 17:23:23 +0000
Message-ID: <E1cDwz5-0007aL-QK@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D59266DB1
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 18:23:33 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: save FW version

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

>From c7da1e9d2641f67e8b20703118ac02fe79604f10 Mon Sep 17 00:00:00 2001
From: Sebastien Guiriec <sebastien.guiriec@intel.com>
Date: Mon, 5 Dec 2016 17:45:01 +0100
Subject: [PATCH] ASoC: Intel: atom: save FW version

After the boot of the SST FW the firmware version is send back
to the driver. This patch is saving the FW version inside the
driver.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.h     | 1 +
 sound/soc/intel/atom/sst/sst_ipc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 3f493862e98d..5c9a51cc77aa 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -436,6 +436,7 @@ struct intel_sst_drv {
 	 */
 	char firmware_name[FW_NAME_SIZE];
 
+	struct snd_sst_fw_version fw_version;
 	struct sst_fw_save	*fw_save;
 };
 
diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 7934a0047384..374bb61c596d 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -242,6 +242,12 @@ static void process_fw_init(struct intel_sst_drv *sst_drv_ctx,
 	dev_dbg(sst_drv_ctx->dev, "Build date %s Time %s\n",
 			init->build_info.date, init->build_info.time);
 
+	/* Save FW version */
+	sst_drv_ctx->fw_version.type = init->fw_version.type;
+	sst_drv_ctx->fw_version.major = init->fw_version.major;
+	sst_drv_ctx->fw_version.minor = init->fw_version.minor;
+	sst_drv_ctx->fw_version.build = init->fw_version.build;
+
 ret:
 	sst_wake_up_block(sst_drv_ctx, retval, FW_DWNL_ID, 0 , NULL, 0);
 }
-- 
2.10.2
