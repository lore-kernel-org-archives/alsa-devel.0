From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 17/17] ASoC: Intel: Skylake: Fix PM behaviour
Date: Tue, 27 Oct 2015 09:23:00 +0900
Message-ID: <1445905380-18167-18-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A4D265473
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:24:13 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

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
---
 sound/soc/intel/skylake/skl.c | 60 +++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 211ef6e2fa21..9b94a8cdf9bd 100644
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
2.4.3
