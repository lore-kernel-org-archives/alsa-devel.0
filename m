From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ALSA: hdac: add extended device driver
	registration
Date: Fri, 21 Aug 2015 15:47:42 +0530
Message-ID: <1440152263-24156-4-git-send-email-vinod.koul@intel.com>
References: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1210E2657CA
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 12:15:41 +0200 (CEST)
In-Reply-To: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds new extended driver objects and API for registering the
extended devices.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h  | 15 ++++++++++
 sound/hda/ext/hdac_ext_bus.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 0641d00e2a94..55e2fc36177f 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -173,5 +173,20 @@ struct hdac_ext_device {
 
 #define to_ehdac_device(dev) (container_of((dev), \
 				 struct hdac_ext_device, hdac))
+/*
+ * HD-audio codec base driver
+ */
+struct hdac_ext_driver {
+	struct hdac_driver hdac;
+
+	int	(*probe)(struct hdac_ext_device *dev);
+	int	(*remove)(struct hdac_ext_device *dev);
+	void	(*shutdown)(struct hdac_ext_device *dev);
+};
+
+int snd_hda_ext_driver_register(struct hdac_ext_driver *drv);
+void snd_hda_ext_driver_unregister(struct hdac_ext_driver *drv);
+
+#define to_ehdac_driver(_drv) container_of(_drv, struct hdac_ext_driver, hdac)
 
 #endif /* __SOUND_HDAUDIO_EXT_H */
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 94fb9878f5cb..8544e4fb1cd3 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -196,3 +196,69 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
+#define dev_to_hdac(dev) (container_of((dev), \
+			struct hdac_device, dev))
+
+static inline struct hdac_ext_driver *get_edrv(struct device *dev)
+{
+	struct hdac_driver *hdrv = drv_to_hdac_driver(dev->driver);
+	struct hdac_ext_driver *edrv = to_ehdac_driver(hdrv);
+
+	return edrv;
+}
+
+static inline struct hdac_ext_device *get_edev(struct device *dev)
+{
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
+	struct hdac_ext_device *edev = to_ehdac_device(hdev);
+
+	return edev;
+}
+
+static int hda_ext_drv_probe(struct device *dev)
+{
+	return (get_edrv(dev))->probe(get_edev(dev));
+}
+
+static int hdac_ext_drv_remove(struct device *dev)
+{
+	return (get_edrv(dev))->remove(get_edev(dev));
+}
+
+static void hdac_ext_drv_shutdown(struct device *dev)
+{
+	return (get_edrv(dev))->shutdown(get_edev(dev));
+}
+
+/**
+ * snd_hda_ext_driver_register - register a driver for ext hda devices
+ *
+ * @drv: ext hda driver structure
+ */
+int snd_hda_ext_driver_register(struct hdac_ext_driver *drv)
+{
+	drv->hdac.type = HDA_DEV_ASOC;
+	drv->hdac.driver.bus = &snd_hda_bus_type;
+	/* we use default match */
+
+	if (drv->probe)
+		drv->hdac.driver.probe = hda_ext_drv_probe;
+	if (drv->remove)
+		drv->hdac.driver.remove = hdac_ext_drv_remove;
+	if (drv->shutdown)
+		drv->hdac.driver.shutdown = hdac_ext_drv_shutdown;
+
+	return driver_register(&drv->hdac.driver);
+}
+EXPORT_SYMBOL_GPL(snd_hda_ext_driver_register);
+
+/**
+ * snd_hda_ext_driver_unregister - unregister a driver for ext hda devices
+ *
+ * @drv: ext hda driver structure
+ */
+void snd_hda_ext_driver_unregister(struct hdac_ext_driver *drv)
+{
+	driver_unregister(&drv->hdac.driver);
+}
+EXPORT_SYMBOL_GPL(snd_hda_ext_driver_unregister);
-- 
1.9.1
