From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: free codec objects on
	removal" to the asoc tree
Date: Wed, 16 Mar 2016 10:09:22 +0000
Message-ID: <E1ag8OI-00062n-5f@debutante>
References: <1458040168-3769-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A496D266005
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:09:29 +0100 (CET)
In-Reply-To: <1458040168-3769-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: free codec objects on removal

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

>From 7373f481dc4098a844a756201e98341bc56baaa2 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Mar 2016 16:39:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: free codec objects on removal

On driver removal we should ask the core to remove the device
objects as well, so invoke snd_hdac_ext_bus_device_remove() in
remove.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ab5e25aaeee3..292d51db9a22 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -725,6 +725,10 @@ static void skl_remove(struct pci_dev *pci)
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
+
+	/* codec removal, invoke bus_device_remove */
+	snd_hdac_ext_bus_device_remove(ebus);
+
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
-- 
2.7.0
