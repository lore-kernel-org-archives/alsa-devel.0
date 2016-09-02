From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 10/11] ALSA: hdac: Implement a match function
Date: Fri,  2 Sep 2016 16:34:59 +0530
Message-ID: <1472814300-5629-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 169DB26809A
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:59 +0200 (CEST)
In-Reply-To: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Ext driver match function will be used to apply any hdac device
specific quirks.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h  |  1 +
 sound/hda/ext/hdac_ext_bus.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 2113765..c182114 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -248,6 +248,7 @@ struct hdac_ext_device {
 	void *private_data;
 
 	struct list_head widget_list;
+	const struct hda_device_id *id_entry;
 };
 
 struct hdac_ext_dma_params {
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 85ccc18..f156884 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -246,6 +246,18 @@ static void hdac_ext_drv_shutdown(struct device *dev)
 	return (get_edrv(dev))->shutdown(get_edev(dev));
 }
 
+static int hdac_ext_drv_match(struct hdac_device *dev, struct hdac_driver *drv)
+{
+	struct hdac_ext_device *edev = get_edev(&dev->dev);
+	const struct hda_device_id *id_entry = hdac_get_device_id(dev, drv);
+
+	if (id_entry) {
+		edev->id_entry = id_entry;
+		return 1;
+	} else
+		return 0;
+}
+
 /**
  * snd_hda_ext_driver_register - register a driver for ext hda devices
  *
@@ -255,6 +267,7 @@ int snd_hda_ext_driver_register(struct hdac_ext_driver *drv)
 {
 	drv->hdac.type = HDA_DEV_ASOC;
 	drv->hdac.driver.bus = &snd_hda_bus_type;
+	drv->hdac.match = hdac_ext_drv_match;
 	/* we use default match */
 
 	if (drv->probe)
-- 
1.9.1
