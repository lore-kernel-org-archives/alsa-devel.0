From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC v2 4/6] video: rmk's HDMI notification prototype
Date: Mon,  4 Jan 2016 20:18:12 +0100
Message-ID: <1451935092-24701-1-git-send-email-p.zabel@pengutronix.de>
References: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C78032604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 20:18:14 +0100 (CET)
In-Reply-To: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is extracted from Russell's food for thought HDMI notification
prototype [1]. I've put it into drivers/video for the time being because
my kernels don't have drivers/cec yet.

The current use case for the notifications on MediaTek MT8173 is to
let the (dis)connection notifications control an ALSA jack object.

No Signed-off-by yet since this is not my code, and up for discussion.

[1] https://patchwork.kernel.org/patch/7339011/
---
 drivers/video/Makefile   |  2 +-
 drivers/video/hdmi-not.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hdmi-not.h | 39 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/hdmi-not.c
 create mode 100644 include/linux/hdmi-not.h

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9ad3c17..bf25760 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_VGASTATE)            += vgastate.o
-obj-$(CONFIG_HDMI)                += hdmi.o
+obj-$(CONFIG_HDMI)                += hdmi.o hdmi-not.o
 
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
diff --git a/drivers/video/hdmi-not.c b/drivers/video/hdmi-not.c
new file mode 100644
index 0000000..ba3be8a
--- /dev/null
+++ b/drivers/video/hdmi-not.c
@@ -0,0 +1,61 @@
+#include <linux/export.h>
+#include <linux/hdmi-not.h>
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
diff --git a/include/linux/hdmi-not.h b/include/linux/hdmi-not.h
new file mode 100644
index 0000000..940ece45
--- /dev/null
+++ b/include/linux/hdmi-not.h
@@ -0,0 +1,39 @@
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
-- 
2.6.2
