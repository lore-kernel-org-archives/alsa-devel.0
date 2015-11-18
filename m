From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't enable WAKEENABLE
	on suspend" to the asoc tree
Date: Wed, 18 Nov 2015 18:47:14 +0000
Message-ID: <E1Zz7lC-0001OR-3u@debutante>
References: <1447267609-27816-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCA08265B6D
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:47:19 +0100 (CET)
In-Reply-To: <1447267609-27816-3-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Don't enable WAKEENABLE on suspend

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

>From a71e269728ce42216cca8ce5145e97e777a36467 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 13 Nov 2015 19:22:06 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't enable WAKEENABLE on suspend

For HDA codecs WAKEENABLE bit is to programmed if codec event
change has to wake the system when suspended.

In skylake I2S systems which are currently supported we have
only HDMI codec, which doesn't use this capability to detect a
HDMI connect/ disconnect event. HDMI HDA codec uses display
interface to detect connect/disconnect event.

This patch removes the WAKEBIT enabling during device D0/D3 as
this seems to cause spurious wakes on the system

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 8ead864f354a..bdb99dcbfdca 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -191,9 +191,6 @@ static int skl_runtime_suspend(struct device *dev)
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	/* enable controller wake up event */
-	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
-
 	return _skl_suspend(ebus);
 }
 
@@ -203,17 +200,11 @@ static int skl_runtime_resume(struct device *dev)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	struct skl *skl = ebus_to_skl(ebus);
-	int status;
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-	/* Read STATESTS before controller reset */
-	status = snd_hdac_chip_readw(bus, STATESTS);
-
 	skl_init_pci(skl);
 	snd_hdac_bus_init_chip(bus, true);
-	/* disable controller Wake Up event */
-	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
 
 	return _skl_resume(ebus);
 }
-- 
2.6.2
