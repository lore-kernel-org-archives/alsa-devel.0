From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Check CPA bit in DSP
	core power down" to the asoc tree
Date: Fri, 09 Oct 2015 12:21:30 +0100
Message-ID: <E1ZkVju-0006bN-7l@finisterre>
References: <1444377711-9720-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6389C265132
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:45 +0200 (CEST)
In-Reply-To: <1444377711-9720-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Check CPA bit in DSP core power down

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

>From 6ea8ba33e65d3d284de7e7373939352e2c728f10 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 9 Oct 2015 09:01:48 +0100
Subject: [PATCH] ASoC: Intel: Skylake: Check CPA bit in DSP core power down

Skylake driver will set the SPA bit to 0 to turn off the DSP core.
Driver will poll the Current Power Active (CPA) bit to match the
Set Power Active (SPA) bit value. When CPA bit matches the value
of SPA bit, the achieved power state has reached.

In case of DSP power down, register that was polled is SPA
instead of CPA. This patch corrects the register to be polled
in case of DSP power down.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 94875b0..194bd00 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -175,7 +175,7 @@ static int skl_dsp_core_power_down(struct sst_dsp  *ctx)
 	/* poll with timeout to check if operation successful */
 	return sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_SPA_MASK,
+			SKL_ADSPCS_CPA_MASK,
 			0,
 			SKL_DSP_PD_TO,
 			"Power down");
-- 
2.5.0
