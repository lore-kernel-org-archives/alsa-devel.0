From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: Reload the firmware in
	case of D3 failure" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:35 +0000
Message-ID: <E1coDQV-0002Il-SR@debutante>
References: <1488910446-26415-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97548267066
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:44 +0100 (CET)
In-Reply-To: <1488910446-26415-6-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: bxtn: Reload the firmware in case of D3 failure

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

>From 03de8c2ef82fae29d53de7eb86b0ca10501499fc Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:27 +0530
Subject: [PATCH] ASoC: Intel: bxtn: Reload the firmware in case of D3 failure

If D3 IPC fails or times out, firmware needs to be reloaded as driver
continues the reset.
So set the fw_load flag to false to reload the firmware in D0.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 2a2bb944cd40..600d95891996 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -533,10 +533,16 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 
 	ret = skl_ipc_set_dx(&skl->ipc, BXT_INSTANCE_ID,
 				BXT_BASE_FW_MODULE_ID, &dx);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(ctx->dev,
 		"Failed to set DSP to D3:core id = %d;Continue reset\n",
 		core_id);
+		/*
+		 * In case of D3 failure, re-download the firmware, so set
+		 * fw_loaded to false.
+		 */
+		skl->fw_loaded = false;
+	}
 
 	if (core_id == SKL_DSP_CORE0_ID) {
 		/* disable Interrupt */
-- 
2.11.0
