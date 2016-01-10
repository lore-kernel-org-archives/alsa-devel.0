From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: enable interrupt as
	wake source in active suspend" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:30 +0000
Message-ID: <E1aIF0w-0008Qs-P2@debutante>
References: <1449816267-11910-12-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 151F42605EA
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:41 +0100 (CET)
In-Reply-To: <1449816267-11910-12-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: enable interrupt as wake source in active suspend

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

>From 1f4956fd96c98e3fbe9a2818014cf36854398db0 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 18 Dec 2015 15:12:06 +0530
Subject: [PATCH] ASoC: Intel: Skylake: enable interrupt as wake source in
 active suspend

In active suspend, any HDA interrupt should wake the system. When device
enters active suspend, we need to enable HDA controller interrupt as wake
source. Similarly disable HDA controller interrupt as wake source when
exiting active suspend.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 80a5f6456aca..443a15de94b5 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -218,6 +218,7 @@ static int skl_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	/*
 	 * Do not suspend if streams which are marked ignore suspend are
@@ -225,6 +226,7 @@ static int skl_suspend(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		snd_hdac_ext_bus_link_power_down_all(ebus);
+		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
 		pci_disable_device(pci);
 		return 0;
@@ -238,6 +240,7 @@ static int skl_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int ret;
 
 	/*
@@ -248,6 +251,7 @@ static int skl_resume(struct device *dev)
 		pci_restore_state(pci);
 		ret = pci_enable_device(pci);
 		snd_hdac_ext_bus_link_power_up_all(ebus);
+		disable_irq_wake(bus->irq);
 	} else {
 		ret = _skl_resume(ebus);
 	}
-- 
2.7.0.rc3
