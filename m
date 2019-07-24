From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: Use dev_get_drvdata where possible
Date: Wed, 24 Jul 2019 21:17:25 +0800
Message-ID: <20190724131725.1655-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: alsa-devel@alsa-project.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/intel/skylake/skl-nhlt.c |  3 +--
 sound/soc/intel/skylake/skl.c      | 12 ++++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 1132109cb992..46d9977224d1 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -241,8 +241,7 @@ int skl_nhlt_update_topology_bin(struct skl *skl)
 static ssize_t skl_nhlt_platform_id_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct skl *skl = bus_to_skl(bus);
 	struct nhlt_acpi_table *nhlt = (struct nhlt_acpi_table *)skl->nhlt;
 	char platform_id[32];
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3362e71b4563..1f625fc65307 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -141,8 +141,7 @@ static int skl_init_chip(struct hdac_bus *bus, bool full_reset)
 
 void skl_update_d0i3c(struct device *dev, bool enable)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	u8 reg;
 	int timeout = 50;
 
@@ -274,8 +273,7 @@ static int skl_acquire_irq(struct hdac_bus *bus, int do_disconnect)
 
 static int skl_suspend_late(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 	struct skl *skl = bus_to_skl(bus);
 
 	return skl_suspend_late_dsp(skl);
@@ -400,8 +398,7 @@ static int skl_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int skl_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
@@ -410,8 +407,7 @@ static int skl_runtime_suspend(struct device *dev)
 
 static int skl_runtime_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
-	struct hdac_bus *bus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = dev_get_drvdata(dev);
 
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
-- 
2.20.1
