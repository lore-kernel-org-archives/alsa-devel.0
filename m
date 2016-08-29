From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 11/12] ALSA: hdac: Implement a match function
Date: Mon, 29 Aug 2016 11:53:25 +0530
Message-ID: <1472451806-10605-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1779E266E64
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:23:44 +0200 (CEST)
In-Reply-To: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
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
 sound/hda/ext/hdac_ext_bus.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index b9593b2..42c2fa6 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -217,6 +217,7 @@ struct hdac_ext_device {
 	struct snd_card *card;
 	void *scodec;
 	void *private_data;
+	const struct hda_device_id *id_entry;
 };
 
 struct hdac_ext_dma_params {
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 31b510c..c5ca488 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -235,6 +235,17 @@ static void hdac_ext_drv_shutdown(struct device *dev)
 	return (get_edrv(dev))->shutdown(get_edev(dev));
 }
 
+static int hdac_ext_drv_match(struct hdac_device *dev, struct hdac_driver *drv)
+{
+	struct hdac_ext_device *edev = get_edev(&dev->dev);
+
+	edev->id_entry = hdac_get_device_id(dev, drv);
+	if (edev->id_entry)
+		return 1;
+	else
+		return 0;
+}
+
 /**
  * snd_hda_ext_driver_register - register a driver for ext hda devices
  *
@@ -244,6 +255,7 @@ int snd_hda_ext_driver_register(struct hdac_ext_driver *drv)
 {
 	drv->hdac.type = HDA_DEV_ASOC;
 	drv->hdac.driver.bus = &snd_hda_bus_type;
+	drv->hdac.match = hdac_ext_drv_match;
 	/* we use default match */
 
 	if (drv->probe)
-- 
1.9.1
