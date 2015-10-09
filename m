From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Verify the status bit
	before handling interrupt" to the asoc tree
Date: Fri, 09 Oct 2015 12:21:28 +0100
Message-ID: <E1ZkVjs-0006as-SM@finisterre>
References: <1444377711-9720-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79EC4265152
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 13:21:45 +0200 (CEST)
In-Reply-To: <1444377711-9720-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Verify the status bit before handling interrupt

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

>From def656fe22abb4fbf174a982dcef1d40274ddb11 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 9 Oct 2015 09:01:49 +0100
Subject: [PATCH] ASoC: Intel: Skylake: Verify the status bit before handling
 interrupt

Like we have in legacy mode HDA driver, we need to check the
status bit and handle interrupt only when it is not zero or all
bits set.  We typically see the status as all 1's when controller
resumes from suspend, So add the check here as well and don't
handle for these cases.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 194bd00..1bfb7f6 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -262,6 +262,11 @@ irqreturn_t skl_dsp_sst_interrupt(int irq, void *dev_id)
 	val = sst_dsp_shim_read_unlocked(ctx, SKL_ADSP_REG_ADSPIS);
 	ctx->intr_status = val;
 
+	if (val == 0xffffffff) {
+		spin_unlock(&ctx->spinlock);
+		return IRQ_NONE;
+	}
+
 	if (val & SKL_ADSPIS_IPC) {
 		skl_ipc_int_disable(ctx);
 		result = IRQ_WAKE_THREAD;
-- 
2.5.0
