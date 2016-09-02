From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 01/11] ALSA: hdac: Add codec helper library
Date: Fri,  2 Sep 2016 16:34:50 +0530
Message-ID: <1472814300-5629-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD82267791
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:10:40 +0200 (CEST)
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

Add hdac helpers to enumerate the HDA widgets and fill connection
lists for each. During ext device init, these helpers are used to
parse the HDA codec for the widgets and cache them in a list.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h    |  31 ++++++++
 sound/hda/ext/Makefile         |   3 +-
 sound/hda/ext/hdac_ext_bus.c   |   6 ++
 sound/hda/ext/hdac_ext_codec.c | 156 +++++++++++++++++++++++++++++++++++++++++
 sound/hda/ext/hdac_ext_codec.h |  26 +++++++
 5 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 sound/hda/ext/hdac_ext_codec.c
 create mode 100644 sound/hda/ext/hdac_ext_codec.h

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index b9593b2..5be7a59 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -193,6 +193,35 @@ struct hda_dai_map {
 };
 
 #define HDA_MAX_NIDS 16
+#define HDA_MAX_CONNECTIONS 32
+/* amp values */
+#define AMP_IN_MUTE(idx)	(0x7080 | ((idx)<<8))
+#define AMP_IN_UNMUTE(idx)	(0x7000 | ((idx)<<8))
+#define AMP_OUT_MUTE		0xb080
+#define AMP_OUT_UNMUTE		0xb000
+
+
+struct hdac_ext_codec_widget;
+
+struct hdac_ext_codec_connection_list {
+	hda_nid_t nid;
+	unsigned int type;
+	struct hdac_ext_codec_widget *input_w;
+};
+
+/**
+ * struct hdac_ext_device - HDAC Ext device
+ */
+struct hdac_ext_codec_widget {
+	struct list_head head;
+	hda_nid_t nid;
+	unsigned int caps;
+	unsigned int type;
+	int num_inputs;
+	struct hdac_ext_codec_connection_list conn_list[HDA_MAX_CONNECTIONS];
+	void *priv;	/* Codec specific widget data */
+	void *params;	/* Widget specific parameters */
+};
 
 /**
  * struct hdac_ext_device - HDAC Ext device
@@ -217,6 +246,8 @@ struct hdac_ext_device {
 	struct snd_card *card;
 	void *scodec;
 	void *private_data;
+
+	struct list_head widget_list;
 };
 
 struct hdac_ext_dma_params {
diff --git a/sound/hda/ext/Makefile b/sound/hda/ext/Makefile
index 9b6f641..d728120 100644
--- a/sound/hda/ext/Makefile
+++ b/sound/hda/ext/Makefile
@@ -1,3 +1,4 @@
-snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o hdac_ext_stream.o
+snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o hdac_ext_stream.o \
+			hdac_ext_codec.o
 
 obj-$(CONFIG_SND_HDA_EXT_CORE) += snd-hda-ext-core.o
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 31b510c..fe25771 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <sound/hdaudio_ext.h>
+#include "hdac_ext_codec.h"
 
 MODULE_DESCRIPTION("HDA extended core");
 MODULE_LICENSE("GPL v2");
@@ -128,6 +129,7 @@ static void default_release(struct device *dev)
 	snd_hdac_ext_bus_device_exit(container_of(dev, struct hdac_device, dev));
 }
 
+
 /**
  * snd_hdac_ext_bus_device_init - initialize the HDA extended codec base device
  * @ebus: hdac extended bus to attach to
@@ -159,6 +161,9 @@ int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
 	hdev->type = HDA_DEV_ASOC;
 	hdev->dev.release = default_release;
 
+	INIT_LIST_HEAD(&edev->widget_list);
+	snd_hdac_ext_parse_widgets(edev);
+
 	ret = snd_hdac_device_register(hdev);
 	if (ret) {
 		dev_err(bus->dev, "failed to register hdac device\n");
@@ -178,6 +183,7 @@ void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
 {
 	struct hdac_ext_device *edev = to_ehdac_device(hdev);
 
+	snd_hdac_ext_codec_cleanup(edev);
 	snd_hdac_device_exit(hdev);
 	kfree(edev);
 }
diff --git a/sound/hda/ext/hdac_ext_codec.c b/sound/hda/ext/hdac_ext_codec.c
new file mode 100644
index 0000000..07b77c8
--- /dev/null
+++ b/sound/hda/ext/hdac_ext_codec.c
@@ -0,0 +1,156 @@
+/*
+ *  hdac_codec.c - HDA codec library
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <sound/hdaudio_ext.h>
+#include "../../hda/local.h"
+#include "hdac_ext_codec.h"
+#include <sound/hda_verbs.h>
+
+static int hdac_generic_query_connlist(struct hdac_device *hdac,
+				struct hdac_ext_codec_widget *wid)
+{
+	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+	unsigned int caps;
+	int i;
+
+	if (!(get_wcaps(hdac, wid->nid) & AC_WCAP_CONN_LIST)) {
+		dev_dbg(&hdac->dev,
+			"HDAC: wid %d wcaps %#x doesn't support connection list\n",
+			wid->nid, get_wcaps(hdac, wid->nid));
+
+		return 0;
+	}
+
+	wid->num_inputs = snd_hdac_get_connections(hdac, wid->nid,
+					mux_nids, HDA_MAX_CONNECTIONS);
+
+	if (wid->num_inputs == 0) {
+		dev_warn(&hdac->dev, "No connections found for wid: %d\n",
+							wid->nid);
+		return 0;
+	}
+
+	for (i = 0; i < wid->num_inputs; i++) {
+		wid->conn_list[i].nid = mux_nids[i];
+		caps = get_wcaps(hdac, mux_nids[i]);
+		wid->conn_list[i].type = get_wcaps_type(caps);
+	}
+
+	dev_dbg(&hdac->dev, "num_inputs %d for wid: %d\n",
+			wid->num_inputs, wid->nid);
+
+	return wid->num_inputs;
+}
+
+static int hdac_codec_add_widget(struct hdac_ext_device *edev, hda_nid_t nid,
+					unsigned int type, unsigned int caps)
+{
+	struct hdac_device *codec = &edev->hdac;
+	struct hdac_ext_codec_widget *widget;
+	unsigned int *cfg;
+
+	widget = kzalloc(sizeof(*widget), GFP_KERNEL);
+	if (!widget)
+		return -ENOMEM;
+
+	widget->nid = nid;
+	widget->type = type;
+	widget->caps = caps;
+	list_add_tail(&widget->head, &edev->widget_list);
+
+	if (type == AC_WID_PIN) {
+		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+		if (!cfg)
+			return -ENOMEM;
+
+		*cfg = snd_hdac_codec_read(codec, nid, 0,
+					AC_VERB_GET_CONFIG_DEFAULT, 0);
+		widget->params = cfg;
+	}
+
+	return hdac_generic_query_connlist(codec, widget);
+}
+
+int snd_hdac_ext_parse_widgets(struct hdac_ext_device *edev)
+{
+	struct hdac_device *hdac = &edev->hdac;
+	hda_nid_t nid;
+	int num_nodes, i;
+	struct hdac_ext_codec_widget *wid;
+	struct hdac_ext_codec_widget *tmp;
+	int ret = 0;
+
+	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
+	if (!nid || num_nodes <= 0) {
+		dev_err(&hdac->dev, "HDAC: failed to get afg sub nodes\n");
+		return -EINVAL;
+	}
+	hdac->num_nodes = num_nodes;
+	hdac->start_nid = nid;
+
+	for (i = 0; i < hdac->num_nodes; i++, nid++) {
+		unsigned int caps;
+		unsigned int type;
+
+		caps = get_wcaps(hdac, nid);
+		type = get_wcaps_type(caps);
+
+		ret = hdac_codec_add_widget(edev, nid, type, caps);
+		if (ret < 0)
+			goto fail_add_widget;
+
+	}
+
+	hdac->end_nid = nid;
+
+	/* Cache input connection to a widget */
+	list_for_each_entry(wid, &edev->widget_list, head) {
+		if (!wid->num_inputs)
+			continue;
+
+		for (i = 0; i < wid->num_inputs; i++) {
+			list_for_each_entry(tmp, &edev->widget_list, head) {
+				if (wid->conn_list[i].nid == tmp->nid) {
+					wid->conn_list[i].input_w = tmp;
+					break;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+fail_add_widget:
+	snd_hdac_ext_codec_cleanup(edev);
+	return ret;
+}
+
+void snd_hdac_ext_codec_cleanup(struct hdac_ext_device *edev)
+{
+	struct hdac_ext_codec_widget *wid, *tmp;
+
+	list_for_each_entry_safe(wid, tmp, &edev->widget_list, head) {
+		kfree(wid->params);
+		list_del(&wid->head);
+		kfree(wid);
+	}
+}
diff --git a/sound/hda/ext/hdac_ext_codec.h b/sound/hda/ext/hdac_ext_codec.h
new file mode 100644
index 0000000..81d4780
--- /dev/null
+++ b/sound/hda/ext/hdac_ext_codec.h
@@ -0,0 +1,26 @@
+/*
+ *  hdac_ext_codec.h - HDA ext codec helpers
+ *
+ *  Copyright (C) 2016 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef __HDAC_EXT_CODEC_H__
+#define __HDAC_EXT_CODEC_H__
+
+int snd_hdac_ext_parse_widgets(struct hdac_ext_device *hdac);
+void snd_hdac_ext_codec_cleanup(struct hdac_ext_device *hdac);
+
+#endif /* __HDAC_EXT_CODEC_H__ */
-- 
1.9.1
