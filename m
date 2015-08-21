From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ALSA: hdac: Add API for removing hdac
	extended device
Date: Fri, 21 Aug 2015 15:47:40 +0530
Message-ID: <1440152263-24156-2-git-send-email-vinod.koul@intel.com>
References: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F25B2657B1
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 12:15:37 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The HDAC extended device objects are created by HDAC extended bus on probe.
When controller is removed they should be removed as well, so add API
snd_hdac_ext_bus_device_remove for this

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h  |  1 +
 sound/hda/ext/hdac_ext_bus.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 0f89df1511dc..148267b76ab7 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -34,6 +34,7 @@ int snd_hdac_ext_bus_init(struct hdac_ext_bus *sbus, struct device *dev,
 void snd_hdac_ext_bus_exit(struct hdac_ext_bus *sbus);
 int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *sbus, int addr);
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev);
+void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus);
 
 #define ebus_to_hbus(ebus)	(&(ebus)->bus)
 #define hbus_to_ebus(_bus) \
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 0aa5d9eb6c3f..cf69202f7da0 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -172,3 +172,22 @@ void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
 	kfree(hdev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
+
+/**
+ * snd_hdac_ext_bus_device_remove - remove HD-audio extended codec base devices
+ *
+ * @ebus: HD-audio extended bus
+ */
+void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus)
+{
+	struct hdac_device *codec, *__codec;
+	/*
+	 * we need to remove all the codec devices objects created in the
+	 * snd_hdac_ext_bus_device_init
+	 */
+	list_for_each_entry_safe(codec, __codec, &ebus->bus.codec_list, list) {
+		snd_hdac_device_unregister(codec);
+		put_device(&codec->dev);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_remove);
-- 
1.9.1
