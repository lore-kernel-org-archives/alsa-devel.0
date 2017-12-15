From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 3/3] ALSA: hdac: Remove usage of struct
	hdac_ext_driver, use hdac_driver instead
Date: Fri, 15 Dec 2017 17:00:00 +0530
Message-ID: <1513337400-19124-4-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337400-19124-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A93EC267B59
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:25:28 +0100 (CET)
In-Reply-To: <1513337400-19124-1-git-send-email-rakesh.a.ughreja@intel.com>
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

This patch removes the hdac_ext_driver structure. The legacy and
enhanced HDaudio capabilities can be handled in a backwards-compatible
way without separate definitions.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio.h      |  5 +++++
 include/sound/hdaudio_ext.h  | 17 ++---------------
 sound/hda/ext/hdac_ext_bus.c | 30 ++++++++++++++----------------
 sound/soc/codecs/hdac_hdmi.c | 12 +++++-------
 4 files changed, 26 insertions(+), 38 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 25178a33..30ec1b0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -186,6 +186,11 @@ struct hdac_driver {
 	const struct hda_device_id *id_table;
 	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
 	void (*unsol_event)(struct hdac_device *dev, unsigned int event);
+
+	/* fields used by ext bus APIs */
+	int (*probe)(struct hdac_device *dev);
+	int (*remove)(struct hdac_device *dev);
+	void (*shutdown)(struct hdac_device *dev);
 };
 
 #define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index e5b0cd1..3c30247 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -160,20 +160,7 @@ struct hdac_ext_dma_params {
 	u8 stream_tag;
 };
 
-/*
- * HD-audio codec base driver
- */
-struct hdac_ext_driver {
-	struct hdac_driver hdac;
-
-	int	(*probe)(struct hdac_device *dev);
-	int	(*remove)(struct hdac_device *dev);
-	void	(*shutdown)(struct hdac_device *dev);
-};
-
-int snd_hda_ext_driver_register(struct hdac_ext_driver *drv);
-void snd_hda_ext_driver_unregister(struct hdac_ext_driver *drv);
-
-#define to_ehdac_driver(_drv) container_of(_drv, struct hdac_ext_driver, hdac)
+int snd_hda_ext_driver_register(struct hdac_driver *drv);
+void snd_hda_ext_driver_unregister(struct hdac_driver *drv);
 
 #endif /* __SOUND_HDAUDIO_EXT_H */
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 77547ed..52f0776 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -200,12 +200,10 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
 #define dev_to_hdac(dev) (container_of((dev), \
 			struct hdac_device, dev))
 
-static inline struct hdac_ext_driver *get_edrv(struct device *dev)
+static inline struct hdac_driver *get_hdrv(struct device *dev)
 {
 	struct hdac_driver *hdrv = drv_to_hdac_driver(dev->driver);
-	struct hdac_ext_driver *edrv = to_ehdac_driver(hdrv);
-
-	return edrv;
+	return hdrv;
 }
 
 static inline struct hdac_device *get_hdev(struct device *dev)
@@ -216,17 +214,17 @@ static inline struct hdac_device *get_hdev(struct device *dev)
 
 static int hda_ext_drv_probe(struct device *dev)
 {
-	return (get_edrv(dev))->probe(get_hdev(dev));
+	return (get_hdrv(dev))->probe(get_hdev(dev));
 }
 
 static int hdac_ext_drv_remove(struct device *dev)
 {
-	return (get_edrv(dev))->remove(get_hdev(dev));
+	return (get_hdrv(dev))->remove(get_hdev(dev));
 }
 
 static void hdac_ext_drv_shutdown(struct device *dev)
 {
-	return (get_edrv(dev))->shutdown(get_hdev(dev));
+	return (get_hdrv(dev))->shutdown(get_hdev(dev));
 }
 
 /**
@@ -234,20 +232,20 @@ static void hdac_ext_drv_shutdown(struct device *dev)
  *
  * @drv: ext hda driver structure
  */
-int snd_hda_ext_driver_register(struct hdac_ext_driver *drv)
+int snd_hda_ext_driver_register(struct hdac_driver *drv)
 {
-	drv->hdac.type = HDA_DEV_ASOC;
-	drv->hdac.driver.bus = &snd_hda_bus_type;
+	drv->type = HDA_DEV_ASOC;
+	drv->driver.bus = &snd_hda_bus_type;
 	/* we use default match */
 
 	if (drv->probe)
-		drv->hdac.driver.probe = hda_ext_drv_probe;
+		drv->driver.probe = hda_ext_drv_probe;
 	if (drv->remove)
-		drv->hdac.driver.remove = hdac_ext_drv_remove;
+		drv->driver.remove = hdac_ext_drv_remove;
 	if (drv->shutdown)
-		drv->hdac.driver.shutdown = hdac_ext_drv_shutdown;
+		drv->driver.shutdown = hdac_ext_drv_shutdown;
 
-	return driver_register(&drv->hdac.driver);
+	return driver_register(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(snd_hda_ext_driver_register);
 
@@ -256,8 +254,8 @@ EXPORT_SYMBOL_GPL(snd_hda_ext_driver_register);
  *
  * @drv: ext hda driver structure
  */
-void snd_hda_ext_driver_unregister(struct hdac_ext_driver *drv)
+void snd_hda_ext_driver_unregister(struct hdac_driver *drv)
 {
-	driver_unregister(&drv->hdac.driver);
+	driver_unregister(&drv->driver);
 }
 EXPORT_SYMBOL_GPL(snd_hda_ext_driver_unregister);
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index a8c6d0f..e467ebb 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2172,14 +2172,12 @@ static const struct hda_device_id hdmi_list[] = {
 
 MODULE_DEVICE_TABLE(hdaudio, hdmi_list);
 
-static struct hdac_ext_driver hdmi_driver = {
-	. hdac = {
-		.driver = {
-			.name   = "HDMI HDA Codec",
-			.pm = &hdac_hdmi_pm,
-		},
-		.id_table       = hdmi_list,
+static struct hdac_driver hdmi_driver = {
+	.driver = {
+		.name   = "HDMI HDA Codec",
+		.pm = &hdac_hdmi_pm,
 	},
+	.id_table       = hdmi_list,
 	.probe          = hdac_hdmi_dev_probe,
 	.remove         = hdac_hdmi_dev_remove,
 };
-- 
2.7.4
