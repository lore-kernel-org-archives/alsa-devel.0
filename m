From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v5 7/9] ALSA: hdac: add bus type and extended ops
	support in hdac_bus
Date: Wed,  3 Jan 2018 10:26:20 +0530
Message-ID: <1514955382-742-8-git-send-email-rakesh.a.ughreja@intel.com>
References: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C7A5F267603
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 05:53:27 +0100 (CET)
In-Reply-To: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
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

Add add bus type field in hdac_bus structure to distinguish the
bus instance. Bus allocated using snd_hdac_bus_init API sets the bus
type to HDA_BUS_LEGACY and snd_hdac_ext_bus_init API sets it to
HDA_BUS_EXT. codec drivers can identify the bus type by calling
snd_hdac_get_bus_type API.

Extended ops are used by the legacy codec drivers to call into
hdac_hda library, in the subsequent patches..

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio.h       | 24 ++++++++++++++++++++++++
 include/sound/hdaudio_ext.h   |  3 ++-
 sound/hda/ext/hdac_ext_bus.c  |  5 ++++-
 sound/hda/hdac_bus.c          |  1 +
 sound/soc/intel/skylake/skl.c |  2 +-
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 30ec1b0..44e5514 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -97,6 +97,12 @@ enum {
 	HDA_DEV_ASOC,
 };
 
+enum {
+	HDA_BUS_INVALID,
+	HDA_BUS_LEGACY,
+	HDA_BUS_EXT,
+};
+
 /* direction */
 enum {
 	HDA_INPUT, HDA_OUTPUT
@@ -212,6 +218,14 @@ struct hdac_bus_ops {
 };
 
 /*
+ * ops used for ASoC HDA codec drivers
+ */
+struct hdac_ext_bus_ops {
+	int (*probe)(struct hdac_device *hdev);
+	int (*remove)(struct hdac_device *hdev);
+};
+
+/*
  * Lowlevel I/O operators
  */
 struct hdac_io_ops {
@@ -265,8 +279,10 @@ struct hdac_rb {
  */
 struct hdac_bus {
 	struct device *dev;
+	int type;
 	const struct hdac_bus_ops *ops;
 	const struct hdac_io_ops *io_ops;
+	const struct hdac_ext_bus_ops *ext_ops;
 
 	/* h/w resources */
 	unsigned long addr;
@@ -341,6 +357,14 @@ struct hdac_bus {
 
 };
 
+static inline int snd_hdac_get_bus_type(struct hdac_bus *bus)
+{
+	if (bus)
+		return bus->type;
+	else
+		return HDA_BUS_INVALID;
+}
+
 int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_bus_ops *ops,
 		      const struct hdac_io_ops *io_ops);
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index c188b80..f34aced 100644
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
index e4bcb76..b68ef25 100644
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
@@ -102,6 +103,8 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	bus->type = HDA_BUS_EXT;
+	bus->ext_ops = ext_ops;
 	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->idx = idx++;
 
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 714a517..bb7567d 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -35,6 +35,7 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	else
 		bus->ops = &default_ops;
 	bus->io_ops = io_ops;
+	bus->type = HDA_BUS_LEGACY;
 	INIT_LIST_HEAD(&bus->stream_list);
 	INIT_LIST_HEAD(&bus->codec_list);
 	INIT_WORK(&bus->unsol_work, process_unsol_events);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3aaf294..712865f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -799,7 +799,7 @@ static int skl_create(struct pci_dev *pci,
 
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
-	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-- 
2.7.4
