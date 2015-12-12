From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 10/13] ASoC: Intel: Skylake: enable
	interrupt as wake source in active suspend
Date: Sat, 12 Dec 2015 17:36:30 +0530
Message-ID: <1449921993-21101-11-git-send-email-vinod.koul@intel.com>
References: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 08B64265862
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 13:04:08 +0100 (CET)
In-Reply-To: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

In active suspend, any HDA interrupt should wake the system. When device
enters active suspend, we need to enable HDA controller interrupt as wake
source. Similarly disable HDA controller interrupt as wake source when
exiting active suspend.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index d26bc3b15cd0..68698fa5ed75 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -209,6 +209,7 @@ static int skl_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
 	/*
 	 * Do not suspend if streams which are marked ignore suspend are
@@ -216,6 +217,7 @@ static int skl_suspend(struct device *dev)
 	 */
 	if (skl->supend_active) {
 		snd_hdac_ext_bus_link_power_down_all(ebus);
+		enable_irq_wake(bus->irq);
 		pci_save_state(pci);
 		pci_disable_device(pci);
 		return 0;
@@ -229,6 +231,7 @@ static int skl_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl  = ebus_to_skl(ebus);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int ret;
 
 	/*
@@ -239,6 +242,7 @@ static int skl_resume(struct device *dev)
 		pci_restore_state(pci);
 		ret = pci_enable_device(pci);
 		snd_hdac_ext_bus_link_power_up_all(ebus);
+		disable_irq_wake(bus->irq);
 	} else {
 		ret = _skl_resume(ebus);
 	}
-- 
1.9.1
