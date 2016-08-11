From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v8 1/5] video: rmk's HDMI notification prototype
Date: Thu, 11 Aug 2016 11:20:23 +0200
Message-ID: <1470907227-899-2-git-send-email-p.zabel@pengutronix.de>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 05BA1266B2A
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 11:20:42 +0200 (CEST)
In-Reply-To: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is Russell's HDMI notification prototype [1], currently waiting
for the HDMI CEC situation to resolve.

The use case for the notifications on MediaTek MT8173 is to let the
(dis)connection notifications control an ALSA jack object.

No Signed-off-by since this is not my code, and still up for discussion.

[1] https://patchwork.kernel.org/patch/8351501/
---
 drivers/video/Kconfig         |  3 +++
 drivers/video/Makefile        |  1 +
 drivers/video/hdmi-notifier.c | 61 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi-notifier.h | 44 +++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..1ee7b9f 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -36,6 +36,9 @@ config VIDEOMODE_HELPERS
 config HDMI
 	bool
 
+config HDMI_NOTIFIERS
+	bool
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17..65f5649 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_HDMI)                += hdmi.o
+obj-$(CONFIG_HDMI_NOTIFIERS)      += hdmi-notifier.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/hdmi-notifier.c b/drivers/video/hdmi-notifier.c
new file mode 100644
index 0000000..a233359
--- /dev/null
+++ b/drivers/video/hdmi-notifier.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/hdmi-notifier.h>
+#include <linux/notifier.h>
+#include <linux/string.h>
+
+static BLOCKING_NOTIFIER_HEAD(hdmi_notifier);
+
+int hdmi_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_register_notifier);
+
+int hdmi_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&hdmi_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(hdmi_unregister_notifier);
+
+void hdmi_event_connect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_CONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_connect);
+
+void hdmi_event_disconnect(struct device *dev)
+{
+	struct hdmi_event_base base;
+
+	base.source = dev;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_DISCONNECTED, &base);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_disconnect);
+
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size)
+{
+	struct hdmi_event_new_edid new_edid;
+
+	new_edid.base.source = dev;
+	new_edid.edid = edid;
+	new_edid.size = size;
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_EDID, &new_edid);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_edid);
+
+void hdmi_event_new_eld(struct device *dev, const void *eld)
+{
+	struct hdmi_event_new_eld new_eld;
+
+	new_eld.base.source = dev;
+	memcpy(new_eld.eld, eld, sizeof(new_eld.eld));
+
+	blocking_notifier_call_chain(&hdmi_notifier, HDMI_NEW_ELD, &new_eld);
+}
+EXPORT_SYMBOL_GPL(hdmi_event_new_eld);
diff --git a/include/linux/hdmi-notifier.h b/include/linux/hdmi-notifier.h
new file mode 100644
index 0000000..9c5ad49
--- /dev/null
+++ b/include/linux/hdmi-notifier.h
@@ -0,0 +1,44 @@
+#ifndef LINUX_HDMI_NOTIFIER_H
+#define LINUX_HDMI_NOTIFIER_H
+
+#include <linux/types.h>
+
+enum {
+	HDMI_CONNECTED,
+	HDMI_DISCONNECTED,
+	HDMI_NEW_EDID,
+	HDMI_NEW_ELD,
+};
+
+struct hdmi_event_base {
+	struct device *source;
+};
+
+struct hdmi_event_new_edid {
+	struct hdmi_event_base base;
+	const void *edid;
+	size_t size;
+};
+
+struct hdmi_event_new_eld {
+	struct hdmi_event_base base;
+	unsigned char eld[128];
+};
+
+union hdmi_event {
+	struct hdmi_event_base base;
+	struct hdmi_event_new_edid edid;
+	struct hdmi_event_new_eld eld;
+};
+
+struct notifier_block;
+
+int hdmi_register_notifier(struct notifier_block *nb);
+int hdmi_unregister_notifier(struct notifier_block *nb);
+
+void hdmi_event_connect(struct device *dev);
+void hdmi_event_disconnect(struct device *dev);
+void hdmi_event_new_edid(struct device *dev, const void *edid, size_t size);
+void hdmi_event_new_eld(struct device *dev, const void *eld);
+
+#endif
-- 
2.8.1
