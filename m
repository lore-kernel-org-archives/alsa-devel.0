From: Xiong Zhang <xiong.y.zhang@intel.com>
Subject: [PATCH] ALSA: hda - Set intel hda controller power at
	freeze() and thaw()
Date: Thu, 17 Dec 2015 14:58:44 +0800
Message-ID: <1450335524-22848-1-git-send-email-xiong.y.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F84D2654B7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 07:52:39 +0100 (CET)
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
Cc: libin.yang@intel.com, han.lu@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

It takes three minutes to enter into hibernation on some OEM SKL
machines and we see many codec spurious response after thaw() opertion.
This is because HDA is still in D0 state after freeze() call and
pci_pm_freeze/pci_pm_freeze_noirq() don't set D3 hot in pci_bus driver.
It seems bios still access HDA when system enter into freeze state,
HDA will receive codec response interrupt immediately after thaw() call.
Because of this unexpected interrupt, HDA enter into a abnormal
state and slow down the system enter into hibernation.

In this patch, we put HDA into D3 hot state in azx_freeze_noirq() and
put HDA into D0 state in azx_thaw_noirq().

Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
---
 sound/pci/hda/hda_intel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c38c68f..3ba7cbc 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -890,6 +890,16 @@ static int azx_suspend(struct device *dev)
 	return 0;
 }
 
+static int azx_freeze_noirq(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+
+	if (pci->vendor == PCI_VENDOR_ID_INTEL)
+		pci_set_power_state(pci, PCI_D3hot);
+
+	return 0;
+}
+
 static int azx_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
@@ -924,6 +934,14 @@ static int azx_resume(struct device *dev)
 	trace_azx_resume(chip);
 	return 0;
 }
+
+static int azx_thaw_noirq(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+
+	if (pci->vendor == PCI_VENDOR_ID_INTEL)
+		pci_set_power_state(pci, PCI_D0);
+}
 #endif /* CONFIG_PM_SLEEP || SUPPORT_VGA_SWITCHEROO */
 
 #ifdef CONFIG_PM
@@ -1035,6 +1053,8 @@ static int azx_runtime_idle(struct device *dev)
 
 static const struct dev_pm_ops azx_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
+	.freeze_noirq = azx_freeze_noirq,
+	.thaw_noirq = azx_thaw_noirq,
 	SET_RUNTIME_PM_OPS(azx_runtime_suspend, azx_runtime_resume, azx_runtime_idle)
 };
 
-- 
1.8.2.1
