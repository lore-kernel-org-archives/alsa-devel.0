From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Move module id defines"
	to the asoc tree
Date: Sun, 13 Mar 2016 15:15:06 +0700
Message-ID: <E1af1B4-0004JF-6D@finisterre>
References: <1457671376-18667-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB562605B6
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:13 +0100 (CET)
In-Reply-To: <1457671376-18667-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Move module id defines

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

>From 39fa37d51ae904968c49ef49165df7fec66fd9ea Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 11 Mar 2016 10:12:49 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Move module id defines

The module ID defines are common to other platforms so can be
reused if moved to a common driver header so move it

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 4 ++++
 sound/soc/intel/skylake/skl-sst.c     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index cbb40751c37e..a82c3de1a228 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -53,6 +53,10 @@ struct sst_dsp_device;
 /* HIPCT */
 #define SKL_ADSP_REG_HIPCT_BUSY		BIT(31)
 
+/* FW base IDs */
+#define SKL_INSTANCE_ID			0
+#define SKL_BASE_FW_MODULE_ID		0
+
 /* Intel HD Audio SRAM Window 1 */
 #define SKL_ADSP_SRAM1_BASE		0xA000
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index e26f4746afb7..348a734f8e24 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -35,9 +35,6 @@
 #define SKL_ADSP_FW_STATUS	SKL_ADSP_SRAM0_BASE
 #define SKL_ADSP_ERROR_CODE	(SKL_ADSP_FW_STATUS + 0x4)
 
-#define SKL_INSTANCE_ID		0
-#define SKL_BASE_FW_MODULE_ID	0
-
 #define SKL_NUM_MODULES		1
 
 static bool skl_check_fw_status(struct sst_dsp *ctx, u32 status)
-- 
2.7.0
