From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/17] ASoC: Intel: Skylake: Fix PM
	behaviour
Date: Fri, 30 Oct 2015 11:08:21 +0900
Message-ID: <E1Zrz77-00017p-0Q@finisterre>
References: <1445905380-18167-18-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18905265AB3
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:25 +0100 (CET)
In-Reply-To: <1445905380-18167-18-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jayachandran B <jayachandran.b@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix PM behaviour

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

>From 7d703efc69e704195073ed31963b2ca86c12194d Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:23:00 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix PM behaviour

The driver runtime behaviour is fine but in suspend, we missed
setting the DSP to suspend and also missed resuming DSP on
resume.

Fix this by having common SKL suspend and resume routines which
power up/down links, suspend/resume DSP and other common
routines, and call these routines from both runtime as well as
system PM handlers

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 60 +++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 211ef6e2..9b94a8c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -129,6 +129,37 @@ static int skl_acquire_irq(struct hdac_ext_bus *ebus, int do_disconnect)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int _skl_suspend(struct hdac_ext_bus *ebus)
+{
+	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	int ret;
+
+	snd_hdac_ext_bus_link_power_down_all(ebus);
+
+	ret = skl_suspend_dsp(skl);
+	if (ret < 0)
+		return ret;
+
+	snd_hdac_bus_stop_chip(bus);
+	snd_hdac_bus_enter_link_reset(bus);
+
+	return 0;
+}
+
+static int _skl_resume(struct hdac_ext_bus *ebus)
+{
+	struct skl *skl = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	skl_init_pci(skl);
+	snd_hdac_bus_init_chip(bus, true);
+
+	return skl_resume_dsp(skl);
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * power management
@@ -137,26 +168,16 @@ static int skl_suspend(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-
-	snd_hdac_bus_stop_chip(bus);
-	snd_hdac_bus_enter_link_reset(bus);
 
-	return 0;
+	return _skl_suspend(ebus);
 }
 
 static int skl_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *hda = ebus_to_skl(ebus);
-
-	skl_init_pci(hda);
 
-	snd_hdac_bus_init_chip(bus, 1);
-
-	return 0;
+	return _skl_resume(ebus);
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -166,24 +187,13 @@ static int skl_runtime_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct skl *skl = ebus_to_skl(ebus);
-	int ret;
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
 	/* enable controller wake up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, 0, STATESTS_INT_MASK);
 
-	snd_hdac_ext_bus_link_power_down_all(ebus);
-
-	ret = skl_suspend_dsp(skl);
-	if (ret < 0)
-		return ret;
-
-	snd_hdac_bus_stop_chip(bus);
-	snd_hdac_bus_enter_link_reset(bus);
-
-	return 0;
+	return _skl_suspend(ebus);
 }
 
 static int skl_runtime_resume(struct device *dev)
@@ -204,7 +214,7 @@ static int skl_runtime_resume(struct device *dev)
 	/* disable controller Wake Up event */
 	snd_hdac_chip_updatew(bus, WAKEEN, STATESTS_INT_MASK, 0);
 
-	return skl_resume_dsp(skl);
+	return _skl_resume(ebus);
 }
 #endif /* CONFIG_PM */
 
-- 
2.6.1
