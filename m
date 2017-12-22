From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v4 6/9] ALSA: hdac: remove memory allocation from
	snd_hdac_ext_bus_device_init
Date: Fri, 22 Dec 2017 18:22:49 +0530
Message-ID: <1513947172-28136-7-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513947172-28136-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 04566267919
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 13:48:20 +0100 (CET)
In-Reply-To: <1513947172-28136-1-git-send-email-rakesh.a.ughreja@intel.com>
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

Remove memory allocation within snd_hdac_ext_bus_device_init, to make
its behaviour identical to snd_hdac_bus_device_init. So that caller
can allocate the parent data structure containing hdac_device.
This API change helps in reusing the legacy HDA codec drivers with
ASoC platform drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio_ext.h   | 3 ++-
 sound/hda/ext/hdac_ext_bus.c  | 9 ++-------
 sound/soc/intel/skylake/skl.c | 8 +++++++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 3c30247..c188b80 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -9,7 +9,8 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_io_ops *io_ops);
 
 void snd_hdac_ext_bus_exit(struct hdac_bus *bus);
-int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr);
+int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr,
+						struct hdac_device *hdev);
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev);
 void snd_hdac_ext_bus_device_remove(struct hdac_bus *bus);
 
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 52f0776..e4bcb76 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -135,16 +135,12 @@ static void default_release(struct device *dev)
  *
  * Returns zero for success or a negative error code.
  */
-int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr)
+int snd_hdac_ext_bus_device_init(struct hdac_bus *bus, int addr,
+					struct hdac_device *hdev)
 {
-	struct hdac_device *hdev = NULL;
 	char name[15];
 	int ret;
 
-	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
-	if (!hdev)
-		return -ENOMEM;
-
 	hdev->bus = bus;
 
 	snprintf(name, sizeof(name), "ehdaudio%dD%d", bus->idx, addr);
@@ -175,7 +171,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
 {
 	snd_hdac_device_exit(hdev);
-	kfree(hdev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index ecfe0d3..d8fa403 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -618,6 +618,8 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
+	struct skl *skl = bus_to_skl(bus);
+	struct hdac_device *hdev;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -627,7 +629,11 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
-	return snd_hdac_ext_bus_device_init(bus, addr);
+	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
 }
 
 /* Codec initialization */
-- 
2.7.4
