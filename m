From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 10/13] ALSA: hdac: add extended ops in the
	hdac_bus
Date: Fri,  1 Jun 2018 22:53:58 -0500
Message-ID: <20180602035401.26934-11-pierre-louis.bossart@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4853B26785C
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:21 +0200 (CEST)
In-Reply-To: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

Add extended ops in the hdac_bus to allow calling the ASoC HDAC library
ops to reuse the legacy HDA codec drivers with ASoC framework.
Extended ops are used by the legacy codec drivers to call into
hdac_hda library, in the subsequent patches..

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hdaudio.h       | 9 +++++++++
 include/sound/hdaudio_ext.h   | 3 ++-
 sound/hda/ext/hdac_ext_bus.c  | 4 +++-
 sound/soc/intel/skylake/skl.c | 2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 62dd486e7d48..78dd64f2672f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -213,6 +213,14 @@ struct hdac_bus_ops {
 	int (*link_power)(struct hdac_bus *bus, bool enable);
 };
 
+/*
+ * ops used for ASoC HDA codec drivers
+ */
+struct hdac_ext_bus_ops {
+	int (*hdev_attach)(struct hdac_device *hdev);
+	int (*hdev_detach)(struct hdac_device *hdev);
+};
+
 /*
  * Lowlevel I/O operators
  */
@@ -265,6 +273,7 @@ struct hdac_bus {
 	struct device *dev;
 	const struct hdac_bus_ops *ops;
 	const struct hdac_io_ops *io_ops;
+	const struct hdac_ext_bus_ops *ext_ops;
 
 	/* h/w resources */
 	unsigned long addr;
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index c188b801239f..f34aced69ca8 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -6,7 +6,8 @@
 
 int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_bus_ops *ops,
-		      const struct hdac_io_ops *io_ops);
+		      const struct hdac_io_ops *io_ops,
+		      const struct hdac_ext_bus_ops *ext_ops);
 
 void snd_hdac_ext_bus_exit(struct hdac_bus *bus);
 int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr,
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 1eb58244688e..9c37d9af3023 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -89,7 +89,8 @@ static const struct hdac_io_ops hdac_ext_default_io = {
  */
 int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 			const struct hdac_bus_ops *ops,
-			const struct hdac_io_ops *io_ops)
+			const struct hdac_io_ops *io_ops,
+			const struct hdac_ext_bus_ops *ext_ops)
 {
 	int ret;
 	static int idx;
@@ -102,6 +103,7 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	bus->ext_ops = ext_ops;
 	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->idx = idx++;
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index b0f509c89ded..0285b2bdedc9 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -832,7 +832,7 @@ static int skl_create(struct pci_dev *pci,
 
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
-	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-- 
2.14.1
