From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v2 05/10] ASoC: Intel: Skylake: use hda_bus
	instead of hdac_bus
Date: Fri,  2 Mar 2018 16:22:33 +0530
Message-ID: <1519987958-5482-6-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AF673267CF5
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:26 +0100 (CET)
In-Reply-To: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Use hda_bus instead of hdac_bus in the SKL ASoC platform driver to enable
reuse of legacy HDA codec drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/skylake/skl.c | 10 +++++++++-
 sound/soc/intel/skylake/skl.h | 10 +++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e7f048c..73830ad 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -35,6 +35,7 @@
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
+#include "../../../pci/hda/hda_codec.h"
 
 static struct skl_machine_pdata skl_dmic_data;
 
@@ -638,7 +639,7 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 	mutex_unlock(&bus->cmd_mutex);
 	if (res == -1)
 		return -EIO;
-	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
+	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
 	return snd_hdac_ext_bus_device_init(bus, addr);
 }
@@ -777,6 +778,7 @@ static int skl_create(struct pci_dev *pci,
 {
 	struct skl *skl;
 	struct hdac_bus *bus;
+	struct hda_bus *hbus;
 
 	int err;
 
@@ -792,6 +794,7 @@ static int skl_create(struct pci_dev *pci,
 		return -ENOMEM;
 	}
 
+	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
 	bus->use_posbuf = 1;
@@ -799,6 +802,11 @@ static int skl_create(struct pci_dev *pci,
 	INIT_WORK(&skl->probe_work, skl_probe_work);
 	bus->bdl_pos_adj = 0;
 
+	mutex_init(&hbus->prepare_mutex);
+	hbus->pci = pci;
+	hbus->mixer_assigned = -1;
+	hbus->modelname = "sklbus";
+
 	*rskl = skl;
 
 	return 0;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 6d8c6ef..8a82485 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -26,6 +26,7 @@
 #include <sound/soc.h>
 #include "skl-nhlt.h"
 #include "skl-ssp-clk.h"
+#include "../../../pci/hda/hda_codec.h"
 
 #define SKL_SUSPEND_DELAY 2000
 
@@ -67,7 +68,7 @@ struct skl_fw_config {
 };
 
 struct skl {
-	struct hdac_bus hbus;
+	struct hda_bus hbus;
 	struct pci_dev *pci;
 
 	unsigned int init_done:1; /* delayed init status */
@@ -101,8 +102,11 @@ struct skl {
 	struct snd_soc_acpi_mach *mach;
 };
 
-#define skl_to_bus(s)  (&(s)->hbus)
-#define bus_to_skl(bus) container_of(bus, struct skl, hbus)
+#define skl_to_bus(s)  (&(s)->hbus.core)
+#define bus_to_skl(bus) container_of(bus, struct skl, hbus.core)
+
+#define skl_to_hbus(s) (&(s)->hbus)
+#define hbus_to_skl(hbus) container_of(hbus, struct skl, hbus)
 
 /* to pass dai dma data */
 struct skl_dma_params {
-- 
2.7.4
