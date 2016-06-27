From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 01/11] ALSA: hdac: Add codec helper library
Date: Mon, 27 Jun 2016 09:17:54 +0530
Message-ID: <1466999284-14782-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F1D1264F02
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 05:51:32 +0200 (CEST)
In-Reply-To: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
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
lists for each.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h    |   1 +
 sound/hda/ext/Makefile     |   3 +-
 sound/hda/ext/hdac_codec.c | 188 +++++++++++++++++++++++++++++++++++++++++++++
 sound/hda/ext/hdac_codec.h |  52 +++++++++++++
 4 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 sound/hda/ext/hdac_codec.c
 create mode 100644 sound/hda/ext/hdac_codec.h

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 93e63c5..79502dc 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -71,6 +71,7 @@ struct hdac_device {
 			 unsigned int flags, unsigned int *res);
 
 	/* widgets */
+	struct list_head widget_list;
 	unsigned int num_nodes;
 	hda_nid_t start_nid, end_nid;
 
diff --git a/sound/hda/ext/Makefile b/sound/hda/ext/Makefile
index 9b6f641..d3c51e0 100644
--- a/sound/hda/ext/Makefile
+++ b/sound/hda/ext/Makefile
@@ -1,3 +1,4 @@
-snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o hdac_ext_stream.o
+snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o hdac_ext_stream.o	\
+			hdac_codec.o
 
 obj-$(CONFIG_SND_HDA_EXT_CORE) += snd-hda-ext-core.o
diff --git a/sound/hda/ext/hdac_codec.c b/sound/hda/ext/hdac_codec.c
new file mode 100644
index 0000000..93e49a3
--- /dev/null
+++ b/sound/hda/ext/hdac_codec.c
@@ -0,0 +1,188 @@
+/*
+ *  hdac_codec.c - HDA codec library
+ *
+ *  Copyright (C) 2016-2017 Intel Corp
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
+#include "hdac_codec.h"
+#include <sound/hda_verbs.h>
+
+static int hdac_generic_query_connlist(struct hdac_device *hdac,
+				struct hdac_codec_widget *wid)
+{
+	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+	unsigned int caps;
+	int i;
+
+	if (!(get_wcaps(hdac, wid->nid) & AC_WCAP_CONN_LIST)) {
+		dev_info(&hdac->dev,
+			"HDAC ASoC: wid %d wcaps %#x doesn't support connection list\n",
+			wid->nid, get_wcaps(hdac, wid->nid));
+
+		return 0;
+	}
+
+	wid->num_inputs = snd_hdac_get_connections(hdac, wid->nid,
+					mux_nids, HDA_MAX_CONNECTIONS);
+
+	if (wid->num_inputs == 0) {
+		dev_info(&hdac->dev, "No connections found for wid: %d\n",
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
+static int hdac_codec_add_widget(struct hdac_device *codec, hda_nid_t nid,
+				unsigned int type, unsigned int caps)
+{
+	struct hdac_codec_widget *widget;
+	unsigned int *cfg;
+	int ret;
+
+	widget = kzalloc(sizeof(*widget), GFP_KERNEL);
+	if (!widget)
+		return -ENOMEM;
+
+	widget->nid = nid;
+	widget->type = type;
+	widget->caps = caps;
+	list_add_tail(&widget->head, &codec->widget_list);
+
+	switch (type) {
+	case AC_WID_PIN:
+		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+
+		*cfg = snd_hdac_codec_read(codec, nid, 0,
+					AC_VERB_GET_CONFIG_DEFAULT, 0);
+		widget->params = cfg;
+		break;
+
+	default:
+		break;
+	}
+
+	ret = hdac_generic_query_connlist(codec, widget);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * snd_hdac_parse_widgets - Iterates over the hda codec, enumerates the
+ *			    widgets and its connections.
+ * @hdac: pointer to HDAC devcie
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_parse_widgets(struct hdac_device *hdac)
+{
+	hda_nid_t nid;
+	int num_nodes, i;
+	struct hdac_codec_widget *wid;
+	struct hdac_codec_widget *tmp;
+	int ret = 0;
+
+	num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
+	if (!nid || num_nodes <= 0) {
+		dev_err(&hdac->dev, "HDAC ASoC: failed to get afg sub nodes\n");
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
+		ret = hdac_codec_add_widget(hdac, nid, type, caps);
+		if (ret < 0)
+			goto fail_add_widget;
+
+	}
+
+	hdac->end_nid = nid;
+
+	/* Cache input connection to a widget */
+	list_for_each_entry(wid, &hdac->widget_list, head) {
+		if (!wid->num_inputs)
+			continue;
+
+		for (i = 0; i < wid->num_inputs; i++) {
+			list_for_each_entry(tmp, &hdac->widget_list, head) {
+				if (wid->conn_list[i].nid == tmp->nid) {
+					wid->conn_list[i].input_w = tmp;
+					break;
+				}
+			}
+		}
+	}
+
+fail_add_widget:
+	snd_hdac_codec_cleanup(hdac);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_parse_widgets);
+
+/**
+ * snd_hdac_codec_init - Initialize some more hdac device elements
+ * @hdac: pointer to hdac device
+ *
+ * Returns 0 if successful.
+ */
+int snd_hdac_codec_init(struct hdac_device *hdac)
+{
+	INIT_LIST_HEAD(&hdac->widget_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_codec_init);
+
+/**
+ * snd_hdac_codec_cleanup - Cleanup resources allocated during device
+ * initialization.
+ * @hdac: pointer to hdac device
+ */
+void snd_hdac_codec_cleanup(struct hdac_device *hdac)
+{
+	struct hdac_codec_widget *wid, *tmp;
+
+	list_for_each_entry_safe(wid, tmp, &hdac->widget_list, head) {
+		kfree(wid->params);
+		list_del(&wid->head);
+		kfree(wid);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_codec_cleanup);
diff --git a/sound/hda/ext/hdac_codec.h b/sound/hda/ext/hdac_codec.h
new file mode 100644
index 0000000..cc9db65
--- /dev/null
+++ b/sound/hda/ext/hdac_codec.h
@@ -0,0 +1,52 @@
+/*
+ *  hdac_codec.h - HDA codec library
+ *
+ *  Copyright (C) 2016-2017 Intel Corp
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
+#ifndef __HDAC_CODEC_H__
+#define __HDAC_CODEC_H__
+
+#define HDA_MAX_CONNECTIONS 32
+/* amp values */
+#define AMP_IN_MUTE(idx)	(0x7080 | ((idx)<<8))
+#define AMP_IN_UNMUTE(idx)	(0x7000 | ((idx)<<8))
+#define AMP_OUT_MUTE		0xb080
+#define AMP_OUT_UNMUTE		0xb000
+
+struct hdac_codec_widget;
+struct hdac_codec_connection_list {
+	hda_nid_t nid;
+	unsigned int type;
+	struct hdac_codec_widget *input_w;
+};
+
+struct hdac_codec_widget {
+	struct list_head head;
+	hda_nid_t nid;
+	unsigned int caps;
+	unsigned int type;
+	int num_inputs;
+	struct hdac_codec_connection_list conn_list[HDA_MAX_CONNECTIONS];
+	void *priv;	/* Codec specific widget data */
+	void *params;	/* Widget specific parameters */
+};
+
+int snd_hdac_parse_widgets(struct hdac_device *hdac);
+int snd_hdac_codec_init(struct hdac_device *hdac);
+void snd_hdac_codec_cleanup(struct hdac_device *hdac);
+
+#endif /* __HDAC_CODEC_H__ */
-- 
1.9.1
