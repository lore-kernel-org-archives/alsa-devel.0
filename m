From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: manage link power in
	active suspend" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:31 +0000
Message-ID: <E1aIF0x-0008RM-Lz@debutante>
References: <1449816267-11910-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C34826063A
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:37 +0100 (CET)
In-Reply-To: <1449816267-11910-11-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: manage link power in active suspend

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

>From c2e20cd8187cb576362e7c8ecb0b1c51eedb2686 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 18 Dec 2015 15:12:05 +0530
Subject: [PATCH] ASoC: Intel: Skylake: manage link power in active suspend

When device enters active suspend, we should turn off the links
as they are not in use. Similarly we need to bring back links
when we exit active suspend.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dd38f5feb7c0..80a5f6456aca 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -224,6 +224,7 @@ static int skl_suspend(struct device *dev)
 	 * running, we need to save the state for these and continue
 	 */
 	if (skl->supend_active) {
+		snd_hdac_ext_bus_link_power_down_all(ebus);
 		pci_save_state(pci);
 		pci_disable_device(pci);
 		return 0;
@@ -246,6 +247,7 @@ static int skl_resume(struct device *dev)
 	if (skl->supend_active) {
 		pci_restore_state(pci);
 		ret = pci_enable_device(pci);
+		snd_hdac_ext_bus_link_power_up_all(ebus);
 	} else {
 		ret = _skl_resume(ebus);
 	}
-- 
2.7.0.rc3
