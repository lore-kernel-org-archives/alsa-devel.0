From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove redundant init
	in resume" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:13 +0000
Message-ID: <E1Zz7lB-0001Ny-6U@debutante>
References: <1447267609-27816-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A4E7265A7B
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:18 +0100 (CET)
In-Reply-To: <1447267609-27816-4-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Remove redundant init in resume

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

>From e03fc82d7c474b2f9bcdb0f6a5ef26c6c3ab24ee Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:07 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove redundant init in resume

Since we call _skl_resume which also initializes the chip we no
need to call these explicitly, so remove the duplication

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index bdb99dcbfdca..d3e87b6f93fe 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -199,13 +199,9 @@ static int skl_runtime_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *skl = ebus_to_skl(ebus);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	skl_init_pci(skl);
-	snd_hdac_bus_init_chip(bus, true);
-
 	return _skl_resume(ebus);
 }
 #endif /* CONFIG_PM */
-- 
2.6.2
