From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH V2] ASoC: hdac_hdmi: add device PM
 dependency
Date: Wed, 3 Apr 2019 02:01:03 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952812DD3@SHSMSX103.ccr.corp.intel.com>
References: <1554194132-2177-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02CA3F8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 04:01:08 +0200 (CEST)
In-Reply-To: <1554194132-2177-1-git-send-email-libin.yang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi all,

Or if we can assume that consumer will definitely call  
hdac_hdmi_device_link_del() itself, the patch can be simplified.

I attach the simplified version of the patch. I'm not sure which is better.

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 5eeb0fe..346e8e5 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1792,6 +1792,49 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);

+/**
+ * hdac_hdmi_device_link_add - add a link between consumer and hdev device
+ * @consumer: Consumer end of the link.
+ * @component: The hdmi codec component.
+ * @flags: Link flags.
+ *
+ * If there is a consumer of the hdev device, which means a consumer device
+ * operation depends on the hdev device power status, the consumer device
+ * driver should call this function. It supports several consumers depending
+ * on the same hdmi codec hdev device.
+ *
+ * Return: pointer of device_link, or NULL if fails to create device_link
+ */
+struct device_link *
+hdac_hdmi_device_link_add(struct device *consumer,
+                         struct snd_soc_component *component,
+                         u32 flags)
+{
+       struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+       struct hdac_device *hdev = hdmi->hdev;
+
+       return device_link_add(consumer, &hdev->dev, flags);
+}
+EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_add);
+
+/**
+ * hdac_hdmi_device_link_del - del the link between consumer and hdev device
+ * @consumer: Consumer end of the link.
+ * @component: The hdmi codec component.
+ *
+ * If the consumer doesn't need the dependency any longer, the consumer device
+ * driver should call this function to release the device_link
+ */
+void hdac_hdmi_device_link_del(struct device *consumer,
+                              struct snd_soc_component *component)
+{
+       struct hdac_hdmi_priv *hdmi = snd_soc_component_get_drvdata(component);
+       struct hdac_device *hdev = hdmi->hdev;
+
+       device_link_remove(consumer, &hdev->dev);
+}
+EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_del);
+
 static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
                        struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
 {
diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
index 4fa2fc9..e877167 100644
--- a/sound/soc/codecs/hdac_hdmi.h
+++ b/sound/soc/codecs/hdac_hdmi.h
@@ -7,4 +7,11 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,

 int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
                        struct snd_soc_dapm_context *dapm);
+
+struct device_link *
+hdac_hdmi_device_link_add(struct device *consumer,
+                         struct snd_soc_component *component,
+                         u32 flags);
+void hdac_hdmi_device_link_del(struct device *consumer,
+                              struct snd_soc_component *component);
 #endif /* __HDAC_HDMI_H__ */
--
2.7.4

Regards,
Libin


>-----Original Message-----
>From: Yang, Libin
>Sent: Tuesday, April 2, 2019 4:36 PM
>To: alsa-devel@alsa-project.org; tiwai@suse.de; broonie@kernel.org; pierre-
>louis.bossart@linux.intel.com
>Cc: Yang, Libin <libin.yang@intel.com>
>Subject: [alsa-devel] [RFC PATCH V2] ASoC: hdac_hdmi: add device PM
>dependency
>
>From: Libin Yang <libin.yang@intel.com>
>
>HDMI audio codec register operation depends on the display audio power
>domain. The hdmi audio codec dapm event callback must be called after
>display audio power is turned on.
>
>Add hdac_hdmi_device_link_add/del() in HDMI audio codec driver. The
>customer audio driver, such as cAVS/SST and SOF audio driver, can call the
>function to set/remove the audio power dependency.
>
>Signed-off-by: Libin Yang <libin.yang@intel.com>
>---
> sound/soc/codecs/hdac_hdmi.c | 86
>++++++++++++++++++++++++++++++++++++++++++++
> sound/soc/codecs/hdac_hdmi.h |  7 ++++
> 2 files changed, 93 insertions(+)
>
>diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
>index 5eeb0fe..7490219 100644
>--- a/sound/soc/codecs/hdac_hdmi.c
>+++ b/sound/soc/codecs/hdac_hdmi.c
>@@ -133,6 +133,12 @@ struct hdac_hdmi_drv_data {
> 	int port_num;
> };
>
>+/* each supplier - consumer pair has one instance of this structure */
>+struct hdac_hdmi_dev_link {
>+	struct list_head head;
>+	struct device_link *link;
>+};
>+
> struct hdac_hdmi_priv {
> 	struct hdac_device *hdev;
> 	struct snd_soc_component *component;
>@@ -141,10 +147,12 @@ struct hdac_hdmi_priv {
> 	struct list_head pin_list;
> 	struct list_head cvt_list;
> 	struct list_head pcm_list;
>+	struct list_head link_list;	/* supplier - consumer pairs */
> 	int num_pin;
> 	int num_cvt;
> 	int num_ports;
> 	struct mutex pin_mutex;
>+	struct mutex link_mutex;
> 	struct hdac_chmap chmap;
> 	struct hdac_hdmi_drv_data *drv_data;
> 	struct snd_soc_dai_driver *dai_drv;
>@@ -1792,6 +1800,72 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai,
>int device,  }  EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
>
>+/**
>+ * hdac_hdmi_device_link_add - add a link between consumer and hdev
>+device
>+ * @consumer: Consumer end of the link.
>+ * @component: The hdmi codec component.
>+ * @flags: Link flags.
>+ *
>+ * If there is a consumer of the hdev device, which means a consumer
>+device
>+ * operation depends on the hdev device power status, the consumer
>+device
>+ * driver should call this function. It supports several consumers
>+depending
>+ * on the same hdmi codec hdev device.
>+ *
>+ * Return: pointer of device_link, or NULL if fails to create
>+device_link  */ struct device_link * hdac_hdmi_device_link_add(struct
>+device *consumer,
>+			  struct snd_soc_component *component,
>+			  u32 flags)
>+{
>+	struct hdac_hdmi_priv *hdmi =
>snd_soc_component_get_drvdata(component);
>+	struct hdac_device *hdev = hdmi->hdev;
>+	struct hdac_hdmi_dev_link *dev_link;
>+
>+	dev_link = devm_kzalloc(&hdev->dev, sizeof(*dev_link), GFP_KERNEL);
>+	if (!dev_link)
>+		return NULL;
>+
>+	dev_link->link = device_link_add(consumer, &hdev->dev, flags);
>+
>+	mutex_lock(&hdmi->link_mutex);
>+	if (dev_link->link)
>+		list_add(&dev_link->head, &hdmi->link_list);
>+	mutex_unlock(&hdmi->link_mutex);
>+
>+	return dev_link->link;
>+}
>+EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_add);
>+
>+/**
>+ * hdac_hdmi_device_link_del - del the link between consumer and hdev
>+device
>+ * @consumer: Consumer end of the link.
>+ * @component: The hdmi codec component.
>+ *
>+ * If the consumer doesn't need the dependency any longer, the consumer
>+device
>+ * driver should call this function to release the device_link  */ void
>+hdac_hdmi_device_link_del(struct device *consumer,
>+			       struct snd_soc_component *component) {
>+	struct hdac_hdmi_priv *hdmi =
>snd_soc_component_get_drvdata(component);
>+	struct hdac_device *hdev = hdmi->hdev;
>+	struct hdac_hdmi_dev_link *dev_link, *tmp;
>+
>+	mutex_lock(&hdmi->link_mutex);
>+	list_for_each_entry_safe(dev_link, tmp, &hdmi->link_list, head) {
>+		if (dev_link->link->consumer == consumer &&
>+		    dev_link->link->supplier == &hdev->dev) {
>+			device_link_del(dev_link->link);
>+			list_del(&dev_link->head);
>+			devm_kfree(&hdev->dev, dev_link);
>+			return;
>+		}
>+	}
>+	mutex_unlock(&hdmi->link_mutex);
>+}
>+EXPORT_SYMBOL_GPL(hdac_hdmi_device_link_del);
>+
> static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
> 			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
>{ @@ -2031,7 +2105,9 @@ static int hdac_hdmi_dev_probe(struct
>hdac_device *hdev)
> 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
> 	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
> 	INIT_LIST_HEAD(&hdmi_priv->pcm_list);
>+	INIT_LIST_HEAD(&hdmi_priv->link_list);
> 	mutex_init(&hdmi_priv->pin_mutex);
>+	mutex_init(&hdmi_priv->link_mutex);
>
> 	/*
> 	 * Turned off in the runtime_suspend during the first explicit @@ -
>2058,8 +2134,18 @@ static int hdac_hdmi_dev_probe(struct hdac_device
>*hdev)
>
> static int hdac_hdmi_dev_remove(struct hdac_device *hdev)  {
>+	struct hdac_hdmi_dev_link *dev_link, *tmp;
>+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
>+
> 	snd_hdac_display_power(hdev->bus, hdev->addr, false);
>
>+	mutex_unlock(&hdmi->link_mutex);
>+	list_for_each_entry_safe(dev_link, tmp, &hdmi->link_list, head) {
>+		device_link_del(dev_link->link);
>+		list_del(&dev_link->head);
>+	}
>+	mutex_unlock(&hdmi->link_mutex);
>+
> 	return 0;
> }
>
>diff --git a/sound/soc/codecs/hdac_hdmi.h b/sound/soc/codecs/hdac_hdmi.h
>index 4fa2fc9..e877167 100644
>--- a/sound/soc/codecs/hdac_hdmi.h
>+++ b/sound/soc/codecs/hdac_hdmi.h
>@@ -7,4 +7,11 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int pcm,
>
> int hdac_hdmi_jack_port_init(struct snd_soc_component *component,
> 			struct snd_soc_dapm_context *dapm);
>+
>+struct device_link *
>+hdac_hdmi_device_link_add(struct device *consumer,
>+			  struct snd_soc_component *component,
>+			  u32 flags);
>+void hdac_hdmi_device_link_del(struct device *consumer,
>+			       struct snd_soc_component *component);
> #endif /* __HDAC_HDMI_H__ */
>--
>2.7.4
