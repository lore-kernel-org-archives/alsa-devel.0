From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v1 7/9] ALSA: hdac: add extended ops in the
	hdac_bus
Date: Fri, 23 Feb 2018 13:42:28 +0530
Message-ID: <1519373550-2545-8-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 14CF92678B4
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 09:10:27 +0100 (CET)
In-Reply-To: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
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

Add extended ops in the hdac_bus to allow calling the ASoC HDAC library
ops to reuse the legacy HDA codec drivers with ASoC framework.
Extended ops are used by the legacy codec drivers to call into
hdac_hda library, in the subsequent patches..

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio.h       | 9 +++++++++
 include/sound/hdaudio_ext.h   | 3 ++-
 sound/hda/ext/hdac_ext_bus.c  | 4 +++-
 sound/soc/intel/skylake/skl.c | 2 +-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 01d3103..f30ecb0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -214,6 +214,14 @@ struct hdac_bus_ops {
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
@@ -268,6 +276,7 @@ struct hdac_bus {
 	struct device *dev;
 	const struct hdac_bus_ops *ops;
 	const struct hdac_io_ops *io_ops;
+	const struct hdac_ext_bus_ops *ext_ops;
 
 	/* h/w resources */
 	unsigned long addr;
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
index 1eb5824..9c37d9a 100644
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
index f273b9f..1a5ac1b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -801,7 +801,7 @@ static int skl_create(struct pci_dev *pci,
 
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
-	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops);
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-- 
2.7.4
