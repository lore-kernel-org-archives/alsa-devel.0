From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove call to
	pci_dev_put" to the asoc tree
Date: Wed, 16 Mar 2016 16:24:21 +0000
Message-ID: <E1agEFB-0006Cp-Ko@debutante>
References: <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8233A26652A
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 17:24:33 +0100 (CET)
In-Reply-To: <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: remove call to pci_dev_put

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

>From 36e7972c0d3f8819a5d9335c36c5dcd168cd2b72 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 16 Mar 2016 21:51:31 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove call to pci_dev_put

The PCI bus takes pci_dev_get() and pci_dev_put() is also there.
So no need for drivers to invoke these. In SKL driver we were
calling pci_dev_put() only which is not right, so remove this

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 72971dc55c52..07d9bc1cf3cb 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -724,7 +724,6 @@ static void skl_remove(struct pci_dev *pci)
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
-	pci_dev_put(pci);
 
 	/* codec removal, invoke bus_device_remove */
 	snd_hdac_ext_bus_device_remove(ebus);
-- 
2.7.0
