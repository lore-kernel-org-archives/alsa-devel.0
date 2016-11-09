From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove pci device
	enabling calls on suspend" to the asoc tree
Date: Wed, 09 Nov 2016 15:25:30 +0000
Message-ID: <E1c4Ukl-0003hp-05@finisterre>
References: <1474868137-29712-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1AAA267097
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 16:25:45 +0100 (CET)
In-Reply-To: <1474868137-29712-11-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: remove pci device enabling calls on suspend

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

>From 68d03a3aa2747e1a33231950d2c8369f1cef4244 Mon Sep 17 00:00:00 2001
From: Jayachandran B <jayachandran.b@intel.com>
Date: Thu, 3 Nov 2016 17:07:22 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove pci device enabling calls on
 suspend

We were invoking pci_disable_device() while going to suspend-to-idle and
pci_enable_device() while coming back to active state.

Turns out that we do not need these calls as we only need system to be
wake capable when in suspend-to-idle state. The wake capability is
already done by enable_irq_wake() calls, so remove these unwanted calls
in driver.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b9209af89915..ed59783e9846 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -290,7 +290,6 @@ static int skl_suspend(struct device *dev)
 
 		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
-		pci_disable_device(pci);
 	} else {
 		ret = _skl_suspend(ebus);
 		if (ret < 0)
@@ -333,7 +332,6 @@ static int skl_resume(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		pci_restore_state(pci);
-		ret = pci_enable_device(pci);
 		snd_hdac_ext_bus_link_power_up_all(ebus);
 		disable_irq_wake(bus->irq);
 		/*
-- 
2.10.2
