From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bxtn: Disable interrupt when DSP
	is in D3" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:42 +0000
Message-ID: <E1coDQc-0002Kz-Vv@debutante>
References: <1488910446-26415-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB58226705E
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:13:51 +0100 (CET)
In-Reply-To: <1488910446-26415-4-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: bxtn: Disable interrupt when DSP is in D3

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

>From 5518af9f97940e84de6a4bf6fed212a95278f818 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 13 Mar 2017 22:11:25 +0530
Subject: [PATCH] ASoC: Intel: bxtn: Disable interrupt when DSP is in D3

When DSP is in D3, no interrupts are expected, so disable
interrupt while entering D3.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/bxt-sst.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index d3be1be5a372..b34c96508605 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -537,6 +537,11 @@ static int bxt_set_dsp_D3(struct sst_dsp *ctx, unsigned int core_id)
 		"Failed to set DSP to D3:core id = %d;Continue reset\n",
 		core_id);
 
+	if (core_id == SKL_DSP_CORE0_ID) {
+		/* disable Interrupt */
+		skl_ipc_op_int_disable(ctx);
+		skl_ipc_int_disable(ctx);
+	}
 	ret = skl_dsp_disable_core(ctx, core_mask);
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to disable core %d\n", ret);
-- 
2.11.0
