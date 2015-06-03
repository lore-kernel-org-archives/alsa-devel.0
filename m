From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 1/2] ALSA: hda - add HDA default codec match
	function
Date: Wed,  3 Jun 2015 12:24:31 +0530
Message-ID: <1433314472-24965-2-git-send-email-vinod.koul@intel.com>
References: <1433314472-24965-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AD87E2604EB
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 08:53:21 +0200 (CEST)
In-Reply-To: <1433314472-24965-1-git-send-email-vinod.koul@intel.com>
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

HDA codec drivers can be matched using vendor id and revision id typically.
So provide a match function which does this and is loaded when driver hasn't
provided one (default behaviour)

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h  | 14 ++++++++++++++
 sound/hda/hda_bus_type.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 64fff4db81bb..4caf1fde8a4f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -28,6 +28,16 @@ struct hdac_widget_tree;
 extern struct bus_type snd_hda_bus_type;
 
 /*
+ * HDA device table
+ */
+struct hda_device_id {
+	__u32 vendor_id;
+	__u32 rev_id;
+	const char *name;
+	unsigned long driver_data;
+};
+
+/*
  * generic arrays
  */
 struct snd_array {
@@ -171,12 +181,16 @@ static inline void snd_hdac_power_down_pm(struct hdac_device *codec) {}
 struct hdac_driver {
 	struct device_driver driver;
 	int type;
+	const struct hda_device_id *id_table;
 	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
 	void (*unsol_event)(struct hdac_device *dev, unsigned int event);
 };
 
 #define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
 
+const struct hda_device_id *
+hdac_get_device_id(struct hdac_device *hdev, struct hdac_driver *drv);
+
 /*
  * Bus verb operators
  */
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 519914a12e8a..89c2711baaaf 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -10,6 +10,40 @@
 MODULE_DESCRIPTION("HD-audio bus");
 MODULE_LICENSE("GPL");
 
+/**
+ * hdac_get_device_id - gets the hdac device id entry
+ * @hdev: HD-audio core device
+ * @drv: HD-audio codec driver
+ *
+ * Compares the hdac device vendor_id and revision_id to the hdac_device
+ * driver id_table and returns the matching device id entry.
+ */
+const struct hda_device_id *
+hdac_get_device_id(struct hdac_device *hdev, struct hdac_driver *drv)
+{
+	if (drv->id_table) {
+		const struct hda_device_id *id  = drv->id_table;
+
+		while (id->vendor_id) {
+			if (hdev->vendor_id == id->vendor_id &&
+				(!id->rev_id || id->rev_id == hdev->revision_id))
+				return id;
+			id++;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(hdac_get_device_id);
+
+static int hdac_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
+{
+	if (hdac_get_device_id(dev, drv))
+		return 1;
+	else
+		return 0;
+}
+
 static int hda_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
@@ -17,8 +51,15 @@ static int hda_bus_match(struct device *dev, struct device_driver *drv)
 
 	if (hdev->type != hdrv->type)
 		return 0;
+
+	/*
+	 * if driver provided a match function use that otherwise we will
+	 * use hdac_codec_match function
+	 */
 	if (hdrv->match)
 		return hdrv->match(hdev, hdrv);
+	else
+		return hdac_codec_match(hdev, hdrv);
 	return 1;
 }
 
-- 
1.9.1
