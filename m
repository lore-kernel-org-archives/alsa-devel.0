From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v8 6/7] ASoC: Intel: Skylake: use hda_bus
	instead of hdac_bus
Date: Wed, 22 Aug 2018 15:25:02 -0500
Message-ID: <20180822202503.16609-7-pierre-louis.bossart@linux.intel.com>
References: <20180822202503.16609-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8B92676C7
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 22:27:31 +0200 (CEST)
In-Reply-To: <20180822202503.16609-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

Use hda_bus instead of hdac_bus in the SKL ASoC platform driver to enable
reuse of legacy HDA codec drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 11 +++++++++--
 sound/soc/intel/skylake/skl.h | 10 +++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3b836125d1de..5f281d443a53 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -33,6 +33,7 @@
 #include <sound/hda_register.h>
 #include <sound/hdaudio.h>
 #include <sound/hda_i915.h>
+#include <sound/hda_codec.h>
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
@@ -673,7 +674,7 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 	mutex_unlock(&bus->cmd_mutex);
 	if (res == -1)
 		return -EIO;
-	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
+	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
 	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
@@ -816,7 +817,7 @@ static int skl_create(struct pci_dev *pci,
 {
 	struct skl *skl;
 	struct hdac_bus *bus;
-
+	struct hda_bus *hbus;
 	int err;
 
 	*rskl = NULL;
@@ -831,6 +832,7 @@ static int skl_create(struct pci_dev *pci,
 		return -ENOMEM;
 	}
 
+	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
 	bus->use_posbuf = 1;
@@ -838,6 +840,11 @@ static int skl_create(struct pci_dev *pci,
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
index 4105a9371b64..8d48cd7c56c8 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -23,6 +23,7 @@
 
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/hda_codec.h>
 #include <sound/soc.h>
 #include "skl-nhlt.h"
 #include "skl-ssp-clk.h"
@@ -71,7 +72,7 @@ struct skl_fw_config {
 };
 
 struct skl {
-	struct hdac_bus hbus;
+	struct hda_bus hbus;
 	struct pci_dev *pci;
 
 	unsigned int init_done:1; /* delayed init status */
@@ -105,8 +106,11 @@ struct skl {
 	struct snd_soc_acpi_mach *mach;
 };
 
-#define skl_to_bus(s)  (&(s)->hbus)
-#define bus_to_skl(bus) container_of(bus, struct skl, hbus)
+#define skl_to_bus(s)  (&(s)->hbus.core)
+#define bus_to_skl(bus) container_of(bus, struct skl, hbus.core)
+
+#define skl_to_hbus(s) (&(s)->hbus)
+#define hbus_to_skl(hbus) container_of((hbus), struct skl, (hbus))
 
 /* to pass dai dma data */
 struct skl_dma_params {
-- 
2.17.1
