From: mengdong.lin@intel.com
Subject: [PATCH v3 2/5] ALSA: hda - allow a codec to control
	the link power
Date: Wed, 29 Apr 2015 17:43:20 +0800
Message-ID: <c184d52023244b8b86e0e049ad7600cca8188d36.1430300071.git.mengdong.lin@intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A7E2604D1
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:36 +0200 (CEST)
In-Reply-To: <cover.1430300071.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

A flag "link_power_control" is added to indicate whether a codec needs to
control the link power.  And a new bus ops link_power() is defined for the
codec to request to enable/disable the link power.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 6a2e030..b97c59e 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -74,6 +74,7 @@ struct hdac_device {
 
 	/* misc flags */
 	atomic_t in_pm;		/* suspend/resume being performed */
+	bool  link_power_control:1;
 
 	/* sysfs */
 	struct hdac_widget_tree *widgets;
@@ -184,6 +185,8 @@ struct hdac_bus_ops {
 	/* get a response from the last command */
 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
 			    unsigned int *res);
+	/* control the link power  */
+	int (*link_power)(struct hdac_bus *bus, bool enable);
 };
 
 /*
@@ -311,6 +314,7 @@ static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
 int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val);
 int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 			      unsigned int *res);
+int snd_hdac_link_power(struct hdac_device *codec, bool enable);
 
 bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset);
 void snd_hdac_bus_stop_chip(struct hdac_bus *bus);
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 55c7d08..cdee710 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -552,6 +552,21 @@ void snd_hdac_power_down_pm(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
 
+/*
+ * Enable/disable the link power for a codec.
+ */
+int snd_hdac_link_power(struct hdac_device *codec, bool enable)
+{
+	if  (!codec->link_power_control)
+		return 0;
+
+	if  (codec->bus->ops->link_power)
+		return codec->bus->ops->link_power(codec->bus, enable);
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_link_power);
+
 /* codec vendor labels */
 struct hda_vendor_id {
 	unsigned int id;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2d8883f..a85242f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -857,6 +857,7 @@ void snd_hda_codec_register(struct hda_codec *codec)
 		return;
 	if (device_is_registered(hda_codec_dev(codec))) {
 		snd_hda_register_beep_device(codec);
+		snd_hdac_link_power(&codec->core, true);
 		pm_runtime_enable(hda_codec_dev(codec));
 		/* it was powered up in snd_hda_codec_new(), now all done */
 		snd_hda_power_down(codec);
@@ -883,6 +884,7 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	codec->in_freeing = 1;
+	snd_hdac_link_power(&codec->core, false);
 	snd_hdac_device_unregister(&codec->core);
 	put_device(hda_codec_dev(codec));
 	return 0;
@@ -3102,6 +3104,7 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
 	    (state & AC_PWRST_CLK_STOP_OK))
 		snd_hdac_codec_link_down(&codec->core);
+	snd_hdac_link_power(&codec->core, false);
 	return 0;
 }
 
@@ -3109,6 +3112,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
+	snd_hdac_link_power(&codec->core, true);
 	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
-- 
1.9.1
