From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v2 07/10] ALSA: hdac: remove memory allocation
	from snd_hdac_ext_bus_device_init
Date: Fri,  2 Mar 2018 16:22:35 +0530
Message-ID: <1519987958-5482-8-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3240F267D24
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:29 +0100 (CET)
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

Remove memory allocation within snd_hdac_ext_bus_device_init, to make
its behaviour identical to snd_hdac_bus_device_init. So that caller
can allocate the parent data structure containing hdac_device.
This API change helps in reusing the legacy HDA codec drivers with
ASoC platform drivers.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio_ext.h   | 3 ++-
 sound/hda/ext/hdac_ext_bus.c  | 8 ++------
 sound/soc/intel/skylake/skl.c | 8 +++++++-
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index 52f0776..1eb5824 100644
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
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 73830ad..eea8b2e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -632,6 +632,8 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
+	struct skl *skl = bus_to_skl(bus);
+	struct hdac_device *hdev;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -641,7 +643,11 @@ static int probe_codec(struct hdac_bus *bus, int addr)
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
